Return-Path: <SRS0=cDsG=WK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F42AC433FF
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 18:42:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E98EB2173B
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 18:42:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1565808135;
	bh=zqDa+7rVeHBWtSIMlu/TAYitVFxHc7/5mZ3QJC6N+G0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Zr/4PIwgieQ8CtXTOpPeua4W3XYEo07Es9ZHQL0qU3T+DsqP/iQVRx1+EQbokn7J4
	 UzJmzl+H187KDCBtzLN7bJqGDkT3OZyILQk4UapYs3cgLwi47sDQAdjCumlG6gW1Bu
	 7lI7cNHC/YpFROFHdmB5YfHxA2vQc43ndvU+I0vs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728952AbfHNSmO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Aug 2019 14:42:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:53208 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728262AbfHNSmN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Aug 2019 14:42:13 -0400
Received: from quaco.ghostprotocols.net (unknown [177.195.212.110])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B7C8D216F4;
        Wed, 14 Aug 2019 18:42:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565808132;
        bh=zqDa+7rVeHBWtSIMlu/TAYitVFxHc7/5mZ3QJC6N+G0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=AjaM+geDKqnwoIEzOy9E2N/6+eJPL2dmAKyYAjK25Qtg9zLsu6qBlODIf8yv5iFeG
         sxbX2+RDEAvRSaZJi1iD6livKC7xFEnRqt7tW2yPcmmVq9D8+6mzyddj37j5yW2M02
         JVnNgo1bsu6Z3udiFndC4+K6UYaXPQiFdLbwmkH0=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        =?UTF-8?q?Luis=20Cl=C3=A1udio=20Gon=C3=A7alves?= 
        <lclaudio@redhat.com>, Taeung Song <treeze.taeung@gmail.com>
Subject: [PATCH 02/28] perf config: Honour $PERF_CONFIG env var to specify alternate .perfconfig
Date:   Wed, 14 Aug 2019 15:40:25 -0300
Message-Id: <20190814184051.3125-3-acme@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190814184051.3125-1-acme@kernel.org>
References: <20190814184051.3125-1-acme@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

We had this comment in Documentation/perf_counter/config.c, i.e. since
when we got this from the git sources, but never really did that
getenv("PERF_CONFIG"), do it now as I need to disable whatever
~/.perfconfig root has so that tests parsing tool output are done for
the expected default output or that we specify an alternate config file
that when read will make the tools produce expected output.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Luis Cláudio Gonçalves <lclaudio@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Taeung Song <treeze.taeung@gmail.com>
Fixes: 078006012401 ("perf_counter tools: add in basic glue from Git")
Link: https://lkml.kernel.org/n/tip-jo209zac9rut0dz1rqvbdlgm@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/perf.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/tools/perf/perf.c b/tools/perf/perf.c
index 97e2628ea5dd..d4e4d53e8b44 100644
--- a/tools/perf/perf.c
+++ b/tools/perf/perf.c
@@ -441,6 +441,9 @@ int main(int argc, const char **argv)
 
 	srandom(time(NULL));
 
+	/* Setting $PERF_CONFIG makes perf read _only_ the given config file. */
+	config_exclusive_filename = getenv("PERF_CONFIG");
+
 	err = perf_config(perf_default_config, NULL);
 	if (err)
 		return err;
-- 
2.21.0

