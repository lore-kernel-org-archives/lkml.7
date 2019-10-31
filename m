Return-Path: <SRS0=21RF=YY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FAFDCA9ECF
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Oct 2019 19:10:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5294A2080F
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Oct 2019 19:10:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729466AbfJaTKc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Oct 2019 15:10:32 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:51862 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729296AbfJaTKb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Oct 2019 15:10:31 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: aratiu)
        with ESMTPSA id 5E60A290B9B
From:   Adrian Ratiu <adrian.ratiu@collabora.com>
To:     Emil Velikov <emil.l.velikov@gmail.com>,
        Adrian Ratiu <adrian.ratiu@collabora.com>
Cc:     "Linux-Kernel\@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>,
        ML dri-devel <dri-devel@lists.freedesktop.org>,
        linux-rockchip <linux-rockchip@lists.infradead.org>,
        kernel@collabora.com, linux-stm32@st-md-mailman.stormreply.com,
        LAKML <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH 0/4] Genericize DW MIPI DSI bridge and add i.MX 6 driver
In-Reply-To: <CACvgo50NmofJrCvADOTxJqJqKEWDsy8qD-1B6R356vFMcmdbWA@mail.gmail.com>
References: <20191031142633.12460-1-adrian.ratiu@collabora.com>
 <CACvgo50NmofJrCvADOTxJqJqKEWDsy8qD-1B6R356vFMcmdbWA@mail.gmail.com>
Date:   Thu, 31 Oct 2019 21:10:48 +0200
Message-ID: <87y2x091dz.fsf@iwork.i-did-not-set--mail-host-address--so-tickle-me>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 31 Oct 2019, Emil Velikov <emil.l.velikov@gmail.com> 
wrote:
> Hi Adrian, 

Hi Emil!

> 
> On Thu, 31 Oct 2019 at 14:26, Adrian Ratiu 
> <adrian.ratiu@collabora.com> wrote: 
>> 
>> Having a generic Synopsis DesignWare MIPI-DSI host controller 
>> bridge driver is a very good idea, however the current 
>> implementation has hardcoded quite a lot of the register 
>> layouts used by the two supported SoC vendors, STM and 
>> Rockchip, which use IP cores v1.30 and v1.31. 
>> 
>> This makes it hard to support other SoC vendors like the 
>> FSL/NXP i.MX 6 which use older v1.01 cores or future versions 
>> because, based on history, layout changes should also be 
>> expected in new DSI versions / SoCs. 
>> 
>> This patch series converts the bridge and platform drivers to 
>> access registers via generic regmap APIs and allows each 
>> platform driver to configure its register layout via struct 
>> reg_fields, then adds support for the host controller found on 
>> i.MX 6. 
>> 
> Have you considered keeping the difference internal to the 
> dw-mipi-dsi driver?  Say having the iMX6 module "request" the 
> v1.01 regmap from the bridge driver, while rockchip/others doing 
> the equivalent.

No, I haven't. It sounds like a good idea though and I think it's 
doable. Thank you!
 
> 
>>  .../bindings/display/imx/mipi-dsi.txt         |  56 ++ 
>>  drivers/gpu/drm/bridge/synopsys/dw-mipi-dsi.c | 518 
>>  +++++++++--------- drivers/gpu/drm/imx/Kconfig 
>>  |   7 + drivers/gpu/drm/imx/Makefile                  |   1 + 
>>  drivers/gpu/drm/imx/dw_mipi_dsi-imx.c         | 502 
>>  +++++++++++++++++ .../gpu/drm/rockchip/dw-mipi-dsi-rockchip.c 
>>  | 154 +++++- drivers/gpu/drm/stm/dw_mipi_dsi-stm.c         | 
>>  160 +++++- include/drm/bridge/dw_mipi_dsi.h              |  60 
>>  +- 8 files changed, 1185 insertions(+), 273 deletions(-) 
>>  create mode 100644 
>>  Documentation/devicetree/bindings/display/imx/mipi-dsi.txt 
>>  create mode 100644 drivers/gpu/drm/imx/dw_mipi_dsi-imx.c 
>> 
> 
> This should make the delta a lot smaller, avoiding the 
> unnecessary copy of register fields and regmap.  Plus plugging 
> future users will be dead trivial.

Agreed. I'll do this in v2 unless someone objects or proposes a 
better alternative.

I'll let this series sit a little more on review so others have a 
chance to see and review; will address all feedback in v2.

>
> -Emil
>
> _______________________________________________
> Linux-rockchip mailing list
> Linux-rockchip@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-rockchip
