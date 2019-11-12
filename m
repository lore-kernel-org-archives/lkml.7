Return-Path: <SRS0=WT+Y=ZE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FCAAC17440
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 19:27:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 14F372196E
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 19:27:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573586869;
	bh=YVPgo+KKFI4eokRGU8vZ1y3LWu0L+SRe0gVOAhPaZPg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Bq2awel+RgXNeDURY/X+j3LUyfFMu83218K67ML6L1iWREmHBVYBtnsDzdALKCT00
	 QECTXOdzWT0OhbgAqRsdZih/ZBnBwrQTgBRc32/4p7W0C5jTNC/ZWige2xl2ssy1aW
	 atNcsN/yYUR5gw4N5UR35jwpIosJyWc+BzMCaNGc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727054AbfKLT1s (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Nov 2019 14:27:48 -0500
Received: from mail-oi1-f195.google.com ([209.85.167.195]:43298 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725997AbfKLT1r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Nov 2019 14:27:47 -0500
Received: by mail-oi1-f195.google.com with SMTP id l20so15879966oie.10;
        Tue, 12 Nov 2019 11:27:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=Y4VJU4JPIoN8kP/oz54y8Wq1pxD+B52sbN7PsTOLQlY=;
        b=exflkZjI2ZBILdpW4axODjadTtAsEC9yplHk6gpcDHwN8UEaZBqUW2Eu/aXFA/841Q
         8pZYg5asWPMioRYW5Ec7Bl4NfsD6QJfKZrPPF4wA1+N4gXijWdZBNmGXYGYDbfV5nTDD
         P3OUjNQNMLXAblEKTEOeigw3c3CATQbvdwPGX0eeabfmPD0efEWAKm5P7wvtLMx18qQ8
         YV4uOduCTDCLp6MnYDMx6vO4BhgVNJc0d0t097r+oeWrdOVlKm9zvecq9hyr5p2xuqOE
         CYAebG2375JT+GsDZoCZKBDHeMCcRo40jVvj8xR/+Soa5tMutXzusGyGuwA/dfdSd16v
         K8mA==
X-Gm-Message-State: APjAAAVQGrLQ8+llY1mrZtTn7ZuaE4oW3O8u6ne3LpLBN0cfCyBuBJaC
        MLM692buAVlkCe45jbXkvsP0k38=
X-Google-Smtp-Source: APXvYqz4Jkfw6OOk4L5JFnxQar5zpZUQ12T/aVbn6qghLtQRbJWl1rIMeQ2geyDRfOhX2lw8P+1LcA==
X-Received: by 2002:aca:5006:: with SMTP id e6mr501570oib.127.1573586866587;
        Tue, 12 Nov 2019 11:27:46 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id 202sm6330662oii.39.2019.11.12.11.27.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Nov 2019 11:27:46 -0800 (PST)
Date:   Tue, 12 Nov 2019 13:27:45 -0600
From:   Rob Herring <robh@kernel.org>
To:     Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc:     vkoul@kernel.org, robh+dt@kernel.org, nm@ti.com,
        ssantosh@kernel.org, dan.j.williams@intel.com,
        dmaengine@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        grygorii.strashko@ti.com, lokeshvutla@ti.com, t-kristo@ti.com,
        tony@atomide.com, j-keerthy@ti.com
Subject: Re: [PATCH v5 08/15] dt-bindings: dma: ti: Add document for K3 UDMA
Message-ID: <20191112192745.GA20639@bogus>
References: <20191111135330.8235-1-peter.ujfalusi@ti.com>
 <20191111135330.8235-9-peter.ujfalusi@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20191111135330.8235-9-peter.ujfalusi@ti.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 11 Nov 2019 15:53:23 +0200, Peter Ujfalusi wrote:
> New binding document for
> Texas Instruments K3 NAVSS Unified DMA – Peripheral Root Complex (UDMA-P).
> 
> UDMA-P is introduced as part of the K3 architecture and can be found in
> AM654 and j721e.
> 
> Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
> ---
>  .../devicetree/bindings/dma/ti/k3-udma.yaml   | 192 ++++++++++++++++++
>  1 file changed, 192 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/dma/ti/k3-udma.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>
