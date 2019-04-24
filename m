Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE3AEC282CE
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 18:30:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E1A121773
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 18:30:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nexedi.com header.i=kirr@nexedi.com header.b="N8zwcMg5";
	dkim=pass (1024-bit key) header.d=mandrillapp.com header.i=@mandrillapp.com header.b="PaxIg5Aw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387735AbfDXSaT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 14:30:19 -0400
Received: from mail133-30.atl131.mandrillapp.com ([198.2.133.30]:4851 "EHLO
        mail133-30.atl131.mandrillapp.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729910AbfDXSaT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 14:30:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; s=mandrill; d=nexedi.com;
 h=From:Subject:To:Cc:Message-Id:References:In-Reply-To:Date:MIME-Version:Content-Type:Content-Transfer-Encoding; i=kirr@nexedi.com;
 bh=U7YiiZ0w+nLArJdO6M9QIPXj108+jBLyhc0n0FtMpL4=;
 b=N8zwcMg5gArLqEIYiT0vPDELC7Ci2aWX1taN/z1lZXyygAY6J4MtIA5zeQnlQL0aty8dNR7XnZ7F
   l0FooAB7UIes8iSUOJB43aEHSzPw98kk+MKFr3uxj9ZevGnw/ajiOcbsVLpjMv5Jhqmwzlf8N/pC
   eye2vKaJZT/0BxetsUY=
Received: from pmta02.mandrill.prod.atl01.rsglab.com (127.0.0.1) by mail133-30.atl131.mandrillapp.com id ho2ljk1sar8t for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2019 18:30:17 +0000 (envelope-from <bounce-md_31050260.5cc0ab39.v1-830294b1b5614a42aed267a98e82b482@mandrillapp.com>)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mandrillapp.com; 
 i=@mandrillapp.com; q=dns/txt; s=mandrill; t=1556130617; h=From : 
 Subject : To : Cc : Message-Id : References : In-Reply-To : Date : 
 MIME-Version : Content-Type : Content-Transfer-Encoding : From : 
 Subject : Date : X-Mandrill-User : List-Unsubscribe; 
 bh=U7YiiZ0w+nLArJdO6M9QIPXj108+jBLyhc0n0FtMpL4=; 
 b=PaxIg5AwbNNeD2BdhCLXBtItI90G0YTjHu/p6tLt/6CfhXTSh0LF7V/rmDt8p6wZxdsH//
 osCP8708wlI8POz/w3ayM4MNbwm6yup0D5ONO6P1huuePj7Ss3Y3CvGuJK3pLDi5i7OaW3Iu
 2JIibjPPHXtvx65gEjW8Hm8pbnI8c=
From:   Kirill Smelkov <kirr@nexedi.com>
Subject: Re: [PATCH AUTOSEL 5.0 59/66] fs: stream_open - opener for stream-like files so that read and write can run simultaneously without deadlock
Received: from [87.98.221.171] by mandrillapp.com id 830294b1b5614a42aed267a98e82b482; Wed, 24 Apr 2019 18:30:17 +0000
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Sasha Levin <sashal@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        stable <stable@vger.kernel.org>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        Yongzhi Pan <panyongzhi@gmail.com>,
        Jonathan Corbet <corbet@lwn.net>,
        David Vrabel <david.vrabel@citrix.com>,
        Juergen Gross <jgross@suse.com>,
        Miklos Szeredi <miklos@szeredi.hu>, Tejun Heo <tj@kernel.org>,
        Kirill Tkhai <ktkhai@virtuozzo.com>,
        Arnd Bergmann <arnd@arndb.de>, Christoph Hellwig <hch@lst.de>,
        Julia Lawall <Julia.Lawall@lip6.fr>,
        Nikolaus Rath <Nikolaus@rath.org>,
        Han-Wen Nienhuys <hanwen@google.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Message-Id: <20190424183012.GB3798@deco.navytux.spb.ru>
References: <20190424143341.27665-1-sashal@kernel.org> <20190424143341.27665-59-sashal@kernel.org> <20190424163415.GB21413@kroah.com> <CAHk-=wjEOyba5As1PEMk6RitNVOJH9oJ_Jbg4y=5B0fcX1iKGw@mail.gmail.com> <20190424171926.GA17719@sasha-vm> <CAHk-=wgh234SyBG810=vB360PCzVkAhQRqGg8aFdATZd+daCFw@mail.gmail.com>
In-Reply-To: <CAHk-=wgh234SyBG810=vB360PCzVkAhQRqGg8aFdATZd+daCFw@mail.gmail.com>
X-Report-Abuse: Please forward a copy of this message, including all headers, to abuse@mandrill.com
X-Report-Abuse: You can also report abuse here: http://mandrillapp.com/contact/abuse?id=31050260.830294b1b5614a42aed267a98e82b482
X-Mandrill-User: md_31050260
Date:   Wed, 24 Apr 2019 18:30:17 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 24, 2019 at 10:26:55AM -0700, Linus Torvalds wrote:
> On Wed, Apr 24, 2019 at 10:19 AM Sasha Levin <sashal@kernel.org> wrote:
> >
> > Hm, I might be confusing something here but I see a bunch of patches
> > that convert existing callers mentioned in this patch to use
> > stream_open() which was introduced here.
> 
> The only use of stream_open() upstream right now is the xenbus
> conversion, and that isn't actually a bugfix, because xenbus used to
> manually do that
> 
>         filp->f_mode &= ~FMODE_ATOMIC_POS; /* cdev-style semantics */
> 
> that stream_open() does.
> 
> So no, there isn't "a bunch of patches" anywhere.
> 
> There are *future* cleanups for 5.2 that will happen, and that might
> have hit linux-next. And there is at least one FUSE patch (again -
> pending, not upstream) that may get marked for stable.
> 
> But I see nothing right now that makes it stable material yet.

Linus, thanks for explaining. Sasha, Greg, there is a FUSE patch that
should be stable material that will need this stream_open() thing. That
patch has just entered fuse.git#for-next today:

	https://git.kernel.org/pub/scm/linux/kernel/git/mszeredi/fuse.git/commit/?id=bbd84f33652f

and will hopefully enter 5.2 when merge window opens. I agree we should
not blindly backport bulk stream_open conversions as performed by
stream_open.cocci, at least unless there is a bug report indicating that
it is actually required for a particular driver. On the other hand both
Xen and FUSE deadlocks were hit for real which justifies stable
propagation for their fixes.

You can read about the deadlock regression and the plan to fix it in
original "fs: stream_open - opener for stream-like files so that read
and write can run simultaneously without deadlock" patch (the 59/66
patch that was send in this thread), or here:

	https://git.kernel.org/linus/10dce8af3422


Hope it clarifies things a bit,

Kirill
