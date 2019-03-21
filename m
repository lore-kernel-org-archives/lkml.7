Return-Path: <SRS0=/BZh=RY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC824C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 02:31:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C579B218D3
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 02:31:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727864AbfCUCb5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Mar 2019 22:31:57 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:5163 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726914AbfCUCb5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Mar 2019 22:31:57 -0400
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 9AE67D7616668189EA82;
        Thu, 21 Mar 2019 10:31:55 +0800 (CST)
Received: from localhost (10.177.31.96) by DGGEMS411-HUB.china.huawei.com
 (10.3.19.211) with Microsoft SMTP Server id 14.3.408.0; Thu, 21 Mar 2019
 10:31:47 +0800
From:   Yue Haibing <yuehaibing@huawei.com>
To:     <mathieu.poirier@linaro.org>, <suzuki.poulose@arm.com>,
        <peterz@infradead.org>, <mingo@redhat.com>, <acme@kernel.org>,
        <alexander.shishkin@linux.intel.com>, <jolsa@redhat.com>,
        <namhyung@kernel.org>, <arnaldo.melo@gmail.com>
CC:     <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH v2 1/2] perf cs-etm: Remove errnoeous ERR_PTR() usage in cs_etm__process_auxtrace_info
Date:   Thu, 21 Mar 2019 10:31:21 +0800
Message-ID: <20190321023122.21332-2-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
In-Reply-To: <20190321023122.21332-1-yuehaibing@huawei.com>
References: <20190321023122.21332-1-yuehaibing@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.177.31.96]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: YueHaibing <yuehaibing@huawei.com>

intlist__findnew() doesn't uses ERR_PTR() as a return mechanism
so its callers shouldn't try to extract the error using PTR_ERR(
ret) from intlist__findnew(), make cs_etm__process_auxtrace_info
return -ENOMEM instead.

Fixes: cd8bfd8c973e ("perf tools: Add processing of coresight metadata")
Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 tools/perf/util/cs-etm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/util/cs-etm.c b/tools/perf/util/cs-etm.c
index 1108049..fd7f1da 100644
--- a/tools/perf/util/cs-etm.c
+++ b/tools/perf/util/cs-etm.c
@@ -1908,7 +1908,7 @@ int cs_etm__process_auxtrace_info(union perf_event *event,
 
 		/* Something went wrong, no need to continue */
 		if (!inode) {
-			err = PTR_ERR(inode);
+			err = -ENOMEM;
 			goto err_free_metadata;
 		}
 
-- 
2.7.0


