Return-Path: <SRS0=xaRW=WR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7620C3A59E
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Aug 2019 23:55:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B23DE217F9
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Aug 2019 23:55:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730701AbfHUXzj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Aug 2019 19:55:39 -0400
Received: from verein.lst.de ([213.95.11.211]:41853 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728872AbfHUXzj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Aug 2019 19:55:39 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 6803368BFE; Thu, 22 Aug 2019 01:55:35 +0200 (CEST)
Date:   Thu, 22 Aug 2019 01:55:34 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Guillem Jover <guillem@hadrons.org>
Cc:     linux-aio@kvack.org, Christoph Hellwig <hch@lst.de>,
        Jeff Moyer <jmoyer@redhat.com>,
        Benjamin LaHaise <bcrl@kvack.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] aio: Fix io_pgetevents() struct __compat_aio_sigset
 layout
Message-ID: <20190821235534.GA9511@lst.de>
References: <20190821033820.14155-1-guillem@hadrons.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190821033820.14155-1-guillem@hadrons.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 21, 2019 at 05:38:20AM +0200, Guillem Jover wrote:
> This type is used to pass the sigset_t from userland to the kernel,
> but it was using the kernel native pointer type for the member
> representing the compat userland pointer to the userland sigset_t.
> 
> This messes up the layout, and makes the kernel eat up both the
> userland pointer and the size members into the kernel pointer, and
> then reads garbage into the kernel sigsetsize. Which makes the sigset_t
> size consistency check fail, and consequently the syscall always
> returns -EINVAL.
> 
> This breaks both libaio and strace on 32-bit userland running on 64-bit
> kernels. And there are apparently no users in the wild of the current
> broken layout (at least according to codesearch.debian.org and a brief
> check over github.com search). So it looks safe to fix this directly
> in the kernel, instead of either letting userland deal with this
> permanently with the additional overhead or trying to make the syscall
> infer what layout userland used, even though this is also being worked
> around in libaio to temporarily cope with kernels that have not yet
> been fixed.
> 
> We use a proper compat_uptr_t instead of a compat_sigset_t pointer.
> 
> Fixes: 7a074e96 ("aio: implement io_pgetevents")
> Signed-off-by: Guillem Jover <guillem@hadrons.org>

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
