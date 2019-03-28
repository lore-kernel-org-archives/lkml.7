Return-Path: <SRS0=Qu8K=R7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E62CAC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 18:44:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B60012064A
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 18:44:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553798669;
	bh=YsfzhjrkUZ/MjGqmaOjabUWDsk+FXglaXDC1SWzXiPs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=xJXc3iDl4DNI/PW4N4ulhxiZ01b7i8cRcUwdgF+dwjQsslEvXkX+F/t9L21Kv8jTy
	 iwgqPtAr8zwizNug4ltsYPaHzy2xIkZ5z+uEV3kIOvPBBtt8SmzP+ns43Smv4aYg92
	 kRnLicJPa0S6C4JTVvW6108xrOXuvBY0ZuTSnKxg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726211AbfC1So2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Mar 2019 14:44:28 -0400
Received: from mail-oi1-f195.google.com ([209.85.167.195]:39009 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725828AbfC1So1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Mar 2019 14:44:27 -0400
Received: by mail-oi1-f195.google.com with SMTP id n187so13800294oih.6;
        Thu, 28 Mar 2019 11:44:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=CX+Ec3c8yzrgasul+E+SqcQqDwlxjCw7tIRt6TNfviM=;
        b=KgjXcp9ahVyhf5eqDITUiqyEaWVe1EfcD2auO7F1FlVoPVIkbLUvvMqkwo1kQ8vqXa
         O+48ieXgcfsTjpLygFxse9PIX3lRAiuSLvcUu81nkv+Z0lGzYzAx/DDoWwk9NPUAACKq
         dXzqX1K41tDIhj27ENYj2AhXSsJ2Qq6512XOu4C/tVnskwB3QL7ESZMFkHpjhkRK7mOn
         SKMWl/Sd+ay09gga8++6KIzkeW8cqBPCY7miNXAkDR7YDxNjO+eGMS64ZzqaiVzuj6Wp
         EXTkRwCUQUO3O5AJT8x4gzmotebSoiXK7xPLOYleXu4pj+rgaf9Opep8KQV97j6aZShQ
         bAvg==
X-Gm-Message-State: APjAAAV8aMMXae2cfS0pq2nSb9kgx/vFuBZDS1Ev4rOH2kFQOL+7pSfH
        9paGz46mtyE9MUoekeYXkQ==
X-Google-Smtp-Source: APXvYqytZgxu6mMm43rBuRhAWDggagDdy0plDNdFz71Wp7xRW7xT6LJjdaMt2f6tezFEim8Kv+298w==
X-Received: by 2002:aca:4b03:: with SMTP id y3mr1019403oia.21.1553798667157;
        Thu, 28 Mar 2019 11:44:27 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id q23sm10366855oic.45.2019.03.28.11.44.26
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 28 Mar 2019 11:44:26 -0700 (PDT)
Date:   Thu, 28 Mar 2019 13:44:25 -0500
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
Subject: Re: [PATCH v3 03/12] dt-binding: gce: add binding for gce event
 property
Message-ID: <20190328184425.GA21602@bogus>
References: <1553739573-19708-1-git-send-email-bibby.hsieh@mediatek.com>
 <1553739573-19708-4-git-send-email-bibby.hsieh@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1553739573-19708-4-git-send-email-bibby.hsieh@mediatek.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 28, 2019 at 10:19:24AM +0800, Bibby Hsieh wrote:
> Client hardware would send event to GCE hardware,
> so #event-cells, mediatek,gce-event-names, mediatek,gce-events.
> present the event.
> 
> Signed-off-by: Bibby Hsieh <bibby.hsieh@mediatek.com>
> ---
>  Documentation/devicetree/bindings/mailbox/mtk-gce.txt | 17 ++++++++++++++---
>  1 file changed, 14 insertions(+), 3 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/mailbox/mtk-gce.txt b/Documentation/devicetree/bindings/mailbox/mtk-gce.txt
> index 1f7f8f2..2f175d6 100644
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

You only need to have a #*-cells if the number is variable.

What are 'events' here? Sounds like interrupts or MSI?

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
> 1.9.1
> 
