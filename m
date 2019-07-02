Return-Path: <SRS0=JAXG=U7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37386C5B578
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jul 2019 02:28:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1067A2183F
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jul 2019 02:28:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1562034532;
	bh=SVHrSuTCIkahwVIAj1H0N9C+8dYexVa3WKpcDqapCBk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Iw0mfg2VYzNPkL3MfwGCFpHlqkatGqmEuUKc9PbIBk4+c7lbtUPMEWVSnB5hDlr4F
	 YSUzvH8E4x4Lgf9rNJk771z0m6H/N4sXJdnx3Y92v0xhhRIy0dTdKMpD8CJ/XATIjT
	 z5aqNKYuVK4UmvdFG8LgVqDQDK3UCyN7awLs4FFw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727680AbfGBC2u (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Jul 2019 22:28:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:41172 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727667AbfGBC2r (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jul 2019 22:28:47 -0400
Received: from quaco.ghostprotocols.net (unknown [179.97.35.11])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 643E921855;
        Tue,  2 Jul 2019 02:28:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1562034526;
        bh=SVHrSuTCIkahwVIAj1H0N9C+8dYexVa3WKpcDqapCBk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=G5ZQ8SMC9K9eryZLUHyN9/y2JXcIoP04OqBr2vsEc0aX824EBpyvsa98RRBPyDdjR
         FVAACjEAOBLTyYeWoYOhxQc+8TvCaXm5HHP/EMzdW2UDwOKabaUOsff2McdB+GD50V
         gcivqWB875jC0hm10P8iH3YS7ib+bEijrKBYG0LI=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Luke Mujica <lukemujica@google.com>,
        Ian Rogers <irogers@google.com>, Jiri Olsa <jolsa@redhat.com>,
        Numfor Mbiziwo-Tiapo <nums@google.com>,
        Stephane Eranian <eranian@google.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 43/43] perf jevents: Use nonlocal include statements in pmu-events.c
Date:   Mon,  1 Jul 2019 23:26:16 -0300
Message-Id: <20190702022616.1259-44-acme@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190702022616.1259-1-acme@kernel.org>
References: <20190702022616.1259-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Luke Mujica <lukemujica@google.com>

Change pmu-events.c to not use local include statements. The code that
creates the include statements for pmu-events.c is in jevents.c.

pmu-events.c is a generated file, and for build systems that put
generated files in a separate directory, include statements with local
pathing cannot find non-generated files.

Signed-off-by: Luke Mujica <lukemujica@google.com>
Cc: Ian Rogers <irogers@google.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Numfor Mbiziwo-Tiapo <nums@google.com>
Cc: Stephane Eranian <eranian@google.com>
Link: https://lkml.kernel.org/n/tip-prgnwmaoo1pv9zz4vnv1bjaj@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/pmu-events/jevents.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/perf/pmu-events/jevents.c b/tools/perf/pmu-events/jevents.c
index 58f77fd0f59f..a1184ea64cc6 100644
--- a/tools/perf/pmu-events/jevents.c
+++ b/tools/perf/pmu-events/jevents.c
@@ -841,7 +841,7 @@ static void create_empty_mapping(const char *output_file)
 		_Exit(1);
 	}
 
-	fprintf(outfp, "#include \"../../pmu-events/pmu-events.h\"\n");
+	fprintf(outfp, "#include \"pmu-events/pmu-events.h\"\n");
 	print_mapping_table_prefix(outfp);
 	print_mapping_table_suffix(outfp);
 	fclose(outfp);
@@ -1096,7 +1096,7 @@ int main(int argc, char *argv[])
 	}
 
 	/* Include pmu-events.h first */
-	fprintf(eventsfp, "#include \"../../pmu-events/pmu-events.h\"\n");
+	fprintf(eventsfp, "#include \"pmu-events/pmu-events.h\"\n");
 
 	/*
 	 * The mapfile allows multiple CPUids to point to the same JSON file,
-- 
2.20.1

