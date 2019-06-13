Return-Path: <SRS0=5wok=UM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1419C31E45
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 22:49:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BFE8D2080A
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 22:49:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1560466166;
	bh=5r/Ccea7fv1M3398BJGxpyT6Y7B/Jshtrbm9AhNbrWg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=QqiUfa+QO4zybnBcmwbst7eYqglsMDLD+gRFI/d/L68wltUKXOSf1xBViyHPFhgrQ
	 582lhoDgSMfR5TTQzCEnII86twWLuc7POrqFReoczaaHSMEe54BL4UUmxJyUfPF9lZ
	 8WxZyEIkNfUdl53bzAqDbmAThuWgrIVFSRXQLOnI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727144AbfFMWtZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Jun 2019 18:49:25 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:35605 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725809AbfFMWtZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jun 2019 18:49:25 -0400
Received: by mail-qk1-f193.google.com with SMTP id l128so506534qke.2;
        Thu, 13 Jun 2019 15:49:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=qMfB3pkeiAOw5VCNnYbb1aIh4uwpJYsVqT9RDBEzeoo=;
        b=Hnht5Xv00NGI1fCoF1LP61CsWpm9DYXyUxpZZNDwn2nUo4IKCYX1YTqLpms+QE5ien
         7nWHGXogIIBQYGx57LyttCAtl4P4LDufUDmSiJXKJWGr3QQw8XvMKzBpdyL99qiuhe2u
         OG2AWQEV6my7TQX0kH6o8St8l1Fc5hegvWLFOmBort8J2khenq3E6KzM/eTziow8/2Yf
         hZY2XH2cH8BsPFadDN4CJxfYFzi8icjydVf1KJdtIuU3hx1H47K+gExS30ZtsrHECv8l
         bHFfIhu66nn7JqDyQn7fQnEDR1zyiSzmx2fZDI0P7rK6mLUvBpedXJYWSwKszCMcqbNh
         fngQ==
X-Gm-Message-State: APjAAAU3ZwFtATb40FzE+Qrmv0ErjL5KmcC/1unl/CoTO95cc88wmx2a
        W+/N2/9VU4G/4RriaGioA6UZbFY=
X-Google-Smtp-Source: APXvYqy3G8V8zTqhCxQHP2ptBgkBUTEr2ls7NUIIjjZbO2+WaM6bJrXPDxWPTfnmRyQjpzImoLmB9g==
X-Received: by 2002:ae9:c208:: with SMTP id j8mr72747599qkg.264.1560466164117;
        Thu, 13 Jun 2019 15:49:24 -0700 (PDT)
Received: from localhost ([64.188.179.243])
        by smtp.gmail.com with ESMTPSA id c18sm439128qkm.78.2019.06.13.15.49.22
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 13 Jun 2019 15:49:23 -0700 (PDT)
Date:   Thu, 13 Jun 2019 16:49:21 -0600
From:   Rob Herring <robh@kernel.org>
To:     Matthias Brugger <matthias.bgg@gmail.com>, arm@kernel.org
Cc:     linux-kernel@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Subject: Re: [PATCH v3] dt-bindings: arm: Convert MediaTek board/soc bindings
 to json-schema
Message-ID: <20190613224921.GA9199@bogus>
References: <20190517154202.24594-1-robh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190517154202.24594-1-robh@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 17, 2019 at 10:42:02AM -0500, Rob Herring wrote:
> Convert MediaTek SoC bindings to DT schema format using json-schema.
> 
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: Matthias Brugger <matthias.bgg@gmail.com>
> Cc: devicetree@vger.kernel.org
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: linux-mediatek@lists.infradead.org
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
> v3:
>  - Rebase to Linus' master
> 
>  .../devicetree/bindings/arm/mediatek.txt      | 89 ------------------
>  .../devicetree/bindings/arm/mediatek.yaml     | 91 +++++++++++++++++++
>  2 files changed, 91 insertions(+), 89 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/arm/mediatek.txt
>  create mode 100644 Documentation/devicetree/bindings/arm/mediatek.yaml

Ping. Three versions of this and no comments... Is Mediatek a dead 
platform?

Rob
