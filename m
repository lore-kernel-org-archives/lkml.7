Return-Path: <SRS0=IBEs=VB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96423C06513
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jul 2019 12:14:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 626DD218A0
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jul 2019 12:14:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1562242476;
	bh=BS6LHDQQf9/yApkc167DvFPp/dm0Nvl/xbr6rW/uOMk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Jokq+B599ti6NxhaNQE98vGGMKdlewGoFmqSIdy6RZeM2StGKQZU/0OlhBe/k7zDK
	 /x5DEM+RAadlq5yQt5Onlp3YpoUSrRCHZ2a/Iqpg84UoqgAviEL8uGoDcaX9hFPCJA
	 KqSSZ5JCeZrOiW4NoJGDIB+7+tYqyWBhCFELU1gI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727694AbfGDMOf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Jul 2019 08:14:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:38568 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727615AbfGDMOe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Jul 2019 08:14:34 -0400
Received: from localhost (unknown [89.205.128.15])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3D3CE2189E;
        Thu,  4 Jul 2019 12:14:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1562242474;
        bh=BS6LHDQQf9/yApkc167DvFPp/dm0Nvl/xbr6rW/uOMk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=T42g+aCDmCVC6bfEvGPCpvXwZ1ofsiUI9KeQsI2FzhxjqAtzdZPhda/+PfapxY9/v
         JrqQHUgMUJn1YU3r6uLtE7RGyGh5uqLlpy3NkPf6pm2PsjiXG7SvTyE8hAAJntIo6+
         hlTth0h0LLcT1J8nkxC4ZeRwv4KYeeP7GjPSbnas=
Date:   Thu, 4 Jul 2019 14:11:43 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Johan Hovold <johan@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        Richard Gong <richard.gong@linux.intel.com>,
        Romain Izard <romain.izard.pro@gmail.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Mans Rullgard <mans@mansr.com>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Randy Dunlap <rdunlap@infradead.org>
Subject: [PATCH 01/12 v2] Platform: add a dev_groups pointer to struct
 platform_driver
Message-ID: <20190704121143.GA5007@kroah.com>
References: <20190704084617.3602-1-gregkh@linuxfoundation.org>
 <20190704084617.3602-2-gregkh@linuxfoundation.org>
 <20190704093200.GM13424@localhost>
 <20190704104311.GA16681@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190704104311.GA16681@kroah.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Platform drivers like to add sysfs groups to their device, but right now
they have to do it "by hand".  The driver core should handle this for
them, but there is no way to get to the bus-default attribute groups as
all platform devices are "special and unique" one-off drivers/devices.

To combat this, add a dev_groups pointer to platform_driver which allows
a platform driver to set up a list of default attributes that will be
properly created and removed by the platform driver core when a probe()
function is successful and removed right before the device is unbound.

Cc: Richard Gong <richard.gong@linux.intel.com>
Cc: Romain Izard <romain.izard.pro@gmail.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Mans Rullgard <mans@mansr.com>
Cc: Bartosz Golaszewski <bgolaszewski@baylibre.com>
Cc: Randy Dunlap <rdunlap@infradead.org>
Cc: Johan Hovold <johan@kernel.org>
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
v2: addressed Johan's comments by reordering when we remove the files
    from the device, and clean up on an error in a nicer way.  Ended up
    making the patch smaller overall, always nice.

 drivers/base/platform.c         | 16 +++++++++++++++-
 include/linux/platform_device.h |  1 +
 2 files changed, 16 insertions(+), 1 deletion(-)

diff --git a/drivers/base/platform.c b/drivers/base/platform.c
index 713903290385..74428a1e03f3 100644
--- a/drivers/base/platform.c
+++ b/drivers/base/platform.c
@@ -614,8 +614,20 @@ static int platform_drv_probe(struct device *_dev)
 
 	if (drv->probe) {
 		ret = drv->probe(dev);
-		if (ret)
+		if (ret) {
+			dev_pm_domain_detach(_dev, true);
+			goto out;
+		}
+	}
+	if (drv->dev_groups) {
+		ret = device_add_groups(_dev, drv->dev_groups);
+		if (ret) {
+			if (drv->remove)
+				drv->remove(dev);
 			dev_pm_domain_detach(_dev, true);
+			return ret;
+		}
+		kobject_uevent(&_dev->kobj, KOBJ_CHANGE);
 	}
 
 out:
@@ -638,6 +650,8 @@ static int platform_drv_remove(struct device *_dev)
 	struct platform_device *dev = to_platform_device(_dev);
 	int ret = 0;
 
+	if (drv->dev_groups)
+		device_remove_groups(_dev, drv->dev_groups);
 	if (drv->remove)
 		ret = drv->remove(dev);
 	dev_pm_domain_detach(_dev, true);
diff --git a/include/linux/platform_device.h b/include/linux/platform_device.h
index cc464850b71e..027f1e1d7af8 100644
--- a/include/linux/platform_device.h
+++ b/include/linux/platform_device.h
@@ -190,6 +190,7 @@ struct platform_driver {
 	int (*resume)(struct platform_device *);
 	struct device_driver driver;
 	const struct platform_device_id *id_table;
+	const struct attribute_group **dev_groups;
 	bool prevent_deferred_probe;
 };
 
-- 
2.22.0

