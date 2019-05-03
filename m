Return-Path: <SRS0=RThv=TD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MIME_QP_LONG_LINE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03840C04AAA
	for <linux-kernel@archiver.kernel.org>; Fri,  3 May 2019 18:55:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CA3CB20B7C
	for <linux-kernel@archiver.kernel.org>; Fri,  3 May 2019 18:55:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=amacapital-net.20150623.gappssmtp.com header.i=@amacapital-net.20150623.gappssmtp.com header.b="Ze7V2HJI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726760AbfECSzA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 May 2019 14:55:00 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:40438 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725997AbfECSy7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 May 2019 14:54:59 -0400
Received: by mail-pg1-f194.google.com with SMTP id d31so3128419pgl.7
        for <linux-kernel@vger.kernel.org>; Fri, 03 May 2019 11:54:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20150623.gappssmtp.com; s=20150623;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=jNpdn+5fsvrXYWS1t6q6BGlDjSLyaro1hz6w+Z7cVVc=;
        b=Ze7V2HJIleQKSjHWj+M8QP+fsyogjvoif9Jv4VUtem6IBwfSqPNCJyVFNS20XYCvAG
         XiSiR4FfiR7PHepl3n7MzONfPKL6x8eNJK/acB633DENM67QE2n0/ZXkJLw07kzUybk+
         8kdjfjTk04bOmEI3V8gE/VRanycjWAJaY9U6Wt2lUgZkp9y3k45UTcrG/mMVasY2yJa/
         EMclqm+L5FRQAeoGKA1ajR/gwJ/S8KScXoReh8pvIKw6ta+j6lxXVx7/hNFcLt5bvJHV
         8tG0lvQIn0cr9hI0S69KAzETz2P7hsKN1/WCQUOS2+4Xsodv1Bo004jz2TEtsDGvrUxO
         ej/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=jNpdn+5fsvrXYWS1t6q6BGlDjSLyaro1hz6w+Z7cVVc=;
        b=X47F1unfAbr+GlNdpX+Vc2xJL9tM9TDXE62Zuu5kn9iGA+2n5or+Ic9Nu+fA7tt+Nm
         AAY8LPqE5/6qAzWvM103hLNeChUAoLLP2z7DTQiBrfMCbssNyi9y0E+NdE/hrGEMWpDh
         ZkTUeOLOo3FprUfluX+wc005u9wJU+IBlL5uE73F7IR0sPnsDXcKYs/H+rZzIPyAvb9M
         azy4/3m2nLe7lia/GrhwFYD2QbVGCLHUosIpRCltRx3YApBp6/VUmRX1IuaFsLvvvHnH
         +r8e3YYTThLiQtf2Yhq47SEW6Py8z1eHv0Xo6wsgRqrCAfUyGM6XTO3j8aZA0qQtoXOo
         cVXw==
X-Gm-Message-State: APjAAAU6e/ncVdJv08Goh6cAkgIMzEzRWtTZMq+oN2awneSomM5HKxsh
        REejE4GfEVafEC/pGsiYir3Pug==
X-Google-Smtp-Source: APXvYqyOx4Yo9LyGCpB/b93ZM96vMHUoRHsvkvZjQ9woG0NDbEa22gAW2OzlNpE6diohJG8LJ5sk9Q==
X-Received: by 2002:a62:164f:: with SMTP id 76mr13278829pfw.172.1556909698011;
        Fri, 03 May 2019 11:54:58 -0700 (PDT)
Received: from ?IPv6:2600:1010:b051:5fe3:59e6:3e7a:27ff:af6f? ([2600:1010:b051:5fe3:59e6:3e7a:27ff:af6f])
        by smtp.gmail.com with ESMTPSA id v15sm3711892pff.105.2019.05.03.11.54.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 03 May 2019 11:54:56 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH] x86/fpu: Remove the _GPL from the kernel_fpu_begin/end() export
From:   Andy Lutomirski <luto@amacapital.net>
X-Mailer: iPhone Mail (16E227)
In-Reply-To: <20190503180739.GF5020@zn.tnic>
Date:   Fri, 3 May 2019 11:54:54 -0700
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Andy Lutomirski <luto@kernel.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Greg KH <gregkh@linuxfoundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Rik van Riel <riel@surriel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Ingo Molnar <mingo@redhat.com>,
        Nicolai Stange <nstange@suse.de>,
        =?utf-8?Q?Radim_Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>, X86 ML <x86@kernel.org>,
        stable <stable@vger.kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <5BD87ACE-1200-4612-AA83-1590DA9E45E5@amacapital.net>
References: <761345df6285930339aced868ebf8ec459091383.1556807897.git.luto@kernel.org> <20190502154043.gfv4iplcvzjz3mc6@linutronix.de> <CALCETrWTCB9xLVdKCODghpeQpJ_3Rz3OwE8FB+5hjYXMYwYPLg@mail.gmail.com> <20190502165520.GC6565@zn.tnic> <bcb6c893-61e6-4b08-5b40-b1b2e24f495b@redhat.com> <20190503180739.GF5020@zn.tnic>
To:     Borislav Petkov <bp@alien8.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> On May 3, 2019, at 11:07 AM, Borislav Petkov <bp@alien8.de> wrote:
>=20
>> On Fri, May 03, 2019 at 11:21:15AM -0600, Paolo Bonzini wrote:
>> Your observation that the API only exists on x86 and s390 has no bearing
>> to whether the functions should be EXPORT_SYMBOL_GPL or EXPORT_SYMBOL.
>> ARM has kernel_neon_begin/end, PPC has enable/disable_kernel_altivec.
>> It's just that SIMD code is so arch-specific that nobody has bothered
>> unifying the namings (or, nobody considers the different names a problem
>> at all).
>=20
> This is actually proving my point: there wasn't any real agreement on
> what interfaces should be immutable so that out-of-tree code can use
> them and us guaranteeing they won't change. Instead, it was a random
> thing that just happened.
>=20

I don=E2=80=99t think I or has said we should try to make these interfaces i=
mmutable. What I=E2=80=99m saying is that, since we=E2=80=99re exporting the=
 symbol anyway and it=E2=80=99s not particularly Linuxy, that we shouldn=E2=80=
=99t say that only *GPL* out-of-tree modules may use it.  It seems like anyo=
ne who wants to put the effort into tracking which kernel has which symbols a=
nd is willing to accept the utter instability of the interface may use it.

So if we ever unexport the symbol entirely, I won=E2=80=99t object.  I objec=
t to what I consider to be the inappropriate claim that it=E2=80=99s a *GPL*=
 export.

(I actually hope we unexport it once simd_get() and friends land =E2=80=94 t=
hey=E2=80=99re a much better API, and we should migrate over to it.)


