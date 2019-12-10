Return-Path: <SRS0=jko7=2A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7492C43603
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 15:37:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8AD13207FF
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 15:37:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="YDPKO9wz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727629AbfLJPhk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Dec 2019 10:37:40 -0500
Received: from smtprelay-out1.synopsys.com ([149.117.87.133]:45222 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727330AbfLJPhk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Dec 2019 10:37:40 -0500
Received: from mailhost.synopsys.com (mdc-mailhost2.synopsys.com [10.225.0.210])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 8A2B9C00BC;
        Tue, 10 Dec 2019 15:37:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1575992259; bh=wCGz21uv5jylmEZ0nnnjoDbbVduGA33/JL1HaoI4a4g=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:In-Reply-To:
         References:From;
        b=YDPKO9wzoyy39bw6iC7+R76kinU7HKu9ki7xlgNpkouzr6ES2FCtj56iRAgaPfe+Q
         ZIR9oIHNjzEildKY/ywHeHs4otRepS3e4WCOEoqPV8vXSYNRDhDqLJGEppwH5Yy6VB
         KVRXF+mk1PhEcJQURZ12MKLYx/Z7ZFQHLFAI7YCEI6ylywYo2x+5ZJaJrlANuH0DYO
         gEC24w6H1pFeGejXf+E77nQiAcdVTuPCXd3o3+ufxOKvtSHO6winoIcUFnljbJ4pDW
         uNDmuelsw1zoLpVCyB1kMDpGpv/ZhkUTZA65gGNilmn4Kg9m0KnemZh+5o3ZAAqny8
         kzDPkFLhAHmqQ==
Received: from de02.synopsys.com (de02.internal.synopsys.com [10.225.17.21])
        by mailhost.synopsys.com (Postfix) with ESMTP id 96528A0062;
        Tue, 10 Dec 2019 15:37:36 +0000 (UTC)
Received: from de02dwia024.internal.synopsys.com (de02dwia024.internal.synopsys.com [10.225.19.81])
        by de02.synopsys.com (Postfix) with ESMTP id 6D4D23E2D0;
        Tue, 10 Dec 2019 16:37:36 +0100 (CET)
From:   Vitor Soares <Vitor.Soares@synopsys.com>
To:     linux-kernel@vger.kernel.org, linux-i3c@lists.infradead.org
Cc:     Joao.Pinto@synopsys.com, bbrezillon@kernel.org,
        gregkh@linuxfoundation.org, wsa@the-dreams.de, arnd@arndb.de,
        broonie@kernel.org, Vitor Soares <Vitor.Soares@synopsys.com>
Subject: [RFC 1/5] i3c: master: export i3c_masterdev_type
Date:   Tue, 10 Dec 2019 16:37:29 +0100
Message-Id: <e6300a989b856e77bab8e57a71ae30b18ced8b3d.1575977795.git.vitor.soares@synopsys.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1575977795.git.vitor.soares@synopsys.com>
References: <cover.1575977795.git.vitor.soares@synopsys.com>
In-Reply-To: <cover.1575977795.git.vitor.soares@synopsys.com>
References: <cover.1575977795.git.vitor.soares@synopsys.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Export i3c_masterdev_type symbol so i3cdev module can verify if an
i3c device is a master device.

Signed-off-by: Vitor Soares <vitor.soares@synopsys.com>
---
 drivers/i3c/internals.h | 1 +
 drivers/i3c/master.c    | 3 ++-
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/i3c/internals.h b/drivers/i3c/internals.h
index 86b7b44..bc062e8 100644
--- a/drivers/i3c/internals.h
+++ b/drivers/i3c/internals.h
@@ -11,6 +11,7 @@
 #include <linux/i3c/master.h>
 
 extern struct bus_type i3c_bus_type;
+extern const struct device_type i3c_masterdev_type;
 
 void i3c_bus_normaluse_lock(struct i3c_bus *bus);
 void i3c_bus_normaluse_unlock(struct i3c_bus *bus);
diff --git a/drivers/i3c/master.c b/drivers/i3c/master.c
index 0436916..a1fb5f7 100644
--- a/drivers/i3c/master.c
+++ b/drivers/i3c/master.c
@@ -523,9 +523,10 @@ static void i3c_masterdev_release(struct device *dev)
 	of_node_put(dev->of_node);
 }
 
-static const struct device_type i3c_masterdev_type = {
+const struct device_type i3c_masterdev_type = {
 	.groups	= i3c_masterdev_groups,
 };
+EXPORT_SYMBOL_GPL(i3c_masterdev_type);
 
 int i3c_bus_set_mode(struct i3c_bus *i3cbus, enum i3c_bus_mode mode,
 		     unsigned long max_i2c_scl_rate)
-- 
2.7.4

