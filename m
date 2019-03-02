Return-Path: <SRS0=OfNL=RF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1270DC43381
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Mar 2019 09:10:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C485C2085A
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Mar 2019 09:10:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551517852;
	bh=2fY7kXEz5TZrvwiB0rqf/WoL+YIL7ujRa26JCZxFtNk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=cR0RReSciRn+z+roLZHY3yZixjIKJZ4py9vx7bEcXx4yJqUXm/nq4vqz2TM79w6LN
	 ZBVi+dN5pGRuKGV7qu0jUMhSxRVf6dKsPCBG9dD3jTjbGeDD8fKH17ePScycAtG62L
	 O00nJkeJBItdIHVKxFn/deAPp8Jk9CriKkDH+0o4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726409AbfCBJKv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 2 Mar 2019 04:10:51 -0500
Received: from mail.kernel.org ([198.145.29.99]:51976 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725902AbfCBJKu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Mar 2019 04:10:50 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 769E220836;
        Sat,  2 Mar 2019 09:10:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551517850;
        bh=2fY7kXEz5TZrvwiB0rqf/WoL+YIL7ujRa26JCZxFtNk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=rAc74re3JOM+PRxI+34de3voEz4ANEy7NTeMadDBin0kQEM7TQNnrIkjIb4MQ9bBd
         SErBl6vAamTFMx9IJtWi+PdZ4IGUb5z6meyNylu365Eosl5hXcKsAXV8P5wESUSWL4
         xAcTRjkyUzv6YbfxEFpUnQRkUATP2BZ7kysoleWA=
Date:   Sat, 2 Mar 2019 10:10:47 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Andy Lutomirski <luto@kernel.org>
Cc:     Steve Muckle <smuckle@google.com>, Shuah Khan <shuah@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Android Kernel Team <kernel-team@android.com>
Subject: Re: [PATCH] selftests: x86: add version check in test_syscall_vdso
Message-ID: <20190302091047.GA14963@kroah.com>
References: <20190301001806.154271-1-smuckle@google.com>
 <CALCETrUcH9R62gDdiG-EGTfSt2kQktv-0+bYmPcLn4PWNMrHSQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALCETrUcH9R62gDdiG-EGTfSt2kQktv-0+bYmPcLn4PWNMrHSQ@mail.gmail.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 01, 2019 at 11:59:24AM -0800, Andy Lutomirski wrote:
> > On Feb 28, 2019, at 4:18 PM, Steve Muckle <smuckle@google.com> wrote:
> >
> > Since 4.17 registers r8-r11 are not clobbered/zeroed by a 64-bit kernel
> > handling a 32-bit syscall and this behavior is enforced by the
> > test_syscall_vdso testcase. See commit 8bb2610bc496
> > ("x86/entry/64/compat: Preserve r8-r11 in int $0x80").
> >
> > Permit the old behavior in the testcase for kernels prior to 4.17.
> 
> NAK.  If you want an old buggy kernel to pass a test, please either
> patch the kernel or run an old test.

Yeah, this isn't ok, especially as you might have 4.14 or 4.9 kernels
that can pass the test if the needed patches were backported.  Checking
kernel version numbers should never be used for anything.

greg k-h
