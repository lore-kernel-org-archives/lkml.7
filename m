Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7A46C10F14
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 15:00:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E95620652
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 15:00:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="hFSnZtrh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729770AbfDPPAb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 11:00:31 -0400
Received: from mout.gmx.net ([212.227.17.22]:56513 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729872AbfDPPAP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 11:00:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1555426751;
        bh=Y8YBUeQRMwzr7J9CrhokVN2JmnDLZgiR6/FvJ8s0awA=;
        h=X-UI-Sender-Class:From:To:Subject:Date:In-Reply-To:References;
        b=hFSnZtrhJMFyrkK+OSxZKbZteH751XTq6PflO4v0YcuSASZUH2TtO0xLW287EFMMn
         rTdbm8p8VlG45xwHNIvqRb8fiDOUv0Srpt4y7QXORrv0uQxqPUOwTkAhKyw4ImRLMW
         yAnOlcvey2JUxg6r48gBmZxZawsKBabbuuxQtiV0=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from localhost.localdomain ([185.53.43.193]) by mail.gmx.com
 (mrgmx102 [212.227.17.168]) with ESMTPSA (Nemesis) id
 0LsOsW-1grxln1gwy-01242I; Tue, 16 Apr 2019 16:59:11 +0200
From:   Frank Wunderlich <frank-w@public-files.de>
To:     CK Hu <ck.hu@mediatek.com>, Philipp Zabel <p.zabel@pengutronix.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org, chunhui dai <chunhui.dai@mediatek.com>,
        Ryder Lee <ryder.lee@mediatek.com>,
        Bibby Hsieh <bibby.hsieh@mediatek.com>
Subject: [PATCH v1 4/4] drm/mediatek: fix possible_crtcs
Date:   Tue, 16 Apr 2019 16:58:48 +0200
Message-Id: <20190416145848.11932-5-frank-w@public-files.de>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190416145848.11932-1-frank-w@public-files.de>
References: <20190416145848.11932-1-frank-w@public-files.de>
X-Provags-ID: V03:K1:9GPlP7IlVWKnFgYWpkxNnSyxoKqbdPAOhYPuzOGEhvtnm/dnvDc
 u0aZ6E09ZQ+c0lL/CBmKiBqESl128QUe38K6t0MlPeCuzA8eJMORcnnA2iNslAeyJ+0Z2lC
 I36MEpQImXtGi5bdpUsnPLatQQ8f2w+RitysYEOi3Q7SqESYkKXRwwvHzoL8heMo24QY9+D
 Fe0s0ddS+mVFkZU3RW9HQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:DkHhuo31RME=:aT6nZd241Pbf2Q68hLlW5Q
 1sAycQMEUyvfRYBu4tlZaNvCtCuyAnZbrQQuyVX81aFSGpUquUUN6fRq4lAJT7jxJS3/hl2aA
 g5RNwVqDuHudo05/VFmXaanMGZyKwuNObCl3GxKV8NV9XTkse1pgh60qgWoPS+R5i8HhqF5Kf
 BwTMV/O8oLLr2NwMcW+bXaPfhrVKAddPONP92fUnKylRCyjME983xSEuiHUW/AhXv7Bh7e8yM
 09t04hA8w6D8BNYRGegwiLNgbwwaDVEA9H2LcNLLruJt+wOtqg5aE2vFxd0KFpD4HV/30uTBk
 qiVYr0qL2pyrZoFVrE2Gu2UufFua6WflqO0TYtmh5fV9N8c7ppXTSHY64QsFf5LETAR3ViORq
 FVoO0l+tIZwcub6ou0AyT4jr+t8cO41us/x5CpIhYHb5R5N4Kt2Imnmpk0cKXVHlKY1p35Fit
 s19b+9kgE2x6nJM/8TnlzVYYYMnBlObiQf8b3+hNy5wtnS7KHuliRKgBFH0wGwIRz2EtUZ1ZP
 FQo8o5f51FhsuaG6ZWnhP0kmRjzkSkcsWBQF9LDGQ2Ruy0b0Qh6nvFWrApGQ26AJ+MgdNNtWe
 +/axL6j6a6WYY7De1RV6bmP/015ZRIwi7xaRF8FnNFdeG4jqQpEhqSX5IYYyTcSMPtzvX0nCC
 e6isWms/iHqothv3VHKqBYZLfD45U5agN+H8uT4i7fJB4aIedctt7F7FQIkIC/rVJs7V8i3ql
 8L8hXJJVQfzfIOvshcrnMMdjr/v/gxp9wxyXogrdSPTVPI08xgxZgxNtmSC9u3W4GX/5GjVKo
 0kBLVvAPwyCWV6CtN2g17Db0kbiaS3IayyPYoI6i7xKEzbym9xiUVcIv1Va60FUod0bQEw+3P
 BVnZ3htBKHknyboSs6oIl+Oy8AHyuRrI63jYsOAq8heGlSLETeZNJGk+Pfxvdm
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ryder Lee <ryder.lee@mediatek.com>

without this patch there is purple stretched font on fbconsole

source: http://forum.banana-pi.org/t/kernel-4-19-rc1-for-testers/6618/52

Signed-off-by: Ryder Lee <ryder.lee@mediatek.com>
Tested-by: Frank Wunderlich <frank-w@public-files.de>
=2D--
 drivers/gpu/drm/mediatek/mtk_dpi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/mediatek/mtk_dpi.c b/drivers/gpu/drm/mediatek=
/mtk_dpi.c
index 5d333138f913..c171b01f77e0 100644
=2D-- a/drivers/gpu/drm/mediatek/mtk_dpi.c
+++ b/drivers/gpu/drm/mediatek/mtk_dpi.c
@@ -610,7 +610,7 @@ static int mtk_dpi_bind(struct device *dev, struct dev=
ice *master, void *data)
 	drm_encoder_helper_add(&dpi->encoder, &mtk_dpi_encoder_helper_funcs);

 	/* Currently DPI0 is fixed to be driven by OVL1 */
-	dpi->encoder.possible_crtcs =3D BIT(1);
+	dpi->encoder.possible_crtcs =3D BIT(0)|BIT(1);

 	ret =3D drm_bridge_attach(&dpi->encoder, dpi->bridge, NULL);
 	if (ret) {
=2D-
2.17.1

