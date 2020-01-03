Return-Path: <SRS0=3Pgh=2Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D76AC32767
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jan 2020 22:13:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D5E9621835
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jan 2020 22:13:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1578089580;
	bh=Qf9EolB2jzZXlWCdEQ5eb6BW0rV3QbEjzHuo0ciTChs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=smKREufU3ZpJqg6Xn28mYOVbxQ/kt64oRdvmQ5tVLmw+c7Ertm31CP+UAaY1VNxWY
	 orILGBjlRfL8n5Gl+0rnOj/2+LffEt3fCpXJK5ZLWtueeDwx50f2R9H3PQringTmPh
	 BQ3ErtfHqWHgullx3OlCv9BSZwo47w0MaG+i5kro=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728832AbgACWNA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Jan 2020 17:13:00 -0500
Received: from mail-il1-f196.google.com ([209.85.166.196]:43163 "EHLO
        mail-il1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728811AbgACWM7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jan 2020 17:12:59 -0500
Received: by mail-il1-f196.google.com with SMTP id v69so37759872ili.10
        for <linux-kernel@vger.kernel.org>; Fri, 03 Jan 2020 14:12:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=DgfHDc2ugqDl3Ojv+ZQfPSfnGXvjjxOAehbizu1AkF0=;
        b=mg/PT+xY8AbXz3UR6AcmN/U+AGUsDrKJrO/OIlDLQmqKXwgA3S7yBbCMjnUw2vW2q2
         M12e7bbHOUyrut8y43TnvrzlRAOieGVdTbPAb3XCM0+cTHHhVvCAwUHq0BxbeaymXJfz
         4dsUNvREDD4CRWNWnFWFIhbkcaqcEe50UjgX5PHtFSe6BIPfqGY0Pmbh3IjPWvyxeOc3
         cvKTAPevBd7W5ZoMtkQeOntKywazhfqpAaFNabR6CfiiUIpywehk0SVVw2Bh21GwIyGS
         g+ouXzknCFDjqnHQhEOr16wsfRQjgiKupHNp4PXdGnUpHV+GmMp43CGm2Vpyww0lBQG0
         n25A==
X-Gm-Message-State: APjAAAV+MVe6UDqTFvOdIc5EcsO7lG+gNObIB20GgrrjjPRazDnb4NIQ
        dOf1Y5KNKStsTRZ3qxm0g+pFNug=
X-Google-Smtp-Source: APXvYqzizXRaDbSHcQQVXMlVsMKO6uQHs13a83S60PpGR58uwvuDFE6TX9O5dc22BKM3IB8GzUbWfg==
X-Received: by 2002:a92:d344:: with SMTP id a4mr77118764ilh.303.1578089578491;
        Fri, 03 Jan 2020 14:12:58 -0800 (PST)
Received: from rob-hp-laptop ([64.188.179.251])
        by smtp.gmail.com with ESMTPSA id a9sm7291001ilk.14.2020.01.03.14.12.55
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jan 2020 14:12:56 -0800 (PST)
Received: from rob (uid 1000)
        (envelope-from rob@rob-hp-laptop)
        id 2219a5
        by rob-hp-laptop (DragonFly Mail Agent v0.11);
        Fri, 03 Jan 2020 15:12:55 -0700
Date:   Fri, 3 Jan 2020 15:12:55 -0700
From:   Rob Herring <robh@kernel.org>
To:     Jiaxin Yu <jiaxin.yu@mediatek.com>
Cc:     yong.liang@mediatek.com, wim@linux-watchdog.org,
        linux@roeck-us.net, p.zabel@pengutronix.de, matthias.bgg@gmail.com,
        linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
        chang-an.chen@mediatek.com, freddy.hsin@mediatek.com,
        yingjoe.chen@mediatek.com, sboyd@kernel.org
Subject: Re: [PATCH 1/2] [PATCH v8 1/2] dt-bindings: mediatek: mt8183: Add
 #reset-cells
Message-ID: <20200103221255.GA1427@bogus>
References: <1578044245-26939-1-git-send-email-jiaxin.yu@mediatek.com>
 <1578044245-26939-2-git-send-email-jiaxin.yu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1578044245-26939-2-git-send-email-jiaxin.yu@mediatek.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 03, 2020 at 05:37:24PM +0800, Jiaxin Yu wrote:
> Add #reset-cells property and update example
> 
> Change-Id: If3f4f0170d417819facff1fd0a0e5e3c6cc9944d

Drop this.

> Signed-off-by: yong.liang <yong.liang@mediatek.com>
> Signed-off-by: Jiaxin Yu <jiaxin.yu@mediatek.com>
> Reviewed-by: Yingjoe Chen <yingjoe.chen@mediatek.com>
> Reviewed-by: Philipp Zabel <p.zabel@pengutronix.de>
> ---
>  .../reset-controller/mt2712-resets.h          | 22 +++++++++++++++++++
>  .../reset-controller/mt8183-resets.h          | 17 ++++++++++++++
>  2 files changed, 39 insertions(+)
>  create mode 100644 include/dt-bindings/reset-controller/mt2712-resets.h

What happened to the binding doc change?

> 
> diff --git a/include/dt-bindings/reset-controller/mt2712-resets.h b/include/dt-bindings/reset-controller/mt2712-resets.h
> new file mode 100644
> index 000000000000..9e7ee762f076
> --- /dev/null
> +++ b/include/dt-bindings/reset-controller/mt2712-resets.h
> @@ -0,0 +1,22 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * Copyright (c) 2019 MediaTek Inc.
> + * Author: Yong Liang <yong.liang@mediatek.com>
> + */
> +
> +#ifndef _DT_BINDINGS_RESET_CONTROLLER_MT2712
> +#define _DT_BINDINGS_RESET_CONTROLLER_MT2712
> +
> +#define MT2712_TOPRGU_INFRA_SW_RST				0
> +#define MT2712_TOPRGU_MM_SW_RST					1
> +#define MT2712_TOPRGU_MFG_SW_RST				2
> +#define MT2712_TOPRGU_VENC_SW_RST				3
> +#define MT2712_TOPRGU_VDEC_SW_RST				4
> +#define MT2712_TOPRGU_IMG_SW_RST				5
> +#define MT2712_TOPRGU_INFRA_AO_SW_RST				8
> +#define MT2712_TOPRGU_USB_SW_RST				9
> +#define MT2712_TOPRGU_APMIXED_SW_RST				10
> +
> +#define MT2712_TOPRGU_SW_RST_NUM				11
> +
> +#endif  /* _DT_BINDINGS_RESET_CONTROLLER_MT2712 */
> diff --git a/include/dt-bindings/reset-controller/mt8183-resets.h b/include/dt-bindings/reset-controller/mt8183-resets.h
> index 8804e34ebdd4..a1bbd41e0d12 100644
> --- a/include/dt-bindings/reset-controller/mt8183-resets.h
> +++ b/include/dt-bindings/reset-controller/mt8183-resets.h
> @@ -78,4 +78,21 @@
>  #define MT8183_INFRACFG_AO_I2C7_SW_RST				126
>  #define MT8183_INFRACFG_AO_I2C8_SW_RST				127
>  
> +#define MT8183_INFRACFG_SW_RST_NUM				128
> +
> +#define MT8183_TOPRGU_MM_SW_RST					1
> +#define MT8183_TOPRGU_MFG_SW_RST				2
> +#define MT8183_TOPRGU_VENC_SW_RST				3
> +#define MT8183_TOPRGU_VDEC_SW_RST				4
> +#define MT8183_TOPRGU_IMG_SW_RST				5
> +#define MT8183_TOPRGU_MD_SW_RST					7
> +#define MT8183_TOPRGU_CONN_SW_RST				9
> +#define MT8183_TOPRGU_CONN_MCU_SW_RST				12
> +#define MT8183_TOPRGU_IPU0_SW_RST				14
> +#define MT8183_TOPRGU_IPU1_SW_RST				15
> +#define MT8183_TOPRGU_AUDIO_SW_RST				17
> +#define MT8183_TOPRGU_CAMSYS_SW_RST				18
> +
> +#define MT8183_TOPRGU_SW_RST_NUM				19
> +
>  #endif  /* _DT_BINDINGS_RESET_CONTROLLER_MT8183 */
> -- 
> 2.18.0
