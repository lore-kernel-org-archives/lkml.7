Return-Path: <SRS0=xYIU=RV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E375C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 20:40:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3665B2133D
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 20:40:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=goldelico.com header.i=@goldelico.com header.b="Gi8/vuU6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727878AbfCRUkC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Mar 2019 16:40:02 -0400
Received: from mo4-p02-ob.smtp.rzone.de ([81.169.146.170]:28375 "EHLO
        mo4-p02-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727269AbfCRUjp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Mar 2019 16:39:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1552941583;
        s=strato-dkim-0002; d=goldelico.com;
        h=References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        X-RZG-CLASS-ID:X-RZG-AUTH:From:Subject:Sender;
        bh=PZ2Eo8d+YhwTy/BkqIPSZ4MMMCqG6vW1xSs6GtuCSkk=;
        b=Gi8/vuU6n3tAyPUtZgmwCP+KIESdyNN0NjHpeS/vn8fD+BPI/bfsrKXuf7T7IioOxb
        rTYmF40G8nPbsq6Iiyubzt/p95Ahzt3cQIfxViKVLz1mSRcNsVr43a5y7T6L5mrXJbx2
        bFShR7qF+o7YSMQf1H/Eg+a52cSOZMZkOR8dluVthU/G9VvP+Qxh7fzb+qQGvH8j48c2
        k6stOdCphG8pZHnFtgOsJqSXvtqPCWi3I2dhDAswLDTA7+WHcIiJ2v/TIthvoSJQPPse
        wmcbZCUekbtv0s2Wwz90M8WaGvmbCTXbJvHPUo1SiqujPyFo+XNN4itSCmkXd2aJAywp
        +1eg==
X-RZG-AUTH: ":JGIXVUS7cutRB/49FwqZ7WcJeFKiMhflhwDubTJ9o1OAA2UNf2M7O2CKNdGj"
X-RZG-CLASS-ID: mo00
Received: from iMac.fritz.box
        by smtp.strato.de (RZmta 44.16 DYNA|AUTH)
        with ESMTPSA id h04075v2IKdZFym
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (curve secp521r1 with 521 ECDH bits, eq. 15360 bits RSA))
        (Client did not present a certificate);
        Mon, 18 Mar 2019 21:39:35 +0100 (CET)
From:   "H. Nikolaus Schaller" <hns@goldelico.com>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     letux-kernel@openphoenux.org, kernel@pyra-handheld.com,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        "H. Nikolaus Schaller" <hns@goldelico.com>
Subject: [RFC 4/4] iio: input-bridge: make the iio-input-bridge driver called by iio-core
Date:   Mon, 18 Mar 2019 21:39:34 +0100
Message-Id: <f5c1baba29b0b1e82d49190c96a83cbef3a1cd6f.1552941573.git.hns@goldelico.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <cover.1552941573.git.hns@goldelico.com>
References: <cover.1552941573.git.hns@goldelico.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds the iio-input-bridge to iio device (un)registering so
that accelerometers are located and made present an input event
device.

Signed-off-by: H. Nikolaus Schaller <hns@goldelico.com>
---
 drivers/iio/industrialio-core.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industrialio-core.c
index 4700fd5d8c90..81f412b41a78 100644
--- a/drivers/iio/industrialio-core.c
+++ b/drivers/iio/industrialio-core.c
@@ -29,6 +29,7 @@
 #include <linux/iio/iio.h>
 #include "iio_core.h"
 #include "iio_core_trigger.h"
+#include "industrialio-inputbridge.h"
 #include <linux/iio/sysfs.h>
 #include <linux/iio/events.h>
 #include <linux/iio/buffer.h>
@@ -1723,6 +1724,15 @@ int __iio_device_register(struct iio_dev *indio_dev, struct module *this_mod)
 	if (ret < 0)
 		goto error_unreg_eventset;
 
+	ret = iio_device_register_inputbridge(indio_dev);
+	if (ret) {
+		dev_err(indio_dev->dev.parent,
+			"Failed to register as input driver\n");
+		device_del(&indio_dev->dev);
+
+		return ret;
+	}
+
 	return 0;
 
 error_unreg_eventset:
@@ -1745,6 +1755,8 @@ void iio_device_unregister(struct iio_dev *indio_dev)
 {
 	mutex_lock(&indio_dev->info_exist_lock);
 
+	iio_device_unregister_inputbridge(indio_dev);
+
 	cdev_device_del(&indio_dev->chrdev, &indio_dev->dev);
 
 	iio_device_unregister_debugfs(indio_dev);
-- 
2.19.1

