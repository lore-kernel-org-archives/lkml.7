Return-Path: <SRS0=HfRD=XN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CDD3C4CEC4
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Sep 2019 12:14:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5A47521907
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Sep 2019 12:14:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1568808876;
	bh=3xBU5bcO/3yvTd7HH3BhD2s5pwzSXCjt2H1NCJIu7NA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=LFE6w7WB14VAdINcgAKwYeSHERnOnRoDf6XpXBLeN7tQVkvaoBW/4rlkhAituK1aH
	 XmCpr+U/Gu7FGuklSHy9sQqfebmOzmXNymLOxYHQKpUo2Zyyiwy5ktSuu5ds0nxeI7
	 hZihhFPYDfORzDbexu3pm+STgl1O5WNY3XhTswYQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730859AbfIRMOf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Sep 2019 08:14:35 -0400
Received: from mail-oi1-f196.google.com ([209.85.167.196]:33262 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727637AbfIRMOf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Sep 2019 08:14:35 -0400
Received: by mail-oi1-f196.google.com with SMTP id e18so5782650oii.0;
        Wed, 18 Sep 2019 05:14:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=x3q5Ep7ytIg0D5+RJg0Slh7fNjlsYm5ZAthpyyaoRs0=;
        b=cUuiMTlPOFUHOB57f6KgjUdmqgswsxM5iwEyIwPelQHNwbbWaOpYU3spXvp1GfEi09
         oY5FppjdgQAUvC8KA/ly15WBGHrnGTg19oyqo6wJ6qUHweI1l3DvHBAdTgbs+WoHu1kk
         9Xtdh23A3Ypx/sNNjCSE9lyuepCVWcNNFroKygzpb/RFko0kjmY74JpSuRp+hbpMEMFK
         hU2kc2AUCKMazWtAg8SXzYEgpPNIl4OjifHOLaSrtX0d5oFX6rd9pKRN8ICT/lzEb4QF
         LDvcOou63upMIiEi4YBNQ4YVGGOwddIG+tGFa+Wweh06ySewcRSGhhOqXMhP/Jz2tdjI
         ifiQ==
X-Gm-Message-State: APjAAAXSNN48FEY4A+bf4Hvo9SAc4/QzhwuOoI7tvwT/nR5Ux1DAqwdq
        oyJ5a/mjJN8WrkGpBd/JUw==
X-Google-Smtp-Source: APXvYqwLlpAkVP9QcKDsnCJ/getcuLTVoSWYrmx09jqIuKydUoh5os3EbpmTVG12tKE5PyBzfc4+4w==
X-Received: by 2002:aca:c38b:: with SMTP id t133mr1809859oif.22.1568808872899;
        Wed, 18 Sep 2019 05:14:32 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id 5sm1784320otp.20.2019.09.18.05.14.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Sep 2019 05:14:32 -0700 (PDT)
Date:   Wed, 18 Sep 2019 07:14:31 -0500
From:   Rob Herring <robh@kernel.org>
To:     Vinod Koul <vkoul@kernel.org>
Cc:     Kishon Vijay Abraham I <kishon@ti.com>,
        linux-arm-msm@vger.kernel.org,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Vinod Koul <vkoul@kernel.org>, Andy Gross <agross@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Evan Green <evgreen@chromium.org>,
        Can Guo <cang@codeaurora.org>,
        Stanley Chu <stanley.chu@mediatek.com>,
        Subhash Jadavani <subhashj@codeaurora.org>,
        Douglas Anderson <dianders@chromium.org>,
        Stephen Boyd <swboyd@chromium.org>
Subject: Re: [PATCH v2 1/3] dt-bindings: ufs: Add sm8150 compatible string
Message-ID: <20190918121431.GA31663@bogus>
References: <20190906051017.26846-1-vkoul@kernel.org>
 <20190906051017.26846-2-vkoul@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190906051017.26846-2-vkoul@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri,  6 Sep 2019 10:40:15 +0530, Vinod Koul wrote:
> Document "qcom,sm8150-ufshc" compatible string for UFS HC found on
> SM8150.
> 
> Signed-off-by: Vinod Koul <vkoul@kernel.org>
> Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> Reviewed-by: Stephen Boyd <swboyd@chromium.org>
> ---
>  Documentation/devicetree/bindings/ufs/ufshcd-pltfrm.txt | 1 +
>  1 file changed, 1 insertion(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
