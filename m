Return-Path: <SRS0=dUEL=RQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E215DC4360F
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 14:38:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B02A2214AE
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 14:38:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552487887;
	bh=2fYBVW0X6jqmlRwixhEnvssPawPfCnQQIkJHvIXSIMM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=DcZnPdF2+1qFseGh0x89eephpOzpXx+QQwR3P4gUfZ2pnjF6UV8wco7UMylU0zFJs
	 X/RyB4HvSYdELSpgQ+UVMYcBzOa2t2BP0TkX87iw9XHyWDNYoQFpufHrL3GiM3C8zU
	 4zTKgc/QMDFmIaOPcZhdNxaSu7Wu/RB39uvbZyz4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727070AbfCMOiG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Mar 2019 10:38:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:44642 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726349AbfCMOiG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Mar 2019 10:38:06 -0400
Received: from localhost (unknown [12.27.65.221])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 661EB2147C;
        Wed, 13 Mar 2019 14:38:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552487885;
        bh=2fYBVW0X6jqmlRwixhEnvssPawPfCnQQIkJHvIXSIMM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Ac5Ridi2un74y7KRHTe0vNLifyxUsGt9iCr1sZ0qIjQ3OVrUgD5ojNIXMHD0M3ki6
         Jnm77wszzo5vV0bHq5ICuLmY1v0bzZDXw9KIOzLf8/VKlXujqjvu8ATBj58ooNurGi
         8HTlLnFyidEK6eK/adbUmtmkdGqIaFcFx4WQpMEI=
Date:   Wed, 13 Mar 2019 07:38:05 -0700
From:   "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
To:     Dmitry Kasatkin <dmitry.kasatkin@huawei.com>
Cc:     Sasha Levin <sashal@kernel.org>, Al Viro <viro@zeniv.linux.org.uk>,
        yuehaibing <yuehaibing@huawei.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "keescook@chromium.org" <keescook@chromium.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: [PATCH -next] exec: Fix mem leak in kernel_read_file
Message-ID: <20190313143805.GB7489@kroah.com>
References: <20190219021038.11340-1-yuehaibing@huawei.com>
 <20190219022512.GW2217@ZenIV.linux.org.uk>
 <ad928cfca24743d5bb9f01e9a3ae74bd@huawei.com>
 <20190311231627.GI158926@sasha-vm>
 <0bd9d01037354048a1d45be1ce96714f@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <0bd9d01037354048a1d45be1ce96714f@huawei.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 13, 2019 at 02:12:30PM +0000, Dmitry Kasatkin wrote:
> 
> 
> 
> 
> 
> 
> From: Sasha Levin <sashal@kernel.org>
> Sent: Tuesday, March 12, 2019 1:16 AM
> To: Dmitry Kasatkin
> Cc: Al Viro; yuehaibing; linux-kernel@vger.kernel.org; linux-fsdevel@vger.kernel.org; keescook@chromium.org; stable@vger.kernel.org; gregkh@google.com
> Subject: Re: [PATCH -next] exec: Fix mem leak in kernel_read_file
>     
> On Mon, Mar 11, 2019 at 04:59:14PM +0000, Dmitry Kasatkin wrote:
> >
> >From: Al Viro <viro@ftp.linux.org.uk> on behalf of Al Viro <viro@zeniv.linux.org.uk>
> >Sent: Tuesday, February 19, 2019 4:25 AM
> >To: yuehaibing
> >Cc: linux-kernel@vger.kernel.org; linux-fsdevel@vger.kernel.org; Dmitry Kasatkin; keescook@chromium.org
> >Subject: Re: [PATCH -next] exec: Fix mem leak in kernel_read_file
> > 
> >On Tue, Feb 19, 2019 at 10:10:38AM +0800, YueHaibing wrote:
> >> syzkaller report this:
> >> BUG: memory leak
> >> unreferenced object 0xffffc9000488d000 (size 9195520):
> >>   comm "syz-executor.0", pid 2752, jiffies 4294787496 (age 18.757s)
> >>   hex dump (first 32 bytes):
> >>     ff ff ff ff ff ff ff ff a8 00 00 00 01 00 00 00  ................
> >>     02 00 00 00 00 00 00 00 80 a1 7a c1 ff ff ff ff  ..........z.....
> >>   backtrace:
> >>     [<000000000863775c>] __vmalloc_node mm/vmalloc.c:1795 [inline]
> >>     [<000000000863775c>] __vmalloc_node_flags mm/vmalloc.c:1809 [inline]
> >>     [<000000000863775c>] vmalloc+0x8c/0xb0 mm/vmalloc.c:1831
> >>     [<000000003f668111>] kernel_read_file+0x58f/0x7d0 fs/exec.c:924
> >>     [<000000002385813f>] kernel_read_file_from_fd+0x49/0x80 fs/exec.c:993
> >>     [<0000000011953ff1>] __do_sys_finit_module+0x13b/0x2a0 kernel/module.c:3895
> >>     [<000000006f58491f>] do_syscall_64+0x147/0x600 arch/x86/entry/common.c:290
> >>     [<00000000ee78baf4>] entry_SYSCALL_64_after_hwframe+0x49/0xbe
> >>     [<00000000241f889b>] 0xffffffffffffffff
> >>
> >> It should goto 'out_free' lable to free allocated buf while kernel_read
> >> fails.
> >
> >Applied.
> >
> >
> >This must be applied to stables as well...
> 
> > It's already in all relevant stable trees...
> 
> I only can see in longterm 4.19.
> 
> What about 4.9 and 4.14?

It was in the queue already for that (you can see it on git.kernel.org),
and they are now part of the -rc releases that are currently out for
review.

thanks,

greg k-h
