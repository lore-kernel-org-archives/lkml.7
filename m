Return-Path: <SRS0=8t7v=ZS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF986C432C3
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Nov 2019 15:29:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AFC8A20678
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Nov 2019 15:29:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728493AbfKZP3U (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Nov 2019 10:29:20 -0500
Received: from smtpq3.tb.mail.iss.as9143.net ([212.54.42.166]:41006 "EHLO
        smtpq3.tb.mail.iss.as9143.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727135AbfKZP3U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Nov 2019 10:29:20 -0500
Received: from [212.54.42.137] (helo=smtp6.tb.mail.iss.as9143.net)
        by smtpq3.tb.mail.iss.as9143.net with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.90_1)
        (envelope-from <jongk@linux-m68k.org>)
        id 1iZcmD-0000kO-Ni; Tue, 26 Nov 2019 16:29:17 +0100
Received: from mail-wm1-f45.google.com ([209.85.128.45])
        by smtp6.tb.mail.iss.as9143.net with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.90_1)
        (envelope-from <jongk@linux-m68k.org>)
        id 1iZcmD-0001Np-JO; Tue, 26 Nov 2019 16:29:17 +0100
Received: by mail-wm1-f45.google.com with SMTP id g206so3674734wme.1;
        Tue, 26 Nov 2019 07:29:17 -0800 (PST)
X-Gm-Message-State: APjAAAUA+aMOBioXdI8sBwCaCLpNMXEfzYftgM+LYUBINjz1tMC8DlQe
        zMMzdU8k6pUOQmGm5Ae6nqhZyB87oRbnfJb6abQ=
X-Google-Smtp-Source: APXvYqyOkLS0wJVUdJYu1Q6ijkEqKlbukKX/UBClH3eTiS7tBWK60bcawei/HX132m5hCWHGlr/BiqgzqpW/wWbt0N8=
X-Received: by 2002:a05:600c:c3:: with SMTP id u3mr4581717wmm.35.1574782157366;
 Tue, 26 Nov 2019 07:29:17 -0800 (PST)
MIME-Version: 1.0
References: <20191124195225.31230-1-jongk@linux-m68k.org> <CAMuHMdVv9FU+kTf7RDd=AFKL12tJxzmGbX4jZZ8Av3VCZUzwhA@mail.gmail.com>
 <20191126144121.kzkujr27ga36gqnf@wittgenstein>
In-Reply-To: <20191126144121.kzkujr27ga36gqnf@wittgenstein>
From:   Kars de Jong <jongk@linux-m68k.org>
Date:   Tue, 26 Nov 2019 16:29:06 +0100
X-Gmail-Original-Message-ID: <CACz-3riWp1fWCaAJtMgRx9VRVAJ+ktdbAqHBobQUXR9XpHrVcQ@mail.gmail.com>
Message-ID: <CACz-3riWp1fWCaAJtMgRx9VRVAJ+ktdbAqHBobQUXR9XpHrVcQ@mail.gmail.com>
Subject: Re: [PATCH] m68k: Wire up clone3() syscall
To:     Christian Brauner <christian.brauner@ubuntu.com>
Cc:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Linux/m68k" <linux-m68k@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-SourceIP: 209.85.128.45
X-Authenticated-Sender: karsdejong@home.nl (via SMTP)
X-Ziggo-spambar: /
X-Ziggo-spamscore: 0.0
X-Ziggo-spamreport: CMAE Analysis: v=2.3 cv=WMwBoUkR c=1 sm=1 tr=0 a=9+rZDBEiDlHhcck0kWbJtElFXBc=:19 a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19 a=IkcTkHD0fZMA:10 a=MeAgGD-zjQ4A:10 a=fxJcL_dCAAAA:8 a=tBb2bbeoAAAA:8 a=VwQbUJbxAAAA:8 a=WQa4lTAXJXru5Gui9GYA:9 a=QEXdDO2ut3YA:10 a=Oj-tNtZlA1e06AYgeCfH:22 a=AjGcO6oz07-iQ99wixmX:22
X-Ziggo-Spam-Status: No
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Christian!

Op di 26 nov. 2019 om 15:41 schreef Christian Brauner
<christian.brauner@ubuntu.com>:
>
> On Mon, Nov 25, 2019 at 10:12:25AM +0100, Geert Uytterhoeven wrote:
> > Hi Kars,
> >
> > On Sun, Nov 24, 2019 at 8:52 PM Kars de Jong <jongk@linux-m68k.org> wrote:
> > > Wire up the clone3() syscall for m68k. The special entry point is done in
> > > assembler as was done for clone() as well. This is needed because all
> > > registers need to be saved. The C wrapper then calls the generic
> > > sys_clone3() with the correct arguments.
> > >
> > > Tested on A1200 using the simple test program from:
> > >
> > >   https://lore.kernel.org/lkml/20190716130631.tohj4ub54md25dys@brauner.io/
>
> Please note that we now have a growing test-suite for the clone3()
> syscall under
> tools/testing/selftests/clone3/*
>
> You can test on a suitable kernel with
>
> make TARGETS=clone3 kselftest

I'm afraid my user space is almost prehistoric. I have a homebrewn
root filesystem of about 2001 vintage, and another one with Debian
3.1.
So until I have bootstrapped a more recent one, I'll leave that to others ;-)

Thanks for checking!

Kind regards,

Kars.
