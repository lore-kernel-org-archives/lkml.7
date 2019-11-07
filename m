Return-Path: <SRS0=GkzU=Y7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35417C5DF60
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 19:00:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 08F0A2085B
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 19:00:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573153250;
	bh=Hj+jYQfvAqWK+5/QfVa6D4pHkGr2gBT1M/a0j2YaHmw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=fKE8/2dEz142+dNOkvT74Ko11v17k21HLRGdN/BwQAzFKTntQhnFFnolRoIA1orGE
	 9BctSn7mSB6RClAlYyVM0aTEadVzeF79bASiau0lHtzukMg/Cz4KzunhE0OaDyQz74
	 WQZFnq7Ci9gTYMZlVG4w4GMcN1KcWuyJpSfuqMq8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727414AbfKGTAt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Nov 2019 14:00:49 -0500
Received: from mail.kernel.org ([198.145.29.99]:40300 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725883AbfKGTAs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Nov 2019 14:00:48 -0500
Received: from quaco.ghostprotocols.net (179-240-172-58.3g.claro.net.br [179.240.172.58])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2BA4E21D79;
        Thu,  7 Nov 2019 19:00:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573153248;
        bh=Hj+jYQfvAqWK+5/QfVa6D4pHkGr2gBT1M/a0j2YaHmw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=PDNQpfZIsEleBdRPMGPNEtKwyn5D0qgIwm/7s5yqz/iYWZ4qz5LrvdggCyc4a/VFD
         G6MmRZsBQPY0uIcxNmxB7dcRaf+5f+whG+OJSEyyTqRAk8RLno7n11uZzxc9BsSrlK
         pLYdPCWtHDqH55IRsccQYi4z4T0Bxa27cRiY4R+w=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Adrian Hunter <adrian.hunter@intel.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 02/63] perf data: Move perf_dir_version into data.h
Date:   Thu,  7 Nov 2019 15:59:10 -0300
Message-Id: <20191107190011.23924-3-acme@kernel.org>
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

perf_dir_version belongs to struct perf_data which is declared in data.h.
To allow its use in inline perf_data functions, move perf_dir_version to
data.h

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Reviewed-by: Jiri Olsa <jolsa@kernel.org>
Link: http://lore.kernel.org/lkml/20191004083121.12182-3-adrian.hunter@intel.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/data.h   | 4 ++++
 tools/perf/util/header.h | 4 ----
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/tools/perf/util/data.h b/tools/perf/util/data.h
index 259868a39019..218fe9a16801 100644
--- a/tools/perf/util/data.h
+++ b/tools/perf/util/data.h
@@ -9,6 +9,10 @@ enum perf_data_mode {
 	PERF_DATA_MODE_READ,
 };
 
+enum perf_dir_version {
+	PERF_DIR_VERSION	= 1,
+};
+
 struct perf_data_file {
 	char		*path;
 	int		 fd;
diff --git a/tools/perf/util/header.h b/tools/perf/util/header.h
index ca53a929e9fd..840f95cee349 100644
--- a/tools/perf/util/header.h
+++ b/tools/perf/util/header.h
@@ -52,10 +52,6 @@ enum perf_header_version {
 	PERF_HEADER_VERSION_2,
 };
 
-enum perf_dir_version {
-	PERF_DIR_VERSION	= 1,
-};
-
 struct perf_file_section {
 	u64 offset;
 	u64 size;
-- 
2.21.0

