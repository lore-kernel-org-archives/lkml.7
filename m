Return-Path: <SRS0=21RF=YY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB8CACA9EC3
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Oct 2019 12:32:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7ED3E20578
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Oct 2019 12:32:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="erYhaPxS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727148AbfJaMcI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Oct 2019 08:32:08 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:40318 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726540AbfJaMcH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Oct 2019 08:32:07 -0400
Received: by mail-wm1-f65.google.com with SMTP id w9so5710578wmm.5
        for <linux-kernel@vger.kernel.org>; Thu, 31 Oct 2019 05:32:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=iiHzOSGjJQCbzAPqjvJdPdeBjEgCItMWMSTqs2n37sc=;
        b=erYhaPxSWRVfhrNNnqIaUT+g+dWRZde7NT4EH875tOgjEHGM+u5+tqhAjgf295UGov
         1ksylWK8LlX1QRbjOZVCnx1TX++ahBHiiIbfbSvfYQeK1BDVBmVyIV2a6Ko1gzNy2VAX
         c3UkMCiAw66KI62+j2mpcJtBly0qQnYHTWGYciLEMO6gkzkTk83YmzfFiMWbSFgD4ZET
         HbJL8tRNXynDclIYnori4Hh0M7UknCQ/RLs2q4AyO/8bh9AAZaZh84kWjTXKvFJr9D9B
         YrNv469waBvGh+26F/b/PlIeOttNJOE9U1lBrtFdSgSoJJfQg82quPr28iNZvNGzXxAS
         C7cQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=iiHzOSGjJQCbzAPqjvJdPdeBjEgCItMWMSTqs2n37sc=;
        b=ZgGLNJaZUssptdB1VgHpbCdxjYgL37mQry/QyS+60yGKGiE+wVXBzU23+naT3IisjV
         LOIIwTuCtT+EIQiQCp1Ic4UY7tK+ZsM8Jow5qClVBITWKctb0jbH224lHywLuuTDjAJ9
         Sb2Wm/DhZqdTHwyREqJzrd7MsFxXV3pNYCwFn/0bOrURh4SDd857Sq/xaeO9Ajob77cs
         uKc68FzkcIP2rqG/0nql25Q+AzdAHKzyAm3t9k0fuQ3kBxhAjFZ+k9cCdN40YeZsqpUL
         OR9N5TkdTbOGkya7ttr+CGH1Gtm2sVsrB65zOJoLT1iWUqsqHL1e1OPVzUEl3ppAdZDO
         cK2g==
X-Gm-Message-State: APjAAAXVIDK2YO935ex8GUkA7YHZPpN4MRu8ByrAYd/2IPIQmzh4J4OW
        vXXUw52g6Mf2RHG9PLWm2Xo=
X-Google-Smtp-Source: APXvYqxkpkOYQLV30/Ff/93VXidtzTBAWFFYwx9EdAPa16xsPbMKfZ/bzVQ/qN32HUwutI0smX33OQ==
X-Received: by 2002:a1c:7305:: with SMTP id d5mr4858256wmb.84.1572525125953;
        Thu, 31 Oct 2019 05:32:05 -0700 (PDT)
Received: from localhost ([92.177.95.83])
        by smtp.gmail.com with ESMTPSA id q6sm3879229wrx.30.2019.10.31.05.32.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Oct 2019 05:32:05 -0700 (PDT)
From:   Roi Martin <jroi.martin@gmail.com>
To:     valdis.kletnieks@vt.edu
Cc:     gregkh@linuxfoundation.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, Roi Martin <jroi.martin@gmail.com>
Subject: [PATCH v2 6/6] staging: exfat: replace kmalloc with kmalloc_array
Date:   Thu, 31 Oct 2019 13:31:39 +0100
Message-Id: <20191031123139.32361-1-jroi.martin@gmail.com>
X-Mailer: git-send-email 2.24.0.rc1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace expressions of the form:
	kmalloc(count * size, GFP_KERNEL);
With:
	kmalloc_array(count, size, GFP_KERNEL);

Signed-off-by: Roi Martin <jroi.martin@gmail.com>
---
v2 changes:

This patch has been rebased against the branch "staging-testing" of the
tree:

https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/staging.git

 drivers/staging/exfat/exfat_core.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/exfat/exfat_core.c b/drivers/staging/exfat/exfat_core.c
index f71235c6a338..f4f82aecc05d 100644
--- a/drivers/staging/exfat/exfat_core.c
+++ b/drivers/staging/exfat/exfat_core.c
@@ -713,8 +713,8 @@ static s32 __load_upcase_table(struct super_block *sb, sector_t sector,
 
 	u32 checksum = 0;
 
-	upcase_table = p_fs->vol_utbl = kmalloc(UTBL_COL_COUNT * sizeof(u16 *),
-						GFP_KERNEL);
+	upcase_table = kmalloc_array(UTBL_COL_COUNT, sizeof(u16 *), GFP_KERNEL);
+	p_fs->vol_utbl = upcase_table;
 	if (!upcase_table)
 		return -ENOMEM;
 	memset(upcase_table, 0, UTBL_COL_COUNT * sizeof(u16 *));
@@ -793,8 +793,8 @@ static s32 __load_default_upcase_table(struct super_block *sb)
 	u16	uni = 0;
 	u16 **upcase_table;
 
-	upcase_table = p_fs->vol_utbl = kmalloc(UTBL_COL_COUNT * sizeof(u16 *),
-						GFP_KERNEL);
+	upcase_table = kmalloc_array(UTBL_COL_COUNT, sizeof(u16 *), GFP_KERNEL);
+	p_fs->vol_utbl = upcase_table;
 	if (!upcase_table)
 		return -ENOMEM;
 	memset(upcase_table, 0, UTBL_COL_COUNT * sizeof(u16 *));
-- 
2.20.1

