Return-Path: <SRS0=facv=24=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A074C282DD
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 21:28:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 57AA22080A
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 21:28:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729085AbgAGV2O (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jan 2020 16:28:14 -0500
Received: from mout.kundenserver.de ([212.227.17.24]:43877 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727569AbgAGV2H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jan 2020 16:28:07 -0500
Received: from threadripper.lan ([149.172.19.189]) by mrelayeu.kundenserver.de
 (mreue107 [212.227.15.145]) with ESMTPA (Nemesis) id
 1MGhi0-1itpwb2ZJS-00Dn1Q; Tue, 07 Jan 2020 22:27:51 +0100
From:   Arnd Bergmann <arnd@arndb.de>
To:     Thierry Reding <thierry.reding@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     Oleksandr Natalenko <oleksandr@redhat.com>,
        Arnd Bergmann <arnd@arndb.de>, Sam Ravnborg <sam@ravnborg.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Boris Brezillon <boris.brezillon@collabora.com>,
        Tomi Valkeinen <tomi.valkeinen@ti.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH] drm: panel: fix excessive stack usage in td028ttec1_prepare
Date:   Tue,  7 Jan 2020 22:27:33 +0100
Message-Id: <20200107212747.4182515-1-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:oXNXLfN/VIsDQFv/SJwQtBS570cMqOiIoOPgTiSj3Dsp8Mast6V
 a6nIAwxIdJ7QG8kqaKHVXD9UMVwHTrPE3j3Y3Y83ybDD2FhmplbMZohwEB70kjxFVxHmGZS
 pyNK70KcneApCD8axx8ajqRUB3eSiIPdg/sGcqYEA5Rl6QBHXZ6yOtpQvGO21SI63N0Rvrq
 2nsYRN5jI3BB6x6CtxvLw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:wybcYGCqFeU=:v6JPZuxuKq6KdDpZhERSQB
 IDxwXvZZ3iIThfYussrtVEboFQsYXSC7qEaAUE2XWaYfMkZWryLaflyAWfWUsATwXMg6kkTS4
 2fkNkoMGkNpx4MCKQifZ0nsPoKH47LK3qlyhSzjot+pm7dGqrUBzd3iRu8R5fefc2RZIZREic
 QWSvAKtAQWM4Ojyk1h0Cv/8n+0At0t7Wag+VUislcxZY83IZULPztI7gUxC9ZGxMgNMBZzerm
 C1FjL3xOW2Nxg609m+EefeTYjxDmVlKyYPjQgyfmSc2AJgMYU68YS05MCx13u5OZXBNWakZjl
 /KgJ+JOuDhchGWb7s+vpjoki5rPqogRFfpHTOzCH+e3z3DlaTrUMmhBWgYv4j8qnZ0dIAjChs
 4I/vpmANC2amo+pw4P/G/yZzXZS3X3vd/umZZfYB5e+bV2zPMLRhZKmYQiiaKFAbPNNpHrpKi
 gdKXp1DNdRwtC+mYFMVC9JPVQgmI8nSS6EjHfUbOFOaVjHwtkP79fOsjFMvY2ZL6aotERGia5
 qJJl0KLotFNKZuev7SN06GiCBcyLIHv04A8yRtwa5ZX1/EnLjygKqHOMtpZjmSH+RVCLfMu8F
 Qcj29MPNM33tUkq7Xj/XcC/l6vgOfoe7g11HPeEmG0uOuA4G+9PCOgjZgcoYfhdabasgvEtvG
 imdpeO5Eh/+GrUr9uEn4xRcNebjiNxHFMQtiFCb8D5OP2Vp3CdiGY4qYvlMszQWLo5vk/Mgby
 DATbiwe4fFXaHGDfofaqzQudl4XduR+bPZFgTm+Ggp36Sc1O3ogVU69gSKhZ89G4deJiSt+i5
 X+8wsPqcTE9MHwxukKoezId5n8vFNAxzQx+tEcRaHTBRmfj1FiOVfaxLtGvlOlJIvvLEGeQAk
 3guOx3RvjSFld8FR+sHQ==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With gcc -O3, the compiler can inline very aggressively,
leading to rather large stack usage:

drivers/gpu/drm/panel/panel-tpo-td028ttec1.c: In function 'td028ttec1_prepare':
drivers/gpu/drm/panel/panel-tpo-td028ttec1.c:233:1: error: the frame size of 2768 bytes is larger than 2048 bytes [-Werror=frame-larger-than=]
 }

Marking jbt_reg_write_1() as noinline avoids the case where
multiple instances of this function get inlined into the same
stack frame and each one adds a copy of 'tx_buf'.

Fixes: mmtom ("init/Kconfig: enable -O3 for all arches")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/gpu/drm/panel/panel-tpo-td028ttec1.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/panel/panel-tpo-td028ttec1.c b/drivers/gpu/drm/panel/panel-tpo-td028ttec1.c
index cf29405a2dbe..17ee5e87141f 100644
--- a/drivers/gpu/drm/panel/panel-tpo-td028ttec1.c
+++ b/drivers/gpu/drm/panel/panel-tpo-td028ttec1.c
@@ -105,7 +105,7 @@ static int jbt_ret_write_0(struct td028ttec1_panel *lcd, u8 reg, int *err)
 	return ret;
 }
 
-static int jbt_reg_write_1(struct td028ttec1_panel *lcd,
+static int noinline_for_stack jbt_reg_write_1(struct td028ttec1_panel *lcd,
 			   u8 reg, u8 data, int *err)
 {
 	struct spi_device *spi = lcd->spi;
-- 
2.20.0

