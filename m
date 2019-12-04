Return-Path: <SRS0=oopU=Z2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F32CDC2BD09
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 16:38:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C9E3120659
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 16:38:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1575477513;
	bh=/wviLduOKfotQNHoow8ik4YY1EhJSDMCv16xIJ/WrXc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=RcBHAj/95uwmcVQoW27D58An4BjHHQw24iWRRFCiXO1wOC3LhvdV+uMs0yOUI5F3U
	 GQQ1icMcZmcGZkvKTMEpMlAUdIT7mFFKxeZel+jVtvjiJj5HyyV/Ag+ZuP70q9iaXJ
	 wKUOEX/6sBtRSUCTVZzuspi0q2ed/l32DisL+MHA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728679AbfLDQid (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Dec 2019 11:38:33 -0500
Received: from mail-ot1-f67.google.com ([209.85.210.67]:36511 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727008AbfLDQic (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Dec 2019 11:38:32 -0500
Received: by mail-ot1-f67.google.com with SMTP id i4so6907778otr.3;
        Wed, 04 Dec 2019 08:38:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=h5BttVEUcYGpQSrvsT4n5KQf35QjinvPiKmGQoO8bAg=;
        b=JE+IMD1ynEnR5wGXadYYBVfg54Quf73yOjmE2MVJA1jzocRq90yPImOp9Rt3pHaZbS
         VzSs5qoZldDKCFVOm82Hq4H7XWAi8+JNF3wGrdgleE5mRibT53TkpAGDJv49C+u3X/18
         D1biNSfkz+aIYd3YMh4C3xGDEhMzB2I3BjAYLV04hExRgnCUl4/wOpxYp+hcVTkiR5e0
         2Jw1L4upLIE/NEGLYoLb7/M0Gv/QOSn7FA0TrLL97X3wvDxSbKUJtF5Qpe0U1j39k1tn
         6nyGHnLqstCLdinXhzylYS7Y2OjuJd+eZV6gxf57mQ6VlXUDJ/srzVMQ2wTr6XoX5J+A
         ETNQ==
X-Gm-Message-State: APjAAAWFPqvkT6w4bdba5/oye2/8pFa/1BGOREZqKbP6bo3FxKeXoyl/
        J19Us3Ur0AZJ1944OThXPg==
X-Google-Smtp-Source: APXvYqw74QgKZdUqI36Owvtd1W7xjNdWgYkr0dTvzlP87KiM77D3wtHoSardHE5weZfCy0fKjH/pVg==
X-Received: by 2002:a9d:ea6:: with SMTP id 35mr3055549otj.106.1575477511579;
        Wed, 04 Dec 2019 08:38:31 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id n16sm2328821otk.25.2019.12.04.08.38.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Dec 2019 08:38:30 -0800 (PST)
Date:   Wed, 4 Dec 2019 10:38:30 -0600
From:   Rob Herring <robh@kernel.org>
To:     Orson Zhai <orson.zhai@unisoc.com>
Cc:     Lee Jones <lee.jones@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Arnd Bergmann <arnd@arndb.de>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, kevin.tang@unisoc.com,
        baolin.wang@unisoc.com, chunyan.zhang@unisoc.com
Subject: Re: [PATCH V2 1/2] dt-bindings: syscon: Add syscon-names to refer to
 syscon easily
Message-ID: <20191204163830.GA25135@bogus>
References: <20191120154148.22067-1-orson.zhai@unisoc.com>
 <20191120154148.22067-2-orson.zhai@unisoc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191120154148.22067-2-orson.zhai@unisoc.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 20, 2019 at 11:41:47PM +0800, Orson Zhai wrote:
> Make life easier when syscon consumer want to access multiple syscon
> nodes with dozens of items.
> Add syscon-names and relative properties to help to manage different
> cases when accessing more than one syscon node even with arguments.
> 
> Signed-off-by: Orson Zhai <orson.zhai@unisoc.com>
> ---
>  .../devicetree/bindings/mfd/syscon.txt        | 43 +++++++++++++++++++
>  1 file changed, 43 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/mfd/syscon.txt b/Documentation/devicetree/bindings/mfd/syscon.txt
> index 25d9e9c2fd53..4c7bdb74bb0a 100644
> --- a/Documentation/devicetree/bindings/mfd/syscon.txt
> +++ b/Documentation/devicetree/bindings/mfd/syscon.txt
> @@ -30,3 +30,46 @@ hwlock1: hwspinlock@40500000 {
>         reg = <0x40500000 0x1000>;
>         #hwlock-cells = <1>;
>  };
> +
> +
> +
> +==Syscon Name==
> +
> +Syscon name is a helper to be used in consumer nodes who refer to system
> +controller node. It provides a way to refer to syscon node by names with
> +phandle args in syscon consumer node. It will help people who have a lot
> +of syscon references to be managed. It is not a must feature and has no
> +effect to syscon node itself at all.
> +
> +Required properties:
> +- syscons: List of phandles and any number of arguments if needed. Arguments
> +  is specific to differnet vendors and its usage should be described at each
> +  vendor's bindings. For example: In Unisoc SoCs, the 1st arg will be treated
> +  as register address offset and the 2nd is bit mask.
> +
> +- syscon-names:        List of syscon node name strings sorted in the same order as
> +  what it represents in property syscons.
> +
> +Optional property:
> +- #.*-cells: Represents the number of arguments in single phandle in syscons
> +  list. ".*" is vendor specific. If this property is not set, default value
> +  will be 0.

This breaks the normal pattern of how '#.*-cells' works. While Arnd 
suggests removing it, I don't think that works well either with having a 
generic 'syscons' property. That means every syscon in a system has to 
have the same number of cells.

I don't really want to see syscon binding expanded. Really, I'd like 
'syscon' to go away. It's nothing more than a flag to create a regmap.

I think it is better to keep the property names specific to exactly what 
the functionality is for each syscon phandle rather than a generic 
binding.

What are the eamples of where you want to use this? Keep in mind that 
this sort of connection should *only* be used for things that have no 
other binding and kernel subsystem.

Rob
