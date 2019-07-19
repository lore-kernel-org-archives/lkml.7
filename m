Return-Path: <SRS0=NvuC=VQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E5A3C7618F
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jul 2019 17:40:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 421942084D
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jul 2019 17:40:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=amacapital-net.20150623.gappssmtp.com header.i=@amacapital-net.20150623.gappssmtp.com header.b="MzWExJYA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729299AbfGSRkQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jul 2019 13:40:16 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:36083 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726243AbfGSRkQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jul 2019 13:40:16 -0400
Received: by mail-io1-f67.google.com with SMTP id o9so60139798iom.3
        for <linux-kernel@vger.kernel.org>; Fri, 19 Jul 2019 10:40:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20150623.gappssmtp.com; s=20150623;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=PdRVJYMKZyuR04Jtd0bhLu62MengDRxfpO0Ujclc4Yc=;
        b=MzWExJYAEzzbpyMApm296Qq5Hxox5HHH9vzMtgdxFwpIs8cMfZNXP+CKk1xGirwqxc
         b5hqpuO6R5U6h626xnidcBcgIRC+bV4FQxfbfAicUNqsZ0IrIgQMC8BdfokeYkXnYl3V
         kU2Dj26gLYG07Gl7NVFPCAjgSBMtec40vr6RZyNiLp37BqBxQdKMRXKElhLMgyJppxeH
         0A9oMcHOuvKR4r7a2tG/jlqPlSXtqTbOp+FaBq2c5Z0J4qEE4PBucy8vEWj/XcrVA3oD
         lCBTwEiPnuQ0IvyaQvk8M2HNvbE4k0bYP3eDEwhcXQr0CUhfxrJEuXeoNsTn+d9T9GNj
         aGyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=PdRVJYMKZyuR04Jtd0bhLu62MengDRxfpO0Ujclc4Yc=;
        b=ZbILM/xcs2p2wuNQNK4Cv9RGNS/Oa+f9bnpl/O2WiX/C5LZbXYQK8uR8m85KQQ5LcB
         uvWmV4WGzB+uHUxekDHRA96e9hDtoSsciLWDjzc1VPlq5Ru0wTD/+PzSgaiGkkEWEx0O
         3za1qTfIt3Rt1nFKYbZgM4Qq76pBWcR4iY6E+LUgys7XJ/jxeOEVzMcZfq+aUXg7zwQx
         ThAcbdc9UlqJKZxT2Wclj7FTEqMTfAj2ISQ8WOiDw8Xdha8ifl0/KZhViuUobUwKkych
         rJ2q4qjZikTtthHi46pkOvlWiiGuqcY5duajqiEql3Mli9TwRpjEAvv6rSCvuNbaLeu+
         oRtw==
X-Gm-Message-State: APjAAAUhaZ1qylWwfnNozHWBwAB8rKVTgk15dc4mSEJl2L3CG25kOiBE
        gz6mCE3UkJ+2FTsECEKwxVzsYs1uIWg=
X-Google-Smtp-Source: APXvYqzw3zsnmFepW9bFPFgBHcfLpQZri7oh1XqrLswjAXtPhVt+sv5PwJwNgAVeFdkNkfQxGYXCxQ==
X-Received: by 2002:a02:13c3:: with SMTP id 186mr55698264jaz.30.1563558015488;
        Fri, 19 Jul 2019 10:40:15 -0700 (PDT)
Received: from ?IPv6:2600:1007:b101:1239:e89f:3ba2:18ab:b874? ([2600:1007:b101:1239:e89f:3ba2:18ab:b874])
        by smtp.gmail.com with ESMTPSA id s24sm27177022ioc.58.2019.07.19.10.40.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 19 Jul 2019 10:40:14 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (1.0)
Subject: Re: [5.2 REGRESSION] Generic vDSO breaks seccomp-enabled userspace on i386
From:   Andy Lutomirski <luto@amacapital.net>
X-Mailer: iPhone Mail (16F203)
In-Reply-To: <20190719170343.GA13680@linux.intel.com>
Date:   Fri, 19 Jul 2019 13:40:13 -0400
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Andy Lutomirski <luto@kernel.org>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <19EF7AC8-609A-4E86-B45E-98DFE965DAAB@amacapital.net>
References: <20190719170343.GA13680@linux.intel.com>
To:     Sean Christopherson <sean.j.christopherson@intel.com>,
        keescook@chromium.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Jul 19, 2019, at 1:03 PM, Sean Christopherson <sean.j.christopherson@in=
tel.com> wrote:
>=20
> The generic vDSO implementation, starting with commit
>=20
>   7ac870747988 ("x86/vdso: Switch to generic vDSO implementation")
>=20
> breaks seccomp-enabled userspace on 32-bit x86 (i386) kernels.  Prior to
> the generic implementation, the x86 vDSO used identical code for both
> x86_64 and i386 kernels, which worked because it did all calcuations using=

> structs with naturally sized variables, i.e. didn't use __kernel_timespec.=

>=20
> The generic vDSO does its internal calculations using __kernel_timespec,
> which in turn requires the i386 fallback syscall to use the 64-bit
> variation, __NR_clock_gettime64.

This is basically doomed to break eventually, right?

I=E2=80=99ve occasionally considered adding a concept of =E2=80=9Cseccomp al=
iases=E2=80=9D.  The idea is that, if a filter returns anything other than A=
LLOW, we re-run it with a different nr that we dig out it a small list of su=
ch cases. This would be limited to cases where the new syscall does the same=
 thing with the same arguments.

I want this for restart_syscall: I want to renumber it.

Kees?
