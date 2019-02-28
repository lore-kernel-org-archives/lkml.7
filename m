Return-Path: <SRS0=g5d9=RD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8A93C4360F
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 05:07:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 764BB2171F
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 05:07:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="lCpAYn8l"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730978AbfB1FHX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Feb 2019 00:07:23 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:34156 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730921AbfB1FHP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Feb 2019 00:07:15 -0500
Received: from pps.filterd (m0044008.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x1S54wtJ000378
        for <linux-kernel@vger.kernel.org>; Wed, 27 Feb 2019 21:07:14 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type; s=facebook; bh=u0UUjGAvbLh2sH/TNv25fxNz2CmH4OKo+0+mXwfTh8I=;
 b=lCpAYn8lcOzUitpMNgpvbINkdnOWyUbQKRbWoczf+28J3mHrg6770C2owXmqCIOjwSi/
 Gn4s4lenbmVaf4i+aqTdwLAGneYGMiaqpOH5WhfXX3avg1/bWA112WiPjC6BEooly/kv
 rvGAJaE9mo/GrR1oUD9Ahl/lPB1JX47rM6s= 
Received: from maileast.thefacebook.com ([199.201.65.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2qx7600a7v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 27 Feb 2019 21:07:14 -0800
Received: from mx-out.facebook.com (2620:10d:c0a1:3::13) by
 mail.thefacebook.com (2620:10d:c021:18::171) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA) id 15.1.1531.3;
 Wed, 27 Feb 2019 21:07:12 -0800
Received: by devbig006.ftw2.facebook.com (Postfix, from userid 4523)
        id D959362E2B27; Wed, 27 Feb 2019 21:07:10 -0800 (PST)
Smtp-Origin-Hostprefix: devbig
From:   Song Liu <songliubraving@fb.com>
Smtp-Origin-Hostname: devbig006.ftw2.facebook.com
To:     <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <ast@kernel.org>, <daniel@iogearbox.net>, <kernel-team@fb.com>,
        <peterz@infradead.org>, <acme@redhat.com>, <jolsa@kernel.org>,
        <namhyung@kernel.org>, Song Liu <songliubraving@fb.com>
Smtp-Origin-Cluster: ftw2c04
Subject: [PATCH v5 perf,bpf 11/15] perf: add -lopcodes to feature-libbfd
Date:   Wed, 27 Feb 2019 21:06:39 -0800
Message-ID: <20190228050643.958685-12-songliubraving@fb.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190228050643.958685-1-songliubraving@fb.com>
References: <20190228050643.958685-1-songliubraving@fb.com>
X-FB-Internal: Safe
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-02-28_02:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Both libbfd and libopcodes are distributed with binutil-dev/devel. When
libbfd presents, it is OK to assume libopcodes also presents. This has
been a safe assumption for bpftool.

This patch adds -lopcodes to perf/Makefile.config. libopcodes will be
used in the next commit for bpf annotation.

Signed-off-by: Song Liu <songliubraving@fb.com>
---
 tools/perf/Makefile.config | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/Makefile.config b/tools/perf/Makefile.config
index b441c88cafa1..e0bafbc273af 100644
--- a/tools/perf/Makefile.config
+++ b/tools/perf/Makefile.config
@@ -701,7 +701,7 @@ else
 endif
 
 ifeq ($(feature-libbfd), 1)
-  EXTLIBS += -lbfd
+  EXTLIBS += -lbfd -lopcodes
 else
   # we are on a system that requires -liberty and (maybe) -lz
   # to link against -lbfd; test each case individually here
-- 
2.17.1

