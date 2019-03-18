Return-Path: <SRS0=xYIU=RV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC91FC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 22:50:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 72F022085A
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 22:50:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20150623.gappssmtp.com header.i=@kernelci-org.20150623.gappssmtp.com header.b="gYsIBVO8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727218AbfCRWuk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Mar 2019 18:50:40 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:54704 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726896AbfCRWuk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Mar 2019 18:50:40 -0400
Received: by mail-wm1-f65.google.com with SMTP id f3so14850062wmj.4
        for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2019 15:50:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20150623.gappssmtp.com; s=20150623;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from:cc;
        bh=Uc4z/PbEJOP2WM4wY5rF/semuXMgKiI/li91+DWKXXI=;
        b=gYsIBVO8Yn1xwTTYB8d8dxBd4NW7aL4amTtp/YdMbeJZj7q6li9yLlRsjsji3rjYmo
         VKZBj4zj/JpPFn7ZMw7C4lmOTgqKBX5e2/hIsezwS+Jz6s4nS5ZdFNKdh8bC+/X+Bk9o
         F2dFR1WOxrbqQrVZPVlCWXWYqHKSRAyD9DXu97apZuM6vD0mklgNi9aSjl+HakS4QFrp
         EcMSqPOq453G7nqZ8sgpbL3AzJyyH8gSp/NyguPKg4q+A0rpewWS0kO3FVRMVmxVqEoa
         fMUlB9rHn6SSxTZaQ8Hiu6T7L/iasOCiWeh1Y6uW9eOUYy+zofYNsEId9/BCW4Txc3Kf
         N2XQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from:cc;
        bh=Uc4z/PbEJOP2WM4wY5rF/semuXMgKiI/li91+DWKXXI=;
        b=cqfxLj6aSUE6jWq63sj6y7Ura/vYB8ejIXcyROPO1iTvmaI3y+imyVGFbLhqw+JEkE
         GG689abIfk46dZ7vZsCsDTjP2mNLN/1LdZ2jpI33ikkWJ9OxC8hUhxtWUPCdgO6nB3DS
         5873GsL8Cl9M1fQ04otikxx3Q5KcLFoJcFt8ByLGUu0MuW3YCLrGZexWo1CH09eT6RYe
         UlnNtFvP47u+RSMrWdJ2LRBSg1Kz5mP7E/2gjiTZwXmkVL9CD1QiJWaWV/kSyd6mNRDS
         9Ov2DFlvHnIqLGVAI07hAeHyCAF15jlzMMamFejUPubU2bVjEbJDzEqeahye0pmJMZ7P
         gz6g==
X-Gm-Message-State: APjAAAUGayRU9gmnmK3xdqjM4uu0Jyj7GhvU903lO5kq//zl57/MXOBj
        4RYon4kLsfUPOLEgXw1c+iNseg==
X-Google-Smtp-Source: APXvYqzmenV7QUNQOY18BnIHsruKYnRs82m21GCq8bcbqMqHddDDwvhk5Y8TGrIcT6bms30WX/TAMw==
X-Received: by 2002:a7b:cf23:: with SMTP id m3mr854274wmg.96.1552949437668;
        Mon, 18 Mar 2019 15:50:37 -0700 (PDT)
Received: from [148.251.42.114] ([2a01:4f8:201:9271::2])
        by smtp.gmail.com with ESMTPSA id a9sm5217453wrt.29.2019.03.18.15.50.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 18 Mar 2019 15:50:36 -0700 (PDT)
Message-ID: <5c9020bc.1c69fb81.6977e.d27a@mx.google.com>
Date:   Mon, 18 Mar 2019 15:50:36 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Kernel: v5.1-rc1-22-gb3725d97ba75
X-Kernelci-Report-Type: bisect
X-Kernelci-Tree: ulfh
X-Kernelci-Lab-Name: lab-collabora
X-Kernelci-Branch: next
Subject: ulfh/next boot bisection: v5.1-rc1-22-gb3725d97ba75 on
 rk3399-gru-kevin
