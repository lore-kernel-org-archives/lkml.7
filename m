Return-Path: <SRS0=rNeM=SR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43AA9C10F0E
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 14:53:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 108592075B
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 14:53:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LiGL1Tgz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727619AbfDOOxx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Apr 2019 10:53:53 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:32842 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727129AbfDOOxx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Apr 2019 10:53:53 -0400
Received: by mail-wr1-f68.google.com with SMTP id q1so22402784wrp.0
        for <linux-kernel@vger.kernel.org>; Mon, 15 Apr 2019 07:53:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=3MUspaz6BzTfB2ND7m258wXcclWW2V4xC0qPB1dlUKM=;
        b=LiGL1Tgz4ejLkfDhnpaNT6HeZiq9WYw5OxOZsYAiwJWysKJgK9ZCuO5suTRD24O6p6
         wGbX3+alBKC9vv6h+vij2tewtGTBRJwgnSwC4ChO9+bMjscUjCaktD6SR/rixndhcWyM
         6Zyy16A49vz2SPDePZYTzDeKGMMjLSJwuCZ5jdf+NOyHMJKnIpvJok18kwT7RB415hFt
         IBA+plfdf/+Rh0oayZS3UDqmq8xDPEWmzfbwovfZZr4hXJW/u+3EhVS13aYeRd0WJD+4
         Z61EZt2o7ok6qkovX3bafBpdL811gq13R3qBl4wmeQCUml3XN5saZbHRRp6k9FeENP2q
         7PZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=3MUspaz6BzTfB2ND7m258wXcclWW2V4xC0qPB1dlUKM=;
        b=qoWlPoGikmIbKaxExePSQgiPu745vu1W2emsdcfC9QdO+IfZmgMQYNAuKFTa6CbSGm
         Xq9w+ngkaUCC7xWISONtLrHgaXfVXEkvUKRE59QxrZo+Y0FQDek+GjmVvmigPgHNLkva
         g7Zkk7yI3VhToeVoBs9bNR58a63+ILs1rk1xEGVDGA0mLHvUQTgAl7GZVruxyohIvCL7
         EWEhEkjvjNoumf1K3X6seapMe1D+24prgs0MKgW3CyfQmdFEQKQ20VkvVapkWO/e3yd7
         RlOEkJcAF6kLybofWU6HFwtFLTNEM+F9udPZe+K85hN1inwYO/fvftf+E7WVjb2BmJUR
         zmqg==
X-Gm-Message-State: APjAAAVAbC4sZ2BGtugJwbWP5pkYMETUTZM8mg33j9MtMj79GQoX/Hg6
        qONnijFRkzeDtlptWHHM01I=
X-Google-Smtp-Source: APXvYqxWhljNKQzMSppqo/Cl/z5JW7PH6Tm/zoqirPrWip87e4w5JPYbe4+Jz2S5/uyFpzGRybKnww==
X-Received: by 2002:a5d:6646:: with SMTP id f6mr1093519wrw.68.1555340031554;
        Mon, 15 Apr 2019 07:53:51 -0700 (PDT)
Received: from macpro-scc.lancs.ac.uk (inc028000049.lancs.ac.uk. [148.88.224.78])
        by smtp.gmail.com with ESMTPSA id o17sm62162950wrw.73.2019.04.15.07.53.51
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 15 Apr 2019 07:53:51 -0700 (PDT)
Date:   Mon, 15 Apr 2019 15:53:50 +0100
From:   Willy Wolff <willy.mh.wolff.ml@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/2] driver core: printk to pr_*
Message-ID: <20190415145349.vqfhcp4iv4uka4lt@macpro-scc.lancs.ac.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch change usage of printk to their pr_* equivalent.

Note, pr_debug(...) will not be emitted unless DEBUG is defined or
CONFIG_DYNAMIC_DEBUG is enabled.

Signed-off-by: Willy Wolff <willy.mh.wolff.ml@gmail.com>
---
Changes in v2:
  - Add a cover letter.

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

