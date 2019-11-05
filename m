Return-Path: <SRS0=2+op=Y5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 764FAC5DF61
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Nov 2019 19:43:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2ED4321A49
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Nov 2019 19:43:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1572982998;
	bh=t9iIhp7YCBy/rgI8OMzs2tbzJ18GgG2J9895nKvt2nQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=2JxrsXFuPpyuQ/ou6sOQubbVl/apy6y65OuBsrythKGjZerx1DejWrp/Qdso6oVQP
	 FZMRPPAyqOFCYAsRtmmPu2VUjGpahVWT4D5EAr7xTx6sSXgoAXz92huoMeTxpmK6Ln
	 /DHKcdVfj0kvrzaG7vqITDWhYTDcLrL2SnTkdK7w=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390947AbfKETnR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Nov 2019 14:43:17 -0500
Received: from mail-ot1-f65.google.com ([209.85.210.65]:41269 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390391AbfKETnR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Nov 2019 14:43:17 -0500
Received: by mail-ot1-f65.google.com with SMTP id 94so18671450oty.8;
        Tue, 05 Nov 2019 11:43:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=DxJeph9SMIl2HaoxiyZwlewIG04Tl4irjIR+yBHGfk8=;
        b=IGpOAQVZ+QGn1cGuOdDbjjL0UxZ+FwcOV3TAMq4Jm5woJGyb7Q2KdIl/ajnY8gUve/
         D6VqGvWS50MmLcJ4vm57T3qXy0fZKNkPtKJyoDpq1PCLyDtW8D6fFb76mLmDhXiKsl8Y
         CvfQuh74kS5DnlXbv43YuZYNWuKAKC7SDJZiltLx5N0vhVeOoQQKHivzVVeZsGI7U2vt
         NOC9SKXFytnq6HTxVGkBeKoNLShWai2HsVyXBE6H6RtzwiQJmh22nO6kibIvrIuOQPOC
         lo6AwhqzAcPc3w1ZeqI1xYLxtAdVZ9El0K+/sATN9Ebkq2M2NMHxhKsLescklpbElJob
         86FA==
X-Gm-Message-State: APjAAAUMi5TOK+MIqg1tKc6ZpOFioqxGFo6gy5FLMiNIgOkyxM3cKN7K
        nSUURQdgypqRsApCmrCBz+Ka/nE=
X-Google-Smtp-Source: APXvYqzGqoQJX7yypT0mKyxtD5PEOEBFSFjqnv7Ri+Z9HkmNdS3Js06cTZGsq26M5OG0tvHPTq6Gxw==
X-Received: by 2002:a9d:7846:: with SMTP id c6mr4364877otm.338.1572982996049;
        Tue, 05 Nov 2019 11:43:16 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id o203sm377657oia.4.2019.11.05.11.43.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Nov 2019 11:43:15 -0800 (PST)
Date:   Tue, 5 Nov 2019 13:43:14 -0600
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Kevin Hilman <khilman@baylibre.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-samsung-soc@vger.kernel.org,
        Krzysztof Kozlowski <krzk@kernel.org>
Subject: Re: [PATCH v3 2/2] dt-bindings: power: Convert Samsung Exynos Power
 Domain bindings to json-schema
Message-ID: <20191105194314.GA16556@bogus>
References: <20191030173216.5993-1-krzk@kernel.org>
 <20191030173216.5993-2-krzk@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191030173216.5993-2-krzk@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 30 Oct 2019 18:32:16 +0100, Krzysztof Kozlowski wrote:
> Convert Samsung Exynos Soc Power Domain bindings to DT schema format using
> json-schema.
> 
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> 
> ---
> 
> Changes since v2:
> 1. Use new name of file in samsung,sysmmu.yaml and MAINTAINERS.
> 
> Changes since v1:
> 1. Indent example with four spaces (more readable),
> 2. Remove unneeded types,
> 3. Add missing address in example and fix the name.
> ---
>  .../bindings/iommu/samsung,sysmmu.yaml        |  2 +-
>  .../devicetree/bindings/power/pd-samsung.txt  | 45 -------------
>  .../devicetree/bindings/power/pd-samsung.yaml | 66 +++++++++++++++++++
>  MAINTAINERS                                   |  2 +-
>  4 files changed, 68 insertions(+), 47 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/power/pd-samsung.txt
>  create mode 100644 Documentation/devicetree/bindings/power/pd-samsung.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>
