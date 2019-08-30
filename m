Return-Path: <SRS0=2mSC=W2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC4ABC3A59F
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Aug 2019 02:24:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8B75E21726
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Aug 2019 02:24:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AEE15Scq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727735AbfH3CYv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Aug 2019 22:24:51 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:41598 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727344AbfH3CYv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Aug 2019 22:24:51 -0400
Received: by mail-pg1-f195.google.com with SMTP id x15so2668840pgg.8;
        Thu, 29 Aug 2019 19:24:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=qfHiLZajGyQDnbfm/jvtW9Y9R5M2p7DW5ZQEIckHoIU=;
        b=AEE15Scqgeqfee6h9MeLygul9EiReiKiMPLySc5IHgyQDjIttqvfWRkTeHoR9cQ4ZC
         Bs8a+YMTsmvohPYqoa4ZISQRzf5MbaafXCVf/lvEbJCu/YCast/gVqy7hn3/3qniO9Zp
         Ofm4j+/PgRGeegh9vSk86mryoeb+TAfrMK/i/vpVWwato9FosqnNRsyWn+mAB3evqWjT
         Hkk7cBUThfvhb4JTR3JQdibcJEo7ZDKTj7ZigD0z56phvENT5F1Yjkq1PLGaV4nsoJHG
         yFK5ephsFoBT9XYnA5TG8p/MCcpY5l6kRaY5bw4TtQ5y3k5JLUKLdfB7vcDzdMsAVV7s
         PRJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=qfHiLZajGyQDnbfm/jvtW9Y9R5M2p7DW5ZQEIckHoIU=;
        b=G1dMsfWqCbiWwYdN4aYM4ymK2o8NGPgyQan9dyE+O4ZwFEe+Kd+hUmO+v6v5NNR6jy
         iYV9177BOrguY2c6KvqYfg6UgGdAVGcY05PRv1z1W34vUIc2EENzYwi7vg9j2st/xWyo
         a0kVtt64AeEeSkCr2S+LNz54FD7olt8Yaske2l0Xj0NUi5BCRP13N9+mwmKSz0M3q8WO
         bg5RBmLLQ0cE7IcAhm/u88rwUHLBVYdpnE1msA5ZWI3lak9V51F+B9txhTNWjzSVwxE+
         k1pIoMcERpdyrl/OcImTP8jrZheXcYNMkzGv177Uw4KgyKpYKNv4P3EJhaxvkkzssYXE
         bu5A==
X-Gm-Message-State: APjAAAXIhDaCDPA8DWF2Jh2kIA7zTZcO8yaYtW5nCUqLbyeY4F83v38L
        COto5gcyi4BZthdjGAk7geo=
X-Google-Smtp-Source: APXvYqzHxjwFfhhNfzkE0ZbWpuup5FH96HqX+rEvBA5/FoBj8a68JGhKksj2O3CU5esDbG3a+sOx/A==
X-Received: by 2002:a62:e50f:: with SMTP id n15mr12638906pff.208.1567131890874;
        Thu, 29 Aug 2019 19:24:50 -0700 (PDT)
Received: from gli-arch.genesyslogic.com.tw (60-251-58-169.HINET-IP.hinet.net. [60.251.58.169])
        by smtp.gmail.com with ESMTPSA id 6sm4890944pfa.7.2019.08.29.19.24.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Aug 2019 19:24:50 -0700 (PDT)
From:   Ben Chuang <benchuanggli@gmail.com>
To:     adrian.hunter@intel.com, ulf.hansson@linaro.org
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        johnsonm@danlj.org, ben.chuang@genesyslogic.com.tw,
        Ben Chuang <benchuanggli@gmail.com>
Subject: [PATCH V7 3/5] PCI: Add Genesys Logic, Inc. Vendor ID
Date:   Fri, 30 Aug 2019 10:24:49 +0800
Message-Id: <20190830022449.8445-1-benchuanggli@gmail.com>
X-Mailer: git-send-email 2.22.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ben Chuang <ben.chuang@genesyslogic.com.tw>

Add the Genesys Logic, Inc. vendor ID to pci_ids.h.

Signed-off-by: Ben Chuang <ben.chuang@genesyslogic.com.tw>
Co-developed-by: Michael K Johnson <johnsonm@danlj.org>
Signed-off-by: Michael K Johnson <johnsonm@danlj.org>
Acked-by: Adrian Hunter <adrian.hunter@intel.com>
---
 include/linux/pci_ids.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/linux/pci_ids.h b/include/linux/pci_ids.h
index 70e86148cb1e..4f7e12772a14 100644
--- a/include/linux/pci_ids.h
+++ b/include/linux/pci_ids.h
@@ -2403,6 +2403,8 @@
 #define PCI_DEVICE_ID_RDC_R6061		0x6061
 #define PCI_DEVICE_ID_RDC_D1010		0x1010
 
+#define PCI_VENDOR_ID_GLI		0x17a0
+
 #define PCI_VENDOR_ID_LENOVO		0x17aa
 
 #define PCI_VENDOR_ID_QCOM		0x17cb
-- 
2.22.1

