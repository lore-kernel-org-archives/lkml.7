Return-Path: <SRS0=jko7=2A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 505F4C43603
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 15:37:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 247842077B
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 15:37:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="lj6AdmHY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727702AbfLJPh4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Dec 2019 10:37:56 -0500
Received: from smtprelay-out1.synopsys.com ([149.117.87.133]:45234 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727320AbfLJPhk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Dec 2019 10:37:40 -0500
Received: from mailhost.synopsys.com (mdc-mailhost2.synopsys.com [10.225.0.210])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id B42EEC00A2;
        Tue, 10 Dec 2019 15:37:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1575992259; bh=69j7jHbx5yJ5MhVkwHC0PThYgKjCClJKrN77KC+ilaQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:In-Reply-To:
         References:From;
        b=lj6AdmHY5d6/zKnLaJDfKGQkeuwYZ8dPP0k+lRnshmtc+9iZds0nmrUjvP0AK+jWU
         +5zGv7senN67OngiOPgLBWIAWUX4nQ7xmvb6gtaZT3uJqXqQv6XRRbzYaWNBXNlLV8
         QpcGGdQBlB3QrDxQu43UJpve+oME81fEwYEWBKbnQSNKpgqnJy4/pHrywG7Y8fM79X
         IFfxGWBTpxBc3Own+RjQ4DXKmJTOe/cQEqN/dCESfAm0XVDkNo9Vt6jLo2a1w04rPa
         RZAvqeW0JFsQGJURhMYwkLVahtlh3tpT4ulPkPmLF4zt4Tp2MN3bx8nW3S/3xSBrOU
         h4AyhzEDoXkMA==
Received: from de02.synopsys.com (de02.internal.synopsys.com [10.225.17.21])
        by mailhost.synopsys.com (Postfix) with ESMTP id B48B9A005E;
        Tue, 10 Dec 2019 15:37:36 +0000 (UTC)
Received: from de02dwia024.internal.synopsys.com (de02dwia024.internal.synopsys.com [10.225.19.81])
        by de02.synopsys.com (Postfix) with ESMTP id A0FB73E2D9;
        Tue, 10 Dec 2019 16:37:36 +0100 (CET)
From:   Vitor Soares <Vitor.Soares@synopsys.com>
To:     linux-kernel@vger.kernel.org, linux-i3c@lists.infradead.org
Cc:     Joao.Pinto@synopsys.com, bbrezillon@kernel.org,
        gregkh@linuxfoundation.org, wsa@the-dreams.de, arnd@arndb.de,
        broonie@kernel.org, Vitor Soares <Vitor.Soares@synopsys.com>
Subject: [RFC 4/5] i3c: master: add i3c_for_each_dev helper
Date:   Tue, 10 Dec 2019 16:37:32 +0100
Message-Id: <5aa3bd64a6082ded430ce27f5ea3f6956d1436ac.1575977795.git.vitor.soares@synopsys.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1575977795.git.vitor.soares@synopsys.com>
References: <cover.1575977795.git.vitor.soares@synopsys.com>
In-Reply-To: <cover.1575977795.git.vitor.soares@synopsys.com>
References: <cover.1575977795.git.vitor.soares@synopsys.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Introduce i3c_for_each_dev(), an i3c device iterator for use by i3cdev.

Signed-off-by: Vitor Soares <vitor.soares@synopsys.com>
---
 drivers/i3c/internals.h |  1 +
 drivers/i3c/master.c    | 12 ++++++++++++
 2 files changed, 13 insertions(+)

diff --git a/drivers/i3c/internals.h b/drivers/i3c/internals.h
index bc062e8..a6deedf 100644
--- a/drivers/i3c/internals.h
+++ b/drivers/i3c/internals.h
@@ -24,4 +24,5 @@ int i3c_dev_enable_ibi_locked(struct i3c_dev_desc *dev);
 int i3c_dev_request_ibi_locked(struct i3c_dev_desc *dev,
 			       const struct i3c_ibi_setup *req);
 void i3c_dev_free_ibi_locked(struct i3c_dev_desc *dev);
+int i3c_for_each_dev(void *data, int (*fn)(struct device *, void *));
 #endif /* I3C_INTERNAL_H */
diff --git a/drivers/i3c/master.c b/drivers/i3c/master.c
index a9df276..cc41efe 100644
--- a/drivers/i3c/master.c
+++ b/drivers/i3c/master.c
@@ -2640,6 +2640,18 @@ void i3c_dev_free_ibi_locked(struct i3c_dev_desc *dev)
 	dev->ibi = NULL;
 }
 
+int i3c_for_each_dev(void *data, int (*fn)(struct device *, void *))
+{
+	int res;
+
+	mutex_lock(&i3c_core_lock);
+	res = bus_for_each_dev(&i3c_bus_type, NULL, data, fn);
+	mutex_unlock(&i3c_core_lock);
+
+	return res;
+}
+EXPORT_SYMBOL_GPL(i3c_for_each_dev);
+
 static int __init i3c_init(void)
 {
 	return bus_register(&i3c_bus_type);
-- 
2.7.4