To:     tomeu.vizoso@collabora.com, guillaume.tucker@collabora.com,
        mgalka@collabora.com, Ziyuan Xu <xzy.xu@rock-chips.com>,
        Shawn Lin <shawn.lin@rock-chips.com>, broonie@kernel.org,
        matthew.hart@linaro.org, khilman@baylibre.com,
        enric.balletbo@collabora.com, Ulf Hansson <ulf.hansson@linaro.org>
From:   "kernelci.org bot" <bot@kernelci.org>
Cc:     Heiko Stuebner <heiko@sntech.de>, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Jaehoon Chung <jh80.chung@samsung.com>,
        linux-rockchip@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
* This automated bisection report was sent to you on the basis  *
* that you may be involved with the breaking commit it has      *
* found.  No manual investigation has been done to verify it,   *
* and the root cause of the problem may be somewhere else.      *
* Hope this helps!                                              *
* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *

ulfh/next boot bisection: v5.1-rc1-22-gb3725d97ba75 on rk3399-gru-kevin

Summary:
  Start:      b3725d97ba75 Merge branch 'fixes' into next
  Details:    https://kernelci.org/boot/id/5c8fa85d59b5148afcfe6052
  Plain log:  https://storage.kernelci.org//ulfh/next/v5.1-rc1-22-gb3725d97=
ba75/arm64/defconfig/gcc-7/lab-collabora/boot-rk3399-gru-kevin.txt
  HTML log:   https://storage.kernelci.org//ulfh/next/v5.1-rc1-22-gb3725d97=
ba75/arm64/defconfig/gcc-7/lab-collabora/boot-rk3399-gru-kevin.html
  Result:     d6a6d722481f mmc: dw_mmc-rockchip: Enable hardware unbusy int=
errupt support

Checks:
  revert:     PASS
  verify:     PASS

Parameters:
  Tree:       ulfh
  URL:        https://git.kernel.org/pub/scm/linux/kernel/git/ulfh/mmc.git
  Branch:     next
  Target:     rk3399-gru-kevin
  CPU arch:   arm64
  Lab:        lab-collabora
  Compiler:   gcc-7
  Config:     defconfig
  Test suite: boot

Breaking commit found:

---------------------------------------------------------------------------=
----
commit d6a6d722481f357eafe7b798fe6fdadd2f5ac6bd
Author: Shawn Lin <shawn.lin@rock-chips.com>
Date:   Tue Mar 12 15:35:09 2019 +0800

    mmc: dw_mmc-rockchip: Enable hardware unbusy interrupt support
    =

    The new register for controlling hardware unbusy interrupt
    is in 0x120. It looks like:
    =

    |------------------------------------------------------------|
    |Bit    |  Attribute |  Reset Value  | Description           |
    |------------------------------------------------------------|
    |31:25  |    RO      |      0x0      |  reserved             |
    |------------------------------------------------------------|
    |24     |    RO      |      0x0      |  rdyint_cnt_finish    |
    |       |            |               |When high, it indicates|
    |       |            |               |that the rdyint counter|
    |       |            |               |is finished.           |
    |------------------------------------------------------------|
    |23:16  |    RO      |      0x0      |  rdyint_cnt_status    |
    |       |            |               |Couner status, reflect |
    |       |            |               |internal counter value.|
    |------------------------------------------------------------|
    |15:9   |    RO      |      0x0      |  reserved             |
    |------------------------------------------------------------|
    |8      |    RW      |      0x0      |  rdyint_gen_working   |
    |       |            |               |When set, IP starts to |
    |       |            |               |count and generate one |
    |       |            |               |rdyint trigger. After  |
    |       |            |               |the rdyint trigger is  |
    |       |            |               |generated, it will be  |
    |       |            |               |cleaned automatically. |
    |       |            |               |Software should set it |
    |       |            |               |again next time.       |
    |------------------------------------------------------------|
    |7:0    |    RW      |      0xff     |   rdyint_gen_maxval   |
    |       |            |               |Max counter value for  |
    |       |            |               |the IP to count when   |
    |       |            |               |rdyint_gen_working is  |
    |       |            |               |set. This counter is   |
    |       |            |               |based on biu_clk.      |
    |------------------------------------------------------------|
    =

    Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
    Tested-by: Ziyuan Xu <xzy.xu@rock-chips.com>
    Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>

