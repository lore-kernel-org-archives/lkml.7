Return-Path: <SRS0=Z4g5=TY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29163C282E1
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 21:54:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E99EA217F9
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 21:54:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1558734851;
	bh=8568j9U5dXFzD1kKJdpRtZ824hg6Kz1VWUSZLe7+WZk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=vXQgg8Q2rj3rBrUleMmhMmXSkReFlj0+gw8CI1nSue96/TNObDYpPZ9+a+AM00nbV
	 L8Ij+/TjnY6uG5zcobQJPXJUMefVGWN6cFNV3d1yx9tJilTZR+tUzv6BSbCnpF+sdS
	 44j/UYZxzlB5qgABaR+Z5tpBwIgLFZMl56kZHiN0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404430AbfEXVyK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 May 2019 17:54:10 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:41200 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404163AbfEXVyJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 May 2019 17:54:09 -0400
Received: by mail-ot1-f67.google.com with SMTP id l25so9995971otp.8;
        Fri, 24 May 2019 14:54:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ocTPW25nWKpvKq/JRulYN0S/pGd+SXijFY/6jO39icc=;
        b=LR+y4dfzQ1En/48ndRBMDMCzCcy5jZO/Cj5wqKrwm/5gJP9+hNp2c/1NBejMfsfD8u
         xSqQg4R1LeTqKdsFW8y6JXE/nbnlmlgMrzu8dVsUNbcN/4HuCNKHQtha9CvwfybGD7vi
         GYUVfPEMDHx58SnSUbnTsl/8WbfC/CIrft4Ru6qm32edtI7gedzHqr7wMajWREaWThKa
         qhm9q4M7nLyQTwY2tInkomF1CgXOfTb73XTI5I/PEAdQPGp82Gv3G70MxaZm2Xq/V9RA
         aiuueAaOOeAwV+39zEXp2JNkfLAQb0HZzIXuVdiJMwN41DVZcb3YUl4IRvIkdQMqRFGh
         lS1g==
X-Gm-Message-State: APjAAAX34cqbRUqUYwjFVUxSaWWwCNHAqDXYI9QWY5qDSji4Ky3sEnhz
        vD1o20gKDnyA8mkntPk/pw==
X-Google-Smtp-Source: APXvYqxz7j6TAqcCOb7TkXaiVR8I/EoSc62MSkmCQ9hdBLYDFZ+4Dlt6IECHsh8xO5wmRSqntod77A==
X-Received: by 2002:a9d:6248:: with SMTP id i8mr198636otk.276.1558734848769;
        Fri, 24 May 2019 14:54:08 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id p64sm1425346oif.8.2019.05.24.14.54.07
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 24 May 2019 14:54:08 -0700 (PDT)
Date:   Fri, 24 May 2019 16:54:07 -0500
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
        Dennis-YC Hsieh 
        <dennis-yc.hsimediatek/mtkcam/drv/fdvt/4.0/cam_fdvt_v4l2.cppeh@mediatek.com>,
        Houlong Wei <houlong.wei@mediatek.com>, ginny.chen@mediatek.com
Subject: Re: [PATCH v6 04/12] dt-binding: gce: add binding for gce event
 property
Message-ID: <20190524215407.GA7214@bogus>
References: <20190516090224.59070-1-bibby.hsieh@mediatek.com>
 <20190516090224.59070-5-bibby.hsieh@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190516090224.59070-5-bibby.hsieh@mediatek.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 16, 2019 at 05:02:16PM +0800, Bibby Hsieh wrote:
> Client hardware would send event to GCE hardware,
> mediatek,gce-event-names and mediatek,gce-events

We removed mediatek,gce-event-names?

> can be used to present the event.
> 
> Signed-off-by: Bibby Hsieh <bibby.hsieh@mediatek.com>
> ---
>  Documentation/devicetree/bindings/mailbox/mtk-gce.txt | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/mailbox/mtk-gce.txt b/Documentation/devicetree/bindings/mailbox/mtk-gce.txt
> index dceab63ccd06..265bb58da7bd 100644
> --- a/Documentation/devicetree/bindings/mailbox/mtk-gce.txt
> +++ b/Documentation/devicetree/bindings/mailbox/mtk-gce.txt
> @@ -35,6 +35,8 @@ Required properties for a client device:
>  Optional properties for a client device:
>  - mediatek,gce-client-reg: u32, specify the sub-system id which is corresponding
>    to the register address.
> +- mediatek,gce-events: u32, the event number defined in
> +  'dt-bindings/gce/mt8173-gce.h' or 'dt-binding/gce/mt8183-gce.h'.

This and the example don't match. Is it an u32 or an array of u32? If 
the latter, how many elements?

>  
>  Some vaules of properties are defined in 'dt-bindings/gce/mt8173-gce.h'
>  or 'dt-binding/gce/mt8183-gce.h'. Such as sub-system ids, thread priority, event ids.
> @@ -57,8 +59,8 @@ Example for a client device:
>  		compatible = "mediatek,mt8173-mmsys";
>  		mboxes = <&gce 0 CMDQ_THR_PRIO_LOWEST 1>,
>  			 <&gce 1 CMDQ_THR_PRIO_LOWEST 1>;
> -		mutex-event-eof = <CMDQ_EVENT_MUTEX0_STREAM_EOF
> -				CMDQ_EVENT_MUTEX1_STREAM_EOF>;
> +		mediatek,gce-events = <CMDQ_EVENT_MDP_RDMA0_SOF>,
> +				      <CMDQ_EVENT_MDP_RSZ0_SOF>;
>  		mediatek,gce-client-reg = <&gce SUBSYS_1400XXXX 0x3000 0x1000>,
>  					  <&gce SUBSYS_1401XXXX 0x2000 0x100>;
>  		...
> -- 
> 2.18.0
> 
