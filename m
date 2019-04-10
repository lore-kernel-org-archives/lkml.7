Return-Path: <SRS0=SZ1Q=SM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4638AC10F14
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 17:49:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1C94A2063F
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 17:49:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hlOoMja4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730345AbfDJRtw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Apr 2019 13:49:52 -0400
Received: from mail-it1-f193.google.com ([209.85.166.193]:38647 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729935AbfDJRtv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Apr 2019 13:49:51 -0400
Received: by mail-it1-f193.google.com with SMTP id f22so4888606ita.3;
        Wed, 10 Apr 2019 10:49:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=a4HGuR9gtKZMdV4ZW4brHmMzJmgAueXVt96dFJJECmM=;
        b=hlOoMja4HkpWsgaGaPbuAm7CyzLPWcLNqOJq6JGew5o1gmr2Xfl83qUIr+7YKQiwQ4
         4Q21nNC691ter4Rqq6bWYvJYOWMVGSWG2d5nQX0s+H0izH/W964570HgDYqpJO8XPAln
         mEDP+6/8lSgqfZKNX+H7iOQVtgDJKDv57Tf7ktoDWr1ZOi0uoshF2bpDr61sOmZzDDei
         zdNFCGvQBfJED69BV/O6mOl48DWbWVNz0mBhZdUQUMdeyDDFWDsOHSGcf8eH50fVoTIk
         +ODeh8ca05hm2bClNB+tbVF8uIGlB3oUgXUFvjcBU3ESl79hJyPqZq5SUQIHBPPKhrF+
         N+HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=a4HGuR9gtKZMdV4ZW4brHmMzJmgAueXVt96dFJJECmM=;
        b=BmNh1qoyqQwDVn9qwUdhWpciImx44tCbOhYUPOge3w1cYOgtlbcA9ARR40dAAuSBFp
         2VcBCQa3GgVj1gi7WeynwB3fHGM5SVib7RUlFGDjfAF0vPEZm0P38GYvy9EshypJ5DRi
         jE1rkhQtQeBLR6tnAj3LoQKEUHVnfqrQEWs++Ua12JZycXqjsGth9ouOnMcx1vbpL3+6
         606aaIQQyb9Ty+3b0qz5Pe2Iu0i81uKHAuztp3rPQO3Gbj68a/g+4LpXUWwmg+lNKeY5
         BCP9aehIdXFUUm8aD7qyXsr1PIqNAj5jvkDL/8fu/221ErTCe2cjFQB0QpLK4hmi8lX/
         c4SA==
X-Gm-Message-State: APjAAAXfbfWqQImDfvSi5E+Ok0C0t8M6mU0u45r+Wj2lIDR2mFB+rLLS
        hgGKbeNNYodGBRCc2rXWrXxAIuqJJ5G940+CyzQ=
X-Google-Smtp-Source: APXvYqwngouX3i/1jzPpqK9jd1mwRddiCjnWAnM2Ms5Lf+TcD6pzCyeqJFvaLVRgoLsGlAdbSlfCxnQGXQJq+xAjr7M=
X-Received: by 2002:a24:9b8b:: with SMTP id o133mr4593001itd.74.1554918590660;
 Wed, 10 Apr 2019 10:49:50 -0700 (PDT)
MIME-Version: 1.0
References: <20190409172558.18778-1-tiny.windzz@gmail.com> <20190409172558.18778-3-tiny.windzz@gmail.com>
 <20190410145659.62nl4o2jvkuggmpe@flea>
In-Reply-To: <20190410145659.62nl4o2jvkuggmpe@flea>
From:   Frank Lee <tiny.windzz@gmail.com>
Date:   Thu, 11 Apr 2019 01:49:39 +0800
Message-ID: <CAEExFWu60DZ2xY7qxpjGFq3f_u2G4p7y-wqmsj0HR7CQy24r7w@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] dt-bindings: cpufreq: Document operating-points-v2-sunxi-cpu
To:     Maxime Ripard <maxime.ripard@bootlin.com>
Cc:     vireshk@kernel.org, nm@ti.com, sboyd@kernel.org,
        robh+dt@kernel.org, mark.rutland@arm.com,
        Chen-Yu Tsai <wens@csie.org>, rjw@rjwysocki.net,
        davem@davemloft.net, mchehab+samsung@kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        nicolas.ferre@microchip.com, Linux PM <linux-pm@vger.kernel.org>,
        devicetree@vger.kernel.org,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 10, 2019 at 10:57 PM Maxime Ripard
