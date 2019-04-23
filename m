Return-Path: <SRS0=LehB=SZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E1ACC10F03
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 23:57:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 07FF421738
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 23:57:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=amacapital-net.20150623.gappssmtp.com header.i=@amacapital-net.20150623.gappssmtp.com header.b="nC43+fai"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728778AbfDWX5k (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Apr 2019 19:57:40 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:46348 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727831AbfDWX5j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Apr 2019 19:57:39 -0400
Received: by mail-pg1-f194.google.com with SMTP id v2so5978423pge.13
        for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2019 16:57:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20150623.gappssmtp.com; s=20150623;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=VkhkJzaUTJucDFJB4blA7Ip3YzN/Wig4l799HSQpMjA=;
        b=nC43+faiEiLWdsHjzm1N6VK4KXtojrzbDDbnRGt4eroC4+Y5cvIarBcNfDIr4qeqM1
         AIlieglWT/Zp5ZK5z0HaN75BYOOPvIkfHMlx1csp6qQzNjoKx+oKXDExBgnGF0F0bH7o
         18PjxFTfyN/hkCYP90S5zq8yc1RFP1xEHsayb6Ee4sbV4NODRQmPUmlbBz6uFYRU5ncE
         XrtPqAdlfxYqsgWO11f19hveuEWVEPl72WDLk+GzF5CZaCTqZh8MnCdmdw+rU6SR6lr2
         TR2C71Dsoln2DRoHNNxBCj1HhDzDQHOdR/WQaGPkRbHYQa2Sh9fsIS2w6LppNKOdGDpG
         BSpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=VkhkJzaUTJucDFJB4blA7Ip3YzN/Wig4l799HSQpMjA=;
        b=la0rzQEF0vZg8QwACqCXjLVLDPDFLPeTu+jFMUFXVpA9DINdcPRLpe9yhrB2aHLVfw
         cD9twLaAMUWaMUFjbas7ejgqU43si9vxnQ6vyXbbCFKdAX5swIaKQo7fGQRRIG1mZY6O
         QARFgAv35J3wA/fpqiUxKMf9PxXUnDM63z3PNlW0Dlo6YfugsYh+HepnuxnbamcdaFy+
         ePsWDIE70Mp7YrNQ/l2g1+IZWJq+1wy9H0ukgGyx285hKJ6rPkzeTwp1CB/VgqA/p4gj
         eKAAFumP3PFGk5vwR3skb5JNaLFuXCHTstSBn/uIBgxsNtX9yMJLeNMSXZBGMxD/XktJ
         j1RQ==
X-Gm-Message-State: APjAAAUIn53YsDJWUZ8otfxRY0tRVCFRte8cyoWf1ruXgwmfeyb3X+7x
        G+jDoSShHATI11MwCTSYOGg32w==
X-Google-Smtp-Source: APXvYqyr//zmsRSf6pWlt/PZUHMNiUInLEV4QH7aC+VRj4xm+CjoiNPHaX1b7e3zR3ddhn2fxr502w==
X-Received: by 2002:a63:1e4f:: with SMTP id p15mr17410496pgm.289.1556063858579;
        Tue, 23 Apr 2019 16:57:38 -0700 (PDT)
Received: from ?IPv6:2600:1010:b02a:3fc2:653f:d30:32fb:18de? ([2600:1010:b02a:3fc2:653f:d30:32fb:18de])
        by smtp.gmail.com with ESMTPSA id m11sm36068085pgd.12.2019.04.23.16.57.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 23 Apr 2019 16:57:37 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (1.0)
Subject: Re: Does vdso_install attempt to re-compile objects under root privilege?
From:   Andy Lutomirski <luto@amacapital.net>
X-Mailer: iPhone Mail (16E227)
In-Reply-To: <CAHk-=wiV2gLQkp6JFQYewL1uzgWnwEK9fKWP3AfZbcu2Lv_GrQ@mail.gmail.com>
Date:   Tue, 23 Apr 2019 16:57:36 -0700
Cc:     Andy Lutomirski <luto@kernel.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>, X86 ML <x86@kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <A160B301-5F50-4E0C-B995-A626886A91E7@amacapital.net>
References: <CAK7LNAQwHRJL=3yD_7P2mMSVnwZbayww+dHC22+v4oTpMZv58w@mail.gmail.com> <CALCETrVSM0vrMVr2y0ECAQ=tNGvBs=im2Kxongq-jvdzUBevbg@mail.gmail.com> <CAHk-=wiV2gLQkp6JFQYewL1uzgWnwEK9fKWP3AfZbcu2Lv_GrQ@mail.gmail.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Apr 23, 2019, at 4:38 PM, Linus Torvalds <torvalds@linux-foundation.org=
> wrote:
>=20
>> On Tue, Apr 23, 2019 at 11:47 AM Andy Lutomirski <luto@kernel.org> wrote:=

>>=20
>> Hmm.  I suppose an alternative would be for vdso_install to fail if
>> the vdso isn't built?
>=20
> I absolutely abhor even the concept of building the kernel as root,
> and I think it should be actively disallowed. Our build system is
> good, but it's good as in "clever and complex" rather than necessarily
> good as in "very secure".
>=20
> So anybody who builds the kernel as root is doing something seriously
> wrong, in my opinion.
>=20
> That's partly exactly _because_ we have a lot of magical and very
> powerful build rules, and complicated implicit things going on.
>=20
> For example, our dependencies aren't even about just the files in the
> kernel repository itself, we have clever things like "if the compiler
> has been updated and features or version changes, we'll automatically
> rebuild, because it's part of our clever build system checks".
>=20
> But that is also part of the reason why I absolutely do *not* want any
> root-building to happen, because our build setup is simply way too
> clever.
>=20
> If root builds stuff, you'll end up with root-owned generated
> subdirectories or various config files etc, and even if you don't have
> security issues, it can complicate the build later as a regular user.
>=20
> I've had the build occasionally fail in odd ways, because some
> root-owned file was now no longer removable (usually it's the
> auto-generated header files in the directory, and the root-generated
> and owned directory is now not writable by the developer any more).
> And every time it happens, I shudder.
>=20
> So all of that simply boils down to "root should not be running those
> complex rules for our config and dependency magic".
>=20
> At the same time, "make install" obviously needs to be done as root.
>=20
> All of which is why I opine that "make install" should never build
> anything at all, it should purely be used as a "install previously
> built files".
>=20
> So yes, I'd much prefer just failing over trying to build as root (or
> even trying to figure out dependencies as root).
>=20
>> What's the ideal outcome here?
>=20
> I'd basically like the rule for "make install" to be that it never
> ever generates a single file in the build tree, so that there are
> never any root-owned (or root-overwritten) files there.
>=20
> So "make install" should even avoid all dependency checking, for the
> simple reason that if you happen to do a system update between "make"
> and "make install", our smart dependencies should never say "oh, the
> compiler version has changed, so now I'll rebuild everything as root
> just because 'make install'".
>=20
> So I think the ideal outcome is just "fail if you can't find the files
> to install".
>=20
>=20

To clarify, this is =E2=80=9Cfail if you can=E2=80=99t find the files to ins=
tall, but don=E2=80=99t even try to check whether those files are up to date=
=E2=80=9D, right?=