diff --git a/drivers/mmc/host/dw_mmc-rockchip.c b/drivers/mmc/host/dw_mmc-r=
ockchip.c
index 8c86a800a8fd..85b1e42782a0 100644
--- a/drivers/mmc/host/dw_mmc-rockchip.c
+++ b/drivers/mmc/host/dw_mmc-rockchip.c
@@ -20,6 +20,9 @@
 #include "dw_mmc-pltfm.h"
 =

 #define RK3288_CLKGEN_DIV       2
+#define RKMMC_RDYINT_GEN	0x120
+#define RKMMC_RDYINT_GEN_WORKING BIT(8)
+#define RKMMC_RDYINT_GEN_MAXVAL GENMASK(7, 0)
 =

 struct dw_mci_rockchip_priv_data {
 	struct clk		*drv_clk;
@@ -28,6 +31,23 @@ struct dw_mci_rockchip_priv_data {
 	int			num_phases;
 };
 =

+static int dw_mci_rockchip_prepare_hw_unbusy(struct dw_mci *host,
+					     bool enable)
+{
+	u32 reg =3D readl(host->regs + RKMMC_RDYINT_GEN);
+
+	if (enable)
+		/* Self-clean when generating unbusy int */
+		reg |=3D RKMMC_RDYINT_GEN_WORKING;
+	else
+		/* Otherwise do it manually to avoid racing condition */
+		reg &=3D ~RKMMC_RDYINT_GEN_WORKING;
+
+	writel(reg, host->regs + RKMMC_RDYINT_GEN);
+
+	return 0;
+}
+
 static void dw_mci_rk3288_set_ios(struct dw_mci *host, struct mmc_ios *ios)
 {
 	struct dw_mci_rockchip_priv_data *priv =3D host->priv;
@@ -301,6 +321,15 @@ static int dw_mci_rockchip_init(struct dw_mci *host)
 				    "rockchip,rk3288-dw-mshc"))
 		host->bus_hz /=3D RK3288_CLKGEN_DIV;
 =

+	/* Some Rockchip SoCs use hw unbusy int */
+	if (of_device_is_compatible(host->dev->of_node,
+				    "rockchip,rk1808-dw-mshc")) {
+		host->hw_unbusy_int =3D 16;
+		writel(~(RKMMC_RDYINT_GEN_WORKING |
+			 RKMMC_RDYINT_GEN_MAXVAL),
+		       host->regs + RKMMC_RDYINT_GEN);
+	}
+
 	return 0;
 }
 =

@@ -322,6 +351,7 @@ static const struct dw_mci_drv_data rk3288_drv_data =3D=
 {
 	.set_ios		=3D dw_mci_rk3288_set_ios,
 	.execute_tuning		=3D dw_mci_rk3288_execute_tuning,
 	.parse_dt		=3D dw_mci_rk3288_parse_dt,
+	.prepare_hw_unbusy      =3D dw_mci_rockchip_prepare_hw_unbusy,
 	.init			=3D dw_mci_rockchip_init,
 };
---------------------------------------------------------------------------=
----


Git bisection log:

---------------------------------------------------------------------------=
----
git bisect start
# good: [4d3d534e9fd596e6f70ee19c75f0cd9aa5be2588] Merge branch 'fixes' int=
o next
git bisect good 4d3d534e9fd596e6f70ee19c75f0cd9aa5be2588
# bad: [b3725d97ba75b0cf6d0eb1e3836915ad234f6f3d] Merge branch 'fixes' into=
 next
