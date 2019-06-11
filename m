Return-Path: <SRS0=TvG7=UK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C863C4321A
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 14:06:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3175920665
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 14:06:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="V0oDQSJW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390941AbfFKOGx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Jun 2019 10:06:53 -0400
Received: from dc2-smtprelay2.synopsys.com ([198.182.61.142]:42576 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2387662AbfFKOGv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jun 2019 10:06:51 -0400
Received: from mailhost.synopsys.com (unknown [10.225.0.210])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id C28C9C592D;
        Tue, 11 Jun 2019 14:06:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1560262009; bh=Y3sMwfqtu4jhDptZ3O+9CpvF/YCnpXaDr+JEzu9WStQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:In-Reply-To:
         References:From;
        b=V0oDQSJWcbW9rULv+rQZi0QdFm65nx0FnUhjRyVKpb14nhfZ5VhigsF0u3onBxcIR
         I6zrGzMI1ZtnOQpWhWGEDKLL+O7M7/gR57n3MBUCbUOAXT5WspJQv88UrldQtS/Hig
         MYZUZd/QPpzOx8YGvxGh7rIrTaQv/iSheo7FmrdeVUheIoyo7DqN9k49ElYki4POCr
         mvRrEl1mKN0etb2h/z6rU2qpyl4NeULe8T1WIYqlvMwXX6M31G6WoCUnI8i2TcuMLd
         N42IrDnkk0IxOFS0kmJavq/mrjMhX2dDjaf/WD2MZr8l6J6B0H1GasTXZq+DUjBTg2
         Aq20zxWEyICuA==
Received: from de02.synopsys.com (germany.internal.synopsys.com [10.225.17.21])
        by mailhost.synopsys.com (Postfix) with ESMTP id 2D844A022E;
        Tue, 11 Jun 2019 14:06:48 +0000 (UTC)
Received: from de02dwia024.internal.synopsys.com (de02dwia024.internal.synopsys.com [10.225.19.81])
        by de02.synopsys.com (Postfix) with ESMTP id DAECD3F591;
        Tue, 11 Jun 2019 16:06:48 +0200 (CEST)
From:   Vitor Soares <Vitor.Soares@synopsys.com>
To:     linux-i3c@lists.infradead.org
Cc:     Joao.Pinto@synopsys.com, Vitor Soares <Vitor.Soares@synopsys.com>,
        Boris Brezillon <bbrezillon@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 2/3] i3c: add mixed limited bus mode
Date:   Tue, 11 Jun 2019 16:06:44 +0200
Message-Id: <cdfdf31d1e52b7569f686c50e6f56163d21d8b36.1560261604.git.vitor.soares@synopsys.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1560261604.git.vitor.soares@synopsys.com>
References: <cover.1560261604.git.vitor.soares@synopsys.com>
In-Reply-To: <cover.1560261604.git.vitor.soares@synopsys.com>
References: <cover.1560261604.git.vitor.soares@synopsys.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The i3c bus spec defines a bus configuration where i2c devices don't
have a 50ns filter but support SCL running at SDR max rate (12.5MHz).

This patch introduces the limited bus mode so that users can use
a higher speed in presence of i2c devices index 1.

Signed-off-by: Vitor Soares <vitor.soares@synopsys.com>
Cc: Boris Brezillon <bbrezillon@kernel.org>
Cc: <linux-kernel@vger.kernel.org>
---
Changes in v3:
  None

Changes in v2:
  Enhance commit message

 drivers/i3c/master.c       | 5 +++++
 include/linux/i3c/master.h | 5 +++++
 2 files changed, 10 insertions(+)

diff --git a/drivers/i3c/master.c b/drivers/i3c/master.c
index f8e580e..025925c 100644
--- a/drivers/i3c/master.c
+++ b/drivers/i3c/master.c
@@ -470,6 +470,7 @@ static int i3c_bus_init(struct i3c_bus *i3cbus)
 static const char * const i3c_bus_mode_strings[] = {
 	[I3C_BUS_MODE_PURE] = "pure",
 	[I3C_BUS_MODE_MIXED_FAST] = "mixed-fast",
+	[I3C_BUS_MODE_MIXED_LIMITED] = "mixed-limited",
 	[I3C_BUS_MODE_MIXED_SLOW] = "mixed-slow",
 };
 
@@ -585,6 +586,7 @@ int i3c_bus_set_mode(struct i3c_bus *i3cbus, enum i3c_bus_mode mode,
 			i3cbus->scl_rate.i3c = I3C_BUS_TYP_I3C_SCL_RATE;
 		break;
 	case I3C_BUS_MODE_MIXED_FAST:
+	case I3C_BUS_MODE_MIXED_LIMITED:
 		if (!i3cbus->scl_rate.i3c)
 			i3cbus->scl_rate.i3c = I3C_BUS_TYP_I3C_SCL_RATE;
 		if (!i3cbus->scl_rate.i2c)
@@ -2490,6 +2492,9 @@ int i3c_master_register(struct i3c_master_controller *master,
 				mode = I3C_BUS_MODE_MIXED_FAST;
 			break;
 		case I3C_LVR_I2C_INDEX(1):
+			if (mode < I3C_BUS_MODE_MIXED_LIMITED)
+				mode = I3C_BUS_MODE_MIXED_LIMITED;
+			break;
 		case I3C_LVR_I2C_INDEX(2):
 			if (mode < I3C_BUS_MODE_MIXED_SLOW)
 				mode = I3C_BUS_MODE_MIXED_SLOW;
diff --git a/include/linux/i3c/master.h b/include/linux/i3c/master.h
index f13fd8b..89ea461 100644
--- a/include/linux/i3c/master.h
+++ b/include/linux/i3c/master.h
@@ -250,12 +250,17 @@ struct i3c_device {
  *			     the bus. The only impact in this mode is that the
  *			     high SCL pulse has to stay below 50ns to trick I2C
  *			     devices when transmitting I3C frames
+ * @I3C_BUS_MODE_MIXED_LIMITED: I2C devices without 50ns spike filter are
+ *				present on the bus. However they allows
+ *				compliance up to the maximum SDR SCL clock
+ *				frequency.
  * @I3C_BUS_MODE_MIXED_SLOW: I2C devices without 50ns spike filter are present
  *			     on the bus
  */
 enum i3c_bus_mode {
 	I3C_BUS_MODE_PURE,
 	I3C_BUS_MODE_MIXED_FAST,
+	I3C_BUS_MODE_MIXED_LIMITED,
 	I3C_BUS_MODE_MIXED_SLOW,
 };
 
-- 
2.7.4

