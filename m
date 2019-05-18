Return-Path: <SRS0=//ty=TS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89CBDC04AAF
	for <linux-kernel@archiver.kernel.org>; Sat, 18 May 2019 08:59:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5C5B9206BF
	for <linux-kernel@archiver.kernel.org>; Sat, 18 May 2019 08:59:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="ZWgXp6qh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729554AbfERI7z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 18 May 2019 04:59:55 -0400
Received: from terminus.zytor.com ([198.137.202.136]:60253 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726263AbfERI7y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 May 2019 04:59:54 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x4I8wkvL1733607
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Sat, 18 May 2019 01:58:46 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x4I8wkvL1733607
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019041745; t=1558169927;
        bh=a1tkUbzT1LKiVA0+L5eHxUsD4dv/AYTuWJMXhqRRPhU=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=ZWgXp6qh/2LmpOMnwptPvbhsfuu3Up80mE0bDlvN1RsLpWJ+UAdyk33FbDtEgs9Lo
         FekM4TNWC4/JcEA8qpOrsjo6L9Yspaiq21V1sogBtJDMiZezQtBMl9yQp1hBPQw+vJ
         8FjrB/BHK2L2olPQ3iI48coG945sEl1N08cGpIqe8KlCEvKl5+LqElgP2K9QO2S4FZ
         4zdtX5Gdj/U2fnRx3i3rPZhS6csxXBbQaDTefKvjHeg4DKYiRYarim5Q81idCsmRQi
         iPmktZM0ZBgVq2Uab1Ce+OftHX71egOy1cMWyvCrS94GcESxA7QE0WdOaJ1ffDIVhh
         Jgf4XzEbe+8pg==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x4I8wi2V1733550;
        Sat, 18 May 2019 01:58:44 -0700
Date:   Sat, 18 May 2019 01:58:44 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Kan Liang <tipbot@zytor.com>
Message-ID: <tip-bf6d18cffa5f26bd5dc71485c2a2ad0c42a0ce60@git.kernel.org>
Cc:     linux-kernel@vger.kernel.org, hpa@zytor.com, acme@redhat.com,
        kan.liang@linux.intel.com, tglx@linutronix.de, mingo@kernel.org,
        ak@linux.intel.com, jolsa@kernel.org
Reply-To: tglx@linutronix.de, kan.liang@linux.intel.com, acme@redhat.com,
          hpa@zytor.com, linux-kernel@vger.kernel.org, jolsa@kernel.org,
          ak@linux.intel.com, mingo@kernel.org
In-Reply-To: <1557234991-130456-1-git-send-email-kan.liang@linux.intel.com>
References: <1557234991-130456-1-git-send-email-kan.liang@linux.intel.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf vendor events intel: Add uncore_upi JSON
 support
Git-Commit-ID: bf6d18cffa5f26bd5dc71485c2a2ad0c42a0ce60
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

Commit-ID:  bf6d18cffa5f26bd5dc71485c2a2ad0c42a0ce60
Gitweb:     https://git.kernel.org/tip/bf6d18cffa5f26bd5dc71485c2a2ad0c42a0ce60
Author:     Kan Liang <kan.liang@linux.intel.com>
AuthorDate: Tue, 7 May 2019 06:16:31 -0700
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Wed, 15 May 2019 16:36:47 -0300

perf vendor events intel: Add uncore_upi JSON support

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
 
