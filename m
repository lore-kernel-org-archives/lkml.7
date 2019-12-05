Return-Path: <SRS0=yQuH=Z3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB906C43603
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Dec 2019 19:33:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 84D70224F8
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Dec 2019 19:33:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1575574406;
	bh=XAUOtI0wjcDlVyNl4pbSZ/3xp52OqFcZAQjcfokMtkM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=CYmy3QL0wRS9COostXO0fZI53BMSr/1E1WCsNSG7O5s8xHlMS4BQQ2sjU7PY2AeDE
	 IfexkEC125nZMsVo6a/nNgspX7/TlQb2xeFgXUw1vDvMJ6peaANJLFI4zHjHebSB5F
	 P4X3cmzM76gEpNwBi/MLmWyrLCM6RYJSSMRm+9/A=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730042AbfLETdZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Dec 2019 14:33:25 -0500
Received: from mail.kernel.org ([198.145.29.99]:55562 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726589AbfLETdY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Dec 2019 14:33:24 -0500
Received: from quaco.ghostprotocols.net (179-240-141-74.3g.claro.net.br [179.240.141.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B4F24206D9;
        Thu,  5 Dec 2019 19:33:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1575574403;
        bh=XAUOtI0wjcDlVyNl4pbSZ/3xp52OqFcZAQjcfokMtkM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=yoW99ybVU5qaohIMXJb8OLiO1CySK3KUxhe7nyo50X7f0cqbU4sXxJqoOL8kZZhFO
         Ehb6IuFQlQaKHKv85yEGXaROTJTMoTX1Ydl/GII135qkSwtM4hMHQ7XrZLs9+mTS52
         Zfx5yc9jy3Tz7g6WT6ZNyZrfupdzkS3ziUprxwBA=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        Chunming Zhou <david1.zhou@amd.com>
Subject: [PATCH 6/6] tools headers UAPI: Update tools's copy of drm.h headers
Date:   Thu,  5 Dec 2019 16:32:24 -0300
Message-Id: <20191205193224.24629-7-acme@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191205193224.24629-1-acme@kernel.org>
References: <20191205193224.24629-1-acme@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

Picking the changes from:

  2093dea3def9 ("drm/syncobj: extend syncobj query ability v3")

Which doesn't affect tooling, just silences this perf build warning:

  Warning: Kernel ABI header at 'tools/include/uapi/drm/drm.h' differs from latest version at 'include/uapi/drm/drm.h'
  diff -u tools/include/uapi/drm/drm.h include/uapi/drm/drm.h

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Christian König <christian.koenig@amd.com>
Cc: Chunming Zhou <david1.zhou@amd.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lkml.kernel.org/n/tip-t1xqmjffo4rxdw395dsnu34j@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/include/uapi/drm/drm.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/include/uapi/drm/drm.h b/tools/include/uapi/drm/drm.h
index 8a5b2f8f8eb9..868bf7996c0f 100644
--- a/tools/include/uapi/drm/drm.h
+++ b/tools/include/uapi/drm/drm.h
@@ -778,11 +778,12 @@ struct drm_syncobj_array {
 	__u32 pad;
 };
 
+#define DRM_SYNCOBJ_QUERY_FLAGS_LAST_SUBMITTED (1 << 0) /* last available point on timeline syncobj */
 struct drm_syncobj_timeline_array {
 	__u64 handles;
 	__u64 points;
 	__u32 count_handles;
-	__u32 pad;
+	__u32 flags;
 };
 
 
-- 
2.21.0

