Return-Path: <SRS0=w7sF=2K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0171FC3F68F
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Dec 2019 02:34:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CC32224680
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Dec 2019 02:34:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="A5XLiLj5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727231AbfLTCec (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Dec 2019 21:34:32 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:36787 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727024AbfLTCeb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Dec 2019 21:34:31 -0500
Received: by mail-pf1-f196.google.com with SMTP id x184so4379851pfb.3
        for <linux-kernel@vger.kernel.org>; Thu, 19 Dec 2019 18:34:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=mVLwMYU9a1Ur9p84n79pZdcxfrBVZ9dl3tOWS7SY+xA=;
        b=A5XLiLj5XSorkfvQSx4vNY7HKLa68YNU6fUVPeKVnsYSZxhYpHtADihv6LVt/KThhw
         abQr4Lo1YZ70r6Yhzt10AHq7H8T4cjrLV5hutX6T0x/76ECM+WY8MccHN1292kSeidFS
         +lq66CmXgUyXMFeHnmljFNydyHmw5XUejn6zHWNL4ZI1R9NkCKrHDWtpUP3vnKcGT7Kd
         bU5mUETfLlbIRvAgZNr9RksSLcfEBrSTRAJPsaTAXTRW+ZePHwsgiTmNvtbqKOfpg+Gu
         lnb4RlFSEv1mYTe2rn1/Z8X9nam7y5eArPaygWDvKNnvYNd55ba+LXn4qYCXQETYs6eE
         BcGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=mVLwMYU9a1Ur9p84n79pZdcxfrBVZ9dl3tOWS7SY+xA=;
        b=MHosZeJLTF4FsNkE9WBWT+QOGtMiHQDhF+caGEL1LIKbutoVPFqTuWJwBMhM95d910
         YpUyqz1L7Js2++ln2N9LgWKphSGB91bUnp2QwEzxl5WZGZpJxHwTY/vluwBwFmj2gOQp
         ERZ2LCgkvt3hILN3kMjDWZqjSPFHcfmyWeKaG322gjj2COxC1VyAYcrmcypDx/wxGG/d
         jt4QssZdcWJlO2tE53eIhn84EsGOPbbd5JpFaBW/X8m+FteEPIUBx2NGR4Z0E0GAn6AL
         h745K2ES0h/xdfvukVXv/Ke3V0WOf4QnyIYxIH13TexyKNyCWOGsEKI6IywaH9Wtt61V
         fEQA==
X-Gm-Message-State: APjAAAVIoPLMPglmUUUIqeVIDlF601yGG/TBGFSCQivQ13pQDlzNb1iB
        UZW7Tv8Rn7D24gDIbsPt6XNuNg==
X-Google-Smtp-Source: APXvYqzQxouN9+tP55/5fJi1dLRhTZxq4NQnMIOJeo5MymuGtB8QKOUaMrH+A5MNTCh7N14bYMd1UA==
X-Received: by 2002:a62:e30f:: with SMTP id g15mr13168064pfh.124.1576809270507;
        Thu, 19 Dec 2019 18:34:30 -0800 (PST)
Received: from yoga (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id x33sm8946698pga.86.2019.12.19.18.34.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Dec 2019 18:34:29 -0800 (PST)
Date:   Thu, 19 Dec 2019 18:34:27 -0800
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Stephen Boyd <sboyd@kernel.org>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        Andy Gross <agross@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Paolo Pisati <p.pisati@gmail.com>
Subject: Re: [PATCH 1/2] clk: qcom: gcc-msm8996: Fix parent for CLKREF clocks
Message-ID: <20191220023427.GL448416@yoga>
References: <20191207203603.2314424-1-bjorn.andersson@linaro.org>
 <20191207203603.2314424-2-bjorn.andersson@linaro.org>
 <20191219063719.5AF942146E@mail.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191219063719.5AF942146E@mail.kernel.org>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 18 Dec 22:37 PST 2019, Stephen Boyd wrote:

> Quoting Bjorn Andersson (2019-12-07 12:36:02)
> > The CLKREF clocks are all fed by the clock signal on the CXO2 pad on the
> > SoC. Update the definition of these clocks to allow this to be wired up
> > to the appropriate clock source.
> > 
> > Retain "xo" as the global named parent to make the change a nop in the
> > event that DT doesn't carry the necessary clocks definition.
> 
> Something seems wrong still.
> 
> I wonder if we need to add the XO "active only" clk to the rpm clk
> driver(s) and mark it as CLK_IS_CRITICAL. In theory that is really the
> truth for most of the SoCs out there because it's the only crystal that
> needs to be on all the time when the CPU is active. The "normal" XO clk
> will then be on all the time unless deep idle is entered and nobody has
> turned that on via some clk_prepare() call. That's because we root all
> other clks through the "normal" XO clk that will be on in deep
> idle/suspend if someone needs it to be.
> 

The patch doesn't attempt to address the fact that our representation of
XO is incomplete, only the fact that CXO2 isn't properly described.

Looking at the clock distribution, we do have RPM_SMD_BB_CLK1_A which
presumably is the clock you're referring to here - i.e. the clock
resource connected to CXO.

> Did the downstream code explicitly enable this ln_bb_clk in the phy
> drivers? I think it may have?
> 

Yes, afaict all downstream drivers consuming a CLKREF also consumes
LN_BB and ensures that this is enabled. So we've been relying on UFS to
either not have probed yet or that UFS probed successfully for PCIe and
USB to be functional.

So either we need this patch to ensure that the requests propagates
down, or I need to patch up the PHY drivers to ensure that they also
vote for the PMIC clock - and I do prefer this patch.

Regards,
Bjorn
