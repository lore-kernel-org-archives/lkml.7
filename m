Return-Path: <SRS0=wo+8=V5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAF01C19759
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 23:04:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8AE4720657
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 23:04:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PYmFSd9X"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390192AbfHAXES (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Aug 2019 19:04:18 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:37239 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390169AbfHAXER (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Aug 2019 19:04:17 -0400
Received: by mail-lj1-f195.google.com with SMTP id z28so16777755ljn.4
        for <linux-kernel@vger.kernel.org>; Thu, 01 Aug 2019 16:04:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=mT/2m/9qbWNTbXIk8Wb+T4VA3gqIoG68CWxRMparBxc=;
        b=PYmFSd9Xncq9yq+ojCef0TO9AkLSYNoCjUFOcw7eI77ElrNAqgoW+p7d427t1RASyv
         8RXFu0MGmH5WoCehuZ2DhSRhMdk0jzdu1tOvE/ypIJB6AXx+/cbyz2IfLhcrFiYsSoBg
         v9iTEnAoeYZcfyexcbU+iwFiT8FPtK131g9TqPl2MfnYWhSugFsmIfx+ch0dJ3dDsZCh
         8QUyCUBnCiYrZqT1vLsG1x7aCSAbvvFtigv53pxdxfrrp86Uz3iuv2kkbdOPqXjiff/+
         1rA2gY7JLidn+5pTDSWiQXsn8++uhaaDBuCWw2Tt1QnfklzqaNIsFnLE4TB9keMGVFtn
         czaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=mT/2m/9qbWNTbXIk8Wb+T4VA3gqIoG68CWxRMparBxc=;
        b=RSiJcEGtCVQvJVEvwEwp+vdowFS/nLGlooxCls1ID8aoSxf8yOdFgTJO4hS/xWpXT4
         6eRM8oUA83Rk09AU17rECCIop2/J9a9QHAyweHMxSFqYZCDFdFNgmQFs8ILHIiNTRCzi
         4hRBZa+FLp3JGgjbaWhPW9bN6dsuSM5eKPbAjKF/TkfZei2w0tuJub0SNYAP4LD/TEFU
         4ROvJWg1srRDefFTIkG/kYv88DW/HMxP8S81VrVsUHemEFrNUrxxWrTuhornWiVROY4K
         5Bfc/PyyBQknGJASQvzyUd+mQt4oX3EcGOOVGZIlwHtocuYpyfV0t4IIF7kU115yNEnq
         hxlA==
X-Gm-Message-State: APjAAAUb8mkmJFHCAMTiruvv0naUTQLgUz/jc//QBAP4LfZvXLQPrZwX
        Sz4H5TBE9IHDZgXWxEq66bE=
X-Google-Smtp-Source: APXvYqyWx9SY+gvRPuxFbygT+Bq7WwGTq2q0DU0NI/mp4EpcqVW0voSTxHuTpyCuxinF/2lyRTrMFg==
X-Received: by 2002:a2e:96d5:: with SMTP id d21mr32290781ljj.170.1564700655789;
        Thu, 01 Aug 2019 16:04:15 -0700 (PDT)
Received: from localhost.localdomain (h-158-174-186-115.NA.cust.bahnhof.se. [158.174.186.115])
        by smtp.gmail.com with ESMTPSA id u18sm12377017lfe.65.2019.08.01.16.04.14
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 01 Aug 2019 16:04:15 -0700 (PDT)
From:   Rikard Falkeborn <rikard.falkeborn@gmail.com>
To:     rikard.falkeborn@gmail.com
Cc:     akpm@linux-foundation.org, joe@perches.com,
        johannes@sipsolutions.net, linux-kernel@vger.kernel.org,
        yamada.masahiro@socionext.com
Subject: [PATCH v2 1/2] linux/bits.h: Clarify macro argument names
Date:   Fri,  2 Aug 2019 01:03:57 +0200
Message-Id: <20190801230358.4193-1-rikard.falkeborn@gmail.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190731190309.19909-1-rikard.falkeborn@gmail.com>
References: <20190731190309.19909-1-rikard.falkeborn@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Be a little more verbose to improve readability.

Signed-off-by: Rikard Falkeborn <rikard.falkeborn@gmail.com>
---
Changes in v2:
  - This patch is new in v2

 include/linux/bits.h | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/include/linux/bits.h b/include/linux/bits.h
index 669d69441a62..d4466aa42a9c 100644
--- a/include/linux/bits.h
+++ b/include/linux/bits.h
@@ -14,16 +14,16 @@
 #define BITS_PER_BYTE		8
 
 /*
- * Create a contiguous bitmask starting at bit position @l and ending at
- * position @h. For example
+ * Create a contiguous bitmask starting at bit position @low and ending at
+ * position @high. For example
  * GENMASK_ULL(39, 21) gives us the 64bit vector 0x000000ffffe00000.
  */
-#define GENMASK(h, l) \
-	(((~UL(0)) - (UL(1) << (l)) + 1) & \
-	 (~UL(0) >> (BITS_PER_LONG - 1 - (h))))
+#define GENMASK(high, low) \
+	(((~UL(0)) - (UL(1) << (low)) + 1) & \
+	 (~UL(0) >> (BITS_PER_LONG - 1 - (high))))
 
-#define GENMASK_ULL(h, l) \
-	(((~ULL(0)) - (ULL(1) << (l)) + 1) & \
-	 (~ULL(0) >> (BITS_PER_LONG_LONG - 1 - (h))))
+#define GENMASK_ULL(high, low) \
+	(((~ULL(0)) - (ULL(1) << (low)) + 1) & \
+	 (~ULL(0) >> (BITS_PER_LONG_LONG - 1 - (high))))
 
 #endif	/* __LINUX_BITS_H */
-- 
2.22.0

