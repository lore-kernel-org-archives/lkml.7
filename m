Return-Path: <SRS0=SjSX=S5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9FC8C43218
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 04:55:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7E90A21530
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 04:55:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="yQ7CYwPj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726184AbfD0Ezr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 27 Apr 2019 00:55:47 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:41331 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726001AbfD0Ezr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Apr 2019 00:55:47 -0400
Received: by mail-pf1-f194.google.com with SMTP id 188so2661167pfd.8
        for <linux-kernel@vger.kernel.org>; Fri, 26 Apr 2019 21:55:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=8AmdxOYLP35ToV+QefTESbhmQTaoPmi11uqrmFGKsEc=;
        b=yQ7CYwPja24N+KnGPtCBMEi/6mLXKPcXZ7hdeLvIZtLUSYncQnOaiPjYzhn4zGPqGP
         o5Jpw2QEX1Lfn7p420g3WU5db9b9LsAVIqUCL1Ba6C1geXf5yHJO+KQe2kTfszBfiD2y
         INMQjZWQGacqaKiowb59fkb8ypGsv644gUPqs0uHrfUHbUP/gyp6lHxFBVZG22SXWV19
         Gx09Ff7n5FpOLNAupM5BSX4cghMzYm1QyOcrLSqRZhtzLkLez8BpLIwz/fx6+/A9Mr5X
         kDEL3RrWRq8JO53kIswtTcmnKLjyxcntPxI1RvsrrOC+bM3aE1DyGHflYCpLFd9xPFh+
         U1UQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=8AmdxOYLP35ToV+QefTESbhmQTaoPmi11uqrmFGKsEc=;
        b=A09nIeNBaSmlilXpEX5ZcDoVXDFJ/0s6dcSSPFTknOR3jGzUzuB8D0XaGbrS2XSLYs
         XjMzzWv4h6LfPWwT7YNZPDVJcevM2zl2IAjswkpQKeSNnCRpkyuGqBTGWuzzrD19NXYK
         IiUcNsSlY+puguxVqoF9rHaNpnpFUi4YOX+Mr7jIG1V4Pg3kuvgC9VowG6fXB4bXrkB3
         PQ3CaDLrf4AP0cX5p2uj0YeR58NziZ1BPDXxfQ2GW8Y4JzRoH4DVcqot3RMYDCnm3BIN
         0SCxMBHKNSVaSXUsQ7tGR8FYltY9JjviARMQMDej2DQVTptsh2+IQZAvFixAPBb85vAr
         OMEQ==
X-Gm-Message-State: APjAAAW38opbDvfah6EX/LgXqzjLLhOSBvmseJA9LqBGJE7LqMijjJcS
        50tHZ/rtjVkZz6ZcMXBifP3GLA==
X-Google-Smtp-Source: APXvYqzbrpO/Zn3dUZTeLDleZTqB0VfRMIwye63UwT6kRitJfMMzkYg8ksEQQB9VbYu3+6J3T8zBSg==
X-Received: by 2002:aa7:991b:: with SMTP id z27mr23371919pff.168.1556340946303;
        Fri, 26 Apr 2019 21:55:46 -0700 (PDT)
Received: from builder (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id z20sm32430469pgf.70.2019.04.26.21.55.44
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 26 Apr 2019 21:55:45 -0700 (PDT)
Date:   Fri, 26 Apr 2019 21:55:43 -0700
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Niklas Cassel <niklas.cassel@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        David Brown <david.brown@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: pms405: increase s3 max voltage
Message-ID: <20190427045543.GG3137@builder>
References: <20190425113429.14321-1-niklas.cassel@linaro.org>
 <20190425121805.GA17362@centauri>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190425121805.GA17362@centauri>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 25 Apr 05:18 PDT 2019, Niklas Cassel wrote:

> The commit description should be: arm64: dts: qcom: qcs404-evb:
> 
> (The s3 regulator node moved during upstreaming.)
> 
> Andy/Bjorn, could you please fix this before applying?
> 

Picked up with the subject change.

Thanks,
Bjorn

> Kind regards,
> Niklas
> 
> On Thu, Apr 25, 2019 at 01:34:29PM +0200, Niklas Cassel wrote:
> > Increase s3 max voltage in accordance to QCS404 CPR Fusing Guide Rev 6.0
> > 
> > Signed-off-by: Niklas Cassel <niklas.cassel@linaro.org>
> > ---
> >  arch/arm64/boot/dts/qcom/qcs404-evb.dtsi | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/arch/arm64/boot/dts/qcom/qcs404-evb.dtsi b/arch/arm64/boot/dts/qcom/qcs404-evb.dtsi
> > index 2c3127167e3c..6910fc663fe1 100644
> > --- a/arch/arm64/boot/dts/qcom/qcs404-evb.dtsi
> > +++ b/arch/arm64/boot/dts/qcom/qcs404-evb.dtsi
> > @@ -64,7 +64,7 @@
> >  		regulator-boot-on;
> >  		regulator-name = "vdd_apc";
> >  		regulator-min-microvolt = <1048000>;
> > -		regulator-max-microvolt = <1352000>;
> > +		regulator-max-microvolt = <1384000>;
> >  	};
> >  };
> >  
> > -- 
> > 2.20.1
> > 
