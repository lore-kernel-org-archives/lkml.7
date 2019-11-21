Return-Path: <SRS0=lLEG=ZN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E897C432C0
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 08:15:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 63A9E20855
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 08:15:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="lDQLQkLF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727114AbfKUIPW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Nov 2019 03:15:22 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:36198 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726961AbfKUIPH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Nov 2019 03:15:07 -0500
Received: by mail-wr1-f67.google.com with SMTP id z3so3206592wru.3
        for <linux-kernel@vger.kernel.org>; Thu, 21 Nov 2019 00:15:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=8LjJcUv5JRc8/4Vw05C03H9zEwwInU8us44q9tvp9r0=;
        b=lDQLQkLFnXHou+oCKFJriVm046psHa6PF4fvQ88rVy8xkKbVud6HDaf5BbBKWorYaG
         9JqhW4wsHV9WyzfjpMwcieA03kIJrYrmsTs2TKpgRF/0ze1l+yFLtdaMn6lM/x0/ZMcZ
         gN8VuphDjfs3yZHIQwGImS367kLOMoEvagMJ3vCF1mTPU29ATxQQQFaVSpUjQyfM49/w
         JWLGU+VUMdyGfRPnSWuMRWG/JiXnCIV5MpgvVOC5m7yzqS1zN7+PxiWfcCju2TKbwpT/
         d/F0AewpDtoCFSsHP1OuXvyMybR3YNTJVEpu/eUr3JCiknF3mZmcCWfs0gzNucjdCHqz
         DVYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=8LjJcUv5JRc8/4Vw05C03H9zEwwInU8us44q9tvp9r0=;
        b=BqzXzzPAzwnYwuOvdg6GT9u/OwPiV4oqPnc8454YXhm99eJq/4DqHODMpe67vTA399
         37JdQe4vc9v0J23TqSbqjY3lAYT6LTT4eMLk9vACwSmilETI65QWjrHkRByovDytlor5
         FcFP2SN3T19RoBK6GQLzRZetLZf+wwt0VnIQ2JcGrPm3k6C9L5OB8gFp6T4fOMhJ+N2y
         ucT3afEzXDY/1EJj3CNn1vzaGy+/uOoe70DQMdTU0yh3K85IA1fdeAuLpdy4b2rWNGFv
         wgKtJ7d5NdhK4aZuRM73jjAeZZlnsvB+iUOVjintZrqJg/Mz85GgQNaSk/H5U6QXL7Qf
         OpdQ==
X-Gm-Message-State: APjAAAU1Tzz8yZhVE7LPVKEqp4K+hO/uQPDMkK24xoPokgnO+QDXAlrn
        lWA2l4F/ZWUVDk3uZ3pFrdZ5FQ==
X-Google-Smtp-Source: APXvYqxuvxQ3VmGAQNQNFsb26ptbHyJKZeZzcG5Kiwzno83aX29giQBgYYZkraYJUUx7vIR0vINsIA==
X-Received: by 2002:a5d:53c1:: with SMTP id a1mr489050wrw.373.1574324105155;
        Thu, 21 Nov 2019 00:15:05 -0800 (PST)
Received: from localhost.localdomain ([51.15.160.169])
        by smtp.googlemail.com with ESMTPSA id w13sm2315075wrm.8.2019.11.21.00.15.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 21 Nov 2019 00:15:04 -0800 (PST)
From:   Corentin Labbe <clabbe@baylibre.com>
To:     airlied@redhat.com, airlied@linux.ie, arnd@arndb.de,
        fenghua.yu@intel.com, gregkh@linuxfoundation.org,
        tony.luck@intel.com
Cc:     linux-ia64@vger.kernel.org, linux-kernel@vger.kernel.org,
        Corentin Labbe <clabbe@baylibre.com>
Subject: [PATCH v2 2/5] agp: move AGPGART_MINOR to include/linux/miscdevice.h
Date:   Thu, 21 Nov 2019 08:14:42 +0000
Message-Id: <1574324085-4338-3-git-send-email-clabbe@baylibre.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1574324085-4338-1-git-send-email-clabbe@baylibre.com>
References: <1574324085-4338-1-git-send-email-clabbe@baylibre.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch move the define for AGPGART_MINOR to include/linux/miscdevice.h.
It is better that all minor number definitions are in the same place.

Signed-off-by: Corentin Labbe <clabbe@baylibre.com>
---
 include/linux/agpgart.h    | 2 --
 include/linux/miscdevice.h | 1 +
 2 files changed, 1 insertion(+), 2 deletions(-)

diff --git a/include/linux/agpgart.h b/include/linux/agpgart.h
index c6b61ca97053..21b34a96cfd8 100644
--- a/include/linux/agpgart.h
+++ b/include/linux/agpgart.h
@@ -30,8 +30,6 @@
 #include <linux/agp_backend.h>
 #include <uapi/linux/agpgart.h>
 
-#define AGPGART_MINOR 175
-
 struct agp_info {
 	struct agp_version version;	/* version of the driver        */
 	u32 bridge_id;		/* bridge vendor/device         */
diff --git a/include/linux/miscdevice.h b/include/linux/miscdevice.h
index b06b75776a32..becde6981a95 100644
--- a/include/linux/miscdevice.h
+++ b/include/linux/miscdevice.h
@@ -33,6 +33,7 @@
 #define SGI_MMTIMER		153
 #define STORE_QUEUE_MINOR	155	/* unused */
 #define I2O_MINOR		166
+#define AGPGART_MINOR		175
 #define HWRNG_MINOR		183
 #define MICROCODE_MINOR		184
 #define IRNET_MINOR		187
-- 
2.23.0

