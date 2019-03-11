Return-Path: <SRS0=FxTY=RO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E02F6C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 14:45:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B409F20657
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 14:45:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727933AbfCKOpe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 10:45:34 -0400
Received: from mx2.suse.de ([195.135.220.15]:33634 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727895AbfCKOpa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 10:45:30 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id E1BFAAFBB;
        Mon, 11 Mar 2019 14:45:27 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 594E51E426A; Mon, 11 Mar 2019 15:45:27 +0100 (CET)
Date:   Mon, 11 Mar 2019 15:45:27 +0100
From:   Jan Kara <jack@suse.cz>
To:     Andrea Arcangeli <aarcange@redhat.com>
Cc:     Jerome Glisse <jglisse@redhat.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>, kvm@vger.kernel.org,
        virtualization@lists.linux-foundation.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, peterx@redhat.com,
        linux-mm@kvack.org, Jan Kara <jack@suse.cz>
Subject: Re: [RFC PATCH V2 5/5] vhost: access vq metadata through kernel
 virtual address
Message-ID: <20190311144527.GM11553@quack2.suse.cz>
References: <1551856692-3384-1-git-send-email-jasowang@redhat.com>
 <1551856692-3384-6-git-send-email-jasowang@redhat.com>
 <20190306092837-mutt-send-email-mst@kernel.org>
 <15105894-4ec1-1ed0-1976-7b68ed9eeeda@redhat.com>
 <20190307101708-mutt-send-email-mst@kernel.org>
 <20190307190910.GE3835@redhat.com>
 <20190307193838.GQ23850@redhat.com>
 <20190307201722.GG3835@redhat.com>
 <20190307212717.GS23850@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190307212717.GS23850@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 07-03-19 16:27:17, Andrea Arcangeli wrote:
> > driver that GUP page for hours/days/weeks/months ... obviously the
> > race window is big enough here. It affects many fs (ext4, xfs, ...)
> > in different ways. I think ext4 is the most obvious because of the
> > kernel log trace it leaves behind.
> > 
> > Bottom line is for set_page_dirty to be safe you need the following:
> >     lock_page()
> >     page_mkwrite()
> >     set_pte_with_write()
> >     unlock_page()
> 
> I also wondered why ext4 writepage doesn't recreate the bh if they got
> dropped by the VM and page->private is 0. I mean, page->index and
> page->mapping are still there, that's enough info for writepage itself
> to take a slow path and calls page_mkwrite to find where to write the
> page on disk.

There are two problems:

1) What to do with errors that page_mkwrite() can generate (ENOMEM, ENOSPC,
EIO). On page fault you just propagate them to userspace, on set_page_dirty()
you have no chance so you just silently loose data.

2) We need various locks to protect page_mkwrite(), possibly do some IO.
set_page_dirty() is rather uncertain context to acquire locks or do IO...

									Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
