Return-Path: <SRS0=camR=ZD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 398B9C43331
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 20:36:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0819F20659
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 20:36:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B9HpL7Sh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727505AbfKKUgL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Nov 2019 15:36:11 -0500
Received: from mail-il1-f196.google.com ([209.85.166.196]:41074 "EHLO
        mail-il1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726955AbfKKUgK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Nov 2019 15:36:10 -0500
Received: by mail-il1-f196.google.com with SMTP id q15so8197601ils.8
        for <linux-kernel@vger.kernel.org>; Mon, 11 Nov 2019 12:36:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=RhwkYq4Xoz6qbJxRjALfE8MZM5xtYEgYwlSWURLNNtQ=;
        b=B9HpL7ShmycybCbB/KdQWKQzEjjgaaa2GSg05G+IyWGcNoKGdgq+i3AiZZCpkls2rS
         gWMgTexeJ+B4g7hN2MsYpn0sfu/aBgzJ6zU7levUDZ604CgComvqjicKfg73ofP3OH25
         9ycCPobwBCJUpzAIFobC/0KchLKnUC7Z6IiPn2X8cpZQ/YAbllHMWVb/3AMBcBaf4KoW
         dScRXQubsprrYmMAUXK6/M3tTpcYw7KrdK55qvc1kEfnPqYpfwtGm1Vm/W2RlRZstHAo
         R7Y38IjXOHk9FgG6h87nYylUA5Q04K6tz486W2iWPF60eTVLBAjh/3o1o4P8F0lQR7mt
         mjSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=RhwkYq4Xoz6qbJxRjALfE8MZM5xtYEgYwlSWURLNNtQ=;
        b=A/LQ2NNxlkDET8Bv9qBSFfOnKWgXbld0NWYfNZy47frHWtmIFX9iXFGaexdp4yAYgq
         joWKubQ0rIonrEq9KCFVk1JK/2cKUqpCyCGNW3jlAARfb5EPL9A1hhn+nlBI38FDr9T+
         s8jXBndeSx+vXLB6Wj2sLFrbMFW7R1eWh+KfOSMvyUx9N6GDbosxfFimCzmkYKcwQ3Lf
         FlcVFL2l3hOvQrsCu40yhmLFeUJU1M9d3GzSg8RcdC3tBX7tAtuN1Vdb7+3EZRyjPSU9
         LMCiywRBs0SfOhR5OPf9E4HOoNAPqs8dTlHOkooRK11kjgvZJ1t7qfLep96oQl/VIUSV
         /uqQ==
X-Gm-Message-State: APjAAAXgtMHowZvooHE9KipBhtgV0fuLiDl7Vlu5zmSqjInUZGC8YYuq
        Mx6KKkmra5yuGAlEsAhP0U4mEdqGIoS7mbu5D5A=
X-Google-Smtp-Source: APXvYqw/oX9kFdOdp1RxxwqQqOlb8BoSGIn/0vDLMRtz4c5Dc3hYdAWfMCCtxk3vtpCQEBmY83VIYWpzy68OPyIjcJo=
X-Received: by 2002:a92:7786:: with SMTP id s128mr33173924ilc.204.1573504569865;
 Mon, 11 Nov 2019 12:36:09 -0800 (PST)
MIME-Version: 1.0
References: <20191021193343.41320-1-kdasu.kdev@gmail.com> <20191105200344.1e8c3eab@xps13>
 <1718371158.75883.1572995022606.JavaMail.zimbra@nod.at>
In-Reply-To: <1718371158.75883.1572995022606.JavaMail.zimbra@nod.at>
From:   Kamal Dasu <kdasu.kdev@gmail.com>
Date:   Mon, 11 Nov 2019 15:35:59 -0500
Message-ID: <CAC=U0a3_OKJ7Fza_5WAst1BZjGm+4e-JvgZZ_QYpL1m5siTYEA@mail.gmail.com>
Subject: Re: [PATCH] mtd: set mtd partition panic write flag
To:     Richard Weinberger <richard@nod.at>
Cc:     Miquel Raynal <miquel.raynal@bootlin.com>,
        linux-mtd <linux-mtd@lists.infradead.org>,
        bcm-kernel-feedback-list <bcm-kernel-feedback-list@broadcom.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        Vignesh Raghavendra <vigneshr@ti.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Richard,

On Tue, Nov 5, 2019 at 6:03 PM Richard Weinberger <richard@nod.at> wrote:
>
> ----- Urspr=C3=BCngliche Mail -----
> > Von: "Miquel Raynal" <miquel.raynal@bootlin.com>
> > An: "Kamal Dasu" <kdasu.kdev@gmail.com>
> > CC: "linux-mtd" <linux-mtd@lists.infradead.org>, "bcm-kernel-feedback-l=
ist" <bcm-kernel-feedback-list@broadcom.com>,
> > "linux-kernel" <linux-kernel@vger.kernel.org>, "David Woodhouse" <dwmw2=
@infradead.org>, "Brian Norris"
> > <computersforpeace@gmail.com>, "Marek Vasut" <marek.vasut@gmail.com>, "=
richard" <richard@nod.at>, "Vignesh Raghavendra"
> > <vigneshr@ti.com>
> > Gesendet: Dienstag, 5. November 2019 20:03:44
> > Betreff: Re: [PATCH] mtd: set mtd partition panic write flag
>
> > Hi Kamal,
> >
> > Richard, something to look into below :)
>
> I'm still recovering from a bad cold. So my brain is not fully working ;)

Thanks for reviewing this. Hope you are feeling better now.

>
> > Kamal Dasu <kdasu.kdev@gmail.com> wrote on Mon, 21 Oct 2019 15:32:52
> > -0400:
> >
> >> Check mtd panic write flag and set the mtd partition panic
> >> write flag so that low level drivers can use it to take
> >> required action to ensure oops data gets written to assigned
> >> mtd partition.
> >
> > I feel there is something wrong with the current implementation
> > regarding partitions but I am not sure this is the right fix. Is this
> > something you detected with some kind of static checker or did you
> > actually experience an issue?
> >
> > In the commit log you say "check mtd (I suppose you mean the
> > master) panic write flag and set the mtd partition panic write flag"
> > which makes sense, but in reality my understanding is that you do the
> > opposite: you check mtd->oops_panic_write which is the partitions'
> > structure, and set part->parent->oops_panic_write which is the master's
> > flag.
>
> IIUC the problem happens when you run mtdoops on a mtd partition.
> The the flag is only set for the partition instead for the master.
>
> So the right fix would be setting the parent's oops_panic_write in

How do I get access to the parts parent in the core ?. Maybe I am
missing something.

> mtd_panic_write().
> Then we don't have to touch mtdpart.c
>
> Thanks,
> //richard
