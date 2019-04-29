Return-Path: <SRS0=c0gK=S7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43B9AC43219
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Apr 2019 06:11:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1B4EE206BF
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Apr 2019 06:11:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727409AbfD2GLb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Apr 2019 02:11:31 -0400
Received: from www.osadl.org ([62.245.132.105]:41113 "EHLO www.osadl.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726758AbfD2GLb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Apr 2019 02:11:31 -0400
Received: from debian01.hofrr.at (178.115.242.59.static.drei.at [178.115.242.59])
        by www.osadl.org (8.13.8/8.13.8/OSADL-2007092901) with ESMTP id x3T6BEma005090;
        Mon, 29 Apr 2019 08:11:14 +0200
From:   Nicholas Mc Guire <hofrat@osadl.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Sven Van Asbroeck <thesven73@gmail.com>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Nicholas Mc Guire <hofrat@osadl.org>
Subject: [PATCH V2] staging: fieldbus: anybus-s: force endiannes annotation
Date:   Mon, 29 Apr 2019 08:05:39 +0200
Message-Id: <1556517940-13725-1-git-send-email-hofrat@osadl.org>
X-Mailer: git-send-email 2.1.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

While the endiannes is being handled correctly sparse was unhappy with
the missing annotation as be16_to_cpu() expects a __be16. The __force
cast to __be16 makes sparse happy but has no impact on the generated 
binary.

Signed-off-by: Nicholas Mc Guire <hofrat@osadl.org>
---

Problem reported by sparse

V2: As requested by Sven Van Asbroeck <thesven73@gmail.com> make the
    impact of the patch clear in the commit message.

As far as I understand sparse here the __force is actually the only 
solution possible to inform sparse that the endiannes handling is ok

Patch was compile-tested with. x86_64_defconfig + OF=y, FIELDBUS_DEV=m,
HMS_ANYBUSS_BUS=m

Verification that the patch has no impact on the binary being generated
was done by verifying that the diff of the binaries before and after
applying the patch is empty.


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

