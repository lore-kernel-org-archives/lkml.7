Return-Path: <SRS0=lq4r=TU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7F65C04AAC
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 15:24:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 781032054F
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 15:24:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZZ8qMKt2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392076AbfETPYw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 May 2019 11:24:52 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:40586 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387783AbfETPYw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 May 2019 11:24:52 -0400
Received: by mail-pf1-f193.google.com with SMTP id u17so7393073pfn.7
        for <linux-kernel@vger.kernel.org>; Mon, 20 May 2019 08:24:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=uk849dcKmoqtNYZ7eIsEjVmGVspH3FFqGVpKFEH8i9o=;
        b=ZZ8qMKt246wsD17eM1gv1+70aRKyqr1s8GR/CGTaqJyuEgSqrj3cRHAfkywZzXGN3w
         pZfZrQ+kKUdjiI2RK8SpGtGITR3IjdgF0JwqClwVAtoCz5KiySr9Q3LwokSPXZ6y7RlA
         e4htp38Cnz/o6UGAabOHWqUnV7pwCTyjSoseSq2YBoJ5XWo2bCOLhrRPldyxbGXrbE8P
         EQjj0yl9NFx8eZI4M3WU7KdVhr9XcN6S+t55Rvn71AXom5U3qBg4OCHmU17j2XTi+oYV
         YRhgZq69dy+LR/lCBUqiJzZZkvg3dUz2jrtopy4txrbgJmQS1CyeXCF8zPsCu6gX2LxH
         EiRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=uk849dcKmoqtNYZ7eIsEjVmGVspH3FFqGVpKFEH8i9o=;
        b=k9FldQUj6eursbf6uDt6pzLJ8f0n7Uyzyy3O2K10AYAYxdno9Xxnj69F/b5a4pf0k+
         G5sXakKt1xiY5Iz5bUL3Zl9my3IqV8YWKsIZk1UEdfJV4xGPlykec3BAZ7dkAryJsn7X
         Awv06V/Av0TFKw/MEpUkrVRPXu5bNYfWJLbnR/WfokbmcGtZs6ysUyQL1dy7sFWlRSS5
         uycv2j1JRBn6iIRFE/WMekaORi/efKXJG2tqOxeOY8rWSC54tOBKONWs7WmEEBsU2q/Y
         8Y8Y62jiyNmSKdKtb0euFTCBZKnA0MEMMagCW3rok+HhFUCESgpU7blvK7vfUr0KRjpn
         eS0g==
X-Gm-Message-State: APjAAAU3wn8Jb9z2yd3Dj76sKCZ3uOtmT/OiXtpmFFT0IeCHzpLtddtv
        WSXAR5qrIeSKBZ4UeftzYNc=
X-Google-Smtp-Source: APXvYqwyXn2QfIUSh4Bsml8Wczd1ITUi8sjw0fVBO5AhMEakb/0LrV0/oQ6eSKM8tB+PxEOC4Ou7gA==
X-Received: by 2002:a65:6145:: with SMTP id o5mr76017985pgv.262.1558365891426;
        Mon, 20 May 2019 08:24:51 -0700 (PDT)
Received: from jordon-HP-15-Notebook-PC.domain.name ([106.51.19.216])
        by smtp.gmail.com with ESMTPSA id h13sm21522895pfo.98.2019.05.20.08.24.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 20 May 2019 08:24:50 -0700 (PDT)
From:   Souptick Joarder <jrdr.linux@gmail.com>
To:     miguel.ojeda.sandonis@gmail.com
Cc:     linux-kernel@vger.kernel.org, willy@infradead.org,
        Souptick Joarder <jrdr.linux@gmail.com>
Subject: [PATCH 1/2] auxdisplay/cfag12864bfb.c: Convert to use vm_map_pages_zero()
Date:   Mon, 20 May 2019 20:58:56 +0530
Message-Id: <1558366136-3765-1-git-send-email-jrdr.linux@gmail.com>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

While using mmap, the incorrect value of length and vm_pgoff are
ignored and this driver go ahead with mapping cfag12864b_buffer
to user vma.

Convert vm_insert_pages() to use vm_map_pages_zero(). We could later
"fix" these drivers to behave according to the normal vm_pgoff
offsetting simply by removing the _zero suffix on the function name and
if that causes regressions, it gives us an easy way to revert.

Signed-off-by: Souptick Joarder <jrdr.linux@gmail.com>
---
 drivers/auxdisplay/cfag12864bfb.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/auxdisplay/cfag12864bfb.c b/drivers/auxdisplay/cfag12864bfb.c
index 40c8a55..4074886 100644
--- a/drivers/auxdisplay/cfag12864bfb.c
+++ b/drivers/auxdisplay/cfag12864bfb.c
@@ -52,8 +52,9 @@
 
 static int cfag12864bfb_mmap(struct fb_info *info, struct vm_area_struct *vma)
 {
-	return vm_insert_page(vma, vma->vm_start,
-		virt_to_page(cfag12864b_buffer));
+	struct page *pages = virt_to_page(cfag12864b_buffer);
+
+	return vm_map_pages_zero(vma, &pages, 1);
 }
 
 static struct fb_ops cfag12864bfb_ops = {
-- 
1.9.1

