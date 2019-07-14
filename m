Return-Path: <SRS0=2uMJ=VL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1EECC73C66
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Jul 2019 06:11:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7DECA2064A
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Jul 2019 06:11:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=umn.edu header.i=@umn.edu header.b="jN/bI1bI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726447AbfGNGLy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 14 Jul 2019 02:11:54 -0400
Received: from mta-p6.oit.umn.edu ([134.84.196.206]:57538 "EHLO
        mta-p6.oit.umn.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725924AbfGNGLx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Jul 2019 02:11:53 -0400
Received: from localhost (unknown [127.0.0.1])
        by mta-p6.oit.umn.edu (Postfix) with ESMTP id 3FF62B4F
        for <linux-kernel@vger.kernel.org>; Sun, 14 Jul 2019 06:11:52 +0000 (UTC)
X-Virus-Scanned: amavisd-new at umn.edu
Received: from mta-p6.oit.umn.edu ([127.0.0.1])
        by localhost (mta-p6.oit.umn.edu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id rEwsikVFp1Zs for <linux-kernel@vger.kernel.org>;
        Sun, 14 Jul 2019 01:11:52 -0500 (CDT)
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
        (using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mta-p6.oit.umn.edu (Postfix) with ESMTPS id 1E76FAF9
        for <linux-kernel@vger.kernel.org>; Sun, 14 Jul 2019 01:11:52 -0500 (CDT)
Received: by mail-io1-f69.google.com with SMTP id z19so16145174ioi.15
        for <linux-kernel@vger.kernel.org>; Sat, 13 Jul 2019 23:11:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umn.edu; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=abpklZSBAfOlfsssLozmiWnThFIhDBs68Sr5R6i8zgQ=;
        b=jN/bI1bI6xTmwDyipxMxz/+vydprSdp+731cfgIZ3E4TrNh/wc3iqzg01cgpNl+rtU
         PIAaMwgc10K/7ZSWBwXQ8358tEi2J4gjiRqH+uQChhph+18e7U0u6JCxX0zr9wV42BlL
         VZq/GKExo1/jc7ECpFVB1clWuwwCHdxB9iPAdhTjs/4QtXQtSDx0zZoIa9CP59AfnJoB
         04QjtoKc69p97oLPt2r/ch0HmOrQ1cmqLrK4buAO9qe+egjyfgJT5eqD6QIwCULlOFoO
         rpsQje2CT1jVm+bzpUFECnQGgzDU/bI1KEP06M0ukqCZSaHlCKCsDDLUtdbPnukSZHnY
         r8iA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=abpklZSBAfOlfsssLozmiWnThFIhDBs68Sr5R6i8zgQ=;
        b=Lwh3XT1C7Rpun2LmlYlQBub9krxRWpw+mLWFF0bqX+wuZtRX799CI3fEORpOtGETqL
         b/dsR7hkAIA2I2QaaBZ3cJ1LrLSW8wAM8leT7mQD/qfdd4enE7FOYYDFs/xAGqdqAxYR
         Rx1NbVWVZetQkTq3QHZVEpJpy2PcUwGW6YdQUkNupENLHt5eT0RHVfXBXhYtTzcjT7yp
         yyL3jS0yeueIWIe6tjDUvDFy3gFwo61p6bncJGuT7MJnIJ76P/AiGJAjxEyIpqBZHVPQ
         E4ottCxxekZQtvIuKMCaP17LL+1pDeJHeShPt7xxV0Ax1c+yEigA06O+/fbxcIYJ9Luf
         /g0Q==
X-Gm-Message-State: APjAAAX+N1Ns68enaMYwltJQ6z23toYfukZZHOV8O4Mcr1KsZ7d3Vp5T
        yIAyraXmRPEv7C8OzIQqz9dOQ9oKGa9qBn+hHNwxqKMAgq1eNU1hdy8IlTdmJAC5VH22pkU8LrY
        vOSBXtDMroHK8xXR2Q1n02jtlxITH
X-Received: by 2002:a5d:964d:: with SMTP id d13mr6785445ios.224.1563084711816;
        Sat, 13 Jul 2019 23:11:51 -0700 (PDT)
X-Google-Smtp-Source: APXvYqyEqKAHBewvhUurGCo8HKrL1xmimR0mO4aQ450XDds19Izi7vlroJwNJbusVoJxukPsZtoECg==
X-Received: by 2002:a5d:964d:: with SMTP id d13mr6785429ios.224.1563084711624;
        Sat, 13 Jul 2019 23:11:51 -0700 (PDT)
Received: from BlueSky.hsd1.mn.comcast.net (c-66-41-25-226.hsd1.mn.comcast.net. [66.41.25.226])
        by smtp.gmail.com with ESMTPSA id s4sm19014746iop.25.2019.07.13.23.11.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 13 Jul 2019 23:11:50 -0700 (PDT)
From:   Wenwen Wang <wang6495@umn.edu>
To:     Wenwen Wang <wenwen@cs.uga.edu>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Colin Ian King <colin.king@canonical.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] test_firmware: fix a memory leak bug
Date:   Sun, 14 Jul 2019 01:11:35 -0500
Message-Id: <1563084696-6865-1-git-send-email-wang6495@umn.edu>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Wenwen Wang <wenwen@cs.uga.edu>

In test_firmware_init(), the buffer pointed to by the global pointer
'test_fw_config' is allocated through kzalloc(). Then, the buffer is
initialized in __test_firmware_config_init(). In the case that the
initialization fails, the following execution in test_firmware_init() needs
to be terminated with an error code returned to indicate this failure.
However, the allocated buffer is not freed on this execution path, leading
to a memory leak bug.

To fix the above issue, free the allocated buffer before returning from
test_firmware_init().

Signed-off-by: Wenwen Wang <wenwen@cs.uga.edu>
---
 lib/test_firmware.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/lib/test_firmware.c b/lib/test_firmware.c
index 83ea6c4..6ca97a6 100644
--- a/lib/test_firmware.c
+++ b/lib/test_firmware.c
@@ -886,8 +886,11 @@ static int __init test_firmware_init(void)
 		return -ENOMEM;
 
 	rc = __test_firmware_config_init();
-	if (rc)
+	if (rc) {
+		kfree(test_fw_config);
+		pr_err("could not init firmware test config: %d\n", rc);
 		return rc;
+	}
 
 	rc = misc_register(&test_fw_misc_device);
 	if (rc) {
-- 
2.7.4

