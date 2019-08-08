Return-Path: <SRS0=IWld=WE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B019EC32751
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 03:26:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 76CA721873
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 03:26:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OibWP8Mo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728345AbfHHD0C (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Aug 2019 23:26:02 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:33358 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728019AbfHHD0C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Aug 2019 23:26:02 -0400
Received: by mail-ed1-f67.google.com with SMTP id i11so25207341edq.0;
        Wed, 07 Aug 2019 20:26:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=QJF5KkLbVrVBnjHUA0f0vsLZgWb5LYS9Tbu0X4IhjlQ=;
        b=OibWP8MoiklKgizvfLdsNAsynHNxnNIWaCKS+Eb/en4J160JrnpldIBMUlaMsZYO8P
         SdRUazIU5/JBlJBdmbhFNijftvqYd5gg03jMadEMoSTQKJ5yoQ6QyU+p4q3fCp5LiPzD
         WFUfEZPalAnA+/ybm9h62TutL3b0XOmH0xFFAuasT4ITU0kkELnREkIGC3uT8/RUcO9a
         EuNr06T1ks2dNDR4fb07fOtG4Jw/uspOREBQASow8RtQO5+7cXVw49WqwIjZtrJ4kI6i
         z+NO1hgZjRBS1t3VDkx2bNmni6g51sYBPZzKybIkuoBEHnHn0mdnPnJxhcJqTH9Ko8Do
         IyvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=QJF5KkLbVrVBnjHUA0f0vsLZgWb5LYS9Tbu0X4IhjlQ=;
        b=fq+p22i/qf2aw+bzdJku4OnzxaD1TaKzKwt6hhRmd1UiSPHmbzHqvFTKlzZmND4pMQ
         kC24zYt7Y4BZQ3gSp4KisldY+hgdLkdPlV+sbSDHTvaEQ4Ojmp1W7z09MnX6TIrg3Poc
         AQLm9gA1KAgDWUtM4Ex1gwLtG+rvi3k32AI/UaHXgujCe7XEnMo4s+c5NoJ06J77Q2IA
         htXOF7CU18GIdSog3LnGEegGB72XZA3hRAqtx49lCfSvAmPrmQSLLU5HwozTLX5Z/yL0
         rP355gASwkZJ6KZoftoAAAvkJPQ3oYmD55lvas14qIOAydzo5f8J8ioh+WfBhkKKtKKV
         9kWw==
X-Gm-Message-State: APjAAAX5TgO0q5x2tWPRlnmsJ1HmqFsc4UQMNQ7rAkFF+JHHWyTrRqO1
        KRV7lv97d4xaJC+PtFlzQbXoEprlS8PR2JDPpGr10A==
X-Google-Smtp-Source: APXvYqySxn6Aum2fW7hESCBNI/WQ907Tgt2T6h/7T2FnGeErkOVqSep722YIjq80TEItLMeAZ29Csd9tKbbb2livg74=
X-Received: by 2002:a17:906:81cb:: with SMTP id e11mr11215527ejx.37.1565234760011;
 Wed, 07 Aug 2019 20:26:00 -0700 (PDT)
MIME-Version: 1.0
References: <1564306219-17439-1-git-send-email-bmeng.cn@gmail.com> <CAEUhbmX2LXST-5eDD_UQJP6-XqKPEByVdnQ_KqFM-fR_dH6pyQ@mail.gmail.com>
In-Reply-To: <CAEUhbmX2LXST-5eDD_UQJP6-XqKPEByVdnQ_KqFM-fR_dH6pyQ@mail.gmail.com>
From:   Bin Meng <bmeng.cn@gmail.com>
Date:   Thu, 8 Aug 2019 11:25:49 +0800
Message-ID: <CAEUhbmV1ehuvmbaCePWeuiTZv+CSnjg6HSbDk22oj5hg36QRGw@mail.gmail.com>
Subject: Re: [PATCH 1/2] dt-bindings: interrupt-controller: msi: Correct
 msi-controller@c's reg
To:     Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 1, 2019 at 5:53 PM Bin Meng <bmeng.cn@gmail.com> wrote:
>
> On Sun, Jul 28, 2019 at 5:30 PM Bin Meng <bmeng.cn@gmail.com> wrote:
> >
> > The base address of msi-controller@c should be set to c.
> >
> > Signed-off-by: Bin Meng <bmeng.cn@gmail.com>
> > ---
> >
> >  Documentation/devicetree/bindings/interrupt-controller/msi.txt | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/Documentation/devicetree/bindings/interrupt-controller/msi.txt b/Documentation/devicetree/bindings/interrupt-controller/msi.txt
> > index c60c034..c20b51d 100644
> > --- a/Documentation/devicetree/bindings/interrupt-controller/msi.txt
> > +++ b/Documentation/devicetree/bindings/interrupt-controller/msi.txt
> > @@ -98,7 +98,7 @@ Example
> >         };
> >
> >         msi_c: msi-controller@c {
> > -               reg = <0xb 0xf00>;
> > +               reg = <0xc 0xf00>;
> >                 compatible = "vendor-b,another-controller";
> >                 msi-controller;
> >                 /* Each device has some unique ID */
> > --
>
> Ping?

Ping?
