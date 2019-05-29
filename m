Return-Path: <SRS0=t3dz=T5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C192C04AB3
	for <linux-kernel@archiver.kernel.org>; Wed, 29 May 2019 04:50:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CFCA021734
	for <linux-kernel@archiver.kernel.org>; Wed, 29 May 2019 04:50:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lmVPkSv/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726240AbfE2Eux (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 May 2019 00:50:53 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:35732 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725840AbfE2Eux (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 May 2019 00:50:53 -0400
Received: by mail-pf1-f193.google.com with SMTP id d126so793984pfd.2
        for <linux-kernel@vger.kernel.org>; Tue, 28 May 2019 21:50:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=CyPwB/k4LFoClaiLVBQxovYOmxxMr+596PldieepkDE=;
        b=lmVPkSv/sd0GNlqoI6FOamK4KmX+xvjQg5jM+YDHvD1pwgKbTb7fijqRRHS+6JKG5o
         Ptfl5l2AvdW0d/V2C3875TFMxlHdbJIMT8cWwg2IlDQT3OSk4GegUyhiZ+vQkDXP0iqo
         Tt8wkXqfoocD+qyQmdg8dRlo5htKdSyf7+G8iphFaINdd99dAFFjr5VpNr0SjkRGYfoS
         zS3fCNl/vslkF31ZjdsGFDtO5DUXXkO+0odgdbjykv4T3ViO38JSgRcmtJ1YqY2lx/iX
         QnX715w7RiDi01SmATqdIZ36rLLVkD+MrZLjJi2ywRbK3GB1S+JKMI09ZNjcr3DgCVJX
         hY8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=CyPwB/k4LFoClaiLVBQxovYOmxxMr+596PldieepkDE=;
        b=CxiuzTleFM63e9hO6EzdoMtJTpp36B4MQjomRmLdkCHp7/Ft5EIk7mUXABoQPZ0Z1a
         eAKbmlywfjU1e/RuPRwZjZxSIA5IPQ8BEUgeY811kZmgOQi7aax7jRSiAvLI+JPXI46T
         V6WLvhvLV4DB3sJXoIJo6r7AzH9PtJ2OSFAmAJgo5S8DFhY53WvEqdPtn7J4kGt+sZx4
         o3RPVj2PY8wdMxV0PqvnXe6aJv4L/WCTGDqL7ZT6HiCV//AD/wAMU42kFHXcYTWqsg9c
         1xxC/xkN2woyCSgrDJUiavf2hbN9gTUNqcBrvUlrUrKk+Yk2OmogiyvB5axI+f+nbSF9
         W4hw==
X-Gm-Message-State: APjAAAUhxaOLq/8zfjLWAxBTJzrwpI2rVYpG+cMoJc7i0ti9wOYhADc/
        nXg5hy8C8lit/YV2u5X9byU=
X-Google-Smtp-Source: APXvYqxNMpF8WZCcRTaxgNjPKJn3GOZr3mEe5I8fLX3gFd0syMu5YuSdpRkp7L2I/UUreUkIWPU6Fg==
X-Received: by 2002:a63:c24c:: with SMTP id l12mr137439663pgg.173.1559105453029;
        Tue, 28 May 2019 21:50:53 -0700 (PDT)
Received: from xy-data.openstacklocal (ecs-159-138-22-150.compute.hwclouds-dns.com. [159.138.22.150])
        by smtp.gmail.com with ESMTPSA id h123sm17798359pfe.80.2019.05.28.21.50.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 28 May 2019 21:50:52 -0700 (PDT)
From:   Young Xiao <92siuyang@gmail.com>
To:     airlied@linux.ie, arnd@arndb.de, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org
Cc:     Young Xiao <92siuyang@gmail.com>
Subject: [PATCH] amd64-agp: fix arbitrary kernel memory writes
Date:   Wed, 29 May 2019 12:52:01 +0800
Message-Id: <1559105521-27053-1-git-send-email-92siuyang@gmail.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

pg_start is copied from userspace on AGPIOC_BIND and AGPIOC_UNBIND ioctl
cmds of agp_ioctl() and passed to agpioc_bind_wrap().  As said in the
comment, (pg_start + mem->page_count) may wrap in case of AGPIOC_BIND,
and it is not checked at all in case of AGPIOC_UNBIND.  As a result, user
with sufficient privileges (usually "video" group) may generate either
local DoS or privilege escalation.

See commit 194b3da873fd ("agp: fix arbitrary kernel memory writes")
for details.

Signed-off-by: Young Xiao <92siuyang@gmail.com>
---
 drivers/char/agp/amd64-agp.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/char/agp/amd64-agp.c b/drivers/char/agp/amd64-agp.c
index c69e39f..5daa0e3 100644
--- a/drivers/char/agp/amd64-agp.c
+++ b/drivers/char/agp/amd64-agp.c
@@ -60,7 +60,8 @@ static int amd64_insert_memory(struct agp_memory *mem, off_t pg_start, int type)
 
 	/* Make sure we can fit the range in the gatt table. */
 	/* FIXME: could wrap */
-	if (((unsigned long)pg_start + mem->page_count) > num_entries)
+	if (((pg_start + mem->page_count) > num_entries) ||
+	    ((pg_start + mem->page_count) < pg_start))
 		return -EINVAL;
 
 	j = pg_start;
-- 
2.7.4

