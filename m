Return-Path: <SRS0=qJmF=WX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BD3DC3A59F
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 00:33:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F29F020578
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 00:33:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oeNqzRpB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728228AbfH0AdI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Aug 2019 20:33:08 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:43659 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726596AbfH0AdH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Aug 2019 20:33:07 -0400
Received: by mail-pg1-f193.google.com with SMTP id k3so11576544pgb.10;
        Mon, 26 Aug 2019 17:33:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=qfHiLZajGyQDnbfm/jvtW9Y9R5M2p7DW5ZQEIckHoIU=;
        b=oeNqzRpBOf1WKNRgs/IebvxB57essXsARVv57FHwN023+Zxq5pvi28VtnBy0pUiZh5
         mtKmgMfBkMPGR6j+VAQJqhwCYCB4mIVbbeaH/ctUOEh2yePgYlfsovTP/T1c10kpCA1+
         gUkVUmSEDOkgYL8VT+K87l1q3Wto0QUxQYyT9vxuxtt1Jji24ZZyUCEFPxsahMBrLo3P
         Iofxt9xhF/RHMzWaR1W57seEoDXzdc5vfmFas68ynA9rujTU/T/jDCNoGWxNE6N9/Mtu
         k8mSDDhZcNet6/hVv26Di+JDN/VwR6AqlaH81dWvVeNGIvCto/rQOE4RvTkKAKMbV+dq
         ghzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=qfHiLZajGyQDnbfm/jvtW9Y9R5M2p7DW5ZQEIckHoIU=;
        b=HCx8AIJKSaQrDTELXBUczj4fZo8L3C1W6VU0VEtZlyaNk9zjrUS7ng8eFilwt4oHDQ
         usswQd9O4duNPO57bTe7FNIlSAZKyJo54cjzmPxsAFRR/XHS0+Gp7rm30vl+OGJfBAEs
         MuI235xGIlqK83GSvfcw0WT4ZxRFF+/DdYi3XXzMSa6TC8r2WXLDoylMdmdY5DUGjhk8
         WxDZvFZLpYXQ5fymHCApsi1siPTBLCE37rC31W9ieVMjdtv9vNjMXvFsAsldmshyeO51
         YaFgXnKrxEgUSAK42OdOm8ADZBu3O7nuukAjgKP2GSeWG+udzJdGhydKMbqekyTs7u8b
         BpNg==
X-Gm-Message-State: APjAAAWnTiFP28oslbrDfV/dbcqM2rnq9/EuEUHTOrZDNodWDfs7pItl
        Z7bfErXmmVkxnEmflkw9/io=
X-Google-Smtp-Source: APXvYqyG8UTLiMR0zDYDuKpQEr99DrhgoWhmcYelhIj05sV+7k3BgI16BFkxD/mmOG/Expd2e/zwpw==
X-Received: by 2002:a65:41c6:: with SMTP id b6mr18694490pgq.269.1566865987217;
        Mon, 26 Aug 2019 17:33:07 -0700 (PDT)
Received: from gli-arch.genesyslogic.com.tw (60-251-58-169.HINET-IP.hinet.net. [60.251.58.169])
        by smtp.gmail.com with ESMTPSA id k3sm508582pjo.3.2019.08.26.17.33.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Aug 2019 17:33:06 -0700 (PDT)
From:   Ben Chuang <benchuanggli@gmail.com>
To:     adrian.hunter@intel.com, ulf.hansson@linaro.org
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        johnsonm@danlj.org, ben.chuang@genesyslogic.com.tw,
        Ben Chuang <benchuanggli@gmail.com>
Subject: [PATCH V6 3/5] PCI: Add Genesys Logic, Inc. Vendor ID
Date:   Tue, 27 Aug 2019 08:33:09 +0800
Message-Id: <20190827003309.2396-1-benchuanggli@gmail.com>
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

