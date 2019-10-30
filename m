Return-Path: <SRS0=iR9I=YX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80A8CCA9EC5
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Oct 2019 15:58:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5084221835
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Oct 2019 15:58:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1572451098;
	bh=FESUteCjHCIC3OUGqfhK24bZ1hYjA2REQ8WFzkI7KM8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=2EXy/bVgbIa96YdnYUF93Tu5k8lPPbRmMhMxix74S3uSXlCcWvRWBBWVfHAgsm4fO
	 9XRC7roJUXOrKKjxyLyTclZ/ckdEQjjVohDji2TP8+W/yZz4uVVfSXGMjxoBHXESzA
	 dCsEd6rfZ/FC+aK9ACEfV5jUKUjbVrj5gk7RIg70=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729276AbfJ3P6R (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Oct 2019 11:58:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:60040 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729264AbfJ3P6O (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Oct 2019 11:58:14 -0400
Received: from sasha-vm.mshome.net (100.50.158.77.rev.sfr.net [77.158.50.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CB003217F9;
        Wed, 30 Oct 2019 15:58:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572451094;
        bh=FESUteCjHCIC3OUGqfhK24bZ1hYjA2REQ8WFzkI7KM8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=0jT/UYzlb/sFmwEwV5e6BP07ynSzG0kvWuPeNyudoa9TqLELJ5ARwm0H6kisF4y2c
         TYNvUPQtUGEoMxqfI/KR1hCBqwIrRKGvYa7JRWsYPjXBfdlAhhmiTWidPHykQdwOi3
         iAgBRW3SgmuEJqpj9s01hhhfThbYd0p1q96DqlXU=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Yunfeng Ye <yeyunfeng@huawei.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Feilong Lin <linfeilong@huawei.com>,
        Hu Shiyuan <hushiyuan@huawei.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.4 09/13] perf kmem: Fix memory leak in compact_gfp_flags()
Date:   Wed, 30 Oct 2019 11:57:47 -0400
Message-Id: <20191030155751.10960-9-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191030155751.10960-1-sashal@kernel.org>
References: <20191030155751.10960-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yunfeng Ye <yeyunfeng@huawei.com>

[ Upstream commit 1abecfcaa7bba21c9985e0136fa49836164dd8fd ]

The memory @orig_flags is allocated by strdup(), it is freed on the
normal path, but leak to free on the error path.

Fix this by adding free(orig_flags) on the error path.

Fixes: 0e11115644b3 ("perf kmem: Print gfp flags in human readable string")
Signed-off-by: Yunfeng Ye <yeyunfeng@huawei.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Feilong Lin <linfeilong@huawei.com>
Cc: Hu Shiyuan <hushiyuan@huawei.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lore.kernel.org/lkml/f9e9f458-96f3-4a97-a1d5-9feec2420e07@huawei.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/perf/builtin-kmem.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/perf/builtin-kmem.c b/tools/perf/builtin-kmem.c
index 93ce665f976f6..b62f2f139edf2 100644
--- a/tools/perf/builtin-kmem.c
+++ b/tools/perf/builtin-kmem.c
@@ -664,6 +664,7 @@ static char *compact_gfp_flags(char *gfp_flags)
 			new = realloc(new_flags, len + strlen(cpt) + 2);
 			if (new == NULL) {
 				free(new_flags);
+				free(orig_flags);
 				return NULL;
 			}
 
-- 
2.20.1

