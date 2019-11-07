Return-Path: <SRS0=GkzU=Y7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67BFAC43331
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 19:00:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 32C0521882
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 19:00:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573153244;
	bh=1HhX0mVkjZHlC7ebxk1WahbvWU66vxaRhGg1q3Ijzr8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=rqvTeeml89ypomFx4IYuYww3t6IySAplzlk8HtYB1gByBPVoFMbtko3ud8busdlLK
	 s87AF41Qy8Cs+ZjF1Lo6IsIZ4+t09eLqdgM7/LHRaxDSDQNtEGZ5rWXDpX5CSC6WWa
	 duO/yF3yyeg0c0ThnzX/j9G5OAF+Upi7K/L4C3SY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727275AbfKGTAn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Nov 2019 14:00:43 -0500
Received: from mail.kernel.org ([198.145.29.99]:40198 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725883AbfKGTAm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Nov 2019 14:00:42 -0500
Received: from quaco.ghostprotocols.net (179-240-172-58.3g.claro.net.br [179.240.172.58])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CFF4E218AE;
        Thu,  7 Nov 2019 19:00:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573153242;
        bh=1HhX0mVkjZHlC7ebxk1WahbvWU66vxaRhGg1q3Ijzr8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=b/8BOTWZcbNcws2EI3x4uY8PyWYw7MNIRLbdGEaAcunk6gAs3wI756bvCwIYmrLAY
         p7tuw4UV4HV591cEFtpgTftJcLqtNdY4LeUK8l+L7n4PWLj0Iw6pU+uUi+1cCVFpkx
         xk7IglaGVgyMSwHxhOVZO31y0N+NAuQ/oEPWB+x8=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Adrian Hunter <adrian.hunter@intel.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 01/63] perf data: Correctly identify directory data files
Date:   Thu,  7 Nov 2019 15:59:09 -0300
Message-Id: <20191107190011.23924-2-acme@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191107190011.23924-1-acme@kernel.org>
References: <20191107190011.23924-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Adrian Hunter <adrian.hunter@intel.com>

In order to rename the "header" file to "data" without conflicting,
correctly identify the non-header files as starting with "data."

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Reviewed-by: Jiri Olsa <jolsa@kernel.org>
Link: http://lore.kernel.org/lkml/20191004083121.12182-2-adrian.hunter@intel.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/data.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/util/data.c b/tools/perf/util/data.c
index 88fba2ba549f..8993253c5564 100644
--- a/tools/perf/util/data.c
+++ b/tools/perf/util/data.c
@@ -96,7 +96,7 @@ int perf_data__open_dir(struct perf_data *data)
 		if (stat(path, &st))
 			continue;
 
-		if (!S_ISREG(st.st_mode) || strncmp(dent->d_name, "data", 4))
+		if (!S_ISREG(st.st_mode) || strncmp(dent->d_name, "data.", 5))
 			continue;
 
 		ret = -ENOMEM;
-- 
2.21.0

