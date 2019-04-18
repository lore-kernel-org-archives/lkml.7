Return-Path: <SRS0=NWWL=SU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EAD9C10F0B
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 07:50:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E11FD2183F
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 07:50:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="JlMxKBLM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388125AbfDRHuh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Apr 2019 03:50:37 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:43503 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725747AbfDRHuh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Apr 2019 03:50:37 -0400
Received: by mail-pg1-f196.google.com with SMTP id z9so798029pgu.10
        for <linux-kernel@vger.kernel.org>; Thu, 18 Apr 2019 00:50:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=1+u7DKJJDYH4Nv31VWy+05JzeHtfYaxqUK6Ky58Kb+o=;
        b=JlMxKBLMdN5Q35ZfymHUS0hQqCDXg8FEI2v7sxeO4UB8u8fM5lDI8S3GTnGBLL2rZt
         YAWfUUzHkp5Qb4D52ytlW6ByOSshgU5uPnRAJVZdVaPIlkF6AaahpVz3f8yeMogLwjZN
         OBRG17mhEdCIoTOAaq1IoSCWFTZwoZvfDul6c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=1+u7DKJJDYH4Nv31VWy+05JzeHtfYaxqUK6Ky58Kb+o=;
        b=MNsrPSnywrxJRpHB0ZQeidY6lGs132rYAttqHbOEnYvqAU0rrQ0CppgblN9SxJOGbx
         38+S+gA8ZxEB9SWuhkbQ/xZXSnyDOMNeDi7VwEeeYzxsOdV9c+S+MwOVHcgvwSUV11Sb
         tM6KrJvBzGNl2hQRgVXBbYtXZbgzbdLFcOztL0udVAyl6Os/NjGNIqswEjDjNfHwGvSO
         khPBe63YdRsIkj2DQg4kwKOGXAGYJJeYz9NSstochUD8zEgXcX/H8gmZeaE8ZnDFglLv
         IviG+mdwh14BvCFOhVaUUI8Mvgy3Ma2UTTS7eyuQFePxNli23XzHR1UV3biVbyVqtQIl
         rTzA==
X-Gm-Message-State: APjAAAV1Xba3dz+vOS2AYXRZEmIXhH+j4w9XNW6XFGr/i04ne3//8h3x
        zvdZuSQy3zIJYB91JBphrZ/HmA==
X-Google-Smtp-Source: APXvYqy8Oz8kwJAS3Eyqk92l46Cdl3Hrm+Q926EELDNeREiPhTbQBlyCW/xZ3jfo5Low9RzCZLhMaQ==
X-Received: by 2002:a63:2157:: with SMTP id s23mr4221987pgm.436.1555573836094;
        Thu, 18 Apr 2019 00:50:36 -0700 (PDT)
Received: from pihsun-z840.tpe.corp.google.com ([2401:fa00:1:10:7889:7a43:f899:134c])
        by smtp.googlemail.com with ESMTPSA id i24sm1870830pfo.85.2019.04.18.00.50.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 18 Apr 2019 00:50:35 -0700 (PDT)
From:   Pi-Hsun Shih <pihsun@chromium.org>
Cc:     Pi-Hsun Shih <pihsun@chromium.org>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] wireless: Use offsetof instead of custom macro.
Date:   Thu, 18 Apr 2019 15:50:14 +0800
Message-Id: <20190418075016.252988-1-pihsun@chromium.org>
X-Mailer: git-send-email 2.21.0.392.gf8f6787159e-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use offsetof to calculate offset of a field to take advantage of
compiler built-in version when possible, and avoid UBSAN warning when
compiling with Clang:

==================================================================
UBSAN: Undefined behaviour in net/wireless/wext-core.c:525:14
member access within null pointer of type 'struct iw_point'
CPU: 3 PID: 165 Comm: kworker/u16:3 Tainted: G S      W         4.19.23 #43
Workqueue: cfg80211 __cfg80211_scan_done [cfg80211]
Call trace:
 dump_backtrace+0x0/0x194
 show_stack+0x20/0x2c
 __dump_stack+0x20/0x28
 dump_stack+0x70/0x94
 ubsan_epilogue+0x14/0x44
 ubsan_type_mismatch_common+0xf4/0xfc
 __ubsan_handle_type_mismatch_v1+0x34/0x54
 wireless_send_event+0x3cc/0x470
 ___cfg80211_scan_done+0x13c/0x220 [cfg80211]
 __cfg80211_scan_done+0x28/0x34 [cfg80211]
 process_one_work+0x170/0x35c
 worker_thread+0x254/0x380
 kthread+0x13c/0x158
 ret_from_fork+0x10/0x18
===================================================================

Signed-off-by: Pi-Hsun Shih <pihsun@chromium.org>
---
 include/uapi/linux/wireless.h | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/include/uapi/linux/wireless.h b/include/uapi/linux/wireless.h
index 86eca3208b6b..f259cca5cc2b 100644
--- a/include/uapi/linux/wireless.h
+++ b/include/uapi/linux/wireless.h
@@ -1090,8 +1090,7 @@ struct iw_event {
 /* iw_point events are special. First, the payload (extra data) come at
  * the end of the event, so they are bigger than IW_EV_POINT_LEN. Second,
  * we omit the pointer, so start at an offset. */
-#define IW_EV_POINT_OFF (((char *) &(((struct iw_point *) NULL)->length)) - \
-			  (char *) NULL)
+#define IW_EV_POINT_OFF offsetof(struct iw_point, length)
 #define IW_EV_POINT_LEN	(IW_EV_LCP_LEN + sizeof(struct iw_point) - \
 			 IW_EV_POINT_OFF)
 
-- 
2.21.0.392.gf8f6787159e-goog

