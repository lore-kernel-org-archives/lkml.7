Return-Path: <SRS0=Q+aa=S3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 154C8C282E1
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 02:15:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CBEF420652
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 02:15:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NEvUOyTA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388647AbfDYCPQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 22:15:16 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:39450 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727660AbfDYCPQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 22:15:16 -0400
Received: by mail-pf1-f193.google.com with SMTP id i17so10298943pfo.6;
        Wed, 24 Apr 2019 19:15:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=upelHXPXvBnmaQF4I2XLLyJfMgebnENhE++m0KAJUwk=;
        b=NEvUOyTAqQiq5Co0uXudut22rlMP1o1svI6X6Qzn10TVCvF5rgiMPKCeOQYVNUJpKW
         gkInixFk44bGYAB9zA7D4zKn+SebVKOij4Pp/cxMxmscRL/juBXZoN2/QZfQ6ltXBYpN
         NMPwxMWc1SmCQRhuM2ZarfueXGjfYNcoaepNvWicvXlaWH0XPseo7uDkr8hiHjReSJc8
         QqDhd90bVJCDobs6HG1AiOwZpashQLwZlmzgGs0esX8WD74SBqZA+7JqUoJnzqWUbFcg
         9HFQDI2QDGKx8nre/bEPmuHm0qVTrjbEk7nljz/AIBUbII+l8M+sxfJINeZt1Xy67NT8
         F7Vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=upelHXPXvBnmaQF4I2XLLyJfMgebnENhE++m0KAJUwk=;
        b=Gwkq6JwJO07x8rBnSyIPJ0amNDMkxweElgsZ6soeVKDw2g2qZTySk319ygVWgY6rfL
         4y1vtwp4ZMRkZ1eyektaFQbTNEsRTvylcCoc+d1u1Y6zR8yroSMdewI32IfCFYSkb/cD
         ls4iED9yN1FebZhvpvMooxThWD3lqnSNlaBHEZn1MX1RbBmOdSwsVbdcpV8zFWhjuQW0
         EsnoPj7Bci/fLNEauQMR0z9t3JEA0mnspRX+x5QwMpieRwOflXH9k+at+txBQ8WFdJif
         5Ne5enNrZukvMN5pglWOmdKDebTzT8yd5IODPdyGbfFpU/FX8SAABp7jjOAOlOerbMyi
         KqQg==
X-Gm-Message-State: APjAAAUtFlTGmvKVA6pAQUgDyem7J1Y3IM3TOr/siVPzpxRD/V08OLOm
        z55d/ViA0BRjq9+sIOV/gGw=
X-Google-Smtp-Source: APXvYqxKGr0bTUcnykotSEx501Z9ZOL8blyv7nEKj6Xy0FtdL4dLgzomz6Z8rHRbqM6oMMoJJpYETQ==
X-Received: by 2002:a62:ed05:: with SMTP id u5mr36357214pfh.63.1556158514707;
        Wed, 24 Apr 2019 19:15:14 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id q87sm31004530pfa.133.2019.04.24.19.15.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 24 Apr 2019 19:15:13 -0700 (PDT)
Subject: Re: [PATCH 1/2] firmware: imx: SCU irq should ONLY be enabled after
 SCU IPC is ready
To:     Anson Huang <anson.huang@nxp.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "wim@linux-watchdog.org" <wim@linux-watchdog.org>,
        Aisheng Dong <aisheng.dong@nxp.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-watchdog@vger.kernel.org" <linux-watchdog@vger.kernel.org>
