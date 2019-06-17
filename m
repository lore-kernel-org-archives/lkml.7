Return-Path: <SRS0=xALZ=UQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F1A5C31E5B
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 19:34:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 384C52085A
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 19:34:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="o+LW5uIK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729054AbfFQTeU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Jun 2019 15:34:20 -0400
Received: from terminus.zytor.com ([198.137.202.136]:60737 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726182AbfFQTeT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jun 2019 15:34:19 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x5HJY6rI3565327
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Mon, 17 Jun 2019 12:34:06 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x5HJY6rI3565327
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019051801; t=1560800047;
        bh=ELboHO34IS0O41Bx6cIOz9GvPicPpEJPyVrBieo5ddo=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=o+LW5uIKDBlYZBT5Kqy7sjIWdY9N6ISHd1ritU4EQYm9dk7zl5hWjVA2MHAvgY5o2
         ToP0pv/VAki9LwBqy+Dc41p1Akv7xSi4uENgc5x3pWFdFzf0r5BhxgYh4S8l62Fx+R
         sf0y3NrWmtTf1jDo9zKv/cHLO1II+FP7rUK0aKoNyYChrdn3yQ9ikZ7qIh5/hDHfCV
         W/bSp1vhQmP3DI7BJE90gaWJvzTMtcK9HzCFayaWCojquvIvXuJWcWLypL60BnNe+e
         lcJekbW02SilwBFxjMQtZe2H8XAPw8193Zsp6Jht6Y9ki819YAyPBfYJPgLMHMwIBy
         m9y1xAVXi6WIg==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x5HJY6WC3565324;
        Mon, 17 Jun 2019 12:34:06 -0700
Date:   Mon, 17 Jun 2019 12:34:06 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Kan Liang <tipbot@zytor.com>
Message-ID: <tip-e05a899718f094e2c87d99115c5b1191405a9fd0@git.kernel.org>
Cc:     mingo@kernel.org, linux-kernel@vger.kernel.org, hpa@zytor.com,
        ak@linux.intel.com, acme@redhat.com, peterz@infradead.org,
        tglx@linutronix.de, jolsa@kernel.org, kan.liang@linux.intel.com
Reply-To: mingo@kernel.org, linux-kernel@vger.kernel.org, hpa@zytor.com,
          ak@linux.intel.com, acme@redhat.com, peterz@infradead.org,
          tglx@linutronix.de, jolsa@kernel.org, kan.liang@linux.intel.com
In-Reply-To: <1559688644-106558-4-git-send-email-kan.liang@linux.intel.com>
References: <1559688644-106558-4-git-send-email-kan.liang@linux.intel.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf header: Rename "sibling cores" to "sibling
 sockets"
Git-Commit-ID: e05a899718f094e2c87d99115c5b1191405a9fd0
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  e05a899718f094e2c87d99115c5b1191405a9fd0
Gitweb:     https://git.kernel.org/tip/e05a899718f094e2c87d99115c5b1191405a9fd0
Author:     Kan Liang <kan.liang@linux.intel.com>
AuthorDate: Tue, 4 Jun 2019 15:50:43 -0700
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Mon, 10 Jun 2019 16:20:11 -0300

perf header: Rename "sibling cores" to "sibling sockets"

The "sibling cores" actually shows the sibling CPUs of a socket.  The
name "sibling cores" is very misleading.

Rename "sibling cores" to "sibling sockets"

Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
Reviewed-by: Jiri Olsa <jolsa@kernel.org>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lkml.kernel.org/r/1559688644-106558-4-git-send-email-kan.liang@linux.intel.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/Documentation/perf.data-file-format.txt | 2 +-
 tools/perf/util/header.c                           | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/perf/Documentation/perf.data-file-format.txt b/tools/perf/Documentation/perf.data-file-format.txt
index 0165e92e717e..de78183f6881 100644
--- a/tools/perf/Documentation/perf.data-file-format.txt
+++ b/tools/perf/Documentation/perf.data-file-format.txt
@@ -168,7 +168,7 @@ struct {
 };
 
 Example:
-	sibling cores   : 0-8
+	sibling sockets : 0-8
 	sibling dies	: 0-3
 	sibling dies	: 4-7
 	sibling threads : 0-1
diff --git a/tools/perf/util/header.c b/tools/perf/util/header.c
index 64976254431c..06ddb6618ef3 100644
--- a/tools/perf/util/header.c
+++ b/tools/perf/util/header.c
@@ -1460,7 +1460,7 @@ static void print_cpu_topology(struct feat_fd *ff, FILE *fp)
 	str = ph->env.sibling_cores;
 
 	for (i = 0; i < nr; i++) {
-		fprintf(fp, "# sibling cores   : %s\n", str);
+		fprintf(fp, "# sibling sockets : %s\n", str);
 		str += strlen(str) + 1;
 	}
 
