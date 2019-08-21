Return-Path: <SRS0=xaRW=WR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C9C1C3A5A1
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Aug 2019 19:39:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E443722DD3
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Aug 2019 19:39:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1566416357;
	bh=3+bOm3apjEeFWJgrs5H219KwrGqh7QwP48GJ2jvHchI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=puujFIFeBD6Ekoe0dSJjq3II3Pe8UhX6iGECHo+myYW5vZVtUHtvxjYRFieaDeVaW
	 AGn1/TBczfK8rMnm6lYrXsWqroG8coQHPjzhWACaavJ3NMd+CSWnkMglBESzd6FL03
	 ghTle4CGyUgB5lFqP5zKkgE7tVC8O795PxTsVCjs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730084AbfHUTjQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Aug 2019 15:39:16 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:44008 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730014AbfHUTjP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Aug 2019 15:39:15 -0400
Received: by mail-ot1-f65.google.com with SMTP id e12so3167184otp.10;
        Wed, 21 Aug 2019 12:39:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=owZHN5PrxnL0KlbCqnJkXzPMTNmx+NgS7FAw3TG7K1E=;
        b=Ks01twHMqKp9pvSqZ8NjZlRkIYu5XmZxPQnBbksE2C2a7dxv5S1A8NLHIfwqj5l6yE
         m4crYIeK4lVUNCvJmJGbKfyCKIB76iZcB1hv6eqeh9cugSie6+y2gTA4WKBMqbG1jVxj
         eQ3Z/B8suZcTqDp45ixx3QcmD0Pnd/54xNFwKECDVSEsVRAu7UreWRY5TMLeCsz2nKIT
         eBL1vjs0/NwFgR4ECloaLHS3sbP3fxVr8un6nRhIr4Hzn1dtG2r0jyKnvWsz3hKGDLZI
         b1rfOfCGxI4fNoee/PCJQU8snvJEAEVxMHyGs+XTyOaYNQ37Av+fwMCUsyNjVEztHCuQ
         S57A==
X-Gm-Message-State: APjAAAUxy2z8T8LhKAkUgUu0R+4HWvGljtFBVG68JLfX7/l7PR7Uk5HP
        hX9XSaLJbDMzpL4395IPiA==
X-Google-Smtp-Source: APXvYqwfBiUWFWD9JyQdy9jjBHwr/SvMK6TECP1Zxw2XDMEvDQZmM2Ki2kaaJbKU9iptMoQHwhPZiQ==
X-Received: by 2002:a05:6830:1bd9:: with SMTP id v25mr10577398ota.205.1566416354716;
        Wed, 21 Aug 2019 12:39:14 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id n1sm90607oie.12.2019.08.21.12.39.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Aug 2019 12:39:14 -0700 (PDT)
Date:   Wed, 21 Aug 2019 14:39:13 -0500
From:   Rob Herring <robh@kernel.org>
To:     Sibi Sankar <sibis@codeaurora.org>
Cc:     bjorn.andersson@linaro.org, robh+dt@kernel.org, vkoul@kernel.org,
        aneela@codeaurora.org, mark.rutland@arm.com, agross@kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, jassisinghbrar@gmail.com,
        clew@codeaurora.org, Sibi Sankar <sibis@codeaurora.org>
Subject: Re: [PATCH v2 6/7] dt-bindings: soc: qcom: aoss: Add SM8150 and
 SC7180 support
Message-ID: <20190821193913.GA13189@bogus>
References: <20190807070957.30655-1-sibis@codeaurora.org>
 <20190807070957.30655-7-sibis@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190807070957.30655-7-sibis@codeaurora.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed,  7 Aug 2019 12:39:56 +0530, Sibi Sankar wrote:
> Add SM8150 and SC7180 AOSS QMP to the list of possible bindings.
> 
> Signed-off-by: Sibi Sankar <sibis@codeaurora.org>
> ---
>  Documentation/devicetree/bindings/soc/qcom/qcom,aoss-qmp.txt | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
