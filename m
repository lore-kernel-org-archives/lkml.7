Return-Path: <SRS0=rNeM=SR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2847AC10F0E
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 19:20:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E693D20818
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 19:20:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="Y96GlD/F"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731625AbfDOTUb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Apr 2019 15:20:31 -0400
Received: from us01smtprelay-2.synopsys.com ([198.182.60.111]:57364 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728289AbfDOTU2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Apr 2019 15:20:28 -0400
Received: from mailhost1.synopsys.com (mailhost1.synopsys.com [10.12.238.239])
        by smtprelay.synopsys.com (Postfix) with ESMTP id 2E75310C0B68;
        Mon, 15 Apr 2019 12:20:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1555356028; bh=PD9Bd2KLbPnyLJM4lKAMFHF/QND4G0ncjh4jLufAdsQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:In-Reply-To:
         References:From;
        b=Y96GlD/FJThumDKKCzLycHo6EZw2PPxmgEo6K/WRuNifc/MwfLwIAODGnl6L2DC/x
         ZKesFFTO1M127wT3eYVvCrrIuFwqHimTBzK0SCGjc9Xcx7SbzmVsfix8/mnzWcpELM
         Cqe1J04YvBJXRK2fH5s16Gadjsi8kHeIHEo7HImc1P3m6oMuyYwlpsHQp9hdJYaeOL
         77+/jj5nG5qVq2U/hgu2W2mee9ys3tejIXu5TMt27UGXd2rT9s8XMLQcXxXqmcHwJP
         nKjYRp0vbGeKqUTmav/rQER5HbFLfi8wMiBHhjTnEjg4PsYFN3H/ZLAxxDUdJJ39vi
         KVIuoZkdjGePg==
Received: from de02dwia024.internal.synopsys.com (de02dwia024.internal.synopsys.com [10.225.19.81])
        by mailhost1.synopsys.com (Postfix) with ESMTP id 57D3F546D;
        Mon, 15 Apr 2019 12:19:55 -0700 (PDT)
From:   Vitor Soares <vitor.soares@synopsys.com>
To:     linux-iio@vger.kernel.org, linux-i3c@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     pmeerw@pmeerw.net, lars@metafoo.de, knaack.h@gmx.de,
        jic23@kernel.org, lorenzo.bianconi83@gmail.com,
        bbrezillon@kernel.org, rafael@kernel.org,
        gregkh@linuxfoundation.org, broonie@kernel.org,
        joao.pinto@synopsys.com, Vitor Soares <vitor.soares@synopsys.com>
Subject: [PATCH 2/3] i3c: Add i3c_get_device_id helper
Date:   Mon, 15 Apr 2019 21:19:40 +0200
Message-Id: <33ba7e13816fcece0a2f7ec917c18807359c16c7.1555354268.git.vitor.soares@synopsys.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1555354268.git.vitor.soares@synopsys.com>
References: <cover.1555354268.git.vitor.soares@synopsys.com>
In-Reply-To: <cover.1555354268.git.vitor.soares@synopsys.com>
References: <cover.1555354268.git.vitor.soares@synopsys.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This helper return the i3c_device_id structure in order the client
have access to the driver data.

Signed-off-by: Vitor Soares <vitor.soares@synopsys.com>
---
 drivers/i3c/device.c       | 8 ++++++++
 include/linux/i3c/device.h | 1 +
 2 files changed, 9 insertions(+)

diff --git a/drivers/i3c/device.c b/drivers/i3c/device.c
index 472be99..8ab8e4c 100644
--- a/drivers/i3c/device.c
+++ b/drivers/i3c/device.c
@@ -235,6 +235,14 @@ struct i3c_device *dev_to_i3cdev(struct device *dev)
 }
 EXPORT_SYMBOL_GPL(dev_to_i3cdev);
 
+const struct i3c_device_id *i3c_get_device_id(struct i3c_device *i3cdev)
+{
+	const struct i3c_driver *i3cdrv = drv_to_i3cdrv(i3cdev->dev.driver);
+
+	return i3cdrv->id_table;
+}
+EXPORT_SYMBOL_GPL(i3c_get_device_id);
+
 /**
  * i3c_driver_register_with_owner() - register an I3C device driver
  *
diff --git a/include/linux/i3c/device.h b/include/linux/i3c/device.h
index 7ee7e30..ee48886 100644
--- a/include/linux/i3c/device.h
+++ b/include/linux/i3c/device.h
@@ -211,6 +211,7 @@ static inline struct i3c_driver *drv_to_i3cdrv(struct device_driver *drv)
 
 struct device *i3cdev_to_dev(struct i3c_device *i3cdev);
 struct i3c_device *dev_to_i3cdev(struct device *dev);
+const struct i3c_device_id *i3c_get_device_id(struct i3c_device *i3cdev);
 
 static inline void i3cdev_set_drvdata(struct i3c_device *i3cdev,
 				      void *data)
-- 
2.7.4

