Return-Path: <SRS0=3iFO=VV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68065C7618F
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 14:53:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 41DCA20665
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 14:53:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1563980006;
	bh=QB7jH8fOdX+ZJA1kSRdtH6qHu2i4mSF2733WgOcvfBA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=L9Bd6IPvjZ3U/z8K1KHRStyZFFgC/B4e8IooaUCWDckPx6E4j0uRJJ02+rbBxLH1d
	 55ShWZCMIZugSE2KOnd/m9sddVkkL/PALFEdB/2gW+l8Sphg9vV+l4u0Jq+O3LBHFN
	 mH58WYIrwWohbmcQwkvwtRBGEzqu5YdT+bnJJbP8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387573AbfGXOxZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jul 2019 10:53:25 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:40606 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726422AbfGXOxY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jul 2019 10:53:24 -0400
Received: by mail-io1-f65.google.com with SMTP id h6so3631032iom.7;
        Wed, 24 Jul 2019 07:53:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=f1uxVtxe60Lcr7dI5TQEbK5Cmx2NSVJK7C4T4Q5hp2Y=;
        b=Xs8OoW84Cso8psAS9wFCWPgdp7MSw98gEpsW47oWTUZorY1m8URStG3q5oMv9Yxp1T
         GI8+81RFhsJyiMLSVaIDRmqGHvDZCPaLHxECeAr3wpkjbXaBdNEaYy1LHFP8gS3m1MvR
         5iaXqQYCHwOQY1iGxFP2mxyReqbb/ZWuSzCHrtXNGIDONsTS908m7XcfyZVCL9U/Ewd6
         hWbXY21reeirsSUK4CzxfcLLyzhYbeF85Q8juZhpFiPN+XzuE4fmA1T64JIzwthujUuM
         Nri48FLqU2fXq3Rvas2cVD7tcJc821h4Ux9G1IWr51ce9NLVjqHkmKa0OKu+WvzvwyR1
         HvlQ==
X-Gm-Message-State: APjAAAWfZMlZdmtHhtHX1AINhLswppRnwgOzgDfmBueJ6c9ZlGgv/G4x
        75O8d9tg5zc+YvB9Q+yrzqvPcxc=
X-Google-Smtp-Source: APXvYqxz45jNhjF9OdeNK+P0XXsH47UQdfWWYJlbey+fEz9h4ZWF7VXuyUUr5GMcM9viKwV/q3AN8w==
X-Received: by 2002:a6b:4f0d:: with SMTP id d13mr7295101iob.170.1563980003520;
        Wed, 24 Jul 2019 07:53:23 -0700 (PDT)
Received: from localhost ([64.188.179.254])
        by smtp.gmail.com with ESMTPSA id n17sm37419022iog.63.2019.07.24.07.53.22
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 24 Jul 2019 07:53:22 -0700 (PDT)
Date:   Wed, 24 Jul 2019 08:53:22 -0600
From:   Rob Herring <robh@kernel.org>
To:     Niklas Cassel <niklas.cassel@linaro.org>
Cc:     Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Ilia Lin <ilia.lin@kernel.org>, Andy Gross <agross@kernel.org>,
        linux-arm-msm@vger.kernel.org, jorge.ramirez-ortiz@linaro.org,
        bjorn.andersson@linaro.org, ulf.hansson@linaro.org,
        Sricharan R <sricharan@codeaurora.org>,
        Niklas Cassel <niklas.cassel@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 01/13] dt-bindings: cpufreq: Re-organise kryo cpufreq to
 use it for other nvmem based qcom socs
Message-ID: <20190724145322.GA4233@bogus>
References: <20190705095726.21433-1-niklas.cassel@linaro.org>
 <20190705095726.21433-2-niklas.cassel@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190705095726.21433-2-niklas.cassel@linaro.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri,  5 Jul 2019 11:57:12 +0200, Niklas Cassel wrote:
> From: Sricharan R <sricharan@codeaurora.org>
> 
> The kryo cpufreq driver reads the nvmem cell and uses that data to
> populate the opps. There are other qcom cpufreq socs like krait which
> does similar thing. Except for the interpretation of the read data,
> rest of the driver is same for both the cases. So pull the common things
> out for reuse.
> 
> Signed-off-by: Sricharan R <sricharan@codeaurora.org>
> [niklas.cassel@linaro.org: split dt-binding into a separate patch and
> do not rename the compatible string.]
> Signed-off-by: Niklas Cassel <niklas.cassel@linaro.org>
> ---
> Changes since RFC:
> -Made DT bindings a separate patch.
> -Keep the original compatible string, since renaming it breaks DT
> backwards compatibility.
> 
>  .../opp/{kryo-cpufreq.txt => qcom-nvmem-cpufreq.txt}   | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
>  rename Documentation/devicetree/bindings/opp/{kryo-cpufreq.txt => qcom-nvmem-cpufreq.txt} (98%)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
