Return-Path: <SRS0=wfQU=S6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79CE8C43219
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Apr 2019 02:39:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 510242077B
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Apr 2019 02:39:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726435AbfD1CjS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 27 Apr 2019 22:39:18 -0400
Received: from www.osadl.org ([62.245.132.105]:55277 "EHLO www.osadl.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726112AbfD1CjS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Apr 2019 22:39:18 -0400
Received: from debian01.hofrr.at (178.115.242.59.static.drei.at [178.115.242.59])
        by www.osadl.org (8.13.8/8.13.8/OSADL-2007092901) with ESMTP id x3S2cubh028251;
        Sun, 28 Apr 2019 04:39:05 +0200
From:   Nicholas Mc Guire <hofrat@osadl.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Sven Van Asbroeck <thesven73@gmail.com>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Nicholas Mc Guire <hofrat@osadl.org>
Subject: [PATCH] staging: fieldbus: anybus-s: force endiannes annotation
Date:   Sun, 28 Apr 2019 04:33:24 +0200
Message-Id: <1556418804-10266-2-git-send-email-hofrat@osadl.org>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1556418804-10266-1-git-send-email-hofrat@osadl.org>
References: <1556418804-10266-1-git-send-email-hofrat@osadl.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

While the endiannes is being handled correctly sparse was unhappy with
the missing annotation as be16_to_cpu() expects a __be16. 

Signed-off-by: Nicholas Mc Guire <hofrat@osadl.org>
---

Problem reported by sparse

As far as I understand sparse here the __force is actually the only 
solution possible to inform sparse that the endiannes handling is ok

Patch was compile-tested with. x86_64_defconfig + FIELDBUS_DEV=m,
HMS_ANYBUSS_BUS=m

Patch is against 5.1-rc6 (localversion-next is next-20190426)

 drivers/staging/fieldbus/anybuss/host.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/fieldbus/anybuss/host.c b/drivers/staging/fieldbus/anybuss/host.c
index 6227daf..278acac 100644
--- a/drivers/staging/fieldbus/anybuss/host.c
+++ b/drivers/staging/fieldbus/anybuss/host.c
@@ -1348,7 +1348,7 @@ anybuss_host_common_probe(struct device *dev,
 	add_device_randomness(&val, 4);
 	regmap_bulk_read(cd->regmap, REG_FIELDBUS_TYPE, &fieldbus_type,
 			 sizeof(fieldbus_type));
-	fieldbus_type = be16_to_cpu(fieldbus_type);
+	fieldbus_type = be16_to_cpu((__force __be16)fieldbus_type);
 	dev_info(dev, "Fieldbus type: %04X", fieldbus_type);
 	regmap_bulk_read(cd->regmap, REG_MODULE_SW_V, val, 2);
 	dev_info(dev, "Module SW version: %02X%02X",
-- 
2.1.4

