Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1A7DC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 05:32:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C0A2B214AE
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 05:32:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="clk6785G"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727548AbfCLFcN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Mar 2019 01:32:13 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:57204 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727386AbfCLFbW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Mar 2019 01:31:22 -0400
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x2C5NJ4X029253
        for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2019 22:31:21 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type; s=facebook; bh=AfMfDZ4yvsnvw9Y8hTpmaKPEvZU/vcZpbdE23yuXz+M=;
 b=clk6785Gn7LK+1aBF/z7chB1Fi3ImBR/RzMYhmpZtMS2xf2oJv30bNySF7neTk9PPd6O
 JSvOoObE1WuRvQMU/pwT0qe/Qx1vpeLyIAugOL5Sk0wLu3/oBWWeNGf84/F8CJy38AcB
 bWOyNlmAnVoE/TY0E2LGRhaJPX1cCZJNgUk= 
Received: from maileast.thefacebook.com ([199.201.65.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2r62tvrs0s-10
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2019 22:31:21 -0700
Received: from mx-out.facebook.com (2620:10d:c0a1:3::13) by
 mail.thefacebook.com (2620:10d:c021:18::172) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA) id 15.1.1713.5;
 Mon, 11 Mar 2019 22:31:20 -0700
Received: by devbig006.ftw2.facebook.com (Postfix, from userid 4523)
        id 7C83E62E2019; Mon, 11 Mar 2019 22:31:18 -0700 (PDT)
Smtp-Origin-Hostprefix: devbig
From:   Song Liu <songliubraving@fb.com>
Smtp-Origin-Hostname: devbig006.ftw2.facebook.com
To:     <bpf@vger.kernel.org>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     <ast@kernel.org>, <daniel@iogearbox.net>, <kernel-team@fb.com>,
        <peterz@infradead.org>, <acme@redhat.com>, <jolsa@kernel.org>,
        <namhyung@kernel.org>, <sdf@fomichev.me>,
        Song Liu <songliubraving@fb.com>
Smtp-Origin-Cluster: ftw2c04
Subject: [PATCH v9 perf,bpf 11/15] perf: add -lopcodes to feature-libbfd
Date:   Mon, 11 Mar 2019 22:30:47 -0700
Message-ID: <20190312053051.2690567-12-songliubraving@fb.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190312053051.2690567-1-songliubraving@fb.com>
References: <20190312053051.2690567-1-songliubraving@fb.com>
X-FB-Internal: Safe
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-03-12_04:,,
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
 tools/perf/Makefile.config | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/tools/perf/Makefile.config b/tools/perf/Makefile.config
index 0f11d5891301..df4ad45599ca 100644
--- a/tools/perf/Makefile.config
+++ b/tools/perf/Makefile.config
@@ -713,7 +713,7 @@ else
 endif
 
 ifeq ($(feature-libbfd), 1)
-  EXTLIBS += -lbfd
+  EXTLIBS += -lbfd -lopcodes
 else
   # we are on a system that requires -liberty and (maybe) -lz
   # to link against -lbfd; test each case individually here
@@ -724,10 +724,10 @@ else
   $(call feature_check,libbfd-liberty-z)
 
   ifeq ($(feature-libbfd-liberty), 1)
-    EXTLIBS += -lbfd -liberty
+    EXTLIBS += -lbfd -lopcodes -liberty
   else
     ifeq ($(feature-libbfd-liberty-z), 1)
-      EXTLIBS += -lbfd -liberty -lz
+      EXTLIBS += -lbfd -lopcodes -liberty -lz
     endif
   endif
 endif
-- 
2.17.1

