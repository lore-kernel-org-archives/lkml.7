Return-Path: <SRS0=iR9I=YX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2758BCA9EC5
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Oct 2019 15:55:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E2B8E208C0
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Oct 2019 15:55:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1572450917;
	bh=x0F+D/HARx9yU0WLzMqfRG1a2qd4UBpC1RlbhC+gVOk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ZDJvcRQ+xdBDeFdPTyPC82euC+SQjsXxK7na4oC90bExka/je0IrVpI5Hwexz6cqu
	 OJia3K9OK/1LcUzZzOAJvybHbAzz8tTEMFywoCfOBhVXhe7huP3E9mkc93gWBbevRB
	 INeWLCVkXiML7bANrYDivucj4pqZgiLrtTtkBgDM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728552AbfJ3PzP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Oct 2019 11:55:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:56768 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726728AbfJ3PzN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Oct 2019 11:55:13 -0400
Received: from sasha-vm.mshome.net (100.50.158.77.rev.sfr.net [77.158.50.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1B4E621835;
        Wed, 30 Oct 2019 15:55:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572450912;
        bh=x0F+D/HARx9yU0WLzMqfRG1a2qd4UBpC1RlbhC+gVOk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=rYQiZ5XoFUflmUlpBcndz4vM9KZ613UO1oaWizeHL2zTw2VVBWxBWVM9JTMB9KLRH
         R2Z3A+s5ObZ2v7+C1iagZ69BJnd6b8Rc23WyUAxEGMTWO8b9XXg3KiZhLVzCpQtEZh
         9E4JgOpBQJTTUlRlq0x9eVOENY7pzK/cTF1bnt7Q=
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
Subject: [PATCH AUTOSEL 4.19 23/38] perf kmem: Fix memory leak in compact_gfp_flags()
Date:   Wed, 30 Oct 2019 11:53:51 -0400
Message-Id: <20191030155406.10109-23-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191030155406.10109-1-sashal@kernel.org>
References: <20191030155406.10109-1-sashal@kernel.org>
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
index b63bca4b0c2a6..56dd5d1476e06 100644
--- a/tools/perf/builtin-kmem.c
+++ b/tools/perf/builtin-kmem.c
@@ -686,6 +686,7 @@ static char *compact_gfp_flags(char *gfp_flags)
 			new = realloc(new_flags, len + strlen(cpt) + 2);
 			if (new == NULL) {
 				free(new_flags);
+				free(orig_flags);
 				return NULL;
 			}
 
-- 
2.20.1

