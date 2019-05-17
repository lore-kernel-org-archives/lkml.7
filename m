Return-Path: <SRS0=M1fl=TR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 513FAC04AB4
	for <linux-kernel@archiver.kernel.org>; Fri, 17 May 2019 19:37:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1A51821903
	for <linux-kernel@archiver.kernel.org>; Fri, 17 May 2019 19:37:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1558121875;
	bh=pX558iNOvnPwXmbcVRl+2A1oJ8dGx3Rq0WMmegXfp74=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=We/+yd1FomG1AtSSe15EldbfHvt47NN6/lnRLfP3Wu7j0GdL4o43Y2MDYKW/k1Gsb
	 7qsj3lJdr+F9ABQjV4P1aybrcPsUzibkFWhD2n2lDulNuKrENsBM5sqglg2xfIsJac
	 z/PL8Mg6aDI0meWb/c/sP2HebR6JUrmwezadjNEM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729577AbfEQThy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 May 2019 15:37:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:52126 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729211AbfEQThs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 May 2019 15:37:48 -0400
Received: from quaco.ghostprotocols.net (unknown [190.15.121.82])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 971AA21726;
        Fri, 17 May 2019 19:37:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1558121867;
        bh=pX558iNOvnPwXmbcVRl+2A1oJ8dGx3Rq0WMmegXfp74=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=QykkbcK7cI9iIBod69e73n9Rm7sT/mcZN0CSPNxWsX9QcgUYKDQT2zM6RE7gpmF2e
         mUXQO9RJvwxhXW9RpsfivgsdCEotE0qwfZv54CXvxyzF7WqgEOTrNxiCMtXH3JPpsB
         yHTIEFCMexQ4uetX42a7arJYg7L3q2k5kHK0YtGY=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Donald Yandt <donald.yandt@gmail.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Avi Kivity <avi@scylladb.com>, Jiri Olsa <jolsa@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Yanmin Zhang <yanmin_zhang@linux.intel.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 20/73] perf machine: Null-terminate version char array upon fgets(/proc/version) error
Date:   Fri, 17 May 2019 16:35:18 -0300
Message-Id: <20190517193611.4974-21-acme@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190517193611.4974-1-acme@kernel.org>
References: <20190517193611.4974-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Donald Yandt <donald.yandt@gmail.com>

If fgets() fails due to any other error besides end-of-file, the version
char array may not even be null-terminated.

Signed-off-by: Donald Yandt <donald.yandt@gmail.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Avi Kivity <avi@scylladb.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Yanmin Zhang <yanmin_zhang@linux.intel.com>
Fixes: a1645ce12adb ("perf: 'perf kvm' tool for monitoring guest performance from host")
Link: http://lkml.kernel.org/r/20190514110100.22019-1-donald.yandt@gmail.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/machine.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/machine.c b/tools/perf/util/machine.c
index 3c520baa198c..28a9541c4835 100644
--- a/tools/perf/util/machine.c
+++ b/tools/perf/util/machine.c
@@ -1234,8 +1234,9 @@ static char *get_kernel_version(const char *root_dir)
 	if (!file)
 		return NULL;
 
-	version[0] = '\0';
 	tmp = fgets(version, sizeof(version), file);
+	if (!tmp)
+		*version = '\0';
 	fclose(file);
 
 	name = strstr(version, prefix);
-- 
2.20.1

