Return-Path: <SRS0=WT+Y=ZE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FBBEC43331
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 11:23:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 392D722469
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 11:23:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="R+7oIipY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727124AbfKLLXS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Nov 2019 06:23:18 -0500
Received: from mail-m972.mail.163.com ([123.126.97.2]:53616 "EHLO
        mail-m972.mail.163.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725874AbfKLLXR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Nov 2019 06:23:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=UoEdC
        yQrUuXSvR01NO/aDEKyyzfgJifCAZ9caujRNak=; b=R+7oIipYIkm/OOF1SuxBS
        7uUp7et33ad90mi+c571QGRJCohjZ3Exsxl430lBn3QGToQIuB0ol6QbclAQzSHS
        2r9TZKY+JnufBRuNEQMD7CtxOQrICpTaWxLbMOD2LOezZ+ieewMUNUNd9bflRBN/
        TKnG+zt7JvlziTxxVfwTok=
Received: from Fedora-30-workstation.localdomain (unknown [122.96.47.248])
        by smtp2 (Coremail) with SMTP id GtxpCgC35HnwlcpdOZziAg--.104S2;
        Tue, 12 Nov 2019 19:22:25 +0800 (CST)
From:   Xiao Yang <ice_yangxiao@163.com>
To:     ak@linux.intel.com
Cc:     acme@kernel.org, jolsa@redhat.com, peterz@infradead.org,
        linux-kernel@vger.kernel.org, Xiao Yang <ice_yangxiao@163.com>,
        kernel test robot <lkp@intel.com>
Subject: [PATCH] perf tools: Add missing util/affinity.c to util/python-ext-sources
Date:   Tue, 12 Nov 2019 19:22:20 +0800
Message-Id: <20191112112220.15515-1-ice_yangxiao@163.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: GtxpCgC35HnwlcpdOZziAg--.104S2
X-Coremail-Antispam: 1Uf129KBjvdXoWrtw1kJFyfAFyfGw48CFW5Awb_yoWkZFX_Ga
        s7tF1UuryUJry0y34jyFs8XF48ta98ur9Yya4DKF45u3W7Gr1Yq3yDurWDXr1rXrs0vrnr
        Jrn5Jr1UWw47WjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7xRR9NVPUUUUU==
X-Originating-IP: [122.96.47.248]
X-CM-SenderInfo: 5lfhs5xdqj5xldr6il2tof0z/1tbiOxxrXlXlniczdwAAsf
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

util/evlist.c added into perf python extension module uses affinity
functions since commit 54b16df58e65 so we should also add util/affinity.c
into the extension module to fix the following issue:
-----------------------------------------------
./perf test -v python
18: 'import perf' in python :
--- start ---
test child forked, pid 15979
Traceback (most recent call last):
File "<stdin>", line 1, in <module>
ImportError: python/perf.so: undefined symbol: affinity__cleanup
test child finished with -1
---- end ----
'import perf' in python: FAILED!
-----------------------------------------------

Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Xiao Yang <ice_yangxiao@163.com>
---
 tools/perf/util/python-ext-sources | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/perf/util/python-ext-sources b/tools/perf/util/python-ext-sources
index 9af183860fbd..521aaa9928cf 100644
--- a/tools/perf/util/python-ext-sources
+++ b/tools/perf/util/python-ext-sources
@@ -7,6 +7,7 @@
 
 util/python.c
 ../lib/ctype.c
+util/affinity.c
 util/cap.c
 util/evlist.c
 util/evsel.c
-- 
2.21.0

