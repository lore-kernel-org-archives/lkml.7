Return-Path: <SRS0=/WLL=WS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80E57C3A5A1
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 19:24:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 523082082F
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 19:24:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="VTfI3oF2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391874AbfHVTYR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Aug 2019 15:24:17 -0400
Received: from mout.gmx.net ([212.227.15.15]:49153 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731683AbfHVTYR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Aug 2019 15:24:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1566501837;
        bh=NpNeLeI+gS2GGYSJDr8S/ivIOUCFCz5f1UMmFg9+C0w=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
        b=VTfI3oF2k9qohyTn446GbuYKUa0xRulhMim8YJaa+TFPFeM1Uv0kf3psMV8WjzoJr
         ZFiuHpZ14E90qjW0tTT53N67gEjzvAZW1J292hcL96Irw7jj+ydR2bYy+FR5PtllGA
         JnauoqrvnrDzeXwfVdafq2uIsyBb6K2UEv7s1FXM=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [217.61.154.89] ([217.61.154.89]) by web-mail.gmx.net
 (3c-app-gmx-bs43.server.lan [172.19.170.95]) (via HTTP); Thu, 22 Aug 2019
 21:23:57 +0200
MIME-Version: 1.0
Message-ID: <trinity-584a4b1c-18c9-43ae-8c1a-5057933ad905-1566501837738@3c-app-gmx-bs43>
From:   "Frank Wunderlich" <frank-w@public-files.de>
To:     "Liam Girdwood" <lgirdwood@gmail.com>
Cc:     "Mark Brown" <broonie@kernel.org>, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org,
        =?UTF-8?Q?=22Ren=C3=A9_van_Dorst=22?= <opensource@vdorst.com>
Subject: BUG: devm_regulator_get returns EPROBE_DEFER
 (5.3-rc5..next-20190822) for bpi-r2/mt7623/mt7530
Content-Type: text/plain; charset=UTF-8
Date:   Thu, 22 Aug 2019 21:23:57 +0200
Importance: normal
Sensitivity: Normal
X-Priority: 3
X-Provags-ID: V03:K1:f9r3uHKHHbamY6L7y+siJCFDx7adfRfrg4NPWU0VlSWzwn3UIbhajPDTvypqLWh2e2Z87
 nup9CtPrIaq4Yu4tnfsTLcWCkoc+aGqkD0AFXDpmKUQLpRtHncZFtvFtSU01XE+hEZwcrq6NgZqN
 Yhw5n6SBqN5tOsdEPMr1Sxa/naxgvgXcYvpNViu0DpD480qhgxI0vaS8GLWlHzBS1IHw/j/N7ual
 WUhJDReF0HvuP+jg6512sX1g+7o4/gJVDU2IzGLYoCH/Tt7Q2aYVP7vrapy4tMDClOOxSdf/5VNG
 xY=
X-UI-Out-Filterresults: notjunk:1;V03:K0:7fkmO6iHJ9Y=:Vgye3BcdvOM05q6643M7Iu
 zQumxsyp/3XZXOW+H4zutForeCza+q+QcLxgKobSr5NxpAUAt+pv52Zzwwd3WieRAfVRxTZnn
 p/WBhM+t9AC+xlZzDV4HyrKCSyGSonN/GlKntjtWfDd3cX2h8RsonhcFzqz1MHx8qw2dD5t7z
 ocUnRIrL6Ld/zaLGOtaIrjy0zleCipPpjOsob4I36xbEw/tC0DsrU5HnOMtejxpJ2DsWc6TaM
 rxasSXhpdgvmcdiaSpnnDBThPh5Cw/JkLmUWP6dh3O+mz696EUf/civ3veu9HLJ+53J8IQNGn
 joDmO9WNZZLokNElFCjCbckC5axZDSeaqXCoRPhgxqU18f96/dI9/NhPxF6/q3F6sVtPBd6Qm
 mX7ghj12vJZwHJcD9dGNjdLf+VEY28SGKWMQTNSRUqTGZvLz0WPLh09oU6SZNw1FryAQ6TPiF
 3zHPbQNdqKRCvu81Y7w66oqkXTLyWRACP5iGpJlGtl49yInSBYhdMxH4uCI2GW2zOSirKb+/Q
 X89caGMHa16t+uU45PRGoFlIQ7VWSfPrlXHAkcqkFI24tqQ2xLp+dmooSuDXGeizEAvMgizu1
 kYPhw8nevSgP6aR02eFbvJNIbt0Z89/WlIEM8Fqqjc6YQh2fm+zgYyBfcbGsyjeIKpUX7s/tL
 OSywzmj8yEpDW9kId+UK5pqeDI+7zaABjL6HxdkuvuAWu+A==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

i've encountered a bug in regulator between 5.3-rc5 and next-20190822

i build for bananapi-r2/mt7623 using this branch (includes next-patches):

https://github.com/vDorst/linux-1/blob/c34582d96520566c45068b92e080620458ffc1ff/arch/arm/boot/dts/mt7623n-bananapi-bpi-r2.dts#L166

and noticed that switch does not came up

priv->core_pwr = devm_regulator_get(&mdiodev->dev, "core"); returns 517

located here:
https://github.com/vDorst/linux-1/blob/c34582d96520566c45068b92e080620458ffc1ff/drivers/net/dsa/mt7530.c#L1590

#define EPROBE_DEFER 517/* Driver requests probe retry */

https://elixir.bootlin.com/linux/latest/source/drivers/regulator/core.c#L1726

seems of_find_regulator_by_node(node); is failing here, but i see the dts-node (mt6323_vpa_reg: buck_vpa) in /sys/firmware/devicetree/...

tried without next-patches and switch came up including dsa-ports.

i found no commit yet which breaks the regulator-setup

any idea about this?

regards Frank
