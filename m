Return-Path: <SRS0=nnGO=2J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE626C2D0C0
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Dec 2019 07:20:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B51DD2465E
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Dec 2019 07:20:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="wUlqPM9O"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726694AbfLSHUg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Dec 2019 02:20:36 -0500
Received: from mail-pj1-f66.google.com ([209.85.216.66]:55877 "EHLO
        mail-pj1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726294AbfLSHUf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Dec 2019 02:20:35 -0500
Received: by mail-pj1-f66.google.com with SMTP id d5so2070510pjz.5
        for <linux-kernel@vger.kernel.org>; Wed, 18 Dec 2019 23:20:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=kscgx3K8f9rm17CyfQ9LRYgvhZGZDTucQRqu6s3cXY8=;
        b=wUlqPM9OwvDSBUIguTphIAJetJoP7jzTbb4OIqI84eMHS3lsLy9/5tzHTOqCO7QIBw
         pJrS4iyWynSx5Lp6ccLVem+BqrD+MswvsMg3CoCWPsAo3Yu1MYcq4AOiYJmSYjzndq27
         EG+ib26O/X9xpIikIHi8G8mpEGH4B/tgc8M5+/u+wlWdqZZDwPgd/fVxwmw5G/1Rz5lh
         G4rXxgcmbAF4OVt44n+PpRTdze8k8ywufIRjdT5XJwifVPC1Zsp4Z2ZmBQsbaf0kIFj/
         nCJDLd5WCeDxqpRrB0ZlG/AJsmk+VA2atptI2W8+sXubVQiLg7pK2rQHCDq/P/TR6TMK
         nP6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=kscgx3K8f9rm17CyfQ9LRYgvhZGZDTucQRqu6s3cXY8=;
        b=oy4HZ5jSyNMmB9T4xSFS3ICwISUFsuepWFxmGzFKWB57f5Y6cjkUR5p3dQQYVzZocY
         HNIS9FO2VHbZNO6LieXk5fcI7KyyX890Zzhce4rJVtz9AvHdEcKu01MTNZdbngCdyFFJ
         34EBxdduZwmy4Q+HeQSKU4nvooHsy1AVR1ojt4Bl4Yt4au+Q7SecrlywKtsDK84LRGr+
         /zbIGmbCATkFznbVceDt6BEmd4tXpvJ/3GKaEymv3ASF/NeyHReS2mnLlzoMIj1gxF8i
         fh04Os4Af9gKylt8z7P6YoZt8QKNpEVGTLsBtab71wOKefqt87hzKYLuVC04zYwnRqd6
         amBA==
X-Gm-Message-State: APjAAAUJYi8l19BYaMg1kqCJMX6YNf8YJtFy9HDoEh9btN9/ZocVu+y4
        T+jWy4318q+BzxNpwyfm46On+w==
X-Google-Smtp-Source: APXvYqwZDaVVbLJc92e8Bk8x6mCLD0JaErRln4COlsW6/zlSXZ0qymPWOOzXN9QDcgGQYfvmGi86Nw==
X-Received: by 2002:a17:902:7d84:: with SMTP id a4mr7303034plm.97.1576740034787;
        Wed, 18 Dec 2019 23:20:34 -0800 (PST)
Received: from yoga (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id q6sm6515119pfh.127.2019.12.18.23.20.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Dec 2019 23:20:34 -0800 (PST)
Date:   Wed, 18 Dec 2019 23:20:31 -0800
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     pillair@codeaurora.org
Cc:     devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] arm64: dts: qcom: sc7180: Add WCN3990 WLAN module device
 node
Message-ID: <20191219072031.GH448416@yoga>
References: <0101016ed018cde9-da3dc3e0-de6e-4b18-9add-bc6f88511ab2-000000@us-west-2.amazonses.com>
 <20191211072053.GH3143381@builder>
 <000b01d5b631$30ae26f0$920a74d0$@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <000b01d5b631$30ae26f0$920a74d0$@codeaurora.org>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 18 Dec 21:57 PST 2019, pillair@codeaurora.org wrote:

> I will raise the next patchset with the comments addressed.
> 
> > -----Original Message-----
> > From: Bjorn Andersson <bjorn.andersson@linaro.org>
> > Sent: Wednesday, December 11, 2019 12:51 PM
> > To: Rakesh Pillai <pillair@codeaurora.org>
> > Cc: devicetree@vger.kernel.org; linux-arm-msm@vger.kernel.org; linux-
> > kernel@vger.kernel.org; linux-arm-kernel@lists.infradead.org
> > Subject: Re: [PATCH] arm64: dts: qcom: sc7180: Add WCN3990 WLAN module
> > device node
> > 
> > On Wed 04 Dec 00:48 PST 2019, Rakesh Pillai wrote:
> > 
> > > Add device node for the ath10k SNOC platform driver probe
> > > and add resources required for WCN3990 on sc7180 soc.
> > >
> > > Signed-off-by: Rakesh Pillai <pillair@codeaurora.org>
> > > ---
> > > This change is dependent on the below set of changes
> > > arm64: dts: sc7180: Add qupv3_0 and qupv3_1
> > (https://lore.kernel.org/patchwork/patch/1150367/)
> > 
> > Why?
> 
> The mentioned series of patchset brings the DTSI for sc7180.
> Hence the addition of wifi node is dependent on this series
> https://lore.kernel.org/patchwork/patch/1150367/
> 

I see, this should all be settled now. Looking forward to v2.

Thanks,
Bjorn

> 
> > 
> > > ---
> > >  arch/arm64/boot/dts/qcom/sc7180-idp.dts |  4 ++++
> > >  arch/arm64/boot/dts/qcom/sc7180.dtsi    | 27
> > +++++++++++++++++++++++++++
> > >  2 files changed, 31 insertions(+)
> > >
> > > diff --git a/arch/arm64/boot/dts/qcom/sc7180-idp.dts
> > b/arch/arm64/boot/dts/qcom/sc7180-idp.dts
> > > index 189254f..8a6a760 100644
> > > --- a/arch/arm64/boot/dts/qcom/sc7180-idp.dts
> > > +++ b/arch/arm64/boot/dts/qcom/sc7180-idp.dts
> > > @@ -248,6 +248,10 @@
> > >  	status = "okay";
> > >  };
> > >
> > > +&wifi {
> > > +	status = "okay";
> > 
> > Please conclude on the representation of the "skip-hyp-mem-assign" and
> > add it here, rather than in a subsequent patch - which implies that this
> > patch doesn't work on its own.
> 
> 
> Sure, I will update the next patchset.
> 
> 
> > 
> > > +};
> > > +
> > >  /* PINCTRL - additions to nodes defined in sc7180.dtsi */
> > >
> > >  &qup_i2c2_default {
> > > diff --git a/arch/arm64/boot/dts/qcom/sc7180.dtsi
> > b/arch/arm64/boot/dts/qcom/sc7180.dtsi
> > > index 666e9b9..40c9971 100644
> > > --- a/arch/arm64/boot/dts/qcom/sc7180.dtsi
> > > +++ b/arch/arm64/boot/dts/qcom/sc7180.dtsi
> > > @@ -42,6 +42,12 @@
> > >  			compatible = "qcom,cmd-db";
> > >  			no-map;
> > >  		};
> > > +
> > > +		wlan_fw_mem: wlan_fw_region@93900000 {
> > 
> > wlan_fw_mem: memory@93900000 {
> > 
> > > +			compatible = "removed-dma-pool";
> > > +			no-map;
> > > +			reg = <0 0x93900000 0 0x200000>;
> > > +		};
> > >  	};
> > >
> > >  	cpus {
> > > @@ -1119,6 +1125,27 @@
> > >  				#clock-cells = <1>;
> > >  			};
> > >  		};
> > > +
> > > +		wifi: wifi@18800000 {
> > > +			status = "disabled";
> > > +			compatible = "qcom,wcn3990-wifi";
> > > +			reg = <0 0x18800000 0 0x800000>;
> > > +			reg-names = "membase";
> > > +			interrupts =
> > > +				<GIC_SPI 414 IRQ_TYPE_LEVEL_HIGH /* CE0
> > */ >,
> > > +				<GIC_SPI 415 IRQ_TYPE_LEVEL_HIGH /* CE1
> > */ >,
> > > +				<GIC_SPI 416 IRQ_TYPE_LEVEL_HIGH /* CE2
> > */ >,
> > > +				<GIC_SPI 417 IRQ_TYPE_LEVEL_HIGH /* CE3
> > */ >,
> > > +				<GIC_SPI 418 IRQ_TYPE_LEVEL_HIGH /* CE4
> > */ >,
> > > +				<GIC_SPI 419 IRQ_TYPE_LEVEL_HIGH /* CE5
> > */ >,
> > > +				<GIC_SPI 420 IRQ_TYPE_LEVEL_HIGH /* CE6
> > */ >,
> > > +				<GIC_SPI 421 IRQ_TYPE_LEVEL_HIGH /* CE7
> > */ >,
> > > +				<GIC_SPI 422 IRQ_TYPE_LEVEL_HIGH /* CE8
> > */ >,
> > > +				<GIC_SPI 423 IRQ_TYPE_LEVEL_HIGH /* CE9
> > */ >,
> > > +				<GIC_SPI 424 IRQ_TYPE_LEVEL_HIGH /* CE10
> > */>,
> > > +				<GIC_SPI 425 IRQ_TYPE_LEVEL_HIGH /* CE11
> > */>;
> > > +			memory-region = <&wlan_fw_mem>;
> > 
> > No iommus in sc7180?
> > 
> > Regards,
> > Bjorn
> > 
> > > +		};
> > >  	};
> > >
> > >  	timer {
> > > --
> > > 2.7.4
> > >
> > >
> > > _______________________________________________
> > > linux-arm-kernel mailing list
> > > linux-arm-kernel@lists.infradead.org
> > > http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
