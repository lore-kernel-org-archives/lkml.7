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
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8081C31E51
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Jun 2019 11:51:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B7F542070B
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Jun 2019 11:51:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AqKDmnWs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729875AbfFRLvk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Jun 2019 07:51:40 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:43797 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729712AbfFRLvj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jun 2019 07:51:39 -0400
Received: by mail-pg1-f196.google.com with SMTP id f25so7554775pgv.10
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jun 2019 04:51:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=hOk9gY1GdDIpq9WFwxD8Zh8kzeuAf1EMdWtPmOoiuzs=;
        b=AqKDmnWseRoJeA/3BNBy+a5FBQW8eiNJDcZX456wTgOVsvBSVCHPmSWSzyAqPWRcnA
         J3EMYFNhOSO7hI6qVXjTVW6N+OWkKYCZ/ULBswodowOiCTfgz53MwYqZLt53MlEEwcLa
         n9Rbfk34fPHEx8BW92+P7a74aqJ6Q1G0Rb7X4RxW/YBd20UuEMmtby24fuj5ZNN2lurZ
         6lgR/Qo4D7469iHpS6H5A/RNHhH14xLvp7qsomG/KZp/q7PISrhgK/7KRiz/EI1fO6BC
         E9lLuceW7vfY1ZGb7dGZI2feReXQ5TZTeOyIzcSn8pk6c8pdcDSJUH26wZCVwCG4U8vK
         U2WA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=hOk9gY1GdDIpq9WFwxD8Zh8kzeuAf1EMdWtPmOoiuzs=;
        b=foeFYWaE/XxEW8Tla1dZ5/HpK+a32ATC9hrBFPRs9ghPLwNMO47yg/mb4csbFBUaBk
         7jZ0koy9PawXphxC/uhmI/kCJBvVDCpOXLQXjtdtnjszR5mXsaZ/oTH9cFmf40sMl0IF
         OfnJSbW9JNxngTQKVqDLyH4iBHt3w00AUnL2NSkePKdflFmgmlC3AnZ7kHnIsNdCQPnA
         amkZDttJvxoDlvSVgxl8kGIPjEFjAg/nDRDX8eXnkVmPG1T7QyBh7DC/xpgcn7LRIVKi
         jdvgmsMrKYjUt5gBwyKHN9jXHz0YOpB+z3XnHv7KdUJUWf7JSlhAxz2xe1wVAoR6Mg3D
         mD9g==
X-Gm-Message-State: APjAAAVnQD+D61HTD1Ncq6uO2ui0U2pDCNXpazXQ3Itej53wacGYOf47
        3/6Pb7Si7Qf/DQb1sU4D1r8=
X-Google-Smtp-Source: APXvYqyEMwNhC9kLz86UW3VtQ0AZ9v9YW7LRqiXCLayEi85g8rjqKU/xS8FC0KmaWUIJmp9nDMgJRw==
X-Received: by 2002:a17:90a:ac0e:: with SMTP id o14mr4782406pjq.142.1560858698876;
        Tue, 18 Jun 2019 04:51:38 -0700 (PDT)
Received: from localhost.localdomain ([2402:3a80:971:2367:ff63:bd87:123c:3583])
        by smtp.googlemail.com with ESMTPSA id s9sm2070256pjp.7.2019.06.18.04.51.35
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 18 Jun 2019 04:51:38 -0700 (PDT)
From:   Puranjay Mohan <puranjay12@gmail.com>
To:     Shuah Khan <skhan@linuxfoundation.org>
Cc:     Puranjay Mohan <puranjay12@gmail.com>,
        linux-kernel-mentees@lists.linuxfoundation.org,
        linux-kernel@vger.kernel.org, hch@infradead.org
Subject: [PATCH v2] fs: cramfs_fs.h: Fix shifting signed 32-bit value by 31 bits problem
Date:   Tue, 18 Jun 2019 17:19:47 +0530
Message-Id: <20190618114947.10563-1-puranjay12@gmail.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix CRAMFS_BLK_FLAG_UNCOMPRESSED to use "U" cast to avoid shifting signed
32-bit value by 31 bits problem. This isn't a problem for kernel builds
with gcc.

This could be problem since this header is part of public API which
could be included for builds using compilers that don't handle this
condition safely resulting in undefined behavior.

Signed-off-by: Puranjay Mohan <puranjay12@gmail.com>
---
V2 - use the unsigned constants for all flags, not just one

 include/uapi/linux/cramfs_fs.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/uapi/linux/cramfs_fs.h b/include/uapi/linux/cramfs_fs.h
index 6713669aa2ed..71cb602d4198 100644
--- a/include/uapi/linux/cramfs_fs.h
+++ b/include/uapi/linux/cramfs_fs.h
@@ -98,8 +98,8 @@ struct cramfs_super {
  *
  * That leaves room for 3 flag bits in the block pointer table.
  */
-#define CRAMFS_BLK_FLAG_UNCOMPRESSED	(1 << 31)
-#define CRAMFS_BLK_FLAG_DIRECT_PTR	(1 << 30)
+#define CRAMFS_BLK_FLAG_UNCOMPRESSED	(1U << 31)
+#define CRAMFS_BLK_FLAG_DIRECT_PTR	(1U << 30)
 
 #define CRAMFS_BLK_FLAGS	( CRAMFS_BLK_FLAG_UNCOMPRESSED \
 				| CRAMFS_BLK_FLAG_DIRECT_PTR )
-- 
2.21.0

