Return-Path: <SRS0=5O2B=VH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FROM_STARTS_WITH_NUMS,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E94FC73C7C
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jul 2019 10:01:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 02EDF2084B
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jul 2019 10:01:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XggheSc/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727503AbfGJKBk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Jul 2019 06:01:40 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:36215 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725994AbfGJKBk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Jul 2019 06:01:40 -0400
Received: by mail-pf1-f194.google.com with SMTP id r7so872596pfl.3;
        Wed, 10 Jul 2019 03:01:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=oWhtY7VF/0YooGxc360oDSKbTlfpEs5lWHS7BPIJPpE=;
        b=XggheSc/+S6dLAW40vhmTzXkKUDOqr9tyfJ5zD3xq/tu1SgkFHnK+aFANAOmfCWS3S
         2bJUU8amJzfZXEmb4XfDXVH2KUML2cmstd17z7NvMXJsifB+Bea1qtnpjm4bqq9zSfq1
         uolPrZr5tJZu0Lbm1O+eC6qzDKh14uU7fnYs0QbAipXykXS5tUbEi4TLDyWCBFlQ4mnt
         ZNCrC1tPYzV31MNzFKS8E05R08OZhTD5pfYbbe1Lj+0oqUndnKdU7s/hOS24XVYPmwtC
         9Bo3Oz9WZI+n+t86yC+MXN9pCt+JIYiCC/yg2+gBYgV3zRON2EcXRuuNBof1XX3/vKxn
         hDYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=oWhtY7VF/0YooGxc360oDSKbTlfpEs5lWHS7BPIJPpE=;
        b=aZ/qkHlRGnVOI+x4/6jIGIhNoiQtGVOCfhm5P6k7mvwAIseA1arS1rJBaMhYCIjQl/
         xEtTrd2JPaNw/2XS71vjOb2Q84IZnwZ/QPzvC8kKph+E5h9SPQYEqFFB0p+TS4bKME/0
         ubULt8ZxuiNdUyi08wUHAuJ5Lchme6YTARxzYtVyn+w6IGy49R6tBxJvquX0xITwTGYt
         MzcqVPBJoXsEW66sXRa+KDg0vMbs7imnllq7iBVJATHBrIKHFKc0EfSILNFik4KpaLqq
         JkTIvAocc7Sn+E7oaSirvMAFwHjFoBNuDWXyS9MDJqsxLlrAoaZEKeTAZJ78+XTBGa6n
         QkyA==
X-Gm-Message-State: APjAAAV7kKOhx7hk3+X8gbenQoHfd0HuZzEwrcwalnN7wvUtm05EQ/y6
        9pQ6dRC4uNIFWIP9aCcnC7yZxJOiPuL9+A==
X-Google-Smtp-Source: APXvYqxZX+YQAsBXt0Kso/g+3zS8tfNPCvsalPjlDDWX3WD2ie+I3ehs36sH4zgMVmOJ2Hyy5xJwPw==
X-Received: by 2002:a17:90a:77c5:: with SMTP id e5mr5735940pjs.109.1562752898936;
        Wed, 10 Jul 2019 03:01:38 -0700 (PDT)
Received: from sheetal-Inspiron-5537.domain.name ([103.68.35.254])
        by smtp.googlemail.com with ESMTPSA id c5sm1704424pgq.80.2019.07.10.03.01.35
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 10 Jul 2019 03:01:37 -0700 (PDT)
From:   sheetalsingala <2396sheetal@gmail.com>
To:     marcel@holtman.org
Cc:     linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
        sheetalsingala <2396sheetal@gmail.com>
Subject: [PATCH 2/2] Fixed a brace styling issue
Date:   Wed, 10 Jul 2019 15:31:26 +0530
Message-Id: <20190710100126.1519-1-2396sheetal@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixed a coding style issue

Signed-off-by: Sheetal Singala <2396sheetal@gmail.com>
---
 drivers/bluetooth/btintel.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/bluetooth/btintel.c b/drivers/bluetooth/btintel.c
index bb99c8653aab..4a8b812605f3 100644
--- a/drivers/bluetooth/btintel.c
+++ b/drivers/bluetooth/btintel.c
@@ -18,7 +18,7 @@
 
 #define VERSION "0.1"
 
-#define BDADDR_INTEL (&(bdaddr_t) {{0x00, 0x8b, 0x9e, 0x19, 0x03, 0x00}})
+#define BDADDR_INTEL (&(bdaddr_t) {0x00, 0x8b, 0x9e, 0x19, 0x03, 0x00})
 
 int btintel_check_bdaddr(struct hci_dev *hdev)
 {
-- 
2.17.1

