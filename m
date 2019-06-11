Return-Path: <SRS0=TvG7=UK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E5CEC06508
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 19:01:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 77A092184D
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 19:01:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1560279700;
	bh=widFLFpiYx5x3vyIULDsIq6SC0BfpFZKH78DIu7bTrI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Ej/CZpJhYiwsL7yOavrkkfEorLy/gwGFp0uXI8rpxpB/dag+HfBj3elCB4SoousaV
	 6hqbPiTBdoyKg3nECzBtBci7Exqq0CGfmh7pIrod6bdv3O4C37UtsTb3QcC40TDks+
	 VGj4SOVFMIZ770f7irp4dKd31+VhcFJFUxfoQrF8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392286AbfFKTBj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Jun 2019 15:01:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:37944 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389302AbfFKTBi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jun 2019 15:01:38 -0400
Received: from quaco.ghostprotocols.net (unknown [179.97.35.11])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CAB0E2183F;
        Tue, 11 Jun 2019 19:01:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560279697;
        bh=widFLFpiYx5x3vyIULDsIq6SC0BfpFZKH78DIu7bTrI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=H93J6OVo/YqbcqxCC70jXDAOlJixANpy54TRIneN7F0yayWgzJ7mdRKo7Z3c6Gf1j
         Ppk3VGEGu+dLoR40qZof5irPGxv7Y2VpghK4mbzTl3hD5HTdAh2qPMUTmLBdSyWc01
         pMDu8WDAGG6yjx0CMLga4qSXnv3Jogon+U4ZoJxs=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Brendan Gregg <brendan.d.gregg@gmail.com>,
        =?UTF-8?q?Luis=20Cl=C3=A1udio=20Gon=C3=A7alves?= 
        <lclaudio@redhat.com>
Subject: [PATCH 31/85] perf trace: Consume the augmented_raw_syscalls payload
Date:   Tue, 11 Jun 2019 15:58:17 -0300
Message-Id: <20190611185911.11645-32-acme@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190611185911.11645-1-acme@kernel.org>
References: <20190611185911.11645-1-acme@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

To support the SCA_FILENAME beautifier in more than one syscall arg, as
needed for syscalls such as the rename* family, we need to, after
processing one such arg, bump the augmented pointers so that the next
augmented arg don't reuse data for the previous augmented arguments.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Brendan Gregg <brendan.d.gregg@gmail.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Luis Cláudio Gonçalves <lclaudio@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lkml.kernel.org/n/tip-4e4cmzyjxb3wkonfo1x9a27y@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-trace.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
index 19f22127f02e..905e57c336b0 100644
--- a/tools/perf/builtin-trace.c
+++ b/tools/perf/builtin-trace.c
@@ -1233,8 +1233,17 @@ static void thread__set_filename_pos(struct thread *thread, const char *bf,
 static size_t syscall_arg__scnprintf_augmented_string(struct syscall_arg *arg, char *bf, size_t size)
 {
 	struct augmented_arg *augmented_arg = arg->augmented.args;
+	size_t printed = scnprintf(bf, size, "\"%.*s\"", augmented_arg->size, augmented_arg->value);
+	/*
+	 * So that the next arg with a payload can consume its augmented arg, i.e. for rename* syscalls
+	 * we would have two strings, each prefixed by its size.
+	 */
+	int consumed = sizeof(*augmented_arg) + augmented_arg->size;
 
-	return scnprintf(bf, size, "\"%.*s\"", augmented_arg->size, augmented_arg->value);
+	arg->augmented.args += consumed;
+	arg->augmented.size -= consumed;
+
+	return printed;
 }
 
 static size_t syscall_arg__scnprintf_filename(char *bf, size_t size,
-- 
2.20.1

