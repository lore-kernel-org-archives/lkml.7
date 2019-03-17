Return-Path: <SRS0=5V/v=RU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C13FC43381
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Mar 2019 20:00:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ECD4120896
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Mar 2019 20:00:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PLIYwqvn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727561AbfCQT7x (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 17 Mar 2019 15:59:53 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:43081 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727510AbfCQT7s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Mar 2019 15:59:48 -0400
Received: by mail-wr1-f67.google.com with SMTP id d17so14742086wre.10
        for <linux-kernel@vger.kernel.org>; Sun, 17 Mar 2019 12:59:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=+iR+Efn08PaubwgSYudXzJK6N6LHqeb7VmmnEMSNoz4=;
        b=PLIYwqvnAkP/jg7Pfm8NU8jaI6HgysoS4sFfsdk4AQI+n3VKmHMB9HMwZVTY3ePoTv
         bPmCjYp/m+mzoX7oIIkneD6rvwypph15oy6fexSgzYn7dhnsSRg7LJ332ZFB6rV8QJK7
         plcbi0pGbh341upcGA0y8JL/pS5Ksq54gxRtNv4gr/ZTfPp43Oid19R6QzsuwhGDdNCz
         kianRT+1ScqRURzJyezaB/W2TAtNE3rtDRqJWC6jtKH/LUNVM46qV3/Yy2udk7+HyIdJ
         H1Eu8wKKRxbyBrF7G1H5vsCC1PbBAPFeED+6u2Im3FlaCIKVZsl8gPzJIphozsdiQU3Y
         YyTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=+iR+Efn08PaubwgSYudXzJK6N6LHqeb7VmmnEMSNoz4=;
        b=DqWoziZDTXe2Q+nzr4RItqiw1YsYI9naCpM/H1+n+uF7YAEHXuyJeDjYAghZKyrkEF
         htRFmrgoFF18c7covCF6PmLEPJmfapsiOPNlfn0YqC4sib406Y+J8RwSdMrTQXVw0+Vg
         eCIHiZVXgUykLuM4fI+WLZ/FB10mG/MsWRgabn/sg4ibmK5lMxlo0gi4XMJRqqUCDQUv
         eICA+IJLNyv5DfGn37u+aPXYgdx3g2/Z40lPCswXRBHlUW8G31rEqRZMccv9ScUvivbb
         8piAv8pdBwc6uIY7OfpKZb9NlkzEd9SYtmQ5Oz0H8gSRs5LO9QGQo8uTfqnLMvo2kcNn
         vSzA==
X-Gm-Message-State: APjAAAUyxd+Jon1LEueZXM850lZxSPmiTHsdckrT4xi0+J8taM4RMYAM
        YR8eksg5w3WcmeKdhhsFsHEsS2jE
X-Google-Smtp-Source: APXvYqwiCeZF1MrqecrPv+AcYGkTKFzD043xotjYsQ9xtP1P4hxdvSOGy0sE+QIUiQFBmGaZAaw6AA==
X-Received: by 2002:a5d:6682:: with SMTP id l2mr9285716wru.271.1552852785876;
        Sun, 17 Mar 2019 12:59:45 -0700 (PDT)
Received: from ogabbay-VM.habana-labs.com ([31.154.190.6])
        by smtp.gmail.com with ESMTPSA id z1sm7039785wrw.28.2019.03.17.12.59.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 17 Mar 2019 12:59:45 -0700 (PDT)
From:   Oded Gabbay <oded.gabbay@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     gregkh@linuxfoundation.org
Subject: [PATCH 06/15] habanalabs: remove unused defines
Date:   Sun, 17 Mar 2019 21:59:18 +0200
Message-Id: <20190317195927.26238-7-oded.gabbay@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190317195927.26238-1-oded.gabbay@gmail.com>
References: <20190317195927.26238-1-oded.gabbay@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch removes some old defines which are not in use anymore.

Signed-off-by: Oded Gabbay <oded.gabbay@gmail.com>
---
 drivers/misc/habanalabs/goya/goyaP.h | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/drivers/misc/habanalabs/goya/goyaP.h b/drivers/misc/habanalabs/goya/goyaP.h
index 6fdc76b5bde0..ae5e41bc8f7f 100644
--- a/drivers/misc/habanalabs/goya/goyaP.h
+++ b/drivers/misc/habanalabs/goya/goyaP.h
@@ -54,11 +54,9 @@
 /* DRAM Memory Map */
 
 #define CPU_FW_IMAGE_SIZE		0x10000000	/* 256MB */
-#define MMU_PAGE_TABLES_SIZE		0x0DE00000	/* 222MB */
+#define MMU_PAGE_TABLES_SIZE		0x0FC00000	/* 252MB */
 #define MMU_DRAM_DEFAULT_PAGE_SIZE	0x00200000	/* 2MB */
 #define MMU_CACHE_MNG_SIZE		0x00001000	/* 4KB */
-#define CPU_PQ_PKT_SIZE			0x00001000	/* 4KB */
-#define CPU_PQ_DATA_SIZE		0x01FFE000	/* 32MB - 8KB  */
 
 #define CPU_FW_IMAGE_ADDR		DRAM_PHYS_BASE
 #define MMU_PAGE_TABLES_ADDR		(CPU_FW_IMAGE_ADDR + CPU_FW_IMAGE_SIZE)
@@ -66,13 +64,13 @@
 						MMU_PAGE_TABLES_SIZE)
 #define MMU_CACHE_MNG_ADDR		(MMU_DRAM_DEFAULT_PAGE_ADDR + \
 					MMU_DRAM_DEFAULT_PAGE_SIZE)
-#define CPU_PQ_PKT_ADDR			(MMU_CACHE_MNG_ADDR + \
+#define DRAM_KMD_END_ADDR		(MMU_CACHE_MNG_ADDR + \
 						MMU_CACHE_MNG_SIZE)
-#define CPU_PQ_DATA_ADDR		(CPU_PQ_PKT_ADDR + CPU_PQ_PKT_SIZE)
-#define DRAM_BASE_ADDR_USER		(CPU_PQ_DATA_ADDR + CPU_PQ_DATA_SIZE)
 
-#if (DRAM_BASE_ADDR_USER != 0x20000000)
-#error "KMD must reserve 512MB"
+#define DRAM_BASE_ADDR_USER		0x20000000
+
+#if (DRAM_KMD_END_ADDR > DRAM_BASE_ADDR_USER)
+#error "KMD must reserve no more than 512MB"
 #endif
 
 /*
-- 
2.17.1

