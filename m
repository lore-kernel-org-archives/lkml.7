Return-Path: <SRS0=2dYc=UG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 950F8C468BC
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Jun 2019 15:00:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 78C6E20840
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Jun 2019 15:00:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729505AbfFGPAR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Jun 2019 11:00:17 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45990 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729212AbfFGPAM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jun 2019 11:00:12 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 048FF30832CE;
        Fri,  7 Jun 2019 15:00:12 +0000 (UTC)
Received: from hp-dl360pgen8-07.khw2.lab.eng.bos.redhat.com (hp-dl360pgen8-07.khw2.lab.eng.bos.redhat.com [10.16.210.135])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 2ABFA831BB;
        Fri,  7 Jun 2019 15:00:08 +0000 (UTC)
From:   Jarod Wilson <jarod@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Jarod Wilson <jarod@redhat.com>, Joe Perches <joe@perches.com>,
        Jay Vosburgh <j.vosburgh@gmail.com>,
        Veaceslav Falico <vfalico@gmail.com>,
        Andy Gospodarek <andy@greyhouse.net>, netdev@vger.kernel.org
Subject: [PATCH net-next 3/7] bonding: add slave_foo printk macros
Date:   Fri,  7 Jun 2019 10:59:28 -0400
Message-Id: <20190607145933.37058-4-jarod@redhat.com>
In-Reply-To: <20190607145933.37058-1-jarod@redhat.com>
References: <20190607145933.37058-1-jarod@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.44]); Fri, 07 Jun 2019 15:00:12 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Where possible, we generally want both the bond master and the relevant slave
information in message output. Standardize the format using new slave_*
printk macros.

Suggested-by: Joe Perches <joe@perches.com>
CC: Jay Vosburgh <j.vosburgh@gmail.com>
CC: Veaceslav Falico <vfalico@gmail.com>
CC: Andy Gospodarek <andy@greyhouse.net>
CC: netdev@vger.kernel.org
Signed-off-by: Jarod Wilson <jarod@redhat.com>
---
 include/net/bonding.h | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/include/net/bonding.h b/include/net/bonding.h
index b46d68acf701..676e7fae05a3 100644
--- a/include/net/bonding.h
+++ b/include/net/bonding.h
@@ -38,6 +38,15 @@
 #define __long_aligned __attribute__((aligned((sizeof(long)))))
 #endif
 
+#define slave_info(bond_dev, slave_dev, fmt, ...) \
+	netdev_info(bond_dev, "(slave %s): " fmt, (slave_dev)->name, ##__VA_ARGS__)
+#define slave_warn(bond_dev, slave_dev, fmt, ...) \
+	netdev_warn(bond_dev, "(slave %s): " fmt, (slave_dev)->name, ##__VA_ARGS__)
+#define slave_dbg(bond_dev, slave_dev, fmt, ...) \
+	netdev_dbg(bond_dev, "(slave %s): " fmt, (slave_dev)->name, ##__VA_ARGS__)
+#define slave_err(bond_dev, slave_dev, fmt, ...) \
+	netdev_err(bond_dev, "(slave %s): " fmt, (slave_dev)->name, ##__VA_ARGS__)
+
 #define BOND_MODE(bond) ((bond)->params.mode)
 
 /* slave list primitives */
-- 
2.20.1

