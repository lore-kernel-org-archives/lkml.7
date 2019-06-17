Return-Path: <SRS0=xALZ=UQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B314BC31E5B
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 19:02:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 83FED2085A
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 19:02:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="Ng2Edlot"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728564AbfFQTCz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Jun 2019 15:02:55 -0400
Received: from terminus.zytor.com ([198.137.202.136]:56681 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725497AbfFQTCy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jun 2019 15:02:54 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x5HJ2ePQ3554782
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Mon, 17 Jun 2019 12:02:40 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x5HJ2ePQ3554782
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019051801; t=1560798161;
        bh=mv6cuHGdoXRcDWrcpU2BEimXAT/tXYNt7TznQTqPCI4=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=Ng2EdlotcGjd4f8SXfH5bHo7eED6hir+I2A5QK6Fu0rz8mD2Z2ivo4oheSCdA6TBB
         GeuZukjchRnm9bNx+05jHOufI/CF4Pu+xMp56Yq/G9fxF6vJAYbOVIwP/6ECkU0DK4
         Cqvhg7Wjtea3jJMREbtOfC06dG9ITxPUuc5lYyt4QeOb5qlszMsM0FpD8YO6PdQCdJ
         PHTlDnKS3uE2Vu2JlZP1myejUKotmPyQZ9LdGgXbtbE2ziGOOGcQoUxrzYIrmhkI9P
         Yr/049v1qCjse+1mjgKL2lqRyOVXmiRWbg8GuksA4sjlPoJomKQ57txeRyWtlXJG2F
         p7J2KhMeIobdg==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x5HJ2ebw3554779;
        Mon, 17 Jun 2019 12:02:40 -0700
Date:   Mon, 17 Jun 2019 12:02:40 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Adrian Hunter <tipbot@zytor.com>
Message-ID: <tip-9bc668e3bca8fadc50d5a121a1992a72ada0d3f4@git.kernel.org>
Cc:     linux-kernel@vger.kernel.org, acme@redhat.com, mingo@kernel.org,
        hpa@zytor.com, adrian.hunter@intel.com, jolsa@redhat.com,
        tglx@linutronix.de
Reply-To: jolsa@redhat.com, adrian.hunter@intel.com, hpa@zytor.com,
          mingo@kernel.org, acme@redhat.com, tglx@linutronix.de,
          linux-kernel@vger.kernel.org
In-Reply-To: <20190520113728.14389-10-adrian.hunter@intel.com>
References: <20190520113728.14389-10-adrian.hunter@intel.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf intel-pt: Record when decoding PSB+ packets
Git-Commit-ID: 9bc668e3bca8fadc50d5a121a1992a72ada0d3f4
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

Commit-ID:  9bc668e3bca8fadc50d5a121a1992a72ada0d3f4
Gitweb:     https://git.kernel.org/tip/9bc668e3bca8fadc50d5a121a1992a72ada0d3f4
Author:     Adrian Hunter <adrian.hunter@intel.com>
AuthorDate: Mon, 20 May 2019 14:37:15 +0300
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Wed, 5 Jun 2019 09:47:56 -0300

perf intel-pt: Record when decoding PSB+ packets

In preparation for using MTC packets to count cycles, record whether
decoding is between a PSB and PSBEND packets.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Link: http://lkml.kernel.org/r/20190520113728.14389-10-adrian.hunter@intel.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 .../perf/util/intel-pt-decoder/intel-pt-decoder.c  | 41 ++++++++++++++++------
 1 file changed, 31 insertions(+), 10 deletions(-)

diff --git a/tools/perf/util/intel-pt-decoder/intel-pt-decoder.c b/tools/perf/util/intel-pt-decoder/intel-pt-decoder.c
index ef3a1c1cd250..a2384a314990 100644
--- a/tools/perf/util/intel-pt-decoder/intel-pt-decoder.c
+++ b/tools/perf/util/intel-pt-decoder/intel-pt-decoder.c
@@ -116,6 +116,7 @@ struct intel_pt_decoder {
 	bool have_cyc;
 	bool fixup_last_mtc;
 	bool have_last_ip;
+	bool in_psb;
 	enum intel_pt_param_flags flags;
 	uint64_t pos;
 	uint64_t last_ip;
@@ -1549,14 +1550,17 @@ static int intel_pt_walk_psbend(struct intel_pt_decoder *decoder)
 {
 	int err;
 
+	decoder->in_psb = true;
+
 	while (1) {
 		err = intel_pt_get_next_packet(decoder);
 		if (err)
-			return err;
+			goto out;
 
 		switch (decoder->packet.type) {
 		case INTEL_PT_PSBEND:
-			return 0;
+			err = 0;
+			goto out;
 
 		case INTEL_PT_TIP_PGD:
 		case INTEL_PT_TIP_PGE:
@@ -1574,10 +1578,12 @@ static int intel_pt_walk_psbend(struct intel_pt_decoder *decoder)
 		case INTEL_PT_PWRX:
 			decoder->have_tma = false;
 			intel_pt_log("ERROR: Unexpected packet\n");
-			return -EAGAIN;
+			err = -EAGAIN;
+			goto out;
 
 		case INTEL_PT_OVF:
-			return intel_pt_overflow(decoder);
+			err = intel_pt_overflow(decoder);
+			goto out;
 
 		case INTEL_PT_TSC:
 			intel_pt_calc_tsc_timestamp(decoder);
@@ -1623,6 +1629,10 @@ static int intel_pt_walk_psbend(struct intel_pt_decoder *decoder)
 			break;
 		}
 	}
+out:
+	decoder->in_psb = false;
+
+	return err;
 }
 
 static int intel_pt_walk_fup_tip(struct intel_pt_decoder *decoder)
@@ -1996,10 +2006,12 @@ static int intel_pt_walk_psb(struct intel_pt_decoder *decoder)
 {
 	int err;
 
+	decoder->in_psb = true;
+
 	while (1) {
 		err = intel_pt_get_next_packet(decoder);
 		if (err)
-			return err;
+			goto out;
 
 		switch (decoder->packet.type) {
 		case INTEL_PT_TIP_PGD:
@@ -2015,7 +2027,8 @@ static int intel_pt_walk_psb(struct intel_pt_decoder *decoder)
 		case INTEL_PT_PWRE:
 		case INTEL_PT_PWRX:
 			intel_pt_log("ERROR: Unexpected packet\n");
-			return -ENOENT;
+			err = -ENOENT;
+			goto out;
 
 		case INTEL_PT_FUP:
 			decoder->pge = true;
@@ -2074,16 +2087,20 @@ static int intel_pt_walk_psb(struct intel_pt_decoder *decoder)
 				decoder->pkt_state = INTEL_PT_STATE_ERR4;
 			else
 				decoder->pkt_state = INTEL_PT_STATE_ERR3;
-			return -ENOENT;
+			err = -ENOENT;
+			goto out;
 
 		case INTEL_PT_BAD: /* Does not happen */
-			return intel_pt_bug(decoder);
+			err = intel_pt_bug(decoder);
+			goto out;
 
 		case INTEL_PT_OVF:
-			return intel_pt_overflow(decoder);
+			err = intel_pt_overflow(decoder);
+			goto out;
 
 		case INTEL_PT_PSBEND:
-			return 0;
+			err = 0;
+			goto out;
 
 		case INTEL_PT_PSB:
 		case INTEL_PT_VMCS:
@@ -2093,6 +2110,10 @@ static int intel_pt_walk_psb(struct intel_pt_decoder *decoder)
 			break;
 		}
 	}
+out:
+	decoder->in_psb = false;
+
+	return err;
 }
 
 static int intel_pt_walk_to_ip(struct intel_pt_decoder *decoder)
