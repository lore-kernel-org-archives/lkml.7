Return-Path: <SRS0=6SCO=RE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17FE2C43381
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 09:14:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D72FA2085A
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 09:14:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551431676;
	bh=adRrWvZswv6/A0CZm9xhGl59CI2WDzORwkMwbCYtQlc=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=wY9cSlVE1APOAcVYL1FNU/IXZ0x8hRsjpSkiICXNNZb/rklLpJ0aTeSwrCNJZQZq7
	 qmda16QglyIM9kndARIGdp0FIzjw/JVU033FreS6sq046ISTp4eJNZ5WPKXal06EXK
	 PM2D3V3zqclmDf5yYjSs+9URuNPmbyl7U7QsV0xw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732921AbfCAJOf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Mar 2019 04:14:35 -0500
Received: from mail.kernel.org ([198.145.29.99]:48912 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726424AbfCAJOe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Mar 2019 04:14:34 -0500
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EC842218FC;
        Fri,  1 Mar 2019 09:14:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551431673;
        bh=adRrWvZswv6/A0CZm9xhGl59CI2WDzORwkMwbCYtQlc=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=BCl6n1mhiS0jcoDyT/08ZNvSQm5sLptP37zarhchbNnjvkwXifbJBkuYNiKHlnHog
         qRatBMZsA5uxOd8eg2MQiuKD5wDfsERQOzeKGre4+m/M8VxEJiam8z42FkNVLKBgbU
         Uby4zE8sASZJbpEhkYcoicuitwL0zOGXcWpW+PpY=
Received: by mail-lj1-f175.google.com with SMTP id v16so19709885ljg.13;
        Fri, 01 Mar 2019 01:14:32 -0800 (PST)
X-Gm-Message-State: APjAAAUehajj/grGWReaRlskYGYJkP9iyA5WWWn1xA0tCdAhK4CTy9xd
        InE8bAI9OfKQRIytJI5nNyGeAaHeMLFbg4EJjGk=
X-Google-Smtp-Source: APXvYqzeo89Plxq0Q8UMuie44AXbgyZ693kY16HuhEKYLKV3/3K1xVsYsb+In2YxJwz56HVlLG7GExZh6IWcIBtaTOA=
X-Received: by 2002:a2e:88d1:: with SMTP id a17mr1970816ljk.169.1551431670964;
 Fri, 01 Mar 2019 01:14:30 -0800 (PST)
MIME-Version: 1.0
References: <1551430616-42014-1-git-send-email-wen.yang99@zte.com.cn> <1551430616-42014-3-git-send-email-wen.yang99@zte.com.cn>
In-Reply-To: <1551430616-42014-3-git-send-email-wen.yang99@zte.com.cn>
From:   Krzysztof Kozlowski <krzk@kernel.org>
Date:   Fri, 1 Mar 2019 10:14:19 +0100
X-Gmail-Original-Message-ID: <CAJKOXPcn=eP1h0_DNVuKBcb3WXb3mzvPGm-mkk6D8auvC7ABGA@mail.gmail.com>
Message-ID: <CAJKOXPcn=eP1h0_DNVuKBcb3WXb3mzvPGm-mkk6D8auvC7ABGA@mail.gmail.com>
Subject: Re: [PATCH 03/15] ARM: exynos: fix a leaked reference by
 addingmissing of_node_put
To:     Wen Yang <wen.yang99@zte.com.cn>
Cc:     liviu.dudau@arm.com, sudeep.holla@arm.com,
        lorenzo.pieralisi@arm.com, linux@armlinux.org.uk,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kgene@kernel.org,
        "linux-samsung-soc@vger.kernel.org" 
        <linux-samsung-soc@vger.kernel.org>, michal.simek@xilinx.com,
        afaerber@suse.de, manivannan.sadhasivam@linaro.org,
        dinguyen@kernel.org, heiko@sntech.de,
        linux-rockchip@lists.infradead.org, f.fainelli@gmail.com,
        rjui@broadcom.com, sbranden@broadcom.com,
        bcm-kernel-feedback-list@broadcom.com, linus.walleij@linaro.org,
        avifishman70@gmail.com, tmaimon77@gmail.com, venture@google.com,
        yuenn@google.com, brendanhiggins@google.com,
        openbmc@lists.ozlabs.org, xuwei5@hisilicon.com,
        maxime.ripard@bootlin.com, wens@csie.org, catalin.marinas@arm.com,
        will.deacon@arm.com, horms@verge.net.au, magnus.damm@gmail.com,
        linux-renesas-soc@vger.kernel.org, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de,
        fabio.estevam@nxp.com, linux-imx@nxp.com, wang.yi59@zte.com.cn
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 1 Mar 2019 at 09:57, Wen Yang <wen.yang99@zte.com.cn> wrote:
>
> The call to of_get_next_child returns a node pointer with refcount
> incremented thus it must be explicitly decremented after the last
> usage.
>
> Detected by coccinelle with the following warnings:
> ./arch/arm/mach-exynos/firmware.c:201:2-8: ERROR: missing of_node_put; acquired a node pointer with refcount incremented on line 193, but without a corresponding object release within this function.
> ./arch/arm/mach-exynos/firmware.c:204:1-7: ERROR: missing of_node_put; acquired a node pointer with refcount incremented on line 193, but without a corresponding object release within this function.
> ./arch/arm/mach-exynos/suspend.c:642:2-8: ERROR: missing of_node_put; acquired a node pointer with refcount incremented on line 634, but without a corresponding object release within this function.

Thanks, looks good. I'll take it however after merge window.

There are no dependencies between patches therefore you could limit
the amount of people you CC. You put specific "Cc" fields in patch but
you did not use them and sent it to 40 addresses. The CC in the patch
has exactly this purpose - do not send everything to everyone...

Best regards,
Krzysztof
