Return-Path: <SRS0=91bA=RH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 260E3C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 19:38:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EED782070B
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 19:38:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726233AbfCDTiv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Mar 2019 14:38:51 -0500
Received: from mout.kundenserver.de ([217.72.192.73]:51421 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726061AbfCDTiv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Mar 2019 14:38:51 -0500
Received: from wuerfel.lan ([109.192.41.194]) by mrelayeu.kundenserver.de
 (mreue108 [212.227.15.145]) with ESMTPA (Nemesis) id
 1MV6Bs-1gZpqD1spy-00SBO9; Mon, 04 Mar 2019 20:38:39 +0100
From:   Arnd Bergmann <arnd@arndb.de>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>
Cc:     Joseph Lo <josephl@nvidia.com>, Arnd Bergmann <arnd@arndb.de>,
        Douglas Anderson <dianders@chromium.org>,
        Javier Martinez Canillas <javierm@redhat.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] regulator: add regulator_get_linear_step() stub helper
Date:   Mon,  4 Mar 2019 20:38:29 +0100
Message-Id: <20190304193836.687473-1-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:QF9xFjS61cs6qTXNG1v/VSVuwsR/exTDfz0RJyZ49wR4KnR39l0
 pVSKthku/csV7vWfOhXHgpR25lHjfQjtfovBkOK5a38IClzhBZ6tk6+HyITun3hqGSVDDCI
 d060X0OQj/PaUItaCKA4dUT68gv1+V3G+AP4s+8VvVl+uf8UKNm6YBvp7Bcczj2aDXm9oL8
 byKiPTkrHBNxhYkoPyJ/Q==
X-UI-Out-Filterresults: notjunk:1;V03:K0:n70Uf+NhApY=:l3EVPdQ7HcqN9r75rlyzO+
 i0BC0BjxqcFXDtXM7zQc2Do7KWgAHjVQy6yQHPrYfq82vxm8emmbmtmc/jsnqTZQYw8WKcc2v
 o6yQy8+8M2wp3GvSSfGjTCAu4pqdedJbrHwGcl4vUh2aIXzf/vFfKcPytIQi5/qxWnHcgUGU4
 Cq2WTyemPC7uBFYvo/tich960wTEAPJ5rjigZtU1SPOoCrN24zEg2soOW33kblt2VdI+5VU/M
 HOkOBdPTURj+Bb69S6Eb8sp1gyyUxkqgQ7EJJPezt8k2VVxYazKiIQAYRMAoo5WL+ADiuoJG5
 054B7emkb9ZHyS84qWj9Q+tfSlYdiy0VoEjw7WyQg564plAtUdxxtRVzL3+yqsSlZjaLZMWRo
 vohlSOe3dB8NLhMFjy41ohuEZR7zPeJXHxW8gCsBHEQHcMJ4MtyjEH5AOAX6i2Daplx0gxD0O
 jaVkR6eg1V1xwIqGAaNRVpzjA7Jkz63Ko2W2XVx5G3XSBWVQvOGpTJuyo/sxDDwA2iHQSRgxF
 xnGw43GCAsRACmO+CoeqE7SM5XU06x3D2HqTYRIZP2QyngUbijH49xwxv1bgvrCH+L2epGGgu
 orHpCxzupG6nY+EirjwEaMgLlwSart9owTsjXdpZV2ipojsAEGPiudrYi8NBvMODinuBS2j82
 Q9VX7bcqG/0++HOi4dn9LS3VXlc6WlrCnVoY/2iq6czCZ+J4icaXo3COUHZH0HkhV0UQnAlRG
 EdtN6vg5hERKUfVFI/zw8RAZY1I8RPNisu8WjQ==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The regulator header has empty inline functions for most interfaces,
but not regulator_get_linear_step(), which has just grown a user
that does not depend on regulators otherwise:

drivers/clk/tegra/clk-tegra124-dfll-fcpu.c: In function 'get_alignment_from_regulator':
drivers/clk/tegra/clk-tegra124-dfll-fcpu.c:555:19: error: implicit declaration of function 'regulator_get_linear_step'; did you mean 'regulator_get_drvdata'? [-Werror=implicit-function-declaration]
  align->step_uv = regulator_get_linear_step(reg);
                   ^~~~~~~~~~~~~~~~~~~~~~~~~
                   regulator_get_drvdata
cc1: all warnings being treated as errors
scripts/Makefile.build:278: recipe for target 'drivers/clk/tegra/clk-tegra124-dfll-fcpu.o' failed

Add the missing stub along the others.

Fixes: b3cf8d069505 ("clk: tegra: dfll: CVB calculation alignment with the regulator")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 include/linux/regulator/consumer.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/include/linux/regulator/consumer.h b/include/linux/regulator/consumer.h
index f3f76051e8b0..aaf3cee70439 100644
--- a/include/linux/regulator/consumer.h
+++ b/include/linux/regulator/consumer.h
@@ -478,6 +478,11 @@ static inline int regulator_is_supported_voltage(struct regulator *regulator,
 	return 0;
 }
 
+static inline unsigned int regulator_get_linear_step(struct regulator *regulator)
+{
+	return 0;
+}
+
 static inline int regulator_set_current_limit(struct regulator *regulator,
 					     int min_uA, int max_uA)
 {
-- 
2.20.0

