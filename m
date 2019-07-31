Return-Path: <SRS0=cgli=V4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55C17C32751
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 12:47:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2766A206B8
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 12:47:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728892AbfGaMrl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Jul 2019 08:47:41 -0400
Received: from laurent.telenet-ops.be ([195.130.137.89]:43880 "EHLO
        laurent.telenet-ops.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726907AbfGaMrk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jul 2019 08:47:40 -0400
Received: from ramsan ([84.194.98.4])
        by laurent.telenet-ops.be with bizsmtp
        id jQnf2000705gfCL01QnfAQ; Wed, 31 Jul 2019 14:47:39 +0200
Received: from rox.of.borg ([192.168.97.57])
        by ramsan with esmtp (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1hso15-0000Ub-4Z; Wed, 31 Jul 2019 14:47:39 +0200
Received: from geert by rox.of.borg with local (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1hso15-0003mu-1E; Wed, 31 Jul 2019 14:47:39 +0200
From:   Geert Uytterhoeven <geert+renesas@glider.be>
To:     Mark Brown <broonie@kernel.org>
Cc:     linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH] spi: core: Use DEVICE_ATTR_RW() for SPI slave control sysfs attribute
Date:   Wed, 31 Jul 2019 14:47:38 +0200
Message-Id: <20190731124738.14519-1-geert+renesas@glider.be>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert the SPI slave control sysfs attribute from DEVICE_ATTR() to
DEVICE_ATTR_RW(), to reduce boilerplate.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 drivers/spi/spi.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index 75ac046cae5267b7..9fd7926e80c07681 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -2105,8 +2105,8 @@ static int match_true(struct device *dev, void *data)
 	return 1;
 }
 
-static ssize_t spi_slave_show(struct device *dev,
-			      struct device_attribute *attr, char *buf)
+static ssize_t slave_show(struct device *dev, struct device_attribute *attr,
+			  char *buf)
 {
 	struct spi_controller *ctlr = container_of(dev, struct spi_controller,
 						   dev);
@@ -2117,9 +2117,8 @@ static ssize_t spi_slave_show(struct device *dev,
 		       child ? to_spi_device(child)->modalias : NULL);
 }
 
-static ssize_t spi_slave_store(struct device *dev,
-			       struct device_attribute *attr, const char *buf,
-			       size_t count)
+static ssize_t slave_store(struct device *dev, struct device_attribute *attr,
+			   const char *buf, size_t count)
 {
 	struct spi_controller *ctlr = container_of(dev, struct spi_controller,
 						   dev);
@@ -2157,7 +2156,7 @@ static ssize_t spi_slave_store(struct device *dev,
 	return count;
 }
 
-static DEVICE_ATTR(slave, 0644, spi_slave_show, spi_slave_store);
+static DEVICE_ATTR_RW(slave);
 
 static struct attribute *spi_slave_attrs[] = {
 	&dev_attr_slave.attr,
-- 
2.17.1

