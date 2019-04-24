Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CEB4C10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 07:16:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3EF0F20835
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 07:16:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="r+2Kj/VR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730066AbfDXHQX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 03:16:23 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:39846 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729543AbfDXHQW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 03:16:22 -0400
Received: by mail-pg1-f195.google.com with SMTP id l18so8789825pgj.6;
        Wed, 24 Apr 2019 00:16:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=cFWyauVHMRMhPdLJI2BgTJG8Dqk8sJtHkpOrVWo1TWo=;
        b=r+2Kj/VRRjRMppbQcgkvWYHrVcQigiDcz6vJl9rV4EfqsvTQRWdJlocMu2JlYbXrQN
         1N804w36cUOIWkihhhKh7QVLbdIdrwRHEfVUudIk7MZjLB6Cd6HO82QRpkR0HpTwfVN+
         W++PrIdcbxYFZabv7hfwOfJsgvW4FM6KRNbqWw0LByUpma1c/9qvYL75VqNIh8zK7wyy
         +iCOeaZmAHRjiiD4OH7DEdldLodEaVXt2ue3LDSh+intYykAij0Vm2prclo6KGDDmrpC
         Wxbbt46JNuTcx9NldOt+nPvWoced7TcPQsL3m1ufH4tUrhHZVwtmcKOoKzGXd5PMi0m8
         BEKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=cFWyauVHMRMhPdLJI2BgTJG8Dqk8sJtHkpOrVWo1TWo=;
        b=eKFqIgbvxvrC9WNCXpFD9ZSN9eS5IvhaOkNAnEpObgQmLbdHrADqN4r/DumWbxfC/6
         uhF9li41M7f0zlY7cwru0H3GtHbQD7WgnRDRCHFoCvEgTy/xFnnemmJ+JkAFkvHkc3s0
         EuAmd481vqDbrcncoM+BcMnMUuvqb1q7gZstXXJHTBN4L3dfOuD198ZJHfWu0Ldgbcjk
         Ee/QRwP481IvZlNSIEnswJfIcV+Fr0xIvfmF00DNCLcB1DHZuH8BdEbRA8cLQyx97jKT
         nLLB90yQxM6AZX1LeLjUgbU3GyHpzjBPZipS7EX7icEx47PJ3grdog8nQl66lGQsIFBU
         5mTA==
X-Gm-Message-State: APjAAAXscjAA7nSms4AY6BVX0R15C+szB6VK4hisGHz9vknlIWIyOows
        Gchkqi/Kmyap02o60p83FV4jA9XqLb4=
X-Google-Smtp-Source: APXvYqz7uB97zZH3de6DVQLA0w1ZtgCdo3tLgBOpKFilZaIr47oyOLt5sE7s7CAZsN8zMp9A2k7gGw==
X-Received: by 2002:a63:750c:: with SMTP id q12mr29287336pgc.133.1556090181729;
        Wed, 24 Apr 2019 00:16:21 -0700 (PDT)
Received: from squirtle.lan (c-24-22-235-96.hsd1.wa.comcast.net. [24.22.235.96])
        by smtp.gmail.com with ESMTPSA id h4sm18987701pgv.61.2019.04.24.00.16.20
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 24 Apr 2019 00:16:20 -0700 (PDT)
From:   Andrey Smirnov <andrew.smirnov@gmail.com>
To:     linux-pm@vger.kernel.org
Cc:     Andrey Smirnov <andrew.smirnov@gmail.com>,
        Chris Healy <cphealy@gmail.com>,
        Sebastian Reichel <sre@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2] power: supply: sysfs: prevent endless uevent loop with CONFIG_POWER_SUPPLY_DEBUG
Date:   Wed, 24 Apr 2019 00:16:10 -0700
Message-Id: <20190424071610.22688-1-andrew.smirnov@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix a similar endless event loop as was done in commit
8dcf32175b4e ("i2c: prevent endless uevent loop with
CONFIG_I2C_DEBUG_CORE"):

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
seems to have been fixed. Drop debug prints as it was done in I2C
subsystem to resolve the issue.

Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
Cc: Chris Healy <cphealy@gmail.com>
Cc: Sebastian Reichel <sre@kernel.org>
Cc: linux-pm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
---

Changes since [v1]:

    - Converted the patch to drop debug print statements
    
[v1] lore.kernel.org/lkml/20190405073020.10361-1-andrew.smirnov@gmail.com

 drivers/power/supply/power_supply_sysfs.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/drivers/power/supply/power_supply_sysfs.c b/drivers/power/supply/power_supply_sysfs.c
index dce24f596160..5358a80d854f 100644
--- a/drivers/power/supply/power_supply_sysfs.c
+++ b/drivers/power/supply/power_supply_sysfs.c
@@ -383,15 +383,11 @@ int power_supply_uevent(struct device *dev, struct kobj_uevent_env *env)
 	char *prop_buf;
 	char *attrname;
 
-	dev_dbg(dev, "uevent\n");
-
 	if (!psy || !psy->desc) {
 		dev_dbg(dev, "No power supply yet\n");
 		return ret;
 	}
 
-	dev_dbg(dev, "POWER_SUPPLY_NAME=%s\n", psy->desc->name);
-
 	ret = add_uevent_var(env, "POWER_SUPPLY_NAME=%s", psy->desc->name);
 	if (ret)
 		return ret;
@@ -427,8 +423,6 @@ int power_supply_uevent(struct device *dev, struct kobj_uevent_env *env)
 			goto out;
 		}
 
-		dev_dbg(dev, "prop %s=%s\n", attrname, prop_buf);
-
 		ret = add_uevent_var(env, "POWER_SUPPLY_%s=%s", attrname, prop_buf);
 		kfree(attrname);
 		if (ret)
-- 
2.20.1

