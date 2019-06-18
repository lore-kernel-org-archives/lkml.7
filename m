Return-Path: <SRS0=h0iA=UR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53400C31E51
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Jun 2019 07:21:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2895F2080A
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Jun 2019 07:21:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pksCcVRv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728995AbfFRHVN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Jun 2019 03:21:13 -0400
Received: from mail-oi1-f194.google.com ([209.85.167.194]:38394 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725913AbfFRHVN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jun 2019 03:21:13 -0400
Received: by mail-oi1-f194.google.com with SMTP id v186so8303896oie.5;
        Tue, 18 Jun 2019 00:21:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=zk9bWRMIeF1BfW35qp0hNrZwOQClEBtp/7mR1b//Sds=;
        b=pksCcVRvsSoRLVbGmlM9vkhddYn81FdHuqb2RoiaVM1hdZf4Fz7tdW5XfA8dUqZEcr
         q98RHckxVceJloQxaroM5i1vjzSrgNKlMIgYxX0Ok8+lkW5UzpKXqrw+FPkVW5IYdhah
         Miw559GZlOna63lFVsvKKspAxTRhhiCatrjp3rTZN+lt/Q8xN9kAUVWVcZ6tk4+LpCbN
         4bT8jVzwJsIz3xqJYuZh2I0fQ/pvWk5Sl5leMLjF/FdegLAnZFx55cL/Fup2iZXFTGY3
         jBYDdgExFKP8PEW1TGY8zs+IS+I5NAsINO75YoqhKdRlb//iwTC6Bjm9I7bsgN2ymyr1
         d6Hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=zk9bWRMIeF1BfW35qp0hNrZwOQClEBtp/7mR1b//Sds=;
        b=U8SIFJAu6/xmgcwI34VPCGyNRcQ9Db3vV6IVie2IGKycYA1bdxkvidH2yLdzSJkdp6
         63C8fjFMFac0AbBDkvXSABKr9y1gf1bAbVUdjRKLuzPH35W1tuEg++1IvIm6800suXx1
         dtOPh9syVLCd7uAyqeeWzYynEVjtalJRshigt2bGdnLfPQVCGtYnDMat0SLEEGptHTwT
         V2NQaHcczPbUvkWiSWWQ8LDf1dtFO7g7RDVQ+mpbXVzzCragtdzWQYpeWTYkjuSj2Tyh
         FWxviq5NCe4m8RsPACUHIeDYgpCZ/azTBHjXdjVSL8spL+WnAbweU6sweAIY0LYgdQfj
         4sUQ==
X-Gm-Message-State: APjAAAWBo6a8Bsh0YWfaei+9lqBITfshUCR0PeNV1GnDOo2HaQ1yxXti
        mF/Mi/I6V6aVl+PzsJhfW0iHV0yJqwiReQ==
X-Google-Smtp-Source: APXvYqxbFtgEVXknN5nBCSEMIVAKQSNKW3q/Nu7Jv5512Pbro5zbJTVbUyDzdCQyb8/dsWHODIhTFQ==
X-Received: by 2002:a63:5d45:: with SMTP id o5mr995156pgm.40.1560835984975;
        Mon, 17 Jun 2019 22:33:04 -0700 (PDT)
Received: from localhost.localdomain ([112.196.181.128])
        by smtp.googlemail.com with ESMTPSA id v23sm1242659pju.3.2019.06.17.22.33.02
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 17 Jun 2019 22:33:04 -0700 (PDT)
From:   Puranjay Mohan <puranjay12@gmail.com>
To:     Shuah Khan <skhan@linuxfoundation.org>
Cc:     Puranjay Mohan <puranjay12@gmail.com>,
        linux-kernel-mentees@lists.linuxfoundation.org,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] Documentation: platform: convert x86-laptop-drivers.txt to reST
Date:   Tue, 18 Jun 2019 11:02:27 +0530
Message-Id: <20190618053227.31678-1-puranjay12@gmail.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This converts the plain text documentation to reStructuredText format.
No essential content change.

Signed-off-by: Puranjay Mohan <puranjay12@gmail.com>
---
 Documentation/platform/x86-laptop-drivers.rst | 23 +++++++++++++++++++
 Documentation/platform/x86-laptop-drivers.txt | 18 ---------------
 2 files changed, 23 insertions(+), 18 deletions(-)
 create mode 100644 Documentation/platform/x86-laptop-drivers.rst
 delete mode 100644 Documentation/platform/x86-laptop-drivers.txt

diff --git a/Documentation/platform/x86-laptop-drivers.rst b/Documentation/platform/x86-laptop-drivers.rst
new file mode 100644
index 000000000000..0494c3fdd41c
--- /dev/null
+++ b/Documentation/platform/x86-laptop-drivers.rst
@@ -0,0 +1,23 @@
+=============
+compal-laptop
+=============
+
+List of supported hardware:
+===========================
+
+by Compal:
+----------
+- Compal FL90/IFL90
+- Compal FL91/IFL91
+- Compal FL92/JFL92
+- Compal FT00/IFT00
+
+by Dell:
+--------
+- Dell Vostro 1200
+- Dell Mini 9 (Inspiron 910)
+- Dell Mini 10 (Inspiron 1010)
+- Dell Mini 10v (Inspiron 1011)
+- Dell Mini 1012 (Inspiron 1012)
+- Dell Inspiron 11z (Inspiron 1110)
+- Dell Mini 12 (Inspiron 1210)
diff --git a/Documentation/platform/x86-laptop-drivers.txt b/Documentation/platform/x86-laptop-drivers.txt
deleted file mode 100644
index 01facd2590bb..000000000000
--- a/Documentation/platform/x86-laptop-drivers.txt
+++ /dev/null
@@ -1,18 +0,0 @@
-compal-laptop
-=============
-List of supported hardware:
-
-by Compal:
-	Compal FL90/IFL90
-	Compal FL91/IFL91
-	Compal FL92/JFL92
-	Compal FT00/IFT00
-
-by Dell:
-	Dell Vostro 1200
-	Dell Mini 9 (Inspiron 910)
-	Dell Mini 10 (Inspiron 1010)
-	Dell Mini 10v (Inspiron 1011)
-	Dell Mini 1012 (Inspiron 1012)
-	Dell Inspiron 11z (Inspiron 1110)
-	Dell Mini 12 (Inspiron 1210)
-- 
2.21.0

