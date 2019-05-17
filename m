Return-Path: <SRS0=M1fl=TR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 615EDC04AB4
	for <linux-kernel@archiver.kernel.org>; Fri, 17 May 2019 19:37:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 325472189F
	for <linux-kernel@archiver.kernel.org>; Fri, 17 May 2019 19:37:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1558121868;
	bh=A5w67ut3+Fw2xC7zRg11cdfIbepIIL9aAb3m/rsBGHY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=2k0/XnPzWYp9K4NbTZsuprwikbSH8JgeAs0ATKUooftnfnFV/VZMPRC/mS/jVrjp2
	 7O0Hi5WkLNtirDQHt2fNlr4WloCZAC8vTqfjATIzYreMXuE9UUyBzwstKdnmHKgi3s
	 QPrdtlzzFQkSsWfEkpKMo88VnePdGnx1ckBefpgA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729629AbfEQThr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 May 2019 15:37:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:51748 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729211AbfEQThn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 May 2019 15:37:43 -0400
Received: from quaco.ghostprotocols.net (unknown [190.15.121.82])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 18CA92087B;
        Fri, 17 May 2019 19:37:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1558121863;
        bh=A5w67ut3+Fw2xC7zRg11cdfIbepIIL9aAb3m/rsBGHY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=APHlfASucxmWkRoxuJ4hQxE3UzD3jD7QGP0uibtGTnn5rpzJmSG1RWtmzyUQhR5Z+
         11u/BCnULX5Jn9JRzh6srMqUGP/tCP0ZB6pgWgbWvmBBuwRA6x11q6eSInfwNjph85
         YY0hsdg7DbXv02R7WdRRpa7v9Ipwczk8NW5oTKT8=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Kan Liang <kan.liang@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 19/73] perf vendor events intel: Add uncore_upi JSON support
Date:   Fri, 17 May 2019 16:35:17 -0300
Message-Id: <20190517193611.4974-20-acme@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190517193611.4974-1-acme@kernel.org>
References: <20190517193611.4974-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kan Liang <kan.liang@linux.intel.com>

Perf cannot parse UPI (Intel's "Ultra Path Interconnect" [1]) events.

    # perf stat -e UPI_DATA_BANDWIDTH_TX
    event syntax error: 'UPI_DATA_BANDWIDTH_TX'
                     \___ parser error
    Run 'perf list' for a list of valid events

The JSON lists call the box UPI LL, while perf calls it upi.  Add
conversion support to JSON to convert the unit properly.

Committer notes:

[1] https://en.wikipedia.org/wiki/Intel_Ultra_Path_Interconnect

"The Intel Ultra Path Interconnect (UPI) is a point-to-point processor
interconnect developed by Intel which replaced the Intel QuickPath
Interconnect (QPI) in Xeon Skylake-SP platforms starting in 2017.

UPI is a low-latency coherent interconnect for scalable multiprocessor
systems with a shared address space. It uses a directory-based home
snoop coherency protocol with a transfer speed of up to 10.4 GT/s.
Supporting processors typically have two or three UPI links."

Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Link: http://lkml.kernel.org/r/1557234991-130456-1-git-send-email-kan.liang@linux.intel.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/pmu-events/jevents.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/perf/pmu-events/jevents.c b/tools/perf/pmu-events/jevents.c
index 68c92bb599ee..daaea5003d4a 100644
--- a/tools/perf/pmu-events/jevents.c
+++ b/tools/perf/pmu-events/jevents.c
@@ -235,6 +235,7 @@ static struct map {
 	{ "iMPH-U", "uncore_arb" },
 	{ "CPU-M-CF", "cpum_cf" },
 	{ "CPU-M-SF", "cpum_sf" },
+	{ "UPI LL", "uncore_upi" },
 	{}
 };
 
-- 
2.20.1

