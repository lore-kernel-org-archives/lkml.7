Return-Path: <SRS0=TpO6=UA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1DA0C28CC1
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Jun 2019 18:44:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C953527799
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Jun 2019 18:44:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Cvma/tJ4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726965AbfFASo0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 1 Jun 2019 14:44:26 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:35742 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726884AbfFASoT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Jun 2019 14:44:19 -0400
Received: by mail-pf1-f193.google.com with SMTP id d126so8200596pfd.2
        for <linux-kernel@vger.kernel.org>; Sat, 01 Jun 2019 11:44:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=YwCCxRSn7S+aZ89GrQp9eL9ZxtaUz94owFWdDgVxvXo=;
        b=Cvma/tJ4jhnnxmavSW5R8HdynzVCIFeNgUpgbtgjG+dibHth/4z0OfBZ5OZ9hHsqp2
         fN8zWA3sCEZf3ysvc64SlYmCn2GiBMZ+O1ekdvDTwIz4khNT4+l13rK5uE7izEKjiChJ
         /OQ1ftJ4SpDNCPDRh/Ec6zkJe3pH7+HOsxTN4AZ55u86I/Kax4UWnLA2wGeduFouNTLh
         BkcDL1mgmqxOsW71GpHy/NHAfB8MbvgcOePKpKq3CWgzGZiL1NQD0mfdJ5SihtGVbBFT
         KxkDVDWM4vi8lvXGBwL+S3SamPngToQ3Zwf6a9hE8CSj1FKuiYpkdoWWSdi2FaW25y5C
         az7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=YwCCxRSn7S+aZ89GrQp9eL9ZxtaUz94owFWdDgVxvXo=;
        b=ZEy9gDN2/wwZoHqaWB1df2ulyrbSHLlCRNVUaKlfXi+jbyL66xu/hAuvstadoxw36m
         /Fv8Ly2hC3YfHCKZIZu4+L/4AQM9Fnf/UaA0T/c0/Z6HexIJ7IfFMjN72j6/wfGuZthf
         t+v4Wf0W3LoUP84omkvVWde8+Yi7Un0vEi8GCIY36Vstce8bXqtuFP9f36sYh4SvA44P
         FdRq9aG4UxvF9rlLtbNnPpjdbtUrWRQCqjAiUJ+t66uLULpmga+txwe/0yRo9RDtyml4
         c8KhHasDuGLnxb/s2GOHi45mB7i8Taxme74HEvl5uGnAJPRoDlYoqXow7w7hij+CE4aT
         6kJA==
X-Gm-Message-State: APjAAAXQog9PybU0LPMyJaCC9/71dPVZfFwXmZA7kNv5y0rYYEi+ddBr
        ba4BWmkbAogDwcZnguhKAyesOCMz
X-Google-Smtp-Source: APXvYqzrzNvSac9MVtF5aUtRu2mi+jF6DkdPsk5qIIpChJ6nzwwvFC1p1GMaiZQBHa1afdaWw7aVQQ==
X-Received: by 2002:a62:1707:: with SMTP id 7mr5319585pfx.26.1559414658614;
        Sat, 01 Jun 2019 11:44:18 -0700 (PDT)
Received: from localhost.localdomain ([117.192.16.207])
        by smtp.googlemail.com with ESMTPSA id w187sm13287950pfw.20.2019.06.01.11.44.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 01 Jun 2019 11:44:18 -0700 (PDT)
From:   Deepak Mishra <linux.dkm@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     gregkh@linuxfoundation.org, Larry.Finger@lwfinger.net,
        florian.c.schilhabel@googlemail.com, linux.dkm@gmail.com,
        himadri18.07@gmail.com, straube.linux@gmail.com
Subject: [PATCH 6/8] staging: rtl8712: Fixed CamelCase in struct _adapter from drv_types.h
Date:   Sun,  2 Jun 2019 00:13:40 +0530
Message-Id: <2f2a4ffa529fb35ebfb0e7e5afa4b3969fd9c1a7.1559412149.git.linux.dkm@gmail.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <cover.1559412149.git.linux.dkm@gmail.com>
References: <cover.1559412149.git.linux.dkm@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fixes CamelCase as reported by checkpatch.pl
xmitThread renamed to xmit_thread
recvThread renamed to recv_thread

Signed-off-by: Deepak Mishra <linux.dkm@gmail.com>
---
 drivers/staging/rtl8712/drv_types.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/rtl8712/drv_types.h b/drivers/staging/rtl8712/drv_types.h
index a5060a020b2b..1f8aa0358b77 100644
--- a/drivers/staging/rtl8712/drv_types.h
+++ b/drivers/staging/rtl8712/drv_types.h
@@ -154,8 +154,8 @@ struct _adapter {
 	u8	hw_init_completed;
 	struct task_struct *cmd_thread;
 	pid_t evt_thread;
-	struct task_struct *xmitThread;
-	pid_t recvThread;
+	struct task_struct *xmit_thread;
+	pid_t recv_thread;
 	uint (*dvobj_init)(struct _adapter *adapter);
 	void (*dvobj_deinit)(struct _adapter *adapter);
 	struct net_device *pnetdev;
-- 
2.19.1

