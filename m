Return-Path: <SRS0=vnTL=2H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14AECC43603
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Dec 2019 03:21:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DA1B9218AC
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Dec 2019 03:21:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Dyrw3mAK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727534AbfLQDVP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Dec 2019 22:21:15 -0500
Received: from mail-pj1-f67.google.com ([209.85.216.67]:33007 "EHLO
        mail-pj1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727509AbfLQDVL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Dec 2019 22:21:11 -0500
Received: by mail-pj1-f67.google.com with SMTP id r67so3914476pjb.0
        for <linux-kernel@vger.kernel.org>; Mon, 16 Dec 2019 19:21:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=dTJtBCRtUW3V7cvpTHf5hNJH6T4sX7RfeAH8a1VqWM0=;
        b=Dyrw3mAK7lS1NG/iW0+Kzcp8KdP5+6eyVm6g0DnFK9kY9Qj5cRN7SWSXKGJCTqyJsd
         R+sqX9sfDXF7mQlJPgrE9sPOnUBv3oJTDhF75o1OHTBkONfv2zdCmST1VI0KjrRNeHUm
         UyYsC5Bxuv9hC6gqmRhxTx+Psj4VLUhsKxCzE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=dTJtBCRtUW3V7cvpTHf5hNJH6T4sX7RfeAH8a1VqWM0=;
        b=P8d7MpiDwSniTPdO5VfJsUwwOMS6ZFw8n0Zcu3ovSiNnk35H6XpRopFhqcwImwnrFg
         WPThNTWvKK/D7F2NDzp/0kYFnBywMMHf0300eMij4KJa/L2Cz2i3iYMGEjVyYSO1JWiM
         byKjmX/GQgKTIJ4hfrRCCLBqT+rpAO9LWFF1snzjI8kha4wKB/zvpkWcajXARucp8Gw8
         ED/XG0JQ0JMJgoXRRfEMCszyFw7mZmL/7AwPvjwvFRXDE6uZxbeUPrYZom+nC3g+E27S
         0uDsfXvtgLVAqHsnRoiXMUMtZel3WyYj7oa+Cul7wOmAwJUMX5lyrqNJoIoZDtCVXB5m
         hGOQ==
X-Gm-Message-State: APjAAAVIvc/2Wa50m26SCgmFB04PGIptcLCVxXm2KWARljRjxG14USsd
        K4GMfdqj/U59rF0JB8TXyfXpzzMlDLE=
X-Google-Smtp-Source: APXvYqx4WvFFvGRdNjuNVketu96/9otNgHem3YkTRcw9GCeLvmQ7pzz7YlHGkDHF6Jbzu+Fg5vVrlA==
X-Received: by 2002:a17:90a:77c6:: with SMTP id e6mr3353366pjs.129.1576552871239;
        Mon, 16 Dec 2019 19:21:11 -0800 (PST)
Received: from tigerii.tok.corp.google.com ([2401:fa00:8f:203:250d:e71d:5a0a:9afe])
        by smtp.gmail.com with ESMTPSA id j3sm24387455pfi.8.2019.12.16.19.21.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Dec 2019 19:21:10 -0800 (PST)
From:   Sergey Senozhatsky <senozhatsky@chromium.org>
To:     Hans Verkuil <hans.verkuil@cisco.com>,
        Tomasz Figa <tfiga@chromium.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>
Cc:     Sakari Ailus <sakari.ailus@iki.fi>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Pawel Osciak <posciak@chromium.org>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: [RFC][PATCH 08/15] videobuf2: do not sync caches when we are allowed not to
Date:   Tue, 17 Dec 2019 12:20:27 +0900
Message-Id: <20191217032034.54897-9-senozhatsky@chromium.org>
X-Mailer: git-send-email 2.24.1.735.g03f4e72817-goog
In-Reply-To: <20191217032034.54897-1-senozhatsky@chromium.org>
References: <20191217032034.54897-1-senozhatsky@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Skip ->prepare() or/and ->finish() cache synchronisation if
user-space requested us to do so (or when queue dma direction
permits us to skip cache syncs).

Signed-off-by: Sergey Senozhatsky <senozhatsky@chromium.org>
---
 drivers/media/common/videobuf2/videobuf2-core.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/drivers/media/common/videobuf2/videobuf2-core.c b/drivers/media/common/videobuf2/videobuf2-core.c
index 492ed2577219..4e81a8447472 100644
--- a/drivers/media/common/videobuf2/videobuf2-core.c
+++ b/drivers/media/common/videobuf2/videobuf2-core.c
@@ -304,8 +304,11 @@ static void __vb2_buf_mem_prepare(struct vb2_buffer *vb)
 {
 	unsigned int plane;
 
-	for (plane = 0; plane < vb->num_planes; ++plane)
-		call_void_memop(vb, prepare, vb->planes[plane].mem_priv);
+	if (vb->need_cache_sync_on_prepare) {
+		for (plane = 0; plane < vb->num_planes; ++plane)
+			call_void_memop(vb, prepare,
+					vb->planes[plane].mem_priv);
+	}
 	vb->synced = 1;
 }
 
@@ -317,8 +320,11 @@ static void __vb2_buf_mem_finish(struct vb2_buffer *vb)
 {
 	unsigned int plane;
 
-	for (plane = 0; plane < vb->num_planes; ++plane)
-		call_void_memop(vb, finish, vb->planes[plane].mem_priv);
+	if (vb->need_cache_sync_on_finish) {
+		for (plane = 0; plane < vb->num_planes; ++plane)
+			call_void_memop(vb, finish,
+					vb->planes[plane].mem_priv);
+	}
 	vb->synced = 0;
 }
 
-- 
2.24.1.735.g03f4e72817-goog

