Return-Path: <SRS0=FxTY=RO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E638DC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 07:21:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BC388206DF
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 07:21:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726920AbfCKHVu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 03:21:50 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53448 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726623AbfCKHVu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 03:21:50 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 21B0D30821F9;
        Mon, 11 Mar 2019 07:21:50 +0000 (UTC)
Received: from [10.72.12.54] (ovpn-12-54.pek2.redhat.com [10.72.12.54])
        by smtp.corp.redhat.com (Postfix) with ESMTP id EAD25611C3;
        Mon, 11 Mar 2019 07:21:43 +0000 (UTC)
Subject: Re: [RFC PATCH V2 5/5] vhost: access vq metadata through kernel
 virtual address
To:     Andrea Arcangeli <aarcange@redhat.com>
Cc:     Jerome Glisse <jglisse@redhat.com>,
        "Michael S. Tsirkin" <mst@redhat.com>, kvm@vger.kernel.org,
        virtualization@lists.linux-foundation.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, peterx@redhat.com,
        linux-mm@kvack.org, Jan Kara <jack@suse.cz>
References: <1551856692-3384-1-git-send-email-jasowang@redhat.com>
 <1551856692-3384-6-git-send-email-jasowang@redhat.com>
 <20190306092837-mutt-send-email-mst@kernel.org>
 <15105894-4ec1-1ed0-1976-7b68ed9eeeda@redhat.com>
 <20190307101708-mutt-send-email-mst@kernel.org>
 <20190307190910.GE3835@redhat.com> <20190307193838.GQ23850@redhat.com>
 <20190307201722.GG3835@redhat.com> <20190307212717.GS23850@redhat.com>
 <671c4a98-4699-836e-79fc-0ce650c7f701@redhat.com>
 <20190308191108.GA26923@redhat.com>
From:   Jason Wang <jasowang@redhat.com>
Message-ID: <189b7839-3208-fb2e-4ac0-e6ca50e397bb@redhat.com>
Date:   Mon, 11 Mar 2019 15:21:41 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <20190308191108.GA26923@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.47]); Mon, 11 Mar 2019 07:21:50 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2019/3/9 上午3:11, Andrea Arcangeli wrote:
> On Fri, Mar 08, 2019 at 05:13:26PM +0800, Jason Wang wrote:
>> Actually not wrapping around,  the pages for used ring was marked as
>> dirty after a round of virtqueue processing when we're sure vhost wrote
>> something there.
> Thanks for the clarification. So we need to convert it to
> set_page_dirty and move it to the mmu notifier invalidate but in those
> cases where gup_fast was called with write=1 (1 out of 3).
>
> If using ->invalidate_range the page pin also must be removed
> immediately after get_user_pages returns (not ok to hold the pin in
> vmap until ->invalidate_range is called) to avoid false positive gup
> pin checks in things like KSM, or the pin must be released in
> invalidate_range_start (which is called before the pin checks).
>
> Here's why:
>
> 		/*
> 		 * Check that no O_DIRECT or similar I/O is in progress on the
> 		 * page
> 		 */
> 		if (page_mapcount(page) + 1 + swapped != page_count(page)) {
> 			set_pte_at(mm, pvmw.address, pvmw.pte, entry);
> 			goto out_unlock;
> 		}
> 		[..]
> 		set_pte_at_notify(mm, pvmw.address, pvmw.pte, entry);
> 			  ^^^^^^^ too late release the pin here, the
> 				  above already failed
>
> ->invalidate_range cannot be used with mutex anyway so you need to go
> back with invalidate_range_start/end anyway, just the pin must be
> released in _start at the latest in such case.


Yes.


>
> My prefer is generally to call gup_fast() followed by immediate
> put_page() because I always want to drop FOLL_GET from gup_fast as a
> whole to avoid 2 useless atomic ops per gup_fast.


Ok, will do this (if I still plan to use vmap() in next version).


>
> I'll write more about vmap in answer to the other email.
>
> Thanks,
> Andrea


Thanks

