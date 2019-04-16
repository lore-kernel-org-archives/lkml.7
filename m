Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D37FC10F13
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 13:41:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F20382190A
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 13:41:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555422118;
	bh=vPoGYzTp2J+2mpuU6qoqpVpcEdDc4g6Pes22FiJ2sJw=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=bnCgDPa5EOk76EkPaJwxmcmAyhKhB/Kolqn5VP7KLTGcM+WEuXgAxGybHJ9ydyvoi
	 ZRoyGM4+0FsZtx2t8gG7hd2jmDIIicj2+b45/Lrpro35JczMmV8ofbb0OZS3R/lzBV
	 G64fiupo7A+OEH2GqRuhLBdimIoX01MNIaP06hCY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728794AbfDPNl5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 09:41:57 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43760 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726641AbfDPNl4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 09:41:56 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 080C42D801;
        Tue, 16 Apr 2019 13:41:56 +0000 (UTC)
Received: from krava.brq.redhat.com (unknown [10.43.17.48])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 5A37D5C226;
        Tue, 16 Apr 2019 13:41:52 +0000 (UTC)
From:   Jiri Olsa <jolsa@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Song Liu <songliubraving@fb.com>,
        lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>
Subject: [PATCH] perf tools: Fix perf_env__find_bpf_prog_info rb tree lookup
Date:   Tue, 16 Apr 2019 15:41:51 +0200
Message-Id: <20190416134151.15282-1-jolsa@kernel.org>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.30]); Tue, 16 Apr 2019 13:41:56 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We currently don't return NULL in case we don't find
the bpf_prog_info_node, fixing that.

Cc: Song Liu <songliubraving@fb.com>
Link: http://lkml.kernel.org/n/tip-bp07cla6dy6ifydl1sfoiorw@git.kernel.org
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/perf/util/env.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/env.c b/tools/perf/util/env.c
index c6351b557bb0..34a363f2e71b 100644
--- a/tools/perf/util/env.c
+++ b/tools/perf/util/env.c
@@ -57,9 +57,11 @@ struct bpf_prog_info_node *perf_env__find_bpf_prog_info(struct perf_env *env,
 		else if (prog_id > node->info_linear->info.id)
 			n = n->rb_right;
 		else
-			break;
+			goto out;
 	}
+	node = NULL;
 
+out:
 	up_read(&env->bpf_progs.lock);
 	return node;
 }
-- 
2.17.2

