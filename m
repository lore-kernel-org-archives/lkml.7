Return-Path: <SRS0=vtn1=VX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC167C76190
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 08:04:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B425E2166E
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 08:04:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="TYUJvMUe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726514AbfGZIEV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jul 2019 04:04:21 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:33033 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726067AbfGZIEV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jul 2019 04:04:21 -0400
Received: by mail-pf1-f195.google.com with SMTP id g2so24130746pfq.0
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jul 2019 01:04:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=RvwPhyEIP2C1GmNkk4CaBRsJ7LL1kgFaxYotbYvMHPg=;
        b=TYUJvMUexVnsX0m0MLXy24SyzzBqxoROwI7Uc7k8Jawjx30BNj/P3fgvOFd6mgF1ub
         gMVRPVNnGlbMn9NCKeeCRsnJEAJyRti2+XO2Cidy1kRVFPi37z0pc6C6sl6nml6arwGc
         Fe3IOu2AU/BEX1zbbAf3j+/uxFr2E2/wfJudYBKmpnOEyuAlRvQuWNkURmXId2PaGK3N
         iOGNsLw9G/mWislf38UtZ7PUMUIOQwb13WIAANRonntJ5JaszUsHIqMcn7tijUGIWr4e
         UQkx7dd5w0uacRGojJgwxU9+gJEApSPq6Xf8RPPY5kmnAtloZB6KcmHH+c7Iukhd46by
         zpZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=RvwPhyEIP2C1GmNkk4CaBRsJ7LL1kgFaxYotbYvMHPg=;
        b=mX0M0/NUl2tCPMr2uNtClmHpXzMf+1NjdX1GxsPN2gYIZ6G9/wvqhPjisEBfmuinUA
         J0NYnJnbVSpDTYMjN0pNUB2YYtqypDgmfBMB7zqyRtcVMfvwYCO1sntNCh0qdJzPs4S3
         DmJdgatZiEMYSA4U2mR8Yh85X71PNg1/rqERkR1+1mtetTBz2RHOtr8sS2RIRXafaVuQ
         LAeqb40UxQ+qLsdlSVBjFlvfZLSK4Gbgq3bjR0egTXm+3G2BeM4i3RJg6Y734DJUEb0A
         7XRuhERGBDNGcHbcZDpqpagQVD/cdjNnrVh8BRrNsmzrl+8GoEQ3pIrVXrDTFa6wsSNN
         KP4g==
X-Gm-Message-State: APjAAAVTyUTeqrgOBik7WLg7RRcg+ltM8cj66KLs1C3jlqkmGWZ4zVh0
        wwPh5AXtv/1ajBEbHgcywOr2IA==
X-Google-Smtp-Source: APXvYqxTsDwHnJcVzgc3D4+iVqCkMgf3qQEn4QWbmVPCdg1WXTAvCSSDgDPosNz3oyuEWm6Zp3gYRw==
X-Received: by 2002:a63:d852:: with SMTP id k18mr18912708pgj.313.1564128260209;
        Fri, 26 Jul 2019 01:04:20 -0700 (PDT)
Received: from localhost ([122.172.28.117])
        by smtp.gmail.com with ESMTPSA id c12sm38958764pgb.83.2019.07.26.01.04.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 26 Jul 2019 01:04:19 -0700 (PDT)
Date:   Fri, 26 Jul 2019 13:34:17 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Niklas Cassel <niklas.cassel@linaro.org>
Cc:     Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Andy Gross <agross@kernel.org>, Ilia Lin <ilia.lin@kernel.org>,
        linux-arm-msm@vger.kernel.org, jorge.ramirez-ortiz@linaro.org,
        bjorn.andersson@linaro.org, ulf.hansson@linaro.org,
        Sricharan R <sricharan@codeaurora.org>,
        Rob Herring <robh@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 02/14] dt-bindings: cpufreq: Re-organise kryo cpufreq
 to use it for other nvmem based qcom socs
Message-ID: <20190726080417.ohsgedbtyxbxfyj7@vireshk-i7>
References: <20190725104144.22924-1-niklas.cassel@linaro.org>
 <20190725104144.22924-3-niklas.cassel@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190725104144.22924-3-niklas.cassel@linaro.org>
User-Agent: NeoMutt/20180716-391-311a52
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

$subject of this and few more binding patches updated to:

"dt-bindings: opp: XXX"

On 25-07-19, 12:41, Niklas Cassel wrote:
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
> Reviewed-by: Ilia Lin <ilia.lin@kernel.org>
> Reviewed-by: Rob Herring <robh@kernel.org>
> ---
> Changes since V1:
> -Picked up tags.

-- 
viresh
