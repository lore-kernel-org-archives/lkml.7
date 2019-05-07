Return-Path: <SRS0=RyeP=TH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03571C004C9
	for <linux-kernel@archiver.kernel.org>; Tue,  7 May 2019 06:55:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C6C7F20989
	for <linux-kernel@archiver.kernel.org>; Tue,  7 May 2019 06:55:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="UMMLnWG4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726594AbfEGGzo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 May 2019 02:55:44 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:43490 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726437AbfEGGzn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 May 2019 02:55:43 -0400
Received: by mail-pf1-f196.google.com with SMTP id c6so2934792pfa.10
        for <linux-kernel@vger.kernel.org>; Mon, 06 May 2019 23:55:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=UWFGclreBqK14SYbMq2K7ZoXoM7JUPH8rO1VMNdVVW0=;
        b=UMMLnWG4abHWBIpK7s91J324jWLx2vrsbjmPXim3igk7jRFo6ZQ6n83CALMKI/Axly
         G/lx7wzLrE1D6ZHk5aduEeg7Ts7VJ1bwcjIVQBeuDEQkToewjrcaKw5g6vdZegdTlHgJ
         Gpq9PbYgFW9jTYuH6aDEAA9dW846q6LtRdFtVJtKezkkZ4oCMgeIRAOilSme0DwHcMSV
         RAKHSSY2OGD6HuRts/594cqDzKi7gunoDuaj9UGMy8ZqL08qwVMWgzRj3cnWkHdyB8mG
         tyFWFZnXf45cfFlfISFcdEhVphX3J1C3zaJehPhyg16GBclqcHLzaOk694cHCZROZrC9
         w9bQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=UWFGclreBqK14SYbMq2K7ZoXoM7JUPH8rO1VMNdVVW0=;
        b=i+2DLtgX1Wc6kMBiSjRvXMe9sDwkh11lG/pX3Zp3yaafuE5oxxS13VL6ItvV52Id68
         5hVHMZ3h1/eFs0+4ONFVpuJ/RQcksDa2pI3eoF95NMYFCLWvnfY2h79XTmRO8pDBegc5
         w5NaKRAVqNclvxvzLeby7kvzb7cLSzLC9fTcgrdqHH39aKdFZHpSAzupxG06E3lrlhUe
         bVJBEDYYNofG6+c2VQQdoApj67HVtKmvmAlUiaWHbbJieZGRICr2le2n1Rgr6iATG7zZ
         Yj6jiWPgQNC9l+hopkUjw1/fZthp0hqki3rRn2dK8erldBlMx4yOo+3MM/jD5l121U/h
         8MzQ==
X-Gm-Message-State: APjAAAVs78ndV5DMO95raDjTE5umNJ297LwiVLVU9YGwvBI6Jfhfve9X
        v6sbxXTn4QXE7jeSVG6ORQe7EQ==
X-Google-Smtp-Source: APXvYqwxmniIrwLxpXqEa123LJPdEDrKUmBTX9fYCqxmAL0CYOX5G+VVDnPBt11tDpN3zMNqOydAUA==
X-Received: by 2002:a65:624f:: with SMTP id q15mr21964539pgv.436.1557212142702;
        Mon, 06 May 2019 23:55:42 -0700 (PDT)
Received: from tuxbook-pro (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id o10sm19920594pfh.168.2019.05.06.23.55.41
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 06 May 2019 23:55:41 -0700 (PDT)
Date:   Mon, 6 May 2019 23:55:55 -0700
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Vinod Koul <vkoul@kernel.org>
Cc:     Niklas Cassel <niklas.cassel@linaro.org>,
        Andy Gross <agross@kernel.org>,
        David Brown <david.brown@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, amit.kucheria@linaro.org,
        jorge.ramirez-ortiz@linaro.org, lina.iyer@linaro.org,
        ulf.hansson@linaro.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: qcom: qcs404: Add PSCI cpuidle support
Message-ID: <20190507065555.GB2085@tuxbook-pro>
References: <20190506193115.20909-1-niklas.cassel@linaro.org>
 <20190507053547.GE16052@vkoul-mobl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190507053547.GE16052@vkoul-mobl>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 06 May 22:35 PDT 2019, Vinod Koul wrote:

> On 06-05-19, 21:31, Niklas Cassel wrote:
> > Add device bindings for CPUs to suspend using PSCI as the enable-method.
> > 
> > Signed-off-by: Niklas Cassel <niklas.cassel@linaro.org>
> > ---
> >  arch/arm64/boot/dts/qcom/qcs404.dtsi | 15 +++++++++++++++
> >  1 file changed, 15 insertions(+)
> > 
> > diff --git a/arch/arm64/boot/dts/qcom/qcs404.dtsi b/arch/arm64/boot/dts/qcom/qcs404.dtsi
> > index ffedf9640af7..f9db9f3ee10c 100644
> > --- a/arch/arm64/boot/dts/qcom/qcs404.dtsi
> > +++ b/arch/arm64/boot/dts/qcom/qcs404.dtsi
> > @@ -31,6 +31,7 @@
> >  			reg = <0x100>;
> >  			enable-method = "psci";
> >  			next-level-cache = <&L2_0>;
> > +			cpu-idle-states = <&CPU_PC>;
> >  		};
> >  
> >  		CPU1: cpu@101 {
> > @@ -39,6 +40,7 @@
> >  			reg = <0x101>;
> >  			enable-method = "psci";
> >  			next-level-cache = <&L2_0>;
> > +			cpu-idle-states = <&CPU_PC>;
> >  		};
> >  
> >  		CPU2: cpu@102 {
> > @@ -47,6 +49,7 @@
> >  			reg = <0x102>;
> >  			enable-method = "psci";
> >  			next-level-cache = <&L2_0>;
> > +			cpu-idle-states = <&CPU_PC>;
> >  		};
> >  
> >  		CPU3: cpu@103 {
> > @@ -55,12 +58,24 @@
> >  			reg = <0x103>;
> >  			enable-method = "psci";
> >  			next-level-cache = <&L2_0>;
> > +			cpu-idle-states = <&CPU_PC>;
> >  		};
> >  
> >  		L2_0: l2-cache {
> >  			compatible = "cache";
> >  			cache-level = <2>;
> >  		};
> > +
> > +		idle-states {
> 
> Since we are trying to sort the file per address and
> alphabetically, it would be great if this can be moved before l2-cache
> :)
> 

Picked up, with the order adjusted.

> Other than that this lgtm
>  

I presume that lgtm == Reviewed-by...

Thanks,
Bjorn

> > +			CPU_PC: pc {
> > +				compatible = "arm,idle-state";
> > +				arm,psci-suspend-param = <0x40000003>;
> > +				entry-latency-us = <125>;
> > +				exit-latency-us = <180>;
> > +				min-residency-us = <595>;
> > +				local-timer-stop;
> > +			};
> > +		};
> >  	};
> >  
> >  	firmware {
> > -- 
> > 2.21.0
> 
> -- 
> ~Vinod
