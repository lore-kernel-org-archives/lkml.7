Return-Path: <SRS0=i7el=ZO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E21F0C43215
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 06:53:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BAC1F2068F
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 06:53:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="QG3cF8pd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726962AbfKVGxo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Nov 2019 01:53:44 -0500
Received: from mail-ua1-f67.google.com ([209.85.222.67]:34540 "EHLO
        mail-ua1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726018AbfKVGxo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Nov 2019 01:53:44 -0500
Received: by mail-ua1-f67.google.com with SMTP id s25so1850577uap.1
        for <linux-kernel@vger.kernel.org>; Thu, 21 Nov 2019 22:53:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1YU9k9XpRr942/Ij03AkmdwfF1xW9f8cWmfS5A3XY0k=;
        b=QG3cF8pdSIL28X1eGzKqnGvTG84F3Ufrrvrc8SL1ku6vQwPYz/ZYUsZpu040Y27DJW
         L4VBXn057/NW7NJlATWTc6kcsgzfQILeq8kGDkpAJ/wNdnWF6S++4ZeRLrGnJxl9HBgq
         xkb413yOgTl5mrGqih/vn7f5AZJMoe1RGLo5v1LYiNyqM9A8Q1S0HQd62Pcn7VAK7AYS
         2+TIuyreiwtCByxwQBdy4QWiKXcJiQ2G/mFAyqgUILQ/P8wYxbmZoYE72OJFYQLkXXxB
         VMiMV9XRGwzFdh3shltnRsQq9EFe7sRrf2Nlp0z1T0cC+teVA/YJPjg3fZO9/MKgjYjj
         w2qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1YU9k9XpRr942/Ij03AkmdwfF1xW9f8cWmfS5A3XY0k=;
        b=ntADlZXlq/UNUmvFwsvYS03X8y4ldkAjdw8U3U3bg98LAXp7Uq8NHFtjVHIFLasmpF
         +pZikIbuJEDO7ALPunzDIOlq69nCkwu1rZycddQObbul9jqZJOPfE8CBf14JfSgRoZKW
         tVot5oX0oBbjSyOv5/8LR8MfXVCimpvvCymEEeojIe4TGnMTWAZnJjtZFnlKtK3PGUsp
         YEC+msxZ68ZRLV2DtJzBYHLP3P8PjdG9Tvdb4fgNuMt68wxZDztrNlemBRis53LX4hhv
         XdGBR6qVd/YJAY8ZkKLeKk+/uYAbowl9bubwJ1FXykPeilWClZT73ZVcU8NHkNvlTRyP
         0iyg==
X-Gm-Message-State: APjAAAXjGBPpajBrBvUqtdJPmf6UzNBCz3DRmAKd3YCvWGSQIqPYAG4B
        o/eyrLgJWmjLJOQ/9+R0jKoJqWdYNFUs7WWdPD2N1g==
X-Google-Smtp-Source: APXvYqxA4KymHfYVZJp+513DppW1RweHZkY7FevlDR8l2jLOXOk+nmSeISVuvQpjenrUnIKpX/cDOUf9dilFT9SRZZ0=
X-Received: by 2002:ab0:24ce:: with SMTP id k14mr8961736uan.15.1574405623268;
 Thu, 21 Nov 2019 22:53:43 -0800 (PST)
MIME-Version: 1.0
References: <1574232449-13570-1-git-send-email-manish.narani@xilinx.com>
 <1574232449-13570-5-git-send-email-manish.narani@xilinx.com> <CAC=3edbHWA7gv-mTFVXXcMzN6hyzO4LPqkbcRZ-zDp5BAm8_Vw@mail.gmail.com>
In-Reply-To: <CAC=3edbHWA7gv-mTFVXXcMzN6hyzO4LPqkbcRZ-zDp5BAm8_Vw@mail.gmail.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Fri, 22 Nov 2019 07:53:06 +0100
Message-ID: <CAPDyKFrgC1nxe7NqmNHHibYmDfrdx6ubTpOE41bW2Ge796+N8w@mail.gmail.com>
Subject: Re: [PATCH v6 4/8] dt-bindings: mmc: Add optional generic properties
 for mmc
To:     Rob Herring <rob.e.herring@gmail.com>,
        Manish Narani <manish.narani@xilinx.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Michal Simek <michal.simek@xilinx.com>, jolly.shah@xilinx.com,
        rajan.vaja@xilinx.com, nava.manne@xilinx.com,
        Moritz Fischer <mdf@kernel.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        git@xilinx.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 21 Nov 2019 at 20:01, Rob Herring <rob.e.herring@gmail.com> wrote:
>
> On Wed, Nov 20, 2019 at 12:49 AM Manish Narani <manish.narani@xilinx.com> wrote:
> >
> > Add optional properties for mmc hosts which are used to set clk delays
> > for different speed modes in the controller.
> >
> > Signed-off-by: Manish Narani <manish.narani@xilinx.com>
> > ---
> >  .../devicetree/bindings/mmc/mmc-controller.yaml     | 13 +++++++++++++
> >  1 file changed, 13 insertions(+)
> >
> > diff --git a/Documentation/devicetree/bindings/mmc/mmc-controller.yaml b/Documentation/devicetree/bindings/mmc/mmc-controller.yaml
> > index 080754e0ef35..305b2016bc17 100644
> > --- a/Documentation/devicetree/bindings/mmc/mmc-controller.yaml
> > +++ b/Documentation/devicetree/bindings/mmc/mmc-controller.yaml
> > @@ -333,6 +333,18 @@ patternProperties:
> >      required:
> >        - reg
> >
> > +  "^clk-phase-(legacy|sd-hs|mmc-(hs|hs[24]00|ddr52)|uhs-(sdr(12|25|50|104)|ddr50))$":
> > +    minItems: 2
> > +    maxItems: 2
> > +    allOf:
> > +      - $ref: /schemas/types.yaml#/definitions/uint32
> > +      - minimum: 0
> > +        maximum: 359
>
> This is wrong. It can't be both minItems of 2 and a single uint32.
> What's needed is:
>
> allOf:
>   - $ref: /schemas/types.yaml#/definitions/uint32-array
> minItems: 2
> maxItems: 2
> items:
>   minimum: 0
>   maximum: 359

Thanks Rob for clarifying!

Manish, can you please send a fixup on top?

Kind regards
Uffe
