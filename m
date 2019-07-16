Return-Path: <SRS0=jE6e=VN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E37ECC76188
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jul 2019 13:57:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B831D20880
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jul 2019 13:57:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="yA6SXh/f"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733132AbfGPN5O (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Jul 2019 09:57:14 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:44142 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726039AbfGPN5O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jul 2019 09:57:14 -0400
Received: by mail-pl1-f194.google.com with SMTP id t14so10137559plr.11
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jul 2019 06:57:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=J9tvMn39rK3LkqOu4t+M/Ris6W+I1g7NfDcdATIT2DQ=;
        b=yA6SXh/flqAcPgFrv0bHrVdVyOBbpnLlKgHMdKBUFFA+GWNlG08zHTee76Y+Ir+YUQ
         3Lix32Y0btFL+Svnyj3WXrjB3UTrUE/EMFJp/8ctADWxlI7rLED1FviwRM/7AmbPQY7n
         c7qFmWMQICg7xou1omvkRGKzqDJGalc+UC+w32t4feIEm6+sRGbZn6jnkOIeFrsQfEb7
         uZst6zQ4d6NVfVhWMus1AbRwl9+Z60gcK5tWYchhZP95n/dRmxM2QyEXMrDOCFXnPfol
         VapS5Vh01rbwxdrVac5XIV7w6ztOG4147JQBJ/hjlrP/dgKuY7YSsyuySRP2FtBiBO1C
         amhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=J9tvMn39rK3LkqOu4t+M/Ris6W+I1g7NfDcdATIT2DQ=;
        b=Oz96SeuUdHaJG3GFz+WT3SFoWcXMmevLJt8Z/4pCjHOes62xWNpm32EaAW2kzOskRZ
         Gb2UEfWaQmW6GbuWp3g3syWxnDgn0elX58kOrGGWkCGQg1ij8FZkQeu1HvCPM5+ZbC/0
         WUN/s3zpAFu8ysrISuiekrfx5Gly82XEeMsX6WZgFxwt11OQAlG97u+FprtxkY820H7y
         9D9HUJokKKGR+pexJ3t2NkceKcNskFG4pMysXLbmJtTgvGLTMuc5udTxF90VIlHmuxW8
         SeN4XH2sXqC4Ex+GSO0CvNUKEJwu3VuUj54hXSiD10XDQqapICrOQxnNOZ3zXyr/kkDA
         n0dw==
X-Gm-Message-State: APjAAAXgRiIwoxq2x9osXuRT3lX7/tO18HxpaQC8MV5sxHjamLh76rNB
        Z8ycgjqDhPFCZfH13c1jqTFCqUNPAxeiKA==
X-Google-Smtp-Source: APXvYqz4v2PlSDRW/zC7gOXGoE74jaWpBywYYwbtTTemaNofGgKi6J1fORPdJXx8tEO2rPaOq9Ivow==
X-Received: by 2002:a17:902:290b:: with SMTP id g11mr35084846plb.26.1563285431501;
        Tue, 16 Jul 2019 06:57:11 -0700 (PDT)
Received: from blackbox.Home ([200.68.141.29])
        by smtp.gmail.com with ESMTPSA id s6sm33457246pfs.122.2019.07.16.06.57.07
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 16 Jul 2019 06:57:08 -0700 (PDT)
Date:   Tue, 16 Jul 2019 08:58:10 -0500
From:   =?iso-8859-1?Q?An=EDbal_Lim=F3n?= <anibal.limon@linaro.org>
To:     linux-kernel@vger.kernel.org
Cc:     Aniket Masule <amasule@codeaurora.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        bjorn.andersson@linaro.org, nicolas.dechesne@linaro.org
Subject: Re: [PATCH v3] arm64: dts: sdm845: Add video nodes
Message-ID: <20190716135810.GA6839@blackbox.Home>
References: <1562069549-25384-1-git-send-email-amasule@codeaurora.org>
 <81590b01-e9e7-dbc7-c2c8-0d6093db7ce0@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <81590b01-e9e7-dbc7-c2c8-0d6093db7ce0@codeaurora.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 12, 2019 at 02:55:48PM +0530, Rajendra Nayak wrote:
> 
> 
> On 7/2/2019 5:42 PM, Aniket Masule wrote:
> > From: Malathi Gottam <mgottam@codeaurora.org>
> > 
> > This adds video nodes to sdm845 based on the examples
> > in the bindings.
> > 
> > Signed-off-by: Malathi Gottam <mgottam@codeaurora.org>
> > Co-developed-by: Aniket Masule <amasule@codeaurora.org>
> > Signed-off-by: Aniket Masule <amasule@codeaurora.org>
> 
> Reviewed-by: Rajendra Nayak <rnayak@codeaurora.org>
Tested-by: Aníbal Limón <anibal.limon@linaro.org>
> 
> > ---
> >   arch/arm64/boot/dts/qcom/sdm845.dtsi | 30 ++++++++++++++++++++++++++++++
> >   1 file changed, 30 insertions(+)
> > 
> > diff --git a/arch/arm64/boot/dts/qcom/sdm845.dtsi b/arch/arm64/boot/dts/qcom/sdm845.dtsi
> > index fcb9330..f3cd94f 100644
> > --- a/arch/arm64/boot/dts/qcom/sdm845.dtsi
> > +++ b/arch/arm64/boot/dts/qcom/sdm845.dtsi
> > @@ -1893,6 +1893,36 @@
> >   			};
> >   		};
> > +		video-codec@aa00000 {
> > +			compatible = "qcom,sdm845-venus";
> > +			reg = <0 0x0aa00000 0 0xff000>;
> > +			interrupts = <GIC_SPI 174 IRQ_TYPE_LEVEL_HIGH>;
> > +			power-domains = <&videocc VENUS_GDSC>;
> > +			clocks = <&videocc VIDEO_CC_VENUS_CTL_CORE_CLK>,
> > +				 <&videocc VIDEO_CC_VENUS_AHB_CLK>,
> > +				 <&videocc VIDEO_CC_VENUS_CTL_AXI_CLK>;
> > +			clock-names = "core", "iface", "bus";
> > +			iommus = <&apps_smmu 0x10a0 0x8>,
> > +				 <&apps_smmu 0x10b0 0x0>;
> > +			memory-region = <&venus_mem>;
> > +
> > +			video-core0 {
> > +				compatible = "venus-decoder";
> > +				clocks = <&videocc VIDEO_CC_VCODEC0_CORE_CLK>,
> > +					 <&videocc VIDEO_CC_VCODEC0_AXI_CLK>;
> > +				clock-names = "core", "bus";
> > +				power-domains = <&videocc VCODEC0_GDSC>;
> > +			};
> > +
> > +			video-core1 {
> > +				compatible = "venus-encoder";
> > +				clocks = <&videocc VIDEO_CC_VCODEC1_CORE_CLK>,
> > +					 <&videocc VIDEO_CC_VCODEC1_AXI_CLK>;
> > +				clock-names = "core", "bus";
> > +				power-domains = <&videocc VCODEC1_GDSC>;
> > +			};
> > +		};
> > +
> >   		videocc: clock-controller@ab00000 {
> >   			compatible = "qcom,sdm845-videocc";
> >   			reg = <0 0x0ab00000 0 0x10000>;
> > 
> 
> -- 
> QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
> of Code Aurora Forum, hosted by The Linux Foundation
