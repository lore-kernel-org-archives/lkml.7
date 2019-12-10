Return-Path: <SRS0=jko7=2A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72CCAC43603
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 15:29:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4033220828
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 15:29:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=amacapital-net.20150623.gappssmtp.com header.i=@amacapital-net.20150623.gappssmtp.com header.b="r0JdLzmk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727565AbfLJP3z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Dec 2019 10:29:55 -0500
Received: from mail-pj1-f68.google.com ([209.85.216.68]:38452 "EHLO
        mail-pj1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727380AbfLJP3y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Dec 2019 10:29:54 -0500
Received: by mail-pj1-f68.google.com with SMTP id l4so7546385pjt.5
        for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2019 07:29:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20150623.gappssmtp.com; s=20150623;
        h=content-transfer-encoding:from:mime-version:subject:date:message-id
         :references:cc:in-reply-to:to;
        bh=2m22tRgRbycGVEq+HVbXDKyMLb2WG5FY05Buaglo9kM=;
        b=r0JdLzmkZyMw5U1N8SSKuKPpSPZBRu+iwEoZMlFIyi3yWca1kiu95uT/H40Ku4JEJs
         UAQhPgiiUxurKjHE7cRJ9UtwxYVm3UUHbNseBlL3mGf0snPT5C8543snsENdosoncC/G
         cRb7kVJEhBZQWIsstysaGrcbiHO1lWsE4PzmbdtaVrdq1JR4uFle9Q1ohNcc6tN1Bivv
         FdB7q3gH8oCkmrjwjh7A+kAhy3zWozUQccExZiS5xkxcoE/5SW53nLIhOz77LJ2aCuNc
         BSNM8roab+j3D6+RVyFZAzuNMpFJiaL7D/HjXi/jBHsShi8WmUvuWzgYxehLtFFIVevf
         FL+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:content-transfer-encoding:from:mime-version
         :subject:date:message-id:references:cc:in-reply-to:to;
        bh=2m22tRgRbycGVEq+HVbXDKyMLb2WG5FY05Buaglo9kM=;
        b=BZ0oHql41PvKXdsP1LpdN/tOdSxA3xT91eIb7f0R+H7Q++MOVIQ0WxLU28KBaupbMC
         fJMnPImDgQK6kgeD7UsaYn0wpp0yY+GJkY6PBEHO06IFMkfLBpfPPaqNc2fIdh8YQSKU
         fG1tE92h65ON32DMRBnZoGPN+j0BU8aqqBNT/5Inyz9jbBcw6gopzt7TR6SqGPKVVqaz
         SrjeWfowyrsA7V5IqN4PtYsvh/kJBjAKYjFnIfM/46ufgu8Bqw0WhBWJ2cEYCoikdtkJ
         bsSSKRxOfDz39/lGyHT3keUr9JXz+sBlEXcqMVCWc8zSOU1eIyB8e7ikXCkQMt8Y5Kdw
         QFdw==
X-Gm-Message-State: APjAAAWcdSEkSiGfgJP/mCNr4UcTOGpyo1ddBBTI3z6pTn3O4414M9M3
        Jd4pKn3G6GSdhfkedUULmEJb7A==
X-Google-Smtp-Source: APXvYqyHQzkzTLkwLjbXtc6sUNJJurnhyP/lLslash6Z9KOPtwCs7R/U0YPczA84LkoNP5xz0hxYvg==
X-Received: by 2002:a17:902:b68c:: with SMTP id c12mr35217696pls.126.1575991793962;
        Tue, 10 Dec 2019 07:29:53 -0800 (PST)
Received: from ?IPv6:2601:646:c200:1ef2:1854:f81f:5bdb:c33c? ([2601:646:c200:1ef2:1854:f81f:5bdb:c33c])
        by smtp.gmail.com with ESMTPSA id j18sm3743530pfn.112.2019.12.10.07.29.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Dec 2019 07:29:53 -0800 (PST)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From:   Andy Lutomirski <luto@amacapital.net>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH] x86-64/entry: add instruction suffix to SYSRET
Date:   Tue, 10 Dec 2019 07:29:52 -0800
Message-Id: <08B92B44-CCA9-4B83-B9CC-F1601D44B73F@amacapital.net>
References: <cbecab05-9e95-5dec-ef81-499617c153a6@suse.com>
Cc:     Andy Lutomirski <luto@kernel.org>,
        the arch/x86 maintainers <x86@kernel.org>,
        lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <cbecab05-9e95-5dec-ef81-499617c153a6@suse.com>
To:     Jan Beulich <JBeulich@suse.com>
X-Mailer: iPhone Mail (17A878)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Dec 10, 2019, at 2:48 AM, Jan Beulich <JBeulich@suse.com> wrote:
>=20
> =EF=BB=BFOmitting suffixes from instructions in AT&T mode is bad practice w=
hen
> operand size cannot be determined by the assembler from register
> operands, and is likely going to be warned about by upstream gas in the
> future. Add the missing suffix here.
>=20
> Signed-off-by: Jan Beulich <jbeulich@suse.com>
>=20
> --- a/arch/x86/entry/entry_64.S
> +++ b/arch/x86/entry/entry_64.S
> @@ -1728,7 +1728,7 @@ END(nmi)
> SYM_CODE_START(ignore_sysret)
>    UNWIND_HINT_EMPTY
>    mov    $-ENOSYS, %eax
> -    sysret
> +    sysretl

Isn=E2=80=99t the default sysretq?  sysretl looks more correct, but that sug=
gests that your changelog is wrong.

Is this code even reachable?

> SYM_CODE_END(ignore_sysret)
> #endif
>=20
