Return-Path: <SRS0=Osat=YE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3EB7C47404
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Oct 2019 14:42:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CB0EE206A1
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Oct 2019 14:42:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570804958;
	bh=8PjuoTKKlOdKETW02OtNqjArOL30miTCdR83aHNS8lA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Jjl8acGZL2aJo5A+yfZmLlyKXSXpKePnNz6U/nvhArDa7xOfhWxoSn0A44RfHAGZ+
	 Z/KZzbCMHtpxDVHyNS26HDM5y2LfUKmaDLpDHSnF0VTmrICU1cVGFY7UTr1SFeIh2b
	 AR7n2KEF38SpGnKW//2rnqettNRw3RNjMdqkXf2I=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727253AbfJKOmh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Oct 2019 10:42:37 -0400
Received: from mail-oi1-f195.google.com ([209.85.167.195]:41950 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726174AbfJKOmh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Oct 2019 10:42:37 -0400
Received: by mail-oi1-f195.google.com with SMTP id w65so8174550oiw.8;
        Fri, 11 Oct 2019 07:42:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=YUH271mTXQreBz5XUgzwRk8D+t7/xc/m3LDI2Ub97Uo=;
        b=pHLhAS7rb6i0625VjgMu9YFGUTItZr/mINfYgnci3Exq64Ah9iNulxQ0fnPSlN5ftO
         w+KSortTTmk1GwauXD6Ri7SmfT8bQql8nCnHlKwtwCJF2SSJFdN/FcKmWYi+XTV68sT3
         keRVQp/Wqk5z7+OzbzGBuhOIeRDjBZEuWTm0aznwha8283t6EBZLZ6EMWCij9mKaRHi4
         xPSgfadfVxqj/SWiXBWe4viZ4+ijh6oLpmrWRbLFOTAc5CGefKqmQOItzQF8FLw13Ymt
         WXTA/lQHM+SrMv/OIirYGbXce9iTb1ZmxASj8ovoUNCoHsZRUqewT4xfWL7CAsNQRmVn
         hvyQ==
X-Gm-Message-State: APjAAAXypEXKojZCxFlcwgVlyIhq4c2juSqdR85bGvlN5h873ORfYnGO
        H8wKy6/+MTKxh8lrSsLmYKVXOmk=
X-Google-Smtp-Source: APXvYqzebcLKEqGNREYb8fQjDLoM9X2bP/d8/cZlSGqY3GcaIhWsdltfVEmMYZC+jTuJrj8TOcDRCg==
X-Received: by 2002:aca:ac88:: with SMTP id v130mr12798935oie.11.1570804458804;
        Fri, 11 Oct 2019 07:34:18 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id 8sm2728496oti.41.2019.10.11.07.34.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Oct 2019 07:34:18 -0700 (PDT)
Date:   Fri, 11 Oct 2019 09:34:17 -0500
From:   Rob Herring <robh@kernel.org>
To:     Jernej Skrabec <jernej.skrabec@siol.net>
Cc:     mripard@kernel.org, wens@csie.org, robh+dt@kernel.org,
        mark.rutland@arm.com, mchehab@kernel.org, hverkuil@xs4all.nl,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
        linux-sunxi@googlegroups.com
Subject: Re: [PATCH v2 1/6] dt-bindings: bus: sunxi: Add H3 MBUS compatible
Message-ID: <20191011143417.GA23475@bogus>
References: <20190929161653.160158-1-jernej.skrabec@siol.net>
 <20190929161653.160158-2-jernej.skrabec@siol.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190929161653.160158-2-jernej.skrabec@siol.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 29 Sep 2019 18:16:48 +0200, Jernej Skrabec wrote:
> Allwinner H3 SoC also contains MBUS controller.
>
> Add compatible for it.
>
> Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>
> ---
>  Documentation/devicetree/bindings/arm/sunxi/sunxi-mbus.txt | 1 +
>  1 file changed, 1 insertion(+)
>

Acked-by: Rob Herring <robh@kernel.org>
