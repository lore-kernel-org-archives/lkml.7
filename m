Return-Path: <SRS0=KBKa=UT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E3DCC43613
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Jun 2019 08:51:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D6853206E0
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Jun 2019 08:51:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="yQcQxeYX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731459AbfFTIvS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Jun 2019 04:51:18 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:49342 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726071AbfFTIvR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jun 2019 04:51:17 -0400
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id x5K8oPWT013042;
        Thu, 20 Jun 2019 03:50:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1561020625;
        bh=ZvdTayQSZVxrbxnmLhuudH8+x8XODmTbZSOFAYzkOH0=;
        h=Subject:From:To:CC:References:Date:In-Reply-To;
        b=yQcQxeYXgas589nX61LGHgsETt9+I5jlLjqKaFQO/0cV80Umo8zpuMb9/74EeQj+W
         pvcqdtOdUQsiPDP7w3uwKlyIXJzO7jrnZSRr+749ZIwZW5UpiNi2dr+dy5UG6528JU
         YkxAWMVgKoblEXhXllSZe43sV0TPyezzuTVh1UXc=
Received: from DFLE109.ent.ti.com (dfle109.ent.ti.com [10.64.6.30])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x5K8oPQN092929
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 20 Jun 2019 03:50:25 -0500
Received: from DFLE104.ent.ti.com (10.64.6.25) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Thu, 20
 Jun 2019 03:50:25 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Thu, 20 Jun 2019 03:50:25 -0500
Received: from [172.24.190.233] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id x5K8oIqb044496;
        Thu, 20 Jun 2019 03:50:19 -0500
Subject: Re: [PATCH v11 2/2] phy: Add driver for mixel mipi dphy found on
 NXP's i.MX8 SoCs
From:   Kishon Vijay Abraham I <kishon@ti.com>
To:     Fabio Estevam <festevam@gmail.com>,
        =?UTF-8?Q?Guido_G=c3=bcnther?= <agx@sigxcpu.org>
CC:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        Thierry Reding <treding@nvidia.com>,
        =?UTF-8?Q?Andreas_F=c3=a4rber?= <afaerber@suse.de>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Johan Hovold <johan@kernel.org>,
        Lucas Stach <l.stach@pengutronix.de>,
        Abel Vesa <abel.vesa@nxp.com>, Li Jun <jun.li@nxp.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        DRI mailing list <dri-devel@lists.freedesktop.org>,
        Robert Chiras <robert.chiras@nxp.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        Maxime Ripard <maxime.ripard@bootlin.com>
References: <cover.1557657814.git.agx@sigxcpu.org>
 <2000bc4564175abd7966207a5e9fbb9bb7d82059.1557657814.git.agx@sigxcpu.org>
 <CAOMZO5BaFYJxh1v46n2mdPyc+-jg6LgvoGR1rTE+yHZg_0Z8PA@mail.gmail.com>
 <69fcb327-8b51-df9e-12d9-d75751974bce@ti.com>
Message-ID: <9a872f5b-1544-32a0-bd93-1d6333468114@ti.com>
Date:   Thu, 20 Jun 2019 14:18:53 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <69fcb327-8b51-df9e-12d9-d75751974bce@ti.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 24/05/19 9:31 PM, Kishon Vijay Abraham I wrote:
> Hi,
> 
> On 24/05/19 5:53 PM, Fabio Estevam wrote:
>> Hi Kishon,
>>
>> On Sun, May 12, 2019 at 7:49 AM Guido Günther <agx@sigxcpu.org> wrote:
>>>
>>> This adds support for the Mixel DPHY as found on i.MX8 CPUs but since
>>> this is an IP core it will likely be found on others in the future. So
>>> instead of adding this to the nwl host driver make it a generic PHY
>>> driver.
>>>
>>> The driver supports the i.MX8MQ. Support for i.MX8QM and i.MX8QXP can be
>>> added once the necessary system controller bits are in via
>>> mixel_dphy_devdata.
>>>
>>> Signed-off-by: Guido Günther <agx@sigxcpu.org>
>>> Co-developed-by: Robert Chiras <robert.chiras@nxp.com>
>>> Signed-off-by: Robert Chiras <robert.chiras@nxp.com>
>>> Reviewed-by: Fabio Estevam <festevam@gmail.com>
>>> Reviewed-by: Sam Ravnborg <sam@ravnborg.org>
>>
>> Would you have any comments on this series, please?
> 
> I don't have any comments. I'll queue this once I start queuing patches for the
> next merge window.

Can you fix the following checkpatch warning and repost?
WARNING: quoted string split across lines
#420: FILE: drivers/phy/freescale/phy-fsl-imx8-mipi-dphy.c:280:
+	dev_dbg(&phy->dev, "hs_prepare: %u, clk_prepare: %u, "
+		"hs_zero: %u, clk_zero: %u, "

WARNING: quoted string split across lines
#421: FILE: drivers/phy/freescale/phy-fsl-imx8-mipi-dphy.c:281:
+		"hs_zero: %u, clk_zero: %u, "
+		"hs_trail: %u, clk_trail: %u, "

WARNING: quoted string split across lines
#422: FILE: drivers/phy/freescale/phy-fsl-imx8-mipi-dphy.c:282:
+		"hs_trail: %u, clk_trail: %u, "
+		"rxhs_settle: %u\n",

Thanks
Kishon
