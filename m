Return-Path: <SRS0=CtY/=UD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80754C282CE
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Jun 2019 22:09:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4B9D420863
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Jun 2019 22:09:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="LE3OjEH9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726530AbfFDWJO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Jun 2019 18:09:14 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:36485 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726422AbfFDWJN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jun 2019 18:09:13 -0400
Received: by mail-pg1-f193.google.com with SMTP id a3so3752861pgb.3
        for <linux-kernel@vger.kernel.org>; Tue, 04 Jun 2019 15:09:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=NGFWos9reZ21x+VPBWgjaST/llqX50Psvr0VLnDsejc=;
        b=LE3OjEH9gGdSD8HL7lZl/oU8JB8AiXuo0O9VefLwxFSrPzWA63vjBLqujXKByi2zHo
         EW8hrmDGrAVo+1FFiSO6D5l8GqZo+xaiPL1i23DAlGDzelL9ldMHJRRlsPlN26HhXZMV
         marf4yM/9clcphCztYfcrrJf4Y24XL4i4DvoBEx8Ibsvm+H7Bx90Gabs8cniguI8L5GN
         fKo/ejDhrSjivqMZcnaALrq0d8EiuYc5zsOdh+OE+P/9NWv9URNwckpzMLR0lmlAkZc+
         Qa5arISvb2yhpPXSTDY1s81jbncFzBIsZHb7kBrmj23EXebMO+H86+TiLegdgtF7xF3A
         iHOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=NGFWos9reZ21x+VPBWgjaST/llqX50Psvr0VLnDsejc=;
        b=QUqQeA3fWR9eIxmKRtEuLlBfkHFiiWPbP6PyiW0n3oYtlXFTmI+Vk/CLOOfNtzuVl9
         /5mnAOJLyAPE4IxhQiS5cdbv6UV84Oip+cCro1K8UBs/oqMoABqyirapayheyU9fhZ9G
         fpZ7iplSXeLftJHUDDiGwMIRpdo3Qw3YJeY/wQxilhUeed9SVnxeorbStuMxPXx9Rqdw
         EigZD2kDEn25NAJgzXkfuVfU8UCCpu8Z6MSwSe1q7OViyrvKcB9B7fqg1cogsW2uYUm+
         fN7hdCmGqhIRy9Tt9LlJ2n2vsmYDv4FHRLxym10nTTEPYG2Li6lBeKDTUC6uHI32uKbu
         npkg==
X-Gm-Message-State: APjAAAV9L/Yw1Ju1dHHAt6Wp6KVDzlVWPHILrfRtL0Oy4VGOVJnThF6C
        WSsYVMB6y8plVEOBgZF6xoyaLA==
X-Google-Smtp-Source: APXvYqz0k3aXvYp9vPgvRV/jmmcqPdGm62iQvQ+8caZbKxT6w3UTp/yE1RNEnvkaFlsMacIaHCfcaQ==
X-Received: by 2002:a62:2bc7:: with SMTP id r190mr5307624pfr.40.1559686153100;
        Tue, 04 Jun 2019 15:09:13 -0700 (PDT)
Received: from minitux (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id j20sm15469801pff.183.2019.06.04.15.09.11
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 04 Jun 2019 15:09:12 -0700 (PDT)
Date:   Tue, 4 Jun 2019 15:09:10 -0700
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     Andy Gross <agross@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Pedro Sousa <pedrom.sousa@synopsys.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-arm-msm@vger.kernel.org, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-scsi@vger.kernel.org, Evan Green <evgreen@chromium.org>
Subject: Re: [PATCH 3/3] arm64: dts: qcom: sdm845-mtp: Specify UFS
 device-reset GPIO
Message-ID: <20190604220910.GA4814@minitux>
References: <20190604072001.9288-1-bjorn.andersson@linaro.org>
 <20190604072001.9288-4-bjorn.andersson@linaro.org>
 <5cf69ad2.1c69fb81.216a9.30f8@mx.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5cf69ad2.1c69fb81.216a9.30f8@mx.google.com>
User-Agent: Mutt/1.12.0 (2019-05-25)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 04 Jun 09:22 PDT 2019, Stephen Boyd wrote:

> Quoting Bjorn Andersson (2019-06-04 00:20:01)
> > Specify the UFS device-reset gpio, so that the controller will issue a
> > reset of the UFS device.
> > 
> > Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> > ---
> >  arch/arm64/boot/dts/qcom/sdm845-mtp.dts | 2 ++
> >  1 file changed, 2 insertions(+)
> > 
> > diff --git a/arch/arm64/boot/dts/qcom/sdm845-mtp.dts b/arch/arm64/boot/dts/qcom/sdm845-mtp.dts
> > index 2e78638eb73b..d116a0956a9c 100644
> > --- a/arch/arm64/boot/dts/qcom/sdm845-mtp.dts
> > +++ b/arch/arm64/boot/dts/qcom/sdm845-mtp.dts
> > @@ -388,6 +388,8 @@
> >  &ufs_mem_hc {
> >         status = "okay";
> >  
> > +       device-reset-gpios = <&tlmm 150 GPIO_ACTIVE_LOW>;
> > +
> 
> We had to do something similar on one particular brand of UFS that we had. I
> think it was an SK Hynix part that had trouble and wouldn't provision properly.
> Either way, we did this with a pinctrl toggle in the DTS where the "init" state
> has the UFS_RESET pin asserted and then "default" state has the pin deasserted.
> That was good enough to make this work.
> 

Thanks for pointing this out, I forgot to attribute these downstream
changes. I can see how this works, but I must say I find it quite
hackish.

The downstream solution seems to have evolved this into naming these
states and jumping between them (with the appropriate sleeps) during a
host reset as well.


But thanks for the confirmation that there's more than John's memory
that needs this.

Regards,
Bjorn

> 	&ufs_mem_hc {
> 		pinctrl-names = "init", "default";
> 		pinctrl-0 = <&ufs_dev_reset_assert>;
> 		pinctrl-1 = <&ufs_dev_reset_deassert>;
> 	};
> 
>         ufs_dev_reset_assert: ufs_dev_reset_assert {
>                 config {
>                         pins = "ufs_reset";
>                         bias-pull-down;         /* default: pull down */
>                         drive-strength = <8>;   /* default: 3.1 mA */
>                         output-low; /* active low reset */
>                 };
>         };
> 
>         ufs_dev_reset_deassert: ufs_dev_reset_deassert {
>                 config {
>                         pins = "ufs_reset";
>                         bias-pull-down;         /* default: pull down */
>                         drive-strength = <8>;
>                         output-high; /* active low reset */
>                 };
>         };
