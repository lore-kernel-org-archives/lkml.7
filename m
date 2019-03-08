Return-Path: <SRS0=vL1f=RL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A634C43381
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 19:11:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7655F206DF
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 19:11:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726995AbfCHTLQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Mar 2019 14:11:16 -0500
Received: from mx1.redhat.com ([209.132.183.28]:48336 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726294AbfCHTLP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Mar 2019 14:11:15 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 8ED46C05D261;
        Fri,  8 Mar 2019 19:11:15 +0000 (UTC)
Received: from sky.random (ovpn-121-1.rdu2.redhat.com [10.10.121.1])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id EDECF60856;
        Fri,  8 Mar 2019 19:11:08 +0000 (UTC)
Date:   Fri, 8 Mar 2019 14:11:08 -0500
From:   Andrea Arcangeli <aarcange@redhat.com>
To:     Jason Wang <jasowang@redhat.com>
Cc:     Jerome Glisse <jglisse@redhat.com>,
        "Michael S. Tsirkin" <mst@redhat.com>, kvm@vger.kernel.org,
        virtualization@lists.linux-foundation.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, peterx@redhat.com,
        linux-mm@kvack.org, Jan Kara <jack@suse.cz>
Subject: Re: [RFC PATCH V2 5/5] vhost: access vq metadata through kernel
 virtual address
Message-ID: <20190308191108.GA26923@redhat.com>
References: <1551856692-3384-1-git-send-email-jasowang@redhat.com>
 <1551856692-3384-6-git-send-email-jasowang@redhat.com>
 <20190306092837-mutt-send-email-mst@kernel.org>
 <15105894-4ec1-1ed0-1976-7b68ed9eeeda@redhat.com>
 <20190307101708-mutt-send-email-mst@kernel.org>
 <20190307190910.GE3835@redhat.com>
 <20190307193838.GQ23850@redhat.com>
 <20190307201722.GG3835@redhat.com>
 <20190307212717.GS23850@redhat.com>
 <671c4a98-4699-836e-79fc-0ce650c7f701@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <671c4a98-4699-836e-79fc-0ce650c7f701@redhat.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.31]); Fri, 08 Mar 2019 19:11:15 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 08, 2019 at 05:13:26PM +0800, Jason Wang wrote:
> Actually not wrapping around,  the pages for used ring was marked as 
> dirty after a round of virtqueue processing when we're sure vhost wrote 
> something there.

Thanks for the clarification. So we need to convert it to
set_page_dirty and move it to the mmu notifier invalidate but in those
cases where gup_fast was called with write=1 (1 out of 3).

If using ->invalidate_range the page pin also must be removed
immediately after get_user_pages returns (not ok to hold the pin in
vmap until ->invalidate_range is called) to avoid false positive gup
pin checks in things like KSM, or the pin must be released in
invalidate_range_start (which is called before the pin checks).

Here's why:

		/*
		 * Check that no O_DIRECT or similar I/O is in progress on the
		 * page
		 */
		if (page_mapcount(page) + 1 + swapped != page_count(page)) {
			set_pte_at(mm, pvmw.address, pvmw.pte, entry);
			goto out_unlock;
		}
		[..]
		set_pte_at_notify(mm, pvmw.address, pvmw.pte, entry);
			  ^^^^^^^ too late release the pin here, the
				  above already failed

->invalidate_range cannot be used with mutex anyway so you need to go
back with invalidate_range_start/end anyway, just the pin must be
released in _start at the latest in such case.

My prefer is generally to call gup_fast() followed by immediate
put_page() because I always want to drop FOLL_GET from gup_fast as a
whole to avoid 2 useless atomic ops per gup_fast.

I'll write more about vmap in answer to the other email.

Thanks,
Andrea
