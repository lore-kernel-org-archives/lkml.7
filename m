Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AF71C10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 19:56:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 595F42077C
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 19:56:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556135786;
	bh=3ooNikhYSJSf9aR+O0ymvPOm0Fkf31OilqpKq5zfE/Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=jS0QPGjtmv4waPNacrJWBwLVbm2R49uQo0cOnyTbq9sBNdxo+ff9LFjFZANVhUUUL
	 xs8TRv/7BauWHtuhMnYDOqMdKH9NmjeMyQ2b9wkPOUHIbyIWrbBCDr4qKq/1+5GTgH
	 B2J+b+VPW0FJa61fCLU5zcYnu/+2fDuX78xdd8jg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730004AbfDXT4Z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 15:56:25 -0400
Received: from mail-oi1-f196.google.com ([209.85.167.196]:33230 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727383AbfDXT4Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 15:56:24 -0400
Received: by mail-oi1-f196.google.com with SMTP id e5so15350327oii.0;
        Wed, 24 Apr 2019 12:56:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=20tjOs5lkt8HOpIZuEAhDCtz3Zk/SR29ZFUGIW31En0=;
        b=s44YskUDCie0dU+VtLSkcOoxiilMBwVfwW332NcsMHXq42TR0NRslQqwydx5+/0AjD
         7gRN5yAiiLFLzxk0N57TdWzOycP3WB5FkFCiHl2lOkGyOhZoJ8uDKpuyGQgySahbgHJr
         y2rnkhiwiubdwdwQaI+OJmHtOLAJe4NB9Ud+RY8QdC1MBiLtwNBhMFJwd7swXE/8F5H2
         41jSRFOsFQstBI7evKUVppOVhI/GMH4wHGFcjaGqIY4IQChGaRPz77Y4P3SXPQcflIVN
         AJ2U06LVzZl74sPyTMnoZ9NVDNapD2HoU9bnk1PolaMNzkUriEMqrI8R/fWht/MX4hvr
         chsA==
X-Gm-Message-State: APjAAAWV7ftaAGed4nswrxfu4GnVChCM2q4p1qbv4sZK0DlLVcEBO5ri
        MPOBNX2ZDzC37wMtjq1XXw==
X-Google-Smtp-Source: APXvYqy1AsQ1m3VXKqDbGaZdcv9Hptsq+4jNZUzqEez8a6MrXiEimrnQ0KIW3sxENoU7rPMFMv8Whg==
X-Received: by 2002:aca:bdc6:: with SMTP id n189mr562593oif.77.1556135783603;
        Wed, 24 Apr 2019 12:56:23 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id g12sm8216830otr.18.2019.04.24.12.56.22
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 24 Apr 2019 12:56:22 -0700 (PDT)
Date:   Wed, 24 Apr 2019 14:56:21 -0500
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
Subject: Re: [PATCH v4 03/12] dt-binding: gce: add binding for gce event
 property
Message-ID: <20190424195621.GC7270@bogus>
References: <20190415125833.38704-1-bibby.hsieh@mediatek.com>
 <20190415125833.38704-4-bibby.hsieh@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190415125833.38704-4-bibby.hsieh@mediatek.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 15, 2019 at 08:58:24PM +0800, Bibby Hsieh wrote:
> Client hardware would send event to GCE hardware,
> so #event-cells, mediatek,gce-event-names, mediatek,gce-events.
> present the event.
> 
> Signed-off-by: Bibby Hsieh <bibby.hsieh@mediatek.com>
> ---
>  .../devicetree/bindings/mailbox/mtk-gce.txt     | 17 ++++++++++++++---
>  1 file changed, 14 insertions(+), 3 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/mailbox/mtk-gce.txt b/Documentation/devicetree/bindings/mailbox/mtk-gce.txt
> index 1f7f8f2a3f49..2f175d6b296d 100644
> --- a/Documentation/devicetree/bindings/mailbox/mtk-gce.txt
> +++ b/Documentation/devicetree/bindings/mailbox/mtk-gce.txt
> @@ -21,12 +21,21 @@ Required properties:
>  	priority: Priority of GCE thread.
>  	atomic_exec: GCE processing continuous packets of commands in atomic
>  		way.
> +- #event-cells: Should be 1.
> +	<&phandle event_number>
> +	phandle: Label name of a gce node.
> +	event_number: the event number defined in 'dt-bindings/gce/mt8173-gce.h'
> +		      or 'dt-binding/gce/mt8183-gce.h'.

I thought you were going to remove this.

>  
>  Required properties for a client device:
>  - mboxes: Client use mailbox to communicate with GCE, it should have this
>    property and list of phandle, mailbox specifiers.
>  - mediatek,gce-subsys: u32, specify the sub-system id which is corresponding
>    to the register address.
> +Optional propertier for a client device:
> +- mediatek,gce-event-names: the event name can be defined by user.
> +- mediatek,gce-events: u32, the event number defined in
> +  'dt-bindings/gce/mt8173-gce.h' or 'dt-binding/gce/mt8183-gce.h'.

From the example, looks like a phandle plus 1 cell.

>  
>  Some vaules of properties are defined in 'dt-bindings/gce/mt8173-gce.h'
>  or 'dt-binding/gce/mt8183-gce.h'. Such as sub-system ids, thread priority, event ids.
> @@ -40,6 +49,7 @@ Example:
>  		clocks = <&infracfg CLK_INFRA_GCE>;
>  		clock-names = "gce";
>  		#mbox-cells = <3>;
> +		#event-cells = <1>;
>  	};
>  
>  Example for a client device:
> @@ -49,8 +59,9 @@ Example for a client device:
>  		mboxes = <&gce 0 CMDQ_THR_PRIO_LOWEST 1>,
>  			 <&gce 1 CMDQ_THR_PRIO_LOWEST 1>;
>  		mediatek,gce-subsys = <SUBSYS_1400XXXX>;
> -		mutex-event-eof = <CMDQ_EVENT_MUTEX0_STREAM_EOF
> -				CMDQ_EVENT_MUTEX1_STREAM_EOF>;
> -
> +		mediatek,gce-event-names = "rdma0_sof",
> +					   "rsz0_sof";
> +		mediatek,gce-events = <&gce CMDQ_EVENT_MDP_RDMA0_SOF>,
> +				      <&gce CMDQ_EVENT_MDP_RSZ0_SOF>;
>  		...
>  	};
> -- 
> 2.18.0
> 
