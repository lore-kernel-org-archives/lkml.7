Return-Path: <SRS0=Yvat=2B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F19C7C3F68F
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 21:54:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C3F7B24653
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 21:54:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kemnade.info header.i=@kemnade.info header.b="R3GY/cMp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726901AbfLKVye (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Dec 2019 16:54:34 -0500
Received: from mail.andi.de1.cc ([85.214.55.253]:36694 "EHLO mail.andi.de1.cc"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726620AbfLKVyd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Dec 2019 16:54:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=kemnade.info; s=20180802; h=References:In-Reply-To:Message-Id:Date:Subject:
        Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=fGFLT4e/xlGZFRk64SBvODY97tOu+7KBubL0GgO60ZI=; b=R3GY/cMpFqihTBc1sZZpqn+6x
        PyGyc7XSHY1ZHUFWrIjj0tiEz7WQDwvdnGlIVoJ+lwUBb7fLANrrEzmFQK0sTdBhL8AEKDDVEjqhM
        ladygMhcw1nKVd7NkJnuKKqUlvmGQCwBW2WtcuTkn42ZKwooxXvtdMGn7n4oKJv0j3aus=;
Received: from p5dcc331a.dip0.t-ipconnect.de ([93.204.51.26] helo=eeepc)
        by mail.andi.de1.cc with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <andreas@kemnade.info>)
        id 1if9wD-0002FW-9K; Wed, 11 Dec 2019 22:54:29 +0100
Received: from andi by eeepc with local (Exim 4.89)
        (envelope-from <andreas@kemnade.info>)
        id 1if9w8-00005f-P9; Wed, 11 Dec 2019 22:54:24 +0100
From:   Andreas Kemnade <andreas@kemnade.info>
To:     lee.jones@linaro.org, robh+dt@kernel.org, mark.rutland@arm.com,
        a.zummo@towertech.it, alexandre.belloni@bootlin.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-rtc@vger.kernel.org, stefan@agner.ch, b.galvani@gmail.com,
        phh@phh.me, letux-kernel@openphoenux.org
Cc:     Andreas Kemnade <andreas@kemnade.info>
Subject: [PATCH v4 3/5] mfd: rn5t618: add RTC related registers
Date:   Wed, 11 Dec 2019 22:54:07 +0100
Message-Id: <20191211215409.32764-4-andreas@kemnade.info>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20191211215409.32764-1-andreas@kemnade.info>
References: <20191211215409.32764-1-andreas@kemnade.info>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Defines for some RTC related registers were missing, also
they were not included in the volatile register list

Signed-off-by: Andreas Kemnade <andreas@kemnade.info>
---

 drivers/mfd/rn5t618.c       |  2 ++
 include/linux/mfd/rn5t618.h | 11 +++++++++++
 2 files changed, 13 insertions(+)

diff --git a/drivers/mfd/rn5t618.c b/drivers/mfd/rn5t618.c
index 76d997c0cfe4..d78eb29b94a4 100644
--- a/drivers/mfd/rn5t618.c
+++ b/drivers/mfd/rn5t618.c
@@ -33,6 +33,8 @@ static bool rn5t618_volatile_reg(struct device *dev, unsigned int reg)
 	case RN5T618_IR_GPF:
 	case RN5T618_MON_IOIN:
 	case RN5T618_INTMON:
+	case RN5T618_RTC_CTRL1 ... RN5T618_RTC_CTRL2:
+	case RN5T618_RTC_SECONDS ... RN5T618_RTC_YEAR:
 		return true;
 	default:
 		return false;
diff --git a/include/linux/mfd/rn5t618.h b/include/linux/mfd/rn5t618.h
index 739571656f2b..fba0df13d9a8 100644
--- a/include/linux/mfd/rn5t618.h
+++ b/include/linux/mfd/rn5t618.h
@@ -139,6 +139,17 @@
 #define RN5T618_INTPOL			0x9c
 #define RN5T618_INTEN			0x9d
 #define RN5T618_INTMON			0x9e
+
+#define RN5T618_RTC_SECONDS     0xA0
+#define RN5T618_RTC_MDAY        0xA4
+#define RN5T618_RTC_MONTH       0xA5
+#define RN5T618_RTC_YEAR        0xA6
+#define RN5T618_RTC_ADJUST      0xA7
+#define RN5T618_RTC_ALARM_Y_SEC 0xA8
+#define RN5T618_RTC_DAL_MONTH   0xAC
+#define RN5T618_RTC_CTRL1       0xAE
+#define RN5T618_RTC_CTRL2       0xAF
+
 #define RN5T618_PREVINDAC		0xb0
 #define RN5T618_BATDAC			0xb1
 #define RN5T618_CHGCTL1			0xb3
-- 
2.11.0