Cc:     dl-linux-imx <linux-imx@nxp.com>
References: <1556154581-31890-1-git-send-email-Anson.Huang@nxp.com>
From:   Guenter Roeck <linux@roeck-us.net>
Message-ID: <4a89a37c-fc7b-3248-4cc3-ae232ab310b7@roeck-us.net>
Date:   Wed, 24 Apr 2019 19:15:11 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <1556154581-31890-1-git-send-email-Anson.Huang@nxp.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/24/19 6:14 PM, Anson Huang wrote:
> The imx_scu_irq_group_enable() is normally called during module driver
> probe phase to enable SCU group irq, e.g., i.MX system controller
> watchdog driver will call it during its driver probe phase, as i.MX
> system controller watchdog driver does NOT need SCU IPC handle for
> operations, so it could be probed before i.MX SCU IPC is ready, and
> below dump will show out:
> 
> [    0.933001] Hardware name: Freescale i.MX8QXP MEK (DT)
> [    0.938129] pstate: 60000005 (nZCv daif -PAN -UAO)
> [    0.942907] pc : imx_scu_call_rpc+0x114/0x158
> [    0.947251] lr : imx_scu_irq_group_enable+0x74/0xc4
> [    0.952113] sp : ffff00001005bae0
> [    0.955415] x29: ffff00001005bae0 x28: ffff0000111bb0a0
> [    0.960712] x27: ffff00001140b000 x26: ffff00001111068c
> [    0.966011] x25: ffff0000111bb100 x24: 0000000000000000
> [    0.971311] x23: ffff0000113d9cd8 x22: 0000000000000001
> [    0.976610] x21: 0000000000000001 x20: ffff80083b51a410
> [    0.981909] x19: ffff000011259000 x18: 0000000000000480
> [    0.987209] x17: 000000000023ffb8 x16: 0000000000000010
> [    0.992508] x15: 000000000000023f x14: ffffffffffffffff
> [    0.997807] x13: 0000000000000018 x12: 0000000000000030
> [    1.003107] x11: 0000000000000003 x10: 0101010101010101
> [    1.008406] x9 : ffffffffffffffff x8 : 7f7f7f7f7f7f7f7f
> [    1.013706] x7 : fefefeff646c606d x6 : 0000000000000000
> [    1.019005] x5 : ffff0000112596c8 x4 : 0000000000000008
> [    1.024304] x3 : 0000000000000003 x2 : 0000000000000001
> [    1.029604] x1 : ffff00001005bb58 x0 : 0000000000000000
> [    1.034905] Call trace:
> [    1.037341]  imx_scu_call_rpc+0x114/0x158
> [    1.041334]  imx_scu_irq_group_enable+0x74/0xc4
> [    1.045856]  imx_sc_wdt_probe+0x24/0x150
> [    1.049766]  platform_drv_probe+0x4c/0xb0
> [    1.053762]  really_probe+0x1f8/0x2c8
> [    1.057407]  driver_probe_device+0x58/0xfc
> [    1.061490]  device_driver_attach+0x68/0x70
> [    1.065660]  __driver_attach+0x94/0xdc
> [    1.069397]  bus_for_each_dev+0x64/0xc0
> [    1.073220]  driver_attach+0x20/0x28
> [    1.076782]  bus_add_driver+0x148/0x1fc
> [    1.080601]  driver_register+0x68/0x120
> [    1.084424]  __platform_driver_register+0x4c/0x54
> [    1.089120]  imx_sc_wdt_driver_init+0x18/0x20
> [    1.093463]  do_one_initcall+0x58/0x1b8
> [    1.097287]  kernel_init_freeable+0x1cc/0x288
> [    1.101630]  kernel_init+0x10/0x100
> [    1.105101]  ret_from_fork+0x10/0x18
> [    1.108669] ---[ end trace 9e03302114457de9 ]---
> [    1.113296] enable irq failed, group 1, mask 1, ret -22
> 
> To avoid such scenario, return -EPROBE_DEFER in imx_scu_irq_group_enable()
> API if SCU IPC is NOT ready, then module driver which calls this API
> in probe phase will defer probe after SCU IPC ready.
> 
Difficult to comment - I seem to have missed the patch introducing
the call to imx_scu_irq_group_enable() from the watchdog driver, and
I don't see it in -next either.

However, as far as I can see, imx_sc_irq_ipc_handle is initialized from
imx_scu_probe(). If the watchdog driver depends on it, it should be a
sub-node of fsl,imx-scu, and be instantiated from the call to
devm_of_platform_populate() in imx_scu_probe(). This should make the
EPROBE_DEFER unnecessary.

In other words, the above statement "i.MX system controller watchdog
driver does NOT need SCU IPC handle for operations" is no longer accurate.
If it needs the interrupt, and the interrupt needs the IPC handle, the
watchdog driver does require the IPC handle. It would otherwise not need
to defer its probe function until the IPC handle is available.

I would like to add that it is highly unusual for a watchdog driver to depend
on a firmware driver. However, again, that is difficult to argue since I seem
to have missed the patch series introducing that dependency.

Guenter

> Fixes: 851826c7566e ("firmware: imx: enable imx scu general irq function")
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
> ---
>   drivers/firmware/imx/imx-scu-irq.c | 3 +++
>   1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/firmware/imx/imx-scu-irq.c b/drivers/firmware/imx/imx-scu-irq.c
> index 043833a..687121f 100644
> --- a/drivers/firmware/imx/imx-scu-irq.c
> +++ b/drivers/firmware/imx/imx-scu-irq.c
> @@ -100,6 +100,9 @@ int imx_scu_irq_group_enable(u8 group, u32 mask, u8 enable)
>   	struct imx_sc_rpc_msg *hdr = &msg.hdr;
>   	int ret;
>   
> +	if (!imx_sc_irq_ipc_handle)
> +		return -EPROBE_DEFER;
> +
>   	hdr->ver = IMX_SC_RPC_VERSION;
>   	hdr->svc = IMX_SC_RPC_SVC_IRQ;
>   	hdr->func = IMX_SC_IRQ_FUNC_ENABLE;
> 

