Return-Path: <SRS0=OaAC=YQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBD61CA9EB6
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 12:25:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B31D7214B2
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 12:25:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732245AbfJWMZI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Oct 2019 08:25:08 -0400
Received: from mga04.intel.com ([192.55.52.120]:58290 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725775AbfJWMZI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Oct 2019 08:25:08 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 23 Oct 2019 05:25:07 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,220,1569308400"; 
   d="scan'208";a="197412241"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga007.fm.intel.com with ESMTP; 23 Oct 2019 05:25:06 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id ED6181F5; Wed, 23 Oct 2019 15:25:05 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        linux-kernel@vger.kernel.org
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1] driver core: platform: Declare ret variable only once
Date:   Wed, 23 Oct 2019 15:25:05 +0300
Message-Id: <20191023122505.64684-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We may define ret variable only once and avoid adding it each time
platform_get_irq_optional() get extended.

For the sake of consistency do the same in __platform_get_irq_byname().

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/base/platform.c | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/drivers/base/platform.c b/drivers/base/platform.c
index e0ca682a756d..dad9806875f7 100644
--- a/drivers/base/platform.c
+++ b/drivers/base/platform.c
@@ -106,9 +106,9 @@ int platform_get_irq_optional(struct platform_device *dev, unsigned int num)
 	return dev->archdata.irqs[num];
 #else
 	struct resource *r;
-	if (IS_ENABLED(CONFIG_OF_IRQ) && dev->dev.of_node) {
-		int ret;
+	int ret;
 
+	if (IS_ENABLED(CONFIG_OF_IRQ) && dev->dev.of_node) {
 		ret = of_irq_get(dev->dev.of_node, num);
 		if (ret > 0 || ret == -EPROBE_DEFER)
 			return ret;
@@ -117,8 +117,6 @@ int platform_get_irq_optional(struct platform_device *dev, unsigned int num)
 	r = platform_get_resource(dev, IORESOURCE_IRQ, num);
 	if (has_acpi_companion(&dev->dev)) {
 		if (r && r->flags & IORESOURCE_DISABLED) {
-			int ret;
-
 			ret = acpi_irq_get(ACPI_HANDLE(&dev->dev), num, r);
 			if (ret)
 				return ret;
@@ -151,8 +149,7 @@ int platform_get_irq_optional(struct platform_device *dev, unsigned int num)
 	 * allows a common code path across either kind of resource.
 	 */
 	if (num == 0 && has_acpi_companion(&dev->dev)) {
-		int ret = acpi_dev_gpio_irq_get(ACPI_COMPANION(&dev->dev), num);
-
+		ret = acpi_dev_gpio_irq_get(ACPI_COMPANION(&dev->dev), num);
 		/* Our callers expect -ENXIO for missing IRQs. */
 		if (ret >= 0 || ret == -EPROBE_DEFER)
 			return ret;
@@ -240,10 +237,9 @@ static int __platform_get_irq_byname(struct platform_device *dev,
 				     const char *name)
 {
 	struct resource *r;
+	int ret;
 
 	if (IS_ENABLED(CONFIG_OF_IRQ) && dev->dev.of_node) {
-		int ret;
-
 		ret = of_irq_get_byname(dev->dev.of_node, name);
 		if (ret > 0 || ret == -EPROBE_DEFER)
 			return ret;
-- 
2.23.0

