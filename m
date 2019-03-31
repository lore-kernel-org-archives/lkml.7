Return-Path: <SRS0=KwB+=SC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0059C4360F
	for <linux-kernel@archiver.kernel.org>; Sun, 31 Mar 2019 17:43:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 905FE20870
	for <linux-kernel@archiver.kernel.org>; Sun, 31 Mar 2019 17:43:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="q4WSiAVo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731471AbfCaRnD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 31 Mar 2019 13:43:03 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:40642 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731412AbfCaRm7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 Mar 2019 13:42:59 -0400
Received: by mail-wr1-f67.google.com with SMTP id h4so8856036wre.7;
        Sun, 31 Mar 2019 10:42:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=bxkqS9NXBUeMNBk7cq1r32ArnpGuXeZStCmBh0FzFzg=;
        b=q4WSiAVorX8MhyT3yFpRja/c1CsBea1K+gQcqwE/hgm2jTRoHCC05yHXUGThcE3i+5
         PDTqYtRMB9upYV7IvWQQVoceItIAnhSMJvBF/0Kpk8iriTn1eCTo/BSXWv0zjOZLrI0d
         vjSBhWpfeWdV/zVBSu2Cw7212RYpUaRG+Lahxmr1OUXSC0uiSVkbknd37LJtOuWUcnnw
         z5YGdOb7/nlEKYLlQCRV/K3l2wZ6TaSuaG2xlc5VD+1P3Pvqfya3byVZHIDQemgUvb+L
         RFQne32oIPCwjtUAmMyr/XTpMFu3NePlhSQXQsC0BxeEp0a8m8+97lqaZXD72Dw8+D4w
         8JuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=bxkqS9NXBUeMNBk7cq1r32ArnpGuXeZStCmBh0FzFzg=;
        b=VjrVQQ9Mep8LCjOG68oQP7Y1JL2kdLuD8N+qYZIJCLkGX9o7FPG9wxkTAYwqm+I1mM
         +AkkXD2cyAJg+abnbHJ41ZeM/VgBtgqu9CvBVsA2sJWAdFCQ2j+77ixivzzSApUKIMG7
         nrhsx6WkDicuTp26jt6MlS1FsP8gKejIwKrnxM0DtqtRZNGfvuJqxY1wsdQm3IF6FSrY
         A9Qf6xmc9VwQtI0NPPY7MqQndSoT2IwcmDC7CdHIWSJP4iJB+8+N+JJi17E0OjZS5dU3
         WRD6VSmlMsruVcRYm8wdNzBzKLWmDXndjiSCTHQKclHASe4UJ9x0iMCmDJHwusWezB/O
         1SKw==
X-Gm-Message-State: APjAAAXqt/1fYVsB/u/ze3Ah444YtTqsY11EgpclK23jIeJtmc0wRuuU
        +IkU8KigCiSgr5ZgSUqrlIg=
X-Google-Smtp-Source: APXvYqzu5KhOLcZtUUgOafHxSan8lfmjMgj3JuUE2xMFX6hs1TD5JBVb9BAiLJUhn8yVwANawNclwg==
X-Received: by 2002:adf:e506:: with SMTP id j6mr29812359wrm.41.1554054177234;
        Sun, 31 Mar 2019 10:42:57 -0700 (PDT)
Received: from localhost.localdomain (5-12-225-227.residential.rdsnet.ro. [5.12.225.227])
        by smtp.gmail.com with ESMTPSA id v192sm10892354wme.24.2019.03.31.10.42.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 31 Mar 2019 10:42:56 -0700 (PDT)
From:   Vladimir Oltean <olteanv@gmail.com>
To:     f.fainelli@gmail.com, vivien.didelot@gmail.com, andrew@lunn.ch,
        davem@davemloft.net
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        linus.walleij@linaro.org, georg.waibel@sensor-technik.de,
        Vladimir Oltean <olteanv@gmail.com>
Subject: [PATCH net-next 06/17] net: dsa: Call driver's setup callback after setting up its switchdev notifier
Date:   Sun, 31 Mar 2019 20:42:21 +0300
Message-Id: <20190331174232.22060-7-olteanv@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190331174232.22060-1-olteanv@gmail.com>
References: <20190331174232.22060-1-olteanv@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This allows the driver to perform some manipulations of its own during
setup, using generic code.
One current usage scenario is for the driver to request DSA to set up
802.1Q based switch tagging for its ports.

Signed-off-by: Vladimir Oltean <olteanv@gmail.com>
Reviewed-by: Florian Fainelli <f.fainelli@gmail.com>
---
 net/dsa/dsa2.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/net/dsa/dsa2.c b/net/dsa/dsa2.c
index c00ee464afc7..5beceb18b7e2 100644
--- a/net/dsa/dsa2.c
+++ b/net/dsa/dsa2.c
@@ -360,14 +360,14 @@ static int dsa_switch_setup(struct dsa_switch *ds)
 	if (err)
 		return err;
 
-	err = ds->ops->setup(ds);
-	if (err < 0)
-		return err;
-
 	err = dsa_switch_register_notifier(ds);
 	if (err)
 		return err;
 
+	err = ds->ops->setup(ds);
+	if (err < 0)
+		return err;
+
 	if (!ds->slave_mii_bus && ds->ops->phy_read) {
 		ds->slave_mii_bus = devm_mdiobus_alloc(ds->dev);
 		if (!ds->slave_mii_bus)
-- 
2.17.1

