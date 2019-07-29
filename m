Return-Path: <SRS0=K9bG=V2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F7C6C7618B
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 12:24:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5F9C92070D
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 12:24:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="Hc9DVUB9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727964AbfG2MYA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jul 2019 08:24:00 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:36993 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726255AbfG2MX7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jul 2019 08:23:59 -0400
Received: by mail-qk1-f195.google.com with SMTP id d15so43910122qkl.4
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jul 2019 05:23:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=h93KMWTgMZDnkWWP8nidzTcTTS/K0DE/79C+3LGxZF0=;
        b=Hc9DVUB9zGGrVJ8J2XEA+M4C3aZJx9c49dmpHKzoNCU2ejgaEqSxcv3fhGVhL+uzWw
         nHL4gBKdAutOpH1vaKc1M6+W0ck2WmO/L3JPOdrvghzNnafLHj6ur1wKr7AhxxFvvPuO
         6KxorB8bmMspaipmAq0EUj8Du3vfHbwgnUGzgFQHhAd3dK0QvoB12hNRn/RBdV0hltUZ
         3WuVf+t2D413Q+eztp06HMs3MEBWx3stoWCezwzdZJWPXNxgeD+Mkpgk2XvXR1mxBzzS
         +m4M/kIRbiIDW/AKv6ZwMZxdHrWUx0B4rAj66mKfJRrJ1kwrOvJ+8dWdCUCWjDy9t6bG
         SVHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=h93KMWTgMZDnkWWP8nidzTcTTS/K0DE/79C+3LGxZF0=;
        b=QNcsFU3i/i7VaayrMmn/tfKKgqENWAXfn8JQJR0DGJXZPtYkGv5nMpAkZwbDEJAsIn
         D6/P6nJpomgg874pikbR6f3wtBFugF+QJgYmLpuQqR0Q4d6i4AFQigqaG2sdp8hZEik/
         +06FSsTngZWLR12I3eODaOUZnhLg6bd8+Sz/yjSraCPYnfMM+D6j+Cq0INNgPXLcSLKk
         Uxq/VmgCJl0W6dYQMkSelhEJmBXcCbjkoHIVgwaYU01WaqNPcaJEJIPDQnGaB2lqytKd
         wT/Szsd7QI7u/1NbHd4em/yz447ykpJAvgtPuNdvbhR3CxTqMecDkdXwj/+sh01usq5t
         HYow==
X-Gm-Message-State: APjAAAUgexh23xF5dziasSUcPwqJkhH/E4nMc3gS2zYHtUgqe8tXyllq
        /1Q7gMrJFePogwK6S7EVZ7N4Ww==
X-Google-Smtp-Source: APXvYqxrPcU1gM141pqbYW+SSfFaWlhOugMMiTXWccTr698mw4+8vnReZ5XSKCVN6p63tuF/+YFJfQ==
X-Received: by 2002:a37:4a8a:: with SMTP id x132mr74044881qka.42.1564403038878;
        Mon, 29 Jul 2019 05:23:58 -0700 (PDT)
Received: from [192.168.1.153] (pool-71-184-117-43.bstnma.fios.verizon.net. [71.184.117.43])
        by smtp.gmail.com with ESMTPSA id 2sm32890868qtz.73.2019.07.29.05.23.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 29 Jul 2019 05:23:58 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
Subject: Re: [PATCH v2] acpica: fix -Wnull-pointer-arithmetic warnings
From:   Qian Cai <cai@lca.pw>
In-Reply-To: <c98fa373a004472b979255a93b414fe1@AcuMS.aculab.com>
Date:   Mon, 29 Jul 2019 08:23:57 -0400
Cc:     "Moore, Robert" <robert.moore@intel.com>,
        "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>,
        "Schmauss, Erik" <erik.schmauss@intel.com>,
        "jkim@FreeBSD.org" <jkim@FreeBSD.org>,
        "lenb@kernel.org" <lenb@kernel.org>,
        "ndesaulniers@google.com" <ndesaulniers@google.com>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "devel@acpica.org" <devel@acpica.org>,
        "clang-built-linux@googlegroups.com" 
        <clang-built-linux@googlegroups.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <7667BD59-E9FF-4374-AEF6-025FD13837B6@lca.pw>
References: <20190718194846.1880-1-cai@lca.pw>
 <94F2FBAB4432B54E8AACC7DFDE6C92E3B9661CBD@ORSMSX110.amr.corp.intel.com>
 <c98fa373a004472b979255a93b414fe1@AcuMS.aculab.com>
To:     David Laight <David.Laight@ACULAB.COM>
X-Mailer: Apple Mail (2.3445.104.11)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Jul 29, 2019, at 6:24 AM, David Laight <David.Laight@ACULAB.COM> =
wrote:
>=20
> From: Moore, Robert
>> Sent: 26 July 2019 20:36
> ...
>> This is because pointer arithmetic
>> on a pointer not pointing to an array is an undefined behavior (C11 =
6.5.6, constraint 8).
> ...
>=20
> The standards committee as smoking dope again :-)
> If that is enforced as a compiler warning/error a lot of code =
'breaks'.
> Anything that does:
> 	struct foo *foo =3D ...;
>      struct bar *bar =3D (void *)(foo + 1);
> suddenly becomes 'invalid=E2=80=99.

The clang will generate a warning only if =E2=80=9Cfoo" is NULL.

