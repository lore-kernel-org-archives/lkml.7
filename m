Return-Path: <SRS0=EIds=SH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4610C4360F
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 07:30:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B336D2175B
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 07:30:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fdhnNrTQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730242AbfDEHae (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Apr 2019 03:30:34 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:34708 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726594AbfDEHae (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Apr 2019 03:30:34 -0400
Received: by mail-pl1-f194.google.com with SMTP id y6so2574455plt.1;
        Fri, 05 Apr 2019 00:30:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=VOrnHXSxYndVz4s82/4h/nLN4u1uE1Ep10yXCThvdm0=;
        b=fdhnNrTQsWoBprPQFsOKO0qtUwHG1MALvjx54XZ4ZDabC4VsHr4sXxQPV90cIRKB9S
         A4HyhnKuxvjDnkM3cp1izfJgnMdcFr9k28jxQRmwsMC0UzyCII1DXGHss/V0aGqdY1zt
         6PtNxys4pXN4QL/XaN1X50ia2k7LvxjKcnJRQ55hUK9uVUtaryGaMwJTTQaph1t5LZQA
         Tn4vuE9TokRhh57oR2/TN3FLM09Eul0Q8a19O1WyhOIFa2pT6315GT4kpSBBN3NYLtu8
         MO5XPG7SVC7R083C5LJLCfm+OE+PFVZu+2QvwsSpTZvNmPKqev6KBD1dS25gx86ZRacX
         09UQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=VOrnHXSxYndVz4s82/4h/nLN4u1uE1Ep10yXCThvdm0=;
        b=AAMfriRX9bb7qY3zLkWltwx9hxFLjJ0GLXqrb9DH5HFIFMq1MfnMrScRL1SNubVGSm
         EKHblA2lCH2QY2e8gZHonlqr9TY82gLKTJj50FcOu6L/MEFjZDph2WOxQlz11CrKzJjN
         YUp+XfulwKKtojiYu7SxO41xGRNg4JJIy1/0MNRwj0pe8VSHCj427xR65kvyKPuUqhlA
         a6uscrkJxvNBjxqdoNekf+2utAwjD/DjMcLpWqMKumWa04WeK0DPRY3HoTcj59Pld4Sm
         zQuYuO9Nkc1CNY9CQHYJBwhQkU22TNjQT5nEtkT1KwqOjO1oCIMMsIbLGB2GvsW6fM/6
         DW4A==
X-Gm-Message-State: APjAAAXc4OfbesTng0odgFRzBdpVlE2fL5pBl6gnBjSChV/BtWc/ZMY8
        DBShbj+kzyU1/1/jXDroG+E=
X-Google-Smtp-Source: APXvYqy6cMT4BHanKoFfkkZ4mv5VUjuezy/ovsrrzAUBs16QcxyaNtZOtHBBCxosKXxoz/z1+fPluw==
X-Received: by 2002:a17:902:b407:: with SMTP id x7mr11503526plr.288.1554449433145;
        Fri, 05 Apr 2019 00:30:33 -0700 (PDT)
Received: from squirtle.lan (c-24-22-235-96.hsd1.wa.comcast.net. [24.22.235.96])
        by smtp.gmail.com with ESMTPSA id u5sm17042269pfm.121.2019.04.05.00.30.31
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 05 Apr 2019 00:30:32 -0700 (PDT)
From:   Andrey Smirnov <andrew.smirnov@gmail.com>
Cc:     Andrey Smirnov <andrew.smirnov@gmail.com>,
        Chris Healy <cphealy@gmail.com>,
        Sebastian Reichel <sre@kernel.org>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] power: supply: sysfs: prevent endless uevent loop with CONFIG_POWER_SUPPLY_DEBUG
Date:   Fri,  5 Apr 2019 00:30:20 -0700
Message-Id: <20190405073020.10361-1-andrew.smirnov@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix a similar endless event loop as was done in commit 8dcf32175b4e
("i2c: prevent endless uevent loop with CONFIG_I2C_DEBUG_CORE"):

  The culprit is the dev_dbg printk in the i2c uevent handler. If
  this is activated (for instance by CONFIG_I2C_DEBUG_CORE) it results
  in an endless loop with systemd-journald.

  This happens if user-space scans the system log and reads the uevent
  file to get information about a newly created device, which seems
  fair use to me. Unfortunately reading the "uevent" file uses the
  same function that runs for creating the uevent for a new device,
  generating the next syslog entry

Both CONFIG_I2C_DEBUG_CORE and CONFIG_POWER_SUPPLY_DEBUG were reported
in https://bugs.freedesktop.org/show_bug.cgi?id=76886 but only former
seems to have been fixed. Change debug prints to use pr_debug insted
to resolve the issue.

Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
Cc: Chris Healy <cphealy@gmail.com>
Cc: Sebastian Reichel <sre@kernel.org>
Cc: linux-pm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
---
 drivers/power/supply/power_supply_sysfs.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/power/supply/power_supply_sysfs.c b/drivers/power/supply/power_supply_sysfs.c
index dce24f596160..5e91946731fd 100644
--- a/drivers/power/supply/power_supply_sysfs.c
+++ b/drivers/power/supply/power_supply_sysfs.c
@@ -383,14 +383,14 @@ int power_supply_uevent(struct device *dev, struct kobj_uevent_env *env)
 	char *prop_buf;
 	char *attrname;
 
-	dev_dbg(dev, "uevent\n");
+	pr_debug("%s: uevent\n", dev_name(dev));
 
 	if (!psy || !psy->desc) {
 		dev_dbg(dev, "No power supply yet\n");
 		return ret;
 	}
 
-	dev_dbg(dev, "POWER_SUPPLY_NAME=%s\n", psy->desc->name);
+	pr_debug("%s: POWER_SUPPLY_NAME=%s\n", dev_name(dev), psy->desc->name);
 
 	ret = add_uevent_var(env, "POWER_SUPPLY_NAME=%s", psy->desc->name);
 	if (ret)
@@ -427,7 +427,8 @@ int power_supply_uevent(struct device *dev, struct kobj_uevent_env *env)
 			goto out;
 		}
 
-		dev_dbg(dev, "prop %s=%s\n", attrname, prop_buf);
+		pr_debug("%s: prop %s=%s\n", dev_name(dev), attrname,
+			 prop_buf);
 
 		ret = add_uevent_var(env, "POWER_SUPPLY_%s=%s", attrname, prop_buf);
 		kfree(attrname);
-- 
2.20.1

