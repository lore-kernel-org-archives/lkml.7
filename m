Return-Path: <SRS0=nVcb=SO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE809C10F0E
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 15:47:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B879B2082E
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 15:47:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YV/7RsyS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726965AbfDLPr5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Apr 2019 11:47:57 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:44284 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726780AbfDLPr5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Apr 2019 11:47:57 -0400
Received: by mail-wr1-f67.google.com with SMTP id y7so12536328wrn.11
        for <linux-kernel@vger.kernel.org>; Fri, 12 Apr 2019 08:47:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=qA/BJVGjRSgajnaAeGRIgkABV2iBnM8mp3jSv7HGbyA=;
        b=YV/7RsySjgKOq4iNlkHs4raksqmAM+zq/j16am7WgqZ6hIVx4Y3tGcDKLfG6i/EXPO
         Z494asw2Q91CPefqMEmyKkh/rYobFg8Ul5PUt8a+j6lPXLPWeiqQmO6Q2t+yE8IeJzRm
         +Y7fDaLIMEnc0HoBn8bRCvEIEkCYZc5eYk+z0B1Zd/dmQjQH5FeUVVqOOQn1Ndydemtv
         oEaswashiF1pGh/vKLaY0z0sHtjzVorNM42rftu8TsKC2MDLkTFlBGGOoO8g00556+mC
         6SKRWqhNCg9Wz78lZ3YqsqzbtC4GpvemKCR1x0ggBrZHMWUSPD9y3eRy7rno2kJOa5hy
         qrig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=qA/BJVGjRSgajnaAeGRIgkABV2iBnM8mp3jSv7HGbyA=;
        b=QAtPryPiep4ElPT8wZC1ZTI2dg+zCddmtpZtOpOCzX16LBg8S4p9pIWUVwO62MwkSb
         0101uuG3iwuPQHlevzwmSLSLv5OO/b7WsHNoRFVDTiv2EEQbKGyxcOhKzL4oKiPbSoZf
         xCYVqDOuYh4sxa85DbJAcDMP/VefJ/G6DF9SgWD9Y2FAKhlCLTBE/+StDw135wo9bqn1
         UWG7qseij60cY20lCV9g+T9VN1MSrgjJ/Ttcx5tkOZ7XeaoxZYC7OLDG6341Db24zUdj
         BaPQma1IE+sDJUnUOyASAniicl5bMEVctc12Wbyew8UXbeNeL3MxRI3nJpWJiKfMLSML
         emyQ==
X-Gm-Message-State: APjAAAVFv76An+FgDMwK9gwVAy1RxoPC67KkyMcAqFugB0V8oBiH2307
        AImXzadU4XI7RYXumB83qn8=
X-Google-Smtp-Source: APXvYqz5Q+air5AmS/OnJwhXOeWRLvX9EUkTjb13ZS1xGcQ3xEcp2V3K7DtNEKT9zuOINallux+xng==
X-Received: by 2002:adf:ea81:: with SMTP id s1mr15793264wrm.277.1555084075242;
        Fri, 12 Apr 2019 08:47:55 -0700 (PDT)
Received: from macpro-scc.lancs.ac.uk (inc028000049.lancs.ac.uk. [148.88.224.78])
        by smtp.gmail.com with ESMTPSA id d7sm10459704wmf.31.2019.04.12.08.47.54
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 12 Apr 2019 08:47:54 -0700 (PDT)
Date:   Fri, 12 Apr 2019 16:47:54 +0100
From:   Willy Wolff <willy.mh.wolff.ml@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] driver core: printk to pr_*
Message-ID: <20190412154753.ouafktmagb3sw6gj@macpro-scc.lancs.ac.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Willy Wolff <willy.mh.wolff.ml@gmail.com>
---
 drivers/base/dd.c | 18 ++++++++----------
 1 file changed, 8 insertions(+), 10 deletions(-)

diff --git a/drivers/base/dd.c b/drivers/base/dd.c
index a823f469e53f..1bc4557a0f49 100644
--- a/drivers/base/dd.c
+++ b/drivers/base/dd.c
@@ -328,7 +328,7 @@ bool device_is_bound(struct device *dev)
 static void driver_bound(struct device *dev)
 {
 	if (device_is_bound(dev)) {
-		printk(KERN_WARNING "%s: device %s already bound\n",
+		pr_warn("%s: device %s already bound\n",
 			__func__, kobject_name(&dev->kobj));
 		return;
 	}
@@ -494,8 +494,8 @@ static int really_probe(struct device *dev, struct device_driver *drv)
 	}
 
 	if (driver_sysfs_add(dev)) {
-		printk(KERN_ERR "%s: driver_sysfs_add(%s) failed\n",
-			__func__, dev_name(dev));
+		pr_err("%s: driver_sysfs_add(%s) failed\n",
+		       __func__, dev_name(dev));
 		goto probe_failed;
 	}
 
@@ -575,9 +575,8 @@ static int really_probe(struct device *dev, struct device_driver *drv)
 		break;
 	default:
 		/* driver matched but the probe failed */
-		printk(KERN_WARNING
-		       "%s: probe of %s failed with error %d\n",
-		       drv->name, dev_name(dev), ret);
+		pr_warn("%s: probe of %s failed with error %d\n",
+			drv->name, dev_name(dev), ret);
 	}
 	/*
 	 * Ignore errors returned by ->probe so that the next driver can try
@@ -602,8 +601,8 @@ static int really_probe_debug(struct device *dev, struct device_driver *drv)
 	ret = really_probe(dev, drv);
 	rettime = ktime_get();
 	delta = ktime_sub(rettime, calltime);
-	printk(KERN_DEBUG "probe of %s returned %d after %lld usecs\n",
-	       dev_name(dev), ret, (s64) ktime_to_us(delta));
+	pr_debug("probe of %s returned %d after %lld usecs\n",
+		 dev_name(dev), ret, (s64) ktime_to_us(delta));
 	return ret;
 }
 
@@ -687,8 +686,7 @@ static inline bool cmdline_requested_async_probing(const char *drv_name)
 static int __init save_async_options(char *buf)
 {
 	if (strlen(buf) >= ASYNC_DRV_NAMES_MAX_LEN)
-		printk(KERN_WARNING
-			"Too long list of driver names for 'driver_async_probe'!\n");
+		pr_warn("Too long list of driver names for 'driver_async_probe'!\n");
 
 	strlcpy(async_probe_drv_names, buf, ASYNC_DRV_NAMES_MAX_LEN);
 	return 0;
-- 
2.11.0

