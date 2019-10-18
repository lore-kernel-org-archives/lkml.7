Return-Path: <SRS0=6OEZ=YL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7BFBCA9EA9
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 21:52:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A608920700
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 21:52:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2440345AbfJRVwu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Oct 2019 17:52:50 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:35744 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2394243AbfJRVwu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Oct 2019 17:52:50 -0400
Received: by mail-ot1-f65.google.com with SMTP id z6so6230865otb.2;
        Fri, 18 Oct 2019 14:52:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HvighmfITJLDYGeaiDUTpHYE/uCdU2psCtkCA9EvB0w=;
        b=Nu9Ve2oDpOof/eGiT7OPcea6CzsmSr5ukKTenpPwHxIqyYxY77mROE/qryNg8KG7lj
         SVZk5Ec3XJ52g0IZPwPY0kAShzwMZ0rkiFTApPvEYWtoHwowr/2a1vmnDOhdORMydEAg
         j9duL26c36oqVm1NGdhzsnopTIxplJUvlfHGKB+5QS13LePbacEI7q3bEmSQHiOt2z5d
         3H/0HOyqT0ERySbxs6SSFRrDaIhdqvnN/Al1ARHCl3puyWvCcMLHP+sbe1XZ/2zHvej7
         gYCmR8D/ADcS6PZbo6VXevclq08tcGroaq/gharU/VCBXdUfZRKNPKzt+xYWwT1cAuUD
         VMEw==
X-Gm-Message-State: APjAAAU0nQitoxloGzVeuZikurtHLDZsv6aIMiQE4oj9bt67sjs6AcvG
        iqzFByg01qa0e57uoLIFgB5zdwFp
X-Google-Smtp-Source: APXvYqxREG1tr1Cigq+v82UQPbTeqk/Bp8wNDigWOclFGW7C0PMHO75w2B94+RuSKNNqSTjLfpCCFQ==
X-Received: by 2002:a05:6830:4c7:: with SMTP id s7mr9410967otd.3.1571435569212;
        Fri, 18 Oct 2019 14:52:49 -0700 (PDT)
Received: from mail-ot1-f44.google.com (mail-ot1-f44.google.com. [209.85.210.44])
        by smtp.gmail.com with ESMTPSA id x140sm1736340oix.42.2019.10.18.14.52.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 18 Oct 2019 14:52:48 -0700 (PDT)
Received: by mail-ot1-f44.google.com with SMTP id c10so6198418otd.9;
        Fri, 18 Oct 2019 14:52:48 -0700 (PDT)
X-Received: by 2002:a9d:4d0d:: with SMTP id n13mr9769808otf.74.1571435568401;
 Fri, 18 Oct 2019 14:52:48 -0700 (PDT)
MIME-Version: 1.0
References: <20191018125234.21825-1-linux@rasmusvillemoes.dk>
 <VE1PR04MB6687DA0268FAF03D3E77A23B8F6C0@VE1PR04MB6687.eurprd04.prod.outlook.com>
 <e02fa027-9c78-3272-d2d7-7ad2b0ed3ab0@rasmusvillemoes.dk>
In-Reply-To: <e02fa027-9c78-3272-d2d7-7ad2b0ed3ab0@rasmusvillemoes.dk>
From:   Li Yang <leoyang.li@nxp.com>
Date:   Fri, 18 Oct 2019 16:52:37 -0500
X-Gmail-Original-Message-ID: <CADRPPNREUK1SVxO4P5qb2COn+T04dtYgpVEzrveKUt16hBqAtQ@mail.gmail.com>
Message-ID: <CADRPPNREUK1SVxO4P5qb2COn+T04dtYgpVEzrveKUt16hBqAtQ@mail.gmail.com>
Subject: Re: [PATCH 0/7] towards QE support on ARM
To:     Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc:     Qiang Zhao <qiang.zhao@nxp.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>, Timur Tabi <timur@kernel.org>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 18, 2019 at 3:54 PM Rasmus Villemoes
<linux@rasmusvillemoes.dk> wrote:
>
> On 18/10/2019 22.16, Leo Li wrote:
> >
> >>
> >> There have been several attempts in the past few years to allow building the
> >> QUICC engine drivers for platforms other than PPC. This is (the beginning of)
> >> yet another attempt. I hope I can get someone to pick up these relatively
> >> trivial patches (I _think_ they shouldn't change functionality at all), and then
> >> I'll continue slowly working towards removing the PPC32 dependency for
> >> CONFIG_QUICC_ENGINE.
> >
> > Hi Rasmus,
> >
> > I don't fully understand the motivation of this work.  As far as I know the QUICC ENGINE is only used on PowerPC based SoCs.
>
> Hm, you're not the Leo Li that participated in this thread
> <https://lore.kernel.org/lkml/AM3PR04MB11857AE8D2B0BE56121B97D391C90@AM3PR04MB1185.eurprd04.prod.outlook.com/T/#u>?

Oops, I totally forgot about this discussion which is just three years
ago.  :)  The QE-HDLC on LS1021a is kind of a special case.

>
>
>  Can you give an example on how is it used on ARM system?
>
> LS1021A, for example, which is the one I'm aiming for getting fully
> supported in mainline.
> <https://www.nxp.com/products/processors-and-microcontrollers/arm-processors/layerscape-communication-process/qoriq-layerscape-1021a-dual-core-communications-processor-with-lcd-controller:LS1021A>
>
> The forks at https://github.com/qoriq-open-source/linux.git have various
> degrees of support (grep for commits saying stuff like "remove PPCisms"
> - some versions can be found on
> <https://lore.kernel.org/lkml/?q=remove+ppcisms>). Our current kernel is
> based on commits from the now-vanished 4.1 branch, and unfortunately at
> least the 4.14 branch (LSDK-18.06-V4.14) trivially doesn't build on ARM,
> despite the PPC32 dependency having been removed from CONFIG_QUICC_ENGINE.

Can you try the 4.14 branch from a newer LSDK release?  LS1021a should
be supported platform on LSDK.  If it is broken, something is wrong.

>
> >>
> >> Tested on an MPC8309-derived board.
> >
> > MPC8309 is also PPC based.
>
> True, of course. This is just some first few steps, and I'm not claiming
> that this is sufficient to make the QE drivers build on ARM yet. But I
> have a customer with both mpc8309-based and ls1021a-based platforms, and
> they want to run the same, as-close-to-mainline-as-possible, kernel on
> both. So I will take a piecemeal approach, and try to make sure I don't
> break the ppc boards in the process (just building and booting one board
> is of course not sufficient, but better than nothing). Once I get to
> actually build some of the QE drivers for ARM, I'll of course also test
> them.

Understood.  Zhao Qiang also maintains some patches similar to your
patchset and I think they are tested on ARM.  But the review of these
patches from last submission didn't finish.  It looks like your
patches are better divided but not really verified on ARM.  Zhao
Qiang's patches are tested but maybe need some final touch for
cleaning up.  I will let you guys decide what is the best approach to
make this upstreamed.

Regards,
Leo
