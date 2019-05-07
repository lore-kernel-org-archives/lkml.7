Return-Path: <SRS0=RyeP=TH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	T_DKIMWL_WL_HIGH,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1809C004C9
	for <linux-kernel@archiver.kernel.org>; Tue,  7 May 2019 17:41:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 86B2A205C9
	for <linux-kernel@archiver.kernel.org>; Tue,  7 May 2019 17:41:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1557250874;
	bh=cjcACS3FzZFNBPd9EO1/4Nj92eFoQzA0WfrnynIctUI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=lZUFy68s3k8ZiNpEdtWh9pvHfLu2dFkgPfN5NCWExUbTqpnU6b2kvjvNirWJXIfs5
	 AozUvViQlHnXlolJlzB0obRRF0v7j3E1sYoW6Kfp5urat1ai3KoyRplV18bV5DBtDT
	 7rwq0sliYEc9HLzihTB3Kg8hA5vq2bBR4A4EUOBk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727417AbfEGRlN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 May 2019 13:41:13 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:40188 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726335AbfEGRlN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 May 2019 13:41:13 -0400
Received: by mail-ot1-f67.google.com with SMTP id w6so15768664otl.7;
        Tue, 07 May 2019 10:41:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=9rNLy/ZQaK42lTMWdGC3VYdIL1Q3ruxBaNI2KenFfZA=;
        b=NoJANvVa5MJa2GDQ56bsQi0f06K1Ss/FeZD3Do/ChnePT0M5DF3K3wPO544Ng7PpdB
         3YKrM7kF59MvMUu8q7gL5VW1APow1/J4I4BziM6S8Wrs8Kc1sFB+EtQN30cs34tabB2i
         bMXSbnAu02yEXbBRdU9omHFTaWFgS/4s/Ras8zblpwT3q0z0LZPhXv+8AztThugD3TMV
         O8t+n9Z0gMHU9/p2KuhTjeGjD9xGFPz7PlP7jrwWeIgDL6jwgSruopMFQ/MWyJ0a2iPR
         dwdwCu4p2dmeHyh1sau35zP4s6oIl2RXs60PqxBIp0CwjOg7flGR9hjWZ1qli4tQCpGI
         YxEA==
X-Gm-Message-State: APjAAAUxiDhKKJi7sxTS1UeoW+wNwJA8OZpPYNOgYVWUG1HjDJUV7i7b
        chGLmkfWXVAk/GWGiyXEkg==
X-Google-Smtp-Source: APXvYqxVT+rgS9ARF8x0VFy/ggxBe7eDGWK8eU6UPVfhX/GM8vt4GowdhjtHpTbE2QIioJsCsu6roQ==
X-Received: by 2002:a9d:6b93:: with SMTP id b19mr24293889otq.313.1557250872208;
        Tue, 07 May 2019 10:41:12 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id 24sm2059963oiz.14.2019.05.07.10.41.10
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 07 May 2019 10:41:11 -0700 (PDT)
Date:   Tue, 7 May 2019 12:41:10 -0500
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
        Houlong Wei <houlong.wei@mediatek.com>,
        ginny.chen@mediatek.com, kendrick.hsu@mediatek.com,
        Frederic Chen <Frederic.Chen@mediatek.com>
Subject: Re: [PATCH v5 03/12] dt-binding: gce: add binding for gce subsys
 property
Message-ID: <20190507174110.GA6767@bogus>
References: <20190507081355.52630-1-bibby.hsieh@mediatek.com>
 <20190507081355.52630-4-bibby.hsieh@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190507081355.52630-4-bibby.hsieh@mediatek.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 07, 2019 at 04:13:46PM +0800, Bibby Hsieh wrote:
> tcmdq driver provide a function that get the relationship
> of sub system number from device node for client.
> add specification for #subsys-cells, mediatek,gce-subsys.
> 
> Signed-off-by: Bibby Hsieh <bibby.hsieh@mediatek.com>
> ---
>  .../devicetree/bindings/mailbox/mtk-gce.txt       | 15 ++++++++++++---
>  1 file changed, 12 insertions(+), 3 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/mailbox/mtk-gce.txt b/Documentation/devicetree/bindings/mailbox/mtk-gce.txt
> index 1f7f8f2a3f49..8fd9479bc9f6 100644
> --- a/Documentation/devicetree/bindings/mailbox/mtk-gce.txt
> +++ b/Documentation/devicetree/bindings/mailbox/mtk-gce.txt
> @@ -21,11 +21,19 @@ Required properties:
>  	priority: Priority of GCE thread.
>  	atomic_exec: GCE processing continuous packets of commands in atomic
>  		way.
> +- #subsys-cells: Should be 3.
> +	<&phandle subsys_number start_offset size>
> +	phandle: Label name of a gce node.
> +	subsys_number: specify the sub-system id which is corresponding
> +		       to the register address.
> +	start_offset: the start offset of register address that GCE can access.
> +	size: the total size of register address that GCE can access.

Like the #event-cells, do you need this if it isn't variable?

>  
>  Required properties for a client device:
>  - mboxes: Client use mailbox to communicate with GCE, it should have this
>    property and list of phandle, mailbox specifiers.
> -- mediatek,gce-subsys: u32, specify the sub-system id which is corresponding
> +Optional propertier for a client device:
> +- mediatek,gce-client-reg: u32, specify the sub-system id which is corresponding
>    to the register address.

This isn't a u32, but a phandle + 3 cells (or a list of those). How many 
entries can there be?

>  
>  Some vaules of properties are defined in 'dt-bindings/gce/mt8173-gce.h'
> @@ -40,6 +48,7 @@ Example:
>  		clocks = <&infracfg CLK_INFRA_GCE>;
>  		clock-names = "gce";
>  		#mbox-cells = <3>;
> +		#subsys-cells = <3>;
>  	};
>  
>  Example for a client device:
> @@ -48,9 +57,9 @@ Example for a client device:
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
