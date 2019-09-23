Return-Path: <SRS0=bmbz=XS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D15BCC3A5A6
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Sep 2019 14:20:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A81B620820
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Sep 2019 14:20:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b="abcoxhvN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407481AbfIWOUN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Sep 2019 10:20:13 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:36434 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2407008AbfIWOUN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Sep 2019 10:20:13 -0400
Received: by mail-lj1-f196.google.com with SMTP id v24so13925167ljj.3
        for <linux-kernel@vger.kernel.org>; Mon, 23 Sep 2019 07:20:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Cn9/9Me6Kmp4Xn9AfJMQMku3qxEXOlFZIGtDmEDrJpc=;
        b=abcoxhvNE4QzsWdjpcm4fIk+YAxDnJvfoFRGb46mpPwEFg0aOpeJ0eaheg3tZgT4ZG
         ojpl8m/oDAh+qYbzYsIcSeNXc5m5DY3mfdWvxLXTBeWP7wfLsaIXItCLI6UZUPW+vtJ1
         VGOT858b8NEkfBIvrgsoW5+e3A7n18FZCZM84=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Cn9/9Me6Kmp4Xn9AfJMQMku3qxEXOlFZIGtDmEDrJpc=;
        b=LAtc8ShgXk2+0UKtsHYeivajA3MhggtFWOJi6VA/piH+qHMeBPhcfjn+W/nDoll6WD
         AMZDUx4moceBEnSsLG3oofO4KU979FnzuXFGSUeHnmfHM81ApXPz6Ddx43KO7Vcm1ygu
         daHdw9601BUvAfUeIca34Ogt+JbkV8Id/9l8U95nPB8a7VNomKa7V2sF07NoN43vwBpz
         qZKF3lqUjN73CWOnpCmfmht+mpnS5yflrwNAzirt0YbgoHNQrjO8bmzYpmcU/xc+UkhE
         DKW6vs0w5IMHaRmw8tDAAkMcbor3jrlVxewfjlaRIGX0QOO6XDRih5/gLCXchiQoCJNd
         tVjg==
X-Gm-Message-State: APjAAAUprvBtbLKeNA4YCS84MeOXMA05jQm7BnRMVAI2Ph9ZbSYhr8tm
        bJhdKyC+MwpIcjG3xqjbk29UuyCZ+X7So4nV
X-Google-Smtp-Source: APXvYqy+Ki9LgN+TwomD1Y4hGoRYgJaAEevteVNzRvde3/6GQAoELKo5qYA33O6wCDX/Pq8W4P59VQ==
X-Received: by 2002:a2e:3902:: with SMTP id g2mr17815555lja.196.1569248411411;
        Mon, 23 Sep 2019 07:20:11 -0700 (PDT)
Received: from prevas-ravi.prevas.se ([81.216.59.226])
        by smtp.gmail.com with ESMTPSA id b21sm2230125lff.96.2019.09.23.07.20.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Sep 2019 07:20:10 -0700 (PDT)
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Tony Lindgren <tony@atomide.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] pinctrl: devicetree.c: remove orphan pinctrl_dt_has_hogs()
Date:   Mon, 23 Sep 2019 16:20:05 +0200
Message-Id: <20190923142005.5632-1-linux@rasmusvillemoes.dk>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The helper pinctrl_dt_has_hogs() was introduced in
99e4f67508e1 (pinctrl: core: Use delayed work for hogs), but the sole
use then got removed shortly after in 950b0d91dc10 (pinctrl: core: Fix
regression caused by delayed work for hogs).

Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
---
 drivers/pinctrl/devicetree.c | 15 ---------------
 drivers/pinctrl/devicetree.h |  7 -------
 2 files changed, 22 deletions(-)

diff --git a/drivers/pinctrl/devicetree.c b/drivers/pinctrl/devicetree.c
index 5d6d8b1e9062..6716a406d128 100644
--- a/drivers/pinctrl/devicetree.c
+++ b/drivers/pinctrl/devicetree.c
@@ -166,21 +166,6 @@ static int dt_remember_dummy_state(struct pinctrl *p, const char *statename)
 	return dt_remember_or_free_map(p, statename, NULL, map, 1);
 }
 
-bool pinctrl_dt_has_hogs(struct pinctrl_dev *pctldev)
-{
-	struct device_node *np;
-	struct property *prop;
-	int size;
-
-	np = pctldev->dev->of_node;
-	if (!np)
-		return false;
-
-	prop = of_find_property(np, "pinctrl-0", &size);
-
-	return prop ? true : false;
-}
-
 int pinctrl_dt_to_map(struct pinctrl *p, struct pinctrl_dev *pctldev)
 {
 	struct device_node *np = p->dev->of_node;
diff --git a/drivers/pinctrl/devicetree.h b/drivers/pinctrl/devicetree.h
index 00e645d7fac7..efa80779de4f 100644
--- a/drivers/pinctrl/devicetree.h
+++ b/drivers/pinctrl/devicetree.h
@@ -9,8 +9,6 @@ struct of_phandle_args;
 
 #ifdef CONFIG_OF
 
-bool pinctrl_dt_has_hogs(struct pinctrl_dev *pctldev);
-
 void pinctrl_dt_free_maps(struct pinctrl *p);
 int pinctrl_dt_to_map(struct pinctrl *p, struct pinctrl_dev *pctldev);
 
@@ -23,11 +21,6 @@ int pinctrl_parse_index_with_args(const struct device_node *np,
 
 #else
 
-static inline bool pinctrl_dt_has_hogs(struct pinctrl_dev *pctldev)
-{
-	return false;
-}
-
 static inline int pinctrl_dt_to_map(struct pinctrl *p,
 				    struct pinctrl_dev *pctldev)
 {
-- 
2.20.1

