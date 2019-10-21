Return-Path: <SRS0=BTkm=YO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA8E5CA9EAF
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 20:15:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 98E3B20656
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 20:15:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730236AbfJUUP5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Oct 2019 16:15:57 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:53626 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726672AbfJUUP5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Oct 2019 16:15:57 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iMe5m-0005FJ-Aw; Mon, 21 Oct 2019 20:15:50 +0000
Date:   Mon, 21 Oct 2019 21:15:50 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Jan Kara <jack@suse.cz>
Cc:     Guillem Jover <guillem@hadrons.org>, linux-aio@kvack.org,
        Christoph Hellwig <hch@lst.de>, Jeff Moyer <jmoyer@redhat.com>,
        Benjamin LaHaise <bcrl@kvack.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] aio: Fix io_pgetevents() struct __compat_aio_sigset
 layout
Message-ID: <20191021201550.GW26530@ZenIV.linux.org.uk>
References: <20190821033820.14155-1-guillem@hadrons.org>
 <20191017134800.GA27576@quack2.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191017134800.GA27576@quack2.suse.cz>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 17, 2019 at 03:48:00PM +0200, Jan Kara wrote:
> On Wed 21-08-19 05:38:20, Guillem Jover wrote:
> > This type is used to pass the sigset_t from userland to the kernel,
> > but it was using the kernel native pointer type for the member
> > representing the compat userland pointer to the userland sigset_t.
> > 
> > This messes up the layout, and makes the kernel eat up both the
> > userland pointer and the size members into the kernel pointer, and
> > then reads garbage into the kernel sigsetsize. Which makes the sigset_t
> > size consistency check fail, and consequently the syscall always
> > returns -EINVAL.
> > 
> > This breaks both libaio and strace on 32-bit userland running on 64-bit
> > kernels. And there are apparently no users in the wild of the current
> > broken layout (at least according to codesearch.debian.org and a brief
> > check over github.com search). So it looks safe to fix this directly
> > in the kernel, instead of either letting userland deal with this
> > permanently with the additional overhead or trying to make the syscall
> > infer what layout userland used, even though this is also being worked
> > around in libaio to temporarily cope with kernels that have not yet
> > been fixed.
> > 
> > We use a proper compat_uptr_t instead of a compat_sigset_t pointer.
> > 
> > Fixes: 7a074e96 ("aio: implement io_pgetevents")
> > Signed-off-by: Guillem Jover <guillem@hadrons.org>
> 
> This patch seems to have fallen through the cracks. Al?

Looks like - back then I assumed that Jens would've picked it...
Applied to #fixes...
