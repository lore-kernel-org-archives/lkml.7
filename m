Return-Path: <SRS0=QHyQ=ZU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E34AC432C0
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Nov 2019 14:45:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2026A208E4
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Nov 2019 14:45:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726881AbfK1OpW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Nov 2019 09:45:22 -0500
Received: from mout.kundenserver.de ([212.227.17.10]:32973 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726545AbfK1OpV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Nov 2019 09:45:21 -0500
Received: from orion.localdomain ([95.117.37.214]) by mrelayeu.kundenserver.de
 (mreue107 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1MYvLi-1iN5TA1aOO-00UqEE; Thu, 28 Nov 2019 15:45:16 +0100
From:   "Enrico Weigelt, metux IT consult" <info@metux.net>
To:     linux-kernel@vger.kernel.org
Cc:     mturquette@baylibre.com, sboyd@kernel.org,
        linux-clk@vger.kernel.org
Subject: [PATCH 1/7] drivers: clk: unexport clk_register_gpio_gate()
Date:   Thu, 28 Nov 2019 15:44:44 +0100
Message-Id: <20191128144450.24094-1-info@metux.net>
X-Mailer: git-send-email 2.11.0
X-Provags-ID: V03:K1:ytzHB8lP63sR7iFpMp/kXfj5bC7FsWtA/SOrauIwrX+Okt4XuPp
 K35KQMKwjdqYlLN0YaVavNIi7frbhpRr+h7eCMM9a0rMhhOC1a3ecatgHO7DVT2M2e3CjxH
 FwcvrFpRruy54yxjNgInYjsiOcQOAAevSlLsShKRrmMajMPxzLvGS4bUI3ltofv3f9pEGNQ
 zKXshcr3iYR8KKHsB0a3g==
X-UI-Out-Filterresults: notjunk:1;V03:K0:xxU+PuowVDM=:1RF/mbqmtWkrcSnfqUxM2x
 JtxeMPVJVaQi8ufo25KmM+atvFzNaBwOTY0nxdRrqxA+sXThswHgC1pXvtH7Q9DUvJ+SYfT9B
 87ORJxBLs3H7alfLPFzmvSZ5VwSaWhSA0ZLsXwTZ9eCg3BTXxmwtIcn2+lGmweMCGXtdLn13V
 Z1ZKMD4O4yNzVjKlTkU5TfpYGdvSxRIYqawb76Zn1sVNE2pJqdGoFhnk/JdquLWWD4UnrhRut
 lcSGhVCBSVw8xKL115O2wsj082xVoxAN5+RIbA8fCEdTODzikUX/ejhvzAFYjSk8ytoRrmd5v
 BBI5Q9oHRfOgnJpmyrllQ/2q2/n8pJ9Ij8h8q8gI9yMXNajHHWsQlyak64vRVQrxO7/I1zMki
 dtiZ7YE1+BHlzzPYWMNUzyYi34U0B0m2a8LD5zaUfWDk2JrN13vrRt6ozsEQkyGIWxIXycVBB
 tyqYTWgx5qdJnWJx78w+NHQ5rut1X7pIgz2GIfK37UZ+aGS3jrMmBze2Y4dJTM8jcF7xOaA2p
 SfnPEPU9jAV6Tcjgsa5PqJDTGpmIcORg/zva14szzFRRvuy+qakGNUp1rb4wB+psCGtCRIOyC
 GISekHaP8YtvQ8ZjRzlRJ7WsA0yjMH4830YU4YTVHGt04ppWbsCm98+uYqkSa8XruG9aoVFBA
 Dn5aL2sQpGD88i9EYsZ9dGaEMIHkUV8o3DVV1n96WLt3Elf6HNxqfx7X16XCtiNzorXfTihR9
 8yvgX8de6jp6knOMoHpU9fRAiyqyuvVN448n1TJx/k1CUtSiG0yVLd558eSXUbCoFyqaNW/dt
 QJcqMKnYPby/f2Ac5Pv9MZOTgLAylJY0a1DS06k6c//hCx9vhnLvuzZrFlnBbfz1atIXGTArz
 PIUREeFZVhxciEj+rNXA==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The function clk_register_gpio_gate() doesn't seem to have any users
outside clk-gpio.c, thus unexport and make it static.

Signed-off-by: Enrico Weigelt, metux IT consult <info@metux.net>
---
 drivers/clk/clk-gpio.c       | 3 +--
 include/linux/clk-provider.h | 3 ---
 2 files changed, 1 insertion(+), 5 deletions(-)

diff --git a/drivers/clk/clk-gpio.c b/drivers/clk/clk-gpio.c
index 9d930edd6516..f9f81a31984a 100644
--- a/drivers/clk/clk-gpio.c
+++ b/drivers/clk/clk-gpio.c
@@ -186,7 +186,7 @@ struct clk_hw *clk_hw_register_gpio_gate(struct device *dev, const char *name,
 }
 EXPORT_SYMBOL_GPL(clk_hw_register_gpio_gate);
 
-struct clk *clk_register_gpio_gate(struct device *dev, const char *name,
+static struct clk *clk_register_gpio_gate(struct device *dev, const char *name,
 		const char *parent_name, struct gpio_desc *gpiod,
 		unsigned long flags)
 {
@@ -197,7 +197,6 @@ struct clk *clk_register_gpio_gate(struct device *dev, const char *name,
 		return ERR_CAST(hw);
 	return hw->clk;
 }
-EXPORT_SYMBOL_GPL(clk_register_gpio_gate);
 
 /**
  * clk_hw_register_gpio_mux - register a gpio clock mux with the clock framework
diff --git a/include/linux/clk-provider.h b/include/linux/clk-provider.h
index 2fdfe8061363..d283f9896e86 100644
--- a/include/linux/clk-provider.h
+++ b/include/linux/clk-provider.h
@@ -773,9 +773,6 @@ struct clk_gpio {
 #define to_clk_gpio(_hw) container_of(_hw, struct clk_gpio, hw)
 
 extern const struct clk_ops clk_gpio_gate_ops;
-struct clk *clk_register_gpio_gate(struct device *dev, const char *name,
-		const char *parent_name, struct gpio_desc *gpiod,
-		unsigned long flags);
 struct clk_hw *clk_hw_register_gpio_gate(struct device *dev, const char *name,
 		const char *parent_name, struct gpio_desc *gpiod,
 		unsigned long flags);
-- 
2.11.0