git bisect bad b3725d97ba75b0cf6d0eb1e3836915ad234f6f3d
# good: [e266ca36da7de45b64b05698e98e04b578a88888] Merge tag 'staging-5.1-r=
c1' of git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/staging
git bisect good e266ca36da7de45b64b05698e98e04b578a88888
# good: [36011ddc78395b59a8a418c37f20bcc18828f1ef] Merge tag 'gfs2-5.1.fixe=
s' of git://git.kernel.org/pub/scm/linux/kernel/git/gfs2/linux-gfs2
git bisect good 36011ddc78395b59a8a418c37f20bcc18828f1ef
# good: [6bc3fe8e7e172d5584e529a04cf9eec946428768] tools: mark 'test_vmallo=
c.sh' executable
git bisect good 6bc3fe8e7e172d5584e529a04cf9eec946428768
# good: [dc2535be1fd547fbd56aff091370280007b0a1af] Merge tag 'clk-for-linus=
' of git://git.kernel.org/pub/scm/linux/kernel/git/clk/linux
git bisect good dc2535be1fd547fbd56aff091370280007b0a1af
# good: [e8a71a38668919c53e6ca9dd1bfa977e5690523f] Merge tag 'ntb-5.1' of g=
it://github.com/jonmason/ntb
git bisect good e8a71a38668919c53e6ca9dd1bfa977e5690523f
# good: [636deed6c0bc137a7c4f4a97ae1fcf0ad75323da] Merge tag 'for-linus' of=
 git://git.kernel.org/pub/scm/virt/kvm/kvm
git bisect good 636deed6c0bc137a7c4f4a97ae1fcf0ad75323da
# good: [477558d7e8d82b59a650e193a5651cf25b794dbc] Merge tag 'scsi-misc' of=
 git://git.kernel.org/pub/scm/linux/kernel/git/jejb/scsi
git bisect good 477558d7e8d82b59a650e193a5651cf25b794dbc
# good: [80b98e92ebcb4433b86fd32b5d82ec6b0d75cf59] Merge branch 'x86-asm-fo=
r-linus' of git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip
git bisect good 80b98e92ebcb4433b86fd32b5d82ec6b0d75cf59
# good: [9e98c678c2d6ae3a17cb2de55d17f69dddaa231b] Linux 5.1-rc1
git bisect good 9e98c678c2d6ae3a17cb2de55d17f69dddaa231b
# good: [311f059c6aaeb6f5c21459041523a07459d7369b] mmc: sdhci-of-esdhc: add=
 erratum A-009204 support
git bisect good 311f059c6aaeb6f5c21459041523a07459d7369b
# good: [705a0f28811322cb8c578c35a9d07fae7c683845] mmc: dw_mmc: Add hardwar=
e unbusy interrupt support
git bisect good 705a0f28811322cb8c578c35a9d07fae7c683845
# bad: [60cbf5c5e71dab0586455ae846fb67353d2554bf] mmc: renesas_sdhi: update=
 copyright information
git bisect bad 60cbf5c5e71dab0586455ae846fb67353d2554bf
# bad: [eeddc8e5fb23e85ea71e7f03d44b1a3845305213] mmc: mxs-mmc: Enable MMC_=
CAP_ERASE
git bisect bad eeddc8e5fb23e85ea71e7f03d44b1a3845305213
# bad: [d6a6d722481f357eafe7b798fe6fdadd2f5ac6bd] mmc: dw_mmc-rockchip: Ena=
ble hardware unbusy interrupt support
git bisect bad d6a6d722481f357eafe7b798fe6fdadd2f5ac6bd
# first bad commit: [d6a6d722481f357eafe7b798fe6fdadd2f5ac6bd] mmc: dw_mmc-=
rockchip: Enable hardware unbusy interrupt support
---------------------------------------------------------------------------=
----
