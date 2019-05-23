Return-Path: <SRS0=P610=TX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76699C04AAC
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 08:47:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 35A9A2168B
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 08:47:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="d/AwauIs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730114AbfEWIrO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 May 2019 04:47:14 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:36659 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725814AbfEWIrO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 May 2019 04:47:14 -0400
Received: by mail-wm1-f68.google.com with SMTP id j187so4868231wmj.1
        for <linux-kernel@vger.kernel.org>; Thu, 23 May 2019 01:47:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=aZ6D2XlEYwvXZbrqEbjpu9yY579r2bu6ODvrfx8X08w=;
        b=d/AwauIsWqkqiCoDbAJXJ2gr/ROX0wC1/pvbCDuEAyUEFJTeXaTGNfkqW+HnaWJLZG
         xTqX/l4Dr2wnzdj8Oc4Ettwl2MFFi4RnOORMIATXUs6TAh0sMgllhBIlVv4FKPpgXrom
         YeX5+p6SLjDFjMEdUDRN39wh4SdgQqYsGlp3ronpw0C0X/S/bBMY6hvUF8IwGbYjwfjI
         JnfuoujmII2Mwv5rZefh4lig6DI1WoAWJKtOO5IhG7M/vE0WfkUudQVE7nF2n0cz3ZJr
         sPYxuNChtsrgf3Ff+keozDK82BvMgfZ25S93uWy1yoCseq6/Y/HKrxE29TTito+D3nxs
         Y+fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=aZ6D2XlEYwvXZbrqEbjpu9yY579r2bu6ODvrfx8X08w=;
        b=qtiUN0H7fYuZPPC7/iJnkMGY7KXmdaQh8LJYQ/ZMXQC+iZaGE1NWfJtvao1+fFMzaS
         RxNtAHtfjkAHJmoJLqVmbpLyKm5SBnPMrwP2r/sGWYqpd/mpS0Pf+Q850uZIiDTCuRRZ
         CpbeSho8I1RsMxI4XcTWt0TTVIBmxA6Pcu2zeLwUYYONs7sXkQriJizJsdjIXuLfPHiA
         9qv/nGG42zRn49yYxHMTlT/70oxMnjEggAKs9O+6d4pYbLU/SockzW7TghJBJpeLT3WT
         m7C/LKSLOc2Kfkaoe/7NcN7wezFDPZmCAYIR4ju2d3sw3FuobsW8nVvMZoeP4ehNf/0r
         aGQQ==
X-Gm-Message-State: APjAAAU3Nte7WANCJAVwbuErdct4ggx1lNTFQzLgwiKr50r2jAMbErBN
        XiGvDUz8hri2L+BsYWrX9KBhMw==
X-Google-Smtp-Source: APXvYqx8tWRko1FYV9WAi+gy510WGFSXJ0v+a5meO/JBL7cf8aVxNVPDnvTwo4K8Biw+MXULEpH5ag==
X-Received: by 2002:a05:600c:110a:: with SMTP id b10mr9686753wma.125.1558601232286;
        Thu, 23 May 2019 01:47:12 -0700 (PDT)
Received: from [192.168.86.34] (cpc89974-aztw32-2-0-cust43.18-1.cable.virginm.net. [86.30.250.44])
        by smtp.googlemail.com with ESMTPSA id 34sm48072636wre.32.2019.05.23.01.47.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 23 May 2019 01:47:11 -0700 (PDT)
Subject: Re: [PATCH V3 RESEND 2/4] nvmem: imx: add i.MX8 nvmem driver
To:     Peng Fan <peng.fan@nxp.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>
Cc:     dl-linux-imx <linux-imx@nxp.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "van.freenix@gmail.com" <van.freenix@gmail.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>
References: <20190522020040.30283-1-peng.fan@nxp.com>
 <20190522020040.30283-2-peng.fan@nxp.com>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Message-ID: <9d8ea55c-e9e7-82f5-45be-53bc86e59f69@linaro.org>
Date:   Thu, 23 May 2019 09:47:10 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190522020040.30283-2-peng.fan@nxp.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 22/05/2019 02:46, Peng Fan wrote:
> This patch adds i.MX8 nvmem ocotp driver to access fuse via
> RPC to i.MX8 system controller.
> 
> Cc: Srinivas Kandagatla<srinivas.kandagatla@linaro.org>
> Cc: Shawn Guo<shawnguo@kernel.org>
> Cc: Sascha Hauer<s.hauer@pengutronix.de>
> Cc: Pengutronix Kernel Team<kernel@pengutronix.de>
> Cc: Fabio Estevam<festevam@gmail.com>
> Cc: NXP Linux Team<linux-imx@nxp.com>
> Cc:linux-arm-kernel@lists.infradead.org
> Signed-off-by: Peng Fan<peng.fan@nxp.com>
> ---
> 
> V3:
>   Use imx_sc_msg_misc_fuse_read for req/resp
>   Drop uneccessary check
>   Drop the unnecessary type conversion
>   Minor fixes according to v2 comments
> 
> V2:
>   Add "scu" or "SCU", Add imx_sc_misc_otp_fuse_read, minor fixes
> 
>   drivers/nvmem/Kconfig         |   7 ++
>   drivers/nvmem/Makefile        |   2 +
>   drivers/nvmem/imx-ocotp-scu.c | 161 ++++++++++++++++++++++++++++++++++++++++++
>   3 files changed, 170 insertions(+)
>   create mode 100644 drivers/nvmem/imx-ocotp-scu.c

Applied 1/4 and 2/4 patches.
defconfig and dts changes should go via arm-soc tree.

Thanks,
srini
