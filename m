Return-Path: <SRS0=CEgE=VT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96F68C7618F
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 22:09:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6080D21900
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 22:09:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1563833361;
	bh=EHqDBgNEU7kRaV6W5hjKHtril1KJ1rIV6I+v/qz62mU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Huqyi5pyfNTMdYknew6639/DDiGb9nokPEW7UgeDBpasEJ9w/TOjqNzvlvrzW0/Q1
	 90B0aOz2UR9QPnsLKRMZhYS4YinisOYj7vyIWohZyhAXq/6tQnPdFRVCPVfa3ujX2c
	 2rkq+FaVHS4/ctDcVzGVrPCmfXNtzUxgyE+9MpFI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726819AbfGVWJU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jul 2019 18:09:20 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:46256 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726265AbfGVWJU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jul 2019 18:09:20 -0400
Received: by mail-io1-f65.google.com with SMTP id i10so77415496iol.13;
        Mon, 22 Jul 2019 15:09:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=oPO7PdmDzdqi5Fe+NgQYohceRPua/BoALQ80fACcCkI=;
        b=Ipmr/AHU+o2vrCk5IrxCiJjFUi/pzFS53UJVtpZ6W+Vtnd07ahwEMnA0oP0dRQtwPs
         yZBgMyJil6N9y6FEvp0JIxUFQB5X5UIyUiM1uLt2Cn2r8OgVZk0aIp9fVW9bGeK6tLZo
         JO/huYy1tlUlbi8yeEGeFKJN1MY9VFn2nOY4eHIeYEE3G7J7ybcsL2xBJUVFj2V/jWA4
         AKQjN/mV30QE9MFomS+/zG2seBMPqLTdGao/eBKrOHj1N83Gnx+gLyFUeF27cO12lVC4
         Y7ifmiwNqevjgivDMzeCvkqy74nrg+BvHyA0q8pOCs53tiVOsY6adwG3bf4Srr7HLuMK
         BjFQ==
X-Gm-Message-State: APjAAAWUMALzdeWFNCdaTgC5UT6hDAPCa8YGG0eWw32XDj6v1SBDM77z
        Of1Rop1vbFakkwNZpF5jaQ==
X-Google-Smtp-Source: APXvYqwXrVpaoCfl2l8pHwCeHeZHWyE8eKMyGWzfhKD/58sdetuN/smodYWuDL1nzIhyX1pY+xdaTA==
X-Received: by 2002:a5e:924d:: with SMTP id z13mr13556881iop.247.1563833359275;
        Mon, 22 Jul 2019 15:09:19 -0700 (PDT)
Received: from localhost ([64.188.179.254])
        by smtp.gmail.com with ESMTPSA id m4sm36742519iok.68.2019.07.22.15.09.18
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 22 Jul 2019 15:09:18 -0700 (PDT)
Date:   Mon, 22 Jul 2019 16:09:18 -0600
From:   Rob Herring <robh@kernel.org>
To:     Bibby Hsieh <bibby.hsieh@mediatek.com>
Cc:     Jassi Brar <jassisinghbrar@gmail.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        CK HU <ck.hu@mediatek.com>,
        Daniel Kurtz <djkurtz@chromium.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, srv_heupstream@mediatek.com,
        Sascha Hauer <kernel@pengutronix.de>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Nicolas Boichat <drinkcat@chromium.org>,
        YT Shen <yt.shen@mediatek.com>,
        Daoyuan Huang <daoyuan.huang@mediatek.com>,
        Jiaguang Zhang <jiaguang.zhang@mediatek.com>,
        Dennis-YC Hsieh <dennis-yc.hsieh@mediatek.com>,
        Houlong Wei <houlong.wei@mediatek.com>, ginny.chen@mediatek.com
Subject: Re: [PATCH v10 03/12] dt-binding: gce: add binding for gce client
 reg property
Message-ID: <20190722220918.GA24605@bogus>
References: <20190701074842.15401-1-bibby.hsieh@mediatek.com>
 <20190701074842.15401-4-bibby.hsieh@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190701074842.15401-4-bibby.hsieh@mediatek.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 01, 2019 at 03:48:33PM +0800, Bibby Hsieh wrote:
> cmdq driver provide a function that get the relationship
> of sub system number from device node for client.
> add specification for #subsys-cells, mediatek,gce-client-reg.
> 
> Signed-off-by: Bibby Hsieh <bibby.hsieh@mediatek.com>
> ---
>  .../devicetree/bindings/mailbox/mtk-gce.txt    | 18 ++++++++++++++----
>  1 file changed, 14 insertions(+), 4 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/mailbox/mtk-gce.txt b/Documentation/devicetree/bindings/mailbox/mtk-gce.txt
> index 1f7f8f2a3f49..d48282d6b02d 100644
> --- a/Documentation/devicetree/bindings/mailbox/mtk-gce.txt
> +++ b/Documentation/devicetree/bindings/mailbox/mtk-gce.txt
> @@ -21,12 +21,21 @@ Required properties:
>  	priority: Priority of GCE thread.
>  	atomic_exec: GCE processing continuous packets of commands in atomic
>  		way.
> +- #subsys-cells: Should be 3.

You don't need this if it is always 3 and/or is always a single phandle.

> +	<&phandle subsys_number start_offset size>
> +	phandle: Label name of a gce node.
> +	subsys_number: specify the sub-system id which is corresponding
> +		       to the register address.
> +	start_offset: the start offset of register address that GCE can access.
> +	size: the total size of register address that GCE can access.
>  
>  Required properties for a client device:
>  - mboxes: Client use mailbox to communicate with GCE, it should have this
>    property and list of phandle, mailbox specifiers.
> -- mediatek,gce-subsys: u32, specify the sub-system id which is corresponding
> -  to the register address.
> +Optional properties for a client device:
> +- mediatek,gce-client-reg: Specify the sub-system id which is corresponding
> +  to the register address, it should have this property and list of phandle,
> +  sub-system specifiers.
>  
>  Some vaules of properties are defined in 'dt-bindings/gce/mt8173-gce.h'
>  or 'dt-binding/gce/mt8183-gce.h'. Such as sub-system ids, thread priority, event ids.
> @@ -40,6 +49,7 @@ Example:
>  		clocks = <&infracfg CLK_INFRA_GCE>;
>  		clock-names = "gce";
>  		#mbox-cells = <3>;
> +		#subsys-cells = <3>;
>  	};
>  
>  Example for a client device:
> @@ -48,9 +58,9 @@ Example for a client device:
>  		compatible = "mediatek,mt8173-mmsys";
>  		mboxes = <&gce 0 CMDQ_THR_PRIO_LOWEST 1>,
>  			 <&gce 1 CMDQ_THR_PRIO_LOWEST 1>;
> -		mediatek,gce-subsys = <SUBSYS_1400XXXX>;
>  		mutex-event-eof = <CMDQ_EVENT_MUTEX0_STREAM_EOF
>  				CMDQ_EVENT_MUTEX1_STREAM_EOF>;
> -
> +		mediatek,gce-client-reg = <&gce SUBSYS_1400XXXX 0x3000 0x1000>,
> +					  <&gce SUBSYS_1401XXXX 0x2000 0x100>;
>  		...
>  	};
> -- 
> 2.18.0
> 
