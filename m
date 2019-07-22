Return-Path: <SRS0=CEgE=VT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E382DC7618F
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 17:16:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B8A312190F
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 17:16:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="flsNQ3Ds"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731231AbfGVRQR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jul 2019 13:16:17 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:43167 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729058AbfGVRQR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jul 2019 13:16:17 -0400
Received: by mail-pg1-f196.google.com with SMTP id f25so17956027pgv.10
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jul 2019 10:16:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=fH7Lv8U2QXpKv+6l1maxett1Ga5XuZ9aclc7EGbHLSs=;
        b=flsNQ3Dsii/uCXgHxUflRqXrr6R4pyXbDfBYL0/QgeQDPFDEm0/f2hbvvLWc9IjfsW
         f1PUrlvmpCbfs9VpuQ0nV6RnGJZZNppxf92XN6YrFzT6DpD3K3QhT1ZOfio3RWodM/VW
         kt+TmBTTsdwlMKHctvwfDAFnkpZpcehATjUww=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=fH7Lv8U2QXpKv+6l1maxett1Ga5XuZ9aclc7EGbHLSs=;
        b=DQswEeqqELJizNAOeTGV2n1Ohsh+3VUIHt5h1spXdXH5v7EiuOXK0NwuHGGWUzb2fo
         9WHnAgAY72mtpifDGFGjX56yaiqCBGjbrOS12VVq+laiS0KprDgld+vhmilcbuMYaBOR
         vQEwRNaGNDxT9ktZzqi58Pm+oDRFWcHuYFPw4qYrltsPiLFQZdLH//HQR6v82HeHmSHa
         CQxl5YA+sip7DNCtrrGknTi6bxDCLVesNUnjauNx16y/M+Fp1TMR99DnnH2JYuzZVaZ6
         1Jx/d/c8vtt93YlhIlXiRQ+VKQXWR32wzATkeInt/Ej7uURT+fTBJHPqPXBYVsxW0Q7H
         YKag==
X-Gm-Message-State: APjAAAX2A/5sl61wcx8ZJqF8k9FCWwCmz7HAgX+6cQdi4v/Wu/Or1l7S
        QXFLSdJ74ZefQZa31+5UWSJ+hXUGiyY=
X-Google-Smtp-Source: APXvYqyNGNSLAs87MVqlRkjxdi8obg6zaKaz2Xu8ahiy2RTJA7OrP286HVB+L7JWD1PNieNAvDkHbA==
X-Received: by 2002:a63:7455:: with SMTP id e21mr67380411pgn.439.1563815776492;
        Mon, 22 Jul 2019 10:16:16 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id r1sm38032877pgv.70.2019.07.22.10.16.15
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 22 Jul 2019 10:16:15 -0700 (PDT)
Date:   Mon, 22 Jul 2019 10:16:14 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Andy Lutomirski <luto@amacapital.net>
Cc:     Sean Christopherson <sean.j.christopherson@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andy Lutomirski <luto@kernel.org>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [5.2 REGRESSION] Generic vDSO breaks seccomp-enabled userspace
 on i386
Message-ID: <201907221012.41504DCD@keescook>
References: <20190719170343.GA13680@linux.intel.com>
 <19EF7AC8-609A-4E86-B45E-98DFE965DAAB@amacapital.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <19EF7AC8-609A-4E86-B45E-98DFE965DAAB@amacapital.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 19, 2019 at 01:40:13PM -0400, Andy Lutomirski wrote:
> > On Jul 19, 2019, at 1:03 PM, Sean Christopherson <sean.j.christopherson@intel.com> wrote:
> > 
> > The generic vDSO implementation, starting with commit
> > 
> >   7ac870747988 ("x86/vdso: Switch to generic vDSO implementation")
> > 
> > breaks seccomp-enabled userspace on 32-bit x86 (i386) kernels.  Prior to
> > the generic implementation, the x86 vDSO used identical code for both
> > x86_64 and i386 kernels, which worked because it did all calcuations using
> > structs with naturally sized variables, i.e. didn't use __kernel_timespec.
> > 
> > The generic vDSO does its internal calculations using __kernel_timespec,
> > which in turn requires the i386 fallback syscall to use the 64-bit
> > variation, __NR_clock_gettime64.
> 
> This is basically doomed to break eventually, right?

Just so I'm understanding: the vDSO change introduced code to make an
actual syscall on i386, which for most seccomp filters would be rejected?

> I’ve occasionally considered adding a concept of “seccomp aliases”.  The idea is that, if a filter returns anything other than ALLOW, we re-run it with a different nr that we dig out it a small list of such cases. This would be limited to cases where the new syscall does the same thing with the same arguments.

Would that help here? The kernel just sees this a direct syscall. I
guess it could whitelist it by checking the return address?

> I want this for restart_syscall: I want to renumber it.

Oh man, don't get me started on restart_syscall. Some architectures make
it invisible to seccomp and others don't. ugh.

-- 
Kees Cook
