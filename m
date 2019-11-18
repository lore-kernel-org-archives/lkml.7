Return-Path: <SRS0=CA45=ZK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17D74C432C0
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Nov 2019 14:44:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D8972206B6
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Nov 2019 14:44:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574088283;
	bh=O/HQpk9RxiQEt7uI/mJqMP1X3ER13daw+30uHbVimaQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=ZnJdT60WDSjmeXdpJOmUU/jO6xTsAfdJcalJLTgw6SLcbDLJ9czlwXPrLpBNmjMWW
	 j97uz2olg8UYxFEpuzIW+tmgYAUsfci88nRr3Jm1YI7GER+Ffz8HJzZ/CdF+EjHhPt
	 +mKcTk4o31PR4geedPqxOjQsHdv3uEBTQABwgY8k=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727118AbfKROol (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Nov 2019 09:44:41 -0500
Received: from mail.kernel.org ([198.145.29.99]:55630 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726668AbfKROol (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Nov 2019 09:44:41 -0500
Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EE40720722;
        Mon, 18 Nov 2019 14:44:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574088280;
        bh=O/HQpk9RxiQEt7uI/mJqMP1X3ER13daw+30uHbVimaQ=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=U5JghCJKvhmVGeyCgR7y6BBjol75ucpzIMQUQd+3he26X7Q4PyY6E4mYfSGXclaqy
         3yAMZ2Ypyk3RZU6/pUP0U9yEZyqL5jzD4TNKpy3c0kIUJmboeBpFZ+YBLovSUW6igG
         XZ3mMq2H52WHe30poxGPoFjh0JuTzraIGZhsAFuQ=
Received: by mail-qt1-f169.google.com with SMTP id j5so19019546qtn.10;
        Mon, 18 Nov 2019 06:44:39 -0800 (PST)
X-Gm-Message-State: APjAAAWVSpIvLjvUk5Yehim6LO+P67+TcwpoyxppawuvBnAokvIBOBOo
        wEf5wwDa6p2Nv86ADp1C6BTx5Jw5z2uMBYhckA==
X-Google-Smtp-Source: APXvYqycCtreYYmwkSpJwa7wIPYTDvllS4FDO9eKQZ6v5nYk21/RTRhTmW5YtqoeWS3HibQJoVgoy/DxxXHNa8rjx4E=
X-Received: by 2002:ac8:7612:: with SMTP id t18mr27614841qtq.143.1574088279114;
 Mon, 18 Nov 2019 06:44:39 -0800 (PST)
MIME-Version: 1.0
References: <1572588353-110682-1-git-send-email-manish.narani@xilinx.com>
 <1572588353-110682-5-git-send-email-manish.narani@xilinx.com>
 <20191104231427.GA7606@bogus> <MN2PR02MB6029D371F580123CB32BE148C1740@MN2PR02MB6029.namprd02.prod.outlook.com>
In-Reply-To: <MN2PR02MB6029D371F580123CB32BE148C1740@MN2PR02MB6029.namprd02.prod.outlook.com>
From:   Rob Herring <robh@kernel.org>
Date:   Mon, 18 Nov 2019 08:44:27 -0600
X-Gmail-Original-Message-ID: <CAL_JsqJNFGi+X0XU449DE0SRMYaakAzKOuFqZdAT5pptrOZrbg@mail.gmail.com>
Message-ID: <CAL_JsqJNFGi+X0XU449DE0SRMYaakAzKOuFqZdAT5pptrOZrbg@mail.gmail.com>
Subject: Re: [PATCH v5 4/8] dt-bindings: mmc: Add optional generic properties
 for mmc
To:     Manish Narani <MNARANI@xilinx.com>
Cc:     "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "adrian.hunter@intel.com" <adrian.hunter@intel.com>,
        Michal Simek <michals@xilinx.com>,
        Jolly Shah <JOLLYS@xilinx.com>,
        Nava kishore Manne <navam@xilinx.com>,
        Rajan Vaja <RAJANV@xilinx.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>, git <git@xilinx.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 11, 2019 at 4:07 AM Manish Narani <MNARANI@xilinx.com> wrote:
>
> Hi Rob,
>
>
> > -----Original Message-----
> > From: Rob Herring <robh@kernel.org>
> > Sent: Tuesday, November 5, 2019 4:44 AM
> > To: Manish Narani <MNARANI@xilinx.com>
> > Cc: ulf.hansson@linaro.org; mark.rutland@arm.com;
> > adrian.hunter@intel.com; Michal Simek <michals@xilinx.com>; Jolly Shah
> > <JOLLYS@xilinx.com>; Nava kishore Manne <navam@xilinx.com>; Rajan Vaja
> > <RAJANV@xilinx.com>; linux-mmc@vger.kernel.org;
> > devicetree@vger.kernel.org; linux-kernel@vger.kernel.org; linux-arm-
> > kernel@lists.infradead.org; git <git@xilinx.com>
> > Subject: Re: [PATCH v5 4/8] dt-bindings: mmc: Add optional generic
> > properties for mmc
> >
> > On Fri, Nov 01, 2019 at 11:35:49AM +0530, Manish Narani wrote:
> > > Add optional properties for mmc hosts which are used to set clk delays
> > > for different speed modes in the controller.
> > >
> > > Signed-off-by: Manish Narani <manish.narani@xilinx.com>
> > > ---
> > >  .../bindings/mmc/mmc-controller.yaml          | 92 +++++++++++++++++++
> > >  1 file changed, 92 insertions(+)
> > >
> > > diff --git a/Documentation/devicetree/bindings/mmc/mmc-controller.yaml
> > b/Documentation/devicetree/bindings/mmc/mmc-controller.yaml
> > > index 080754e0ef35..87a83d966851 100644
> > > --- a/Documentation/devicetree/bindings/mmc/mmc-controller.yaml
> > > +++ b/Documentation/devicetree/bindings/mmc/mmc-controller.yaml
> > > @@ -212,6 +212,98 @@ properties:
> > >      description:
> > >        eMMC HS400 enhanced strobe mode is supported
> > >
> > > +  # Below mentioned are the clock (phase) delays which are to be
> > configured
> > > +  # in the controller while switching to particular speed mode. The range
> > > +  # of values are 0 to 359 degrees.
> > > +
> > > +  clk-phase-legacy:
> > > +    allOf:
> > > +      - $ref: /schemas/types.yaml#/definitions/uint32
> > > +      - minimum: 0
> > > +      - maximum: 359
> > > +    description:
> > > +      Input/Output Clock Delay pair in degrees for Legacy Mode.
> > > +
> > > +  clk-phase-mmc-hs:
> > > +    allOf:
> > > +      - $ref: /schemas/types.yaml#/definitions/uint32
> > > +      - minimum: 0
> > > +      - maximum: 359
> > > +    description:
> > > +      Input/Output Clock Delay pair degrees for MMC HS.
> > > +
> > > +  clk-phase-sd-hs:
> > > +    allOf:
> > > +      - $ref: /schemas/types.yaml#/definitions/uint32
> > > +      - minimum: 0
> > > +      - maximum: 359
> > > +    description:
> > > +      Input/Output Clock Delay pair in degrees for SD HS.
> > > +
> > > +  clk-phase-uhs-sdr12:
> > > +    allOf:
> > > +      - $ref: /schemas/types.yaml#/definitions/uint32
> > > +      - minimum: 0
> > > +      - maximum: 359
> > > +    description:
> > > +      Input/Output Clock Delay pair in degrees for SDR12.
> > > +
> > > +  clk-phase-uhs-sdr25:
> > > +    allOf:
> > > +      - $ref: /schemas/types.yaml#/definitions/uint32
> > > +      - minimum: 0
> > > +      - maximum: 359
> > > +    description:
> > > +      Input/Output Clock Delay pair in degrees for SDR25.
> > > +
> > > +  clk-phase-uhs-sdr50:
> > > +    allOf:
> > > +      - $ref: /schemas/types.yaml#/definitions/uint32
> > > +      - minimum: 0
> > > +      - maximum: 359
> > > +    description:
> > > +      Input/Output Clock Delay pair in degrees for SDR50.
> > > +
> > > +  clk-phase-uhs-sdr104:
> > > +    allOf:
> > > +      - $ref: /schemas/types.yaml#/definitions/uint32
> > > +      - minimum: 0
> > > +      - maximum: 359
> > > +    description:
> > > +      Input/Output Clock Delay pair in degrees for SDR104.
> > > +
> > > +  clk-phase-uhs-ddr50:
> > > +    allOf:
> > > +      - $ref: /schemas/types.yaml#/definitions/uint32
> > > +      - minimum: 0
> > > +      - maximum: 359
> > > +    description:
> > > +      Input/Output Clock Delay pair in degrees for SD DDR50.
> > > +
> > > +  clk-phase-mmc-ddr52:
> > > +    allOf:
> > > +      - $ref: /schemas/types.yaml#/definitions/uint32
> > > +      - minimum: 0
> > > +      - maximum: 359
> > > +    description:
> > > +      Input/Output Clock Delay pair in degrees for MMC DDR52.
> > > +
> > > +  clk-phase-mmc-hs200:
> > > +    allOf:
> > > +      - $ref: /schemas/types.yaml#/definitions/uint32
> > > +      - minimum: 0
> > > +      - maximum: 359
> > > +    description:
> > > +      Input/Output Clock Delay pair in degrees for MMC HS200.
> > > +
> > > +  clk-phase-mmc-hs400:
> > > +    allOf:
> > > +      - $ref: /schemas/types.yaml#/definitions/uint32
> > > +      - minimum: 0
> > > +      - maximum: 359
> > > +    description:
> > > +      Input/Output Clock Delay pair in degrees for MMC HS400.
> >
> > This can be condensed into:
> >
> > patternProperties:
> >
> > "^clk-phase-(legacy|sd-hs|mmc-(hs|hs[24]00|ddr52)|uhs-
> > (sdr(12|25|50|104)|ddr50))$":
> >
> > Or if you want to divide them between SD and MMC ones, that would be
> > fine for me.
>
> Below change should work? Please review.

Running 'make dt_binding_check' would tell you...

> --- a/Documentation/devicetree/bindings/mmc/mmc-controller.yaml
> +++ b/Documentation/devicetree/bindings/mmc/mmc-controller.yaml
> @@ -333,6 +333,16 @@ patternProperties:
>      required:
>        - reg
>
> +  "^clk-phase-(legacy|sd-hs|mmc-(hs|hs[24]00|ddr52)|uhs-(sdr(12|25|50|104)|ddr50))$":
> +    allOf:
> +      - $ref: /schemas/types.yaml#/definitions/uint32
> +      - minimum: 0
> +      - maximum: 359

Drop the '-' on maximum so that minimum/maximum are 1 item in the list.

> +    description:
> +      Set the clock (phase) delays which are to be configured in the
> +      controller while switching to particular speed mode. These values
> +      are in pair of degrees.
> +
>  dependencies:
>    cd-debounce-delay-ms: [ cd-gpios ]
>    fixed-emmc-driver-type: [ non-removable ]
> @@ -351,6 +361,7 @@ examples:
>          keep-power-in-suspend;
>          wakeup-source;
>          mmc-pwrseq = <&sdhci0_pwrseq>;
> +        clk-phase-sd-hs = <63>, <72>;

This should fail because it is defined as a single int.

Rob