<maxime.ripard@bootlin.com> wrote:
>
> On Tue, Apr 09, 2019 at 01:25:58PM -0400, Yangtao Li wrote:
> > Allwinner Process Voltage Scaling Tables defines the voltage and
> > frequency value  based on the speedbin blown in the efuse combination.
> > The sunxi-cpufreq-nvmem driver reads the efuse value from the SoC to
> > provide the OPP framework with required information.
> > This is used to determine the voltage and frequency value for each
> > OPP of operating-points-v2 table when it is parsed by the OPP framework.
> >
> > The "operating-points-v2-sunxi-cpu" DT extends the "operating-points-v2"
> > with following parameters:
> > - nvmem-cells (NVMEM area containig the speedbin information)
> > - opp-microvolt-<name>: voltage in micro Volts.
> >   At runtime, the platform can pick a <name> and matching
> >   opp-microvolt-<name> property
> >
> > Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
> > ---
> >  .../bindings/opp/sunxi-nvmem-cpufreq.txt      | 166 ++++++++++++++++++
> >  1 file changed, 166 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/opp/sunxi-nvmem-cpufreq.txt
> >
> > diff --git a/Documentation/devicetree/bindings/opp/sunxi-nvmem-cpufreq.txt b/Documentation/devicetree/bindings/opp/sunxi-nvmem-cpufreq.txt
> > new file mode 100644
> > index 000000000000..c81a2075b974
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/opp/sunxi-nvmem-cpufreq.txt
> > @@ -0,0 +1,166 @@
> > +Allwinner Technologies, Inc. NVMEM CPUFreq and OPP bindings
> > +===================================
> > +
> > +For some SoCs, the CPU frequency subset and voltage value of each OPP
> > +varies based on the silicon variant in use. Allwinner Process Voltage
> > +Scaling Tables defines the voltage and frequency value  based on the
> > +speedbin blown in the efuse combination. The sunxi-cpufreq-nvmem driver
> > +reads the efuse value from the SoC to provide the OPP framework with
> > +required information.
> > +
> > +Required properties:
> > +--------------------
> > +In 'cpus' nodes:
> > +- operating-points-v2: Phandle to the operating-points-v2 table to use.
> > +
> > +In 'operating-points-v2' table:
> > +- compatible: Should be
> > +     - 'operating-points-v2-sunxi-cpu'.
>
> Vendor-specific compatibles should have the vendor mentionned.
>
> Also, even though the H6 is the only SoC so far that has needed this,
> we can't really assume that it will be the only SoC to use it, or that
> it will always behave like that.
There is no doubt that many platforms need this.
>
> So having something like allwinner,sun50i-h6-operating-points would be
> great.
allwinner,cpu-operating-points-v2 Maybe better?
>
> > +- nvmem-cells: A phandle pointing to a nvmem-cells node representing the
> > +             efuse registers that has information about the
> > +             speedbin that is used to select the right frequency/voltage
> > +             value pair.
> > +             Please refer the for nvmem-cells
> > +             bindings Documentation/devicetree/bindings/nvmem/nvmem.txt
> > +             and also examples below.
> > +
> > +In every OPP node:
> > +- opp-microvolt-<name>: Voltage in micro Volts.
> > +                     At runtime, the platform can pick a <name> and
> > +                     matching opp-microvolt-<name> property.
> > +                     [See: opp.txt]
>
> You need to document the valid names here.
OK.

Cheers,
Yangtao
