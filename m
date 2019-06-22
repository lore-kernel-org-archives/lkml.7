Return-Path: <SRS0=kYop=UV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35067C43613
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Jun 2019 06:36:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DB4E1208C3
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Jun 2019 06:36:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="Stfngi5q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726204AbfFVGgQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 22 Jun 2019 02:36:16 -0400
Received: from terminus.zytor.com ([198.137.202.136]:38041 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726067AbfFVGgQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Jun 2019 02:36:16 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x5M6ZqxY2004381
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Fri, 21 Jun 2019 23:35:52 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x5M6ZqxY2004381
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019061801; t=1561185353;
        bh=PUxARrLvvRCnMRM1ZkVLEhRmiwS7gZ+Ote2Nu6gZmpo=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=Stfngi5qibHYNSMbikFiEYkDKD4ll9fRDVJxcvPgtpjTs6nYYrvaFBMfbFkyGfnqj
         PACy4jmR7sCVbja7slkfJmafmERSasJF2/JRkkYRWupvdg2NMA0WOAUTufqMLRtN1k
         0XKqyH5sQh20Gq/8ISTXYvcz7JAc8/rn+gB6FGUmLkrMMsWeU/uxb4TvIurH42QUIp
         LklqeSy+YuP3Tqc+IlHgFnXZHU9uDkj1V3I4PGAIVIliUpAMgSBiS4zzVCjvy2ciKc
         2qGPE0TFKf8BaYtH899yHQsDLA6U+Mu0A1BYXQRyHRTv0T75DoGaT8LrQXw05r4tuJ
         FHU9dLTty+vdA==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x5M6ZqEX2004378;
        Fri, 21 Jun 2019 23:35:52 -0700
Date:   Fri, 21 Jun 2019 23:35:52 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Adrian Hunter <tipbot@zytor.com>
Message-ID: <tip-edff7809c80f09398783d602c33a507309c23e24@git.kernel.org>
Cc:     linux-kernel@vger.kernel.org, hpa@zytor.com,
        adrian.hunter@intel.com, tglx@linutronix.de, acme@redhat.com,
        mingo@kernel.org, jolsa@redhat.com
Reply-To: mingo@kernel.org, jolsa@redhat.com, linux-kernel@vger.kernel.org,
          acme@redhat.com, tglx@linutronix.de, adrian.hunter@intel.com,
          hpa@zytor.com
In-Reply-To: <20190610072803.10456-2-adrian.hunter@intel.com>
References: <20190610072803.10456-2-adrian.hunter@intel.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf intel-pt: Add new packets for PEBS via PT
Git-Commit-ID: edff7809c80f09398783d602c33a507309c23e24
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

Commit-ID:  edff7809c80f09398783d602c33a507309c23e24
Gitweb:     https://git.kernel.org/tip/edff7809c80f09398783d602c33a507309c23e24
Author:     Adrian Hunter <adrian.hunter@intel.com>
AuthorDate: Mon, 10 Jun 2019 10:27:53 +0300
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Mon, 17 Jun 2019 15:57:17 -0300

perf intel-pt: Add new packets for PEBS via PT

Add 3 new packets to supports PEBS via PT, namely Block Begin Packet
(BBP), Block Item Packet (BIP) and Block End Packet (BEP). PEBS data is
encoded into multiple BIP packets that come between BBP and BEP. The BEP
packet might be associated with a FUP packet. That is indicated by using
a separate packet type (INTEL_PT_BEP_IP) similar to other packets types
with the _IP suffix.

Refer to the Intel SDM for more information about PEBS via PT:

  https://software.intel.com/en-us/articles/intel-sdm
  May 2019 version: Vol. 3B 18.5.5.2 PEBS output to Intel® Processor Trace

Decoding of BIP packets conflicts with single-byte TNT packets. Since
BIP packets only occur in the context of a block (i.e. between BBP and
BEP), that context must be recorded and passed to the packet decoder.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Link: http://lkml.kernel.org/r/20190610072803.10456-2-adrian.hunter@intel.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 .../perf/util/intel-pt-decoder/intel-pt-decoder.c  |  38 +++++-
 .../util/intel-pt-decoder/intel-pt-pkt-decoder.c   | 140 ++++++++++++++++++++-
 .../util/intel-pt-decoder/intel-pt-pkt-decoder.h   |  21 +++-
 tools/perf/util/intel-pt.c                         |   3 +-
 4 files changed, 193 insertions(+), 9 deletions(-)

diff --git a/tools/perf/util/intel-pt-decoder/intel-pt-decoder.c b/tools/perf/util/intel-pt-decoder/intel-pt-decoder.c
index f001f4ec4ddf..2f7791d4034f 100644
--- a/tools/perf/util/intel-pt-decoder/intel-pt-decoder.c
+++ b/tools/perf/util/intel-pt-decoder/intel-pt-decoder.c
@@ -133,6 +133,7 @@ struct intel_pt_decoder {
 	int mtc_shift;
 	struct intel_pt_stack stack;
 	enum intel_pt_pkt_state pkt_state;
+	enum intel_pt_pkt_ctx pkt_ctx;
 	struct intel_pt_pkt packet;
 	struct intel_pt_pkt tnt;
 	int pkt_step;
@@ -559,7 +560,7 @@ static int intel_pt_get_split_packet(struct intel_pt_decoder *decoder)
 	memcpy(buf + len, decoder->buf, n);
 	len += n;
 
-	ret = intel_pt_get_packet(buf, len, &decoder->packet);
+	ret = intel_pt_get_packet(buf, len, &decoder->packet, &decoder->pkt_ctx);
 	if (ret < (int)old_len) {
 		decoder->next_buf = decoder->buf;
 		decoder->next_len = decoder->len;
@@ -594,6 +595,7 @@ static int intel_pt_pkt_lookahead(struct intel_pt_decoder *decoder,
 {
 	struct intel_pt_pkt_info pkt_info;
 	const unsigned char *buf = decoder->buf;
+	enum intel_pt_pkt_ctx pkt_ctx = decoder->pkt_ctx;
 	size_t len = decoder->len;
 	int ret;
 
@@ -612,7 +614,8 @@ static int intel_pt_pkt_lookahead(struct intel_pt_decoder *decoder,
 			if (!len)
 				return INTEL_PT_NEED_MORE_BYTES;
 
-			ret = intel_pt_get_packet(buf, len, &pkt_info.packet);
+			ret = intel_pt_get_packet(buf, len, &pkt_info.packet,
+						  &pkt_ctx);
 			if (!ret)
 				return INTEL_PT_NEED_MORE_BYTES;
 			if (ret < 0)
@@ -687,6 +690,10 @@ static int intel_pt_calc_cyc_cb(struct intel_pt_pkt_info *pkt_info)
 	case INTEL_PT_MNT:
 	case INTEL_PT_PTWRITE:
 	case INTEL_PT_PTWRITE_IP:
+	case INTEL_PT_BBP:
+	case INTEL_PT_BIP:
+	case INTEL_PT_BEP:
+	case INTEL_PT_BEP_IP:
 		return 0;
 
 	case INTEL_PT_MTC:
@@ -879,7 +886,7 @@ static int intel_pt_get_next_packet(struct intel_pt_decoder *decoder)
 		}
 
 		ret = intel_pt_get_packet(decoder->buf, decoder->len,
-					  &decoder->packet);
+					  &decoder->packet, &decoder->pkt_ctx);
 		if (ret == INTEL_PT_NEED_MORE_BYTES && BITS_PER_LONG == 32 &&
 		    decoder->len < INTEL_PT_PKT_MAX_SZ && !decoder->next_buf) {
 			ret = intel_pt_get_split_packet(decoder);
@@ -1633,6 +1640,10 @@ static int intel_pt_walk_psbend(struct intel_pt_decoder *decoder)
 		case INTEL_PT_MWAIT:
 		case INTEL_PT_PWRE:
 		case INTEL_PT_PWRX:
+		case INTEL_PT_BBP:
+		case INTEL_PT_BIP:
+		case INTEL_PT_BEP:
+		case INTEL_PT_BEP_IP:
 			decoder->have_tma = false;
 			intel_pt_log("ERROR: Unexpected packet\n");
 			err = -EAGAIN;
@@ -1726,6 +1737,10 @@ static int intel_pt_walk_fup_tip(struct intel_pt_decoder *decoder)
 		case INTEL_PT_MWAIT:
 		case INTEL_PT_PWRE:
 		case INTEL_PT_PWRX:
+		case INTEL_PT_BBP:
+		case INTEL_PT_BIP:
+		case INTEL_PT_BEP:
+		case INTEL_PT_BEP_IP:
 			intel_pt_log("ERROR: Missing TIP after FUP\n");
 			decoder->pkt_state = INTEL_PT_STATE_ERR3;
 			decoder->pkt_step = 0;
@@ -2047,6 +2062,12 @@ next:
 			decoder->state.pwrx_payload = decoder->packet.payload;
 			return 0;
 
+		case INTEL_PT_BBP:
+		case INTEL_PT_BIP:
+		case INTEL_PT_BEP:
+		case INTEL_PT_BEP_IP:
+			break;
+
 		default:
 			return intel_pt_bug(decoder);
 		}
@@ -2085,6 +2106,10 @@ static int intel_pt_walk_psb(struct intel_pt_decoder *decoder)
 		case INTEL_PT_MWAIT:
 		case INTEL_PT_PWRE:
 		case INTEL_PT_PWRX:
+		case INTEL_PT_BBP:
+		case INTEL_PT_BIP:
+		case INTEL_PT_BEP:
+		case INTEL_PT_BEP_IP:
 			intel_pt_log("ERROR: Unexpected packet\n");
 			err = -ENOENT;
 			goto out;
@@ -2291,6 +2316,10 @@ static int intel_pt_walk_to_ip(struct intel_pt_decoder *decoder)
 		case INTEL_PT_MWAIT:
 		case INTEL_PT_PWRE:
 		case INTEL_PT_PWRX:
+		case INTEL_PT_BBP:
+		case INTEL_PT_BIP:
+		case INTEL_PT_BEP:
+		case INTEL_PT_BEP_IP:
 		default:
 			break;
 		}
@@ -2641,11 +2670,12 @@ static unsigned char *intel_pt_last_psb(unsigned char *buf, size_t len)
 static bool intel_pt_next_tsc(unsigned char *buf, size_t len, uint64_t *tsc,
 			      size_t *rem)
 {
+	enum intel_pt_pkt_ctx ctx = INTEL_PT_NO_CTX;
 	struct intel_pt_pkt packet;
 	int ret;
 
 	while (len) {
-		ret = intel_pt_get_packet(buf, len, &packet);
+		ret = intel_pt_get_packet(buf, len, &packet, &ctx);
 		if (ret <= 0)
 			return false;
 		if (packet.type == INTEL_PT_TSC) {
diff --git a/tools/perf/util/intel-pt-decoder/intel-pt-pkt-decoder.c b/tools/perf/util/intel-pt-decoder/intel-pt-pkt-decoder.c
index 605fce537d80..0ccf10a0bf44 100644
--- a/tools/perf/util/intel-pt-decoder/intel-pt-pkt-decoder.c
+++ b/tools/perf/util/intel-pt-decoder/intel-pt-pkt-decoder.c
@@ -62,6 +62,10 @@ static const char * const packet_name[] = {
 	[INTEL_PT_MWAIT]	= "MWAIT",
 	[INTEL_PT_PWRE]		= "PWRE",
 	[INTEL_PT_PWRX]		= "PWRX",
+	[INTEL_PT_BBP]		= "BBP",
+	[INTEL_PT_BIP]		= "BIP",
+	[INTEL_PT_BEP]		= "BEP",
+	[INTEL_PT_BEP_IP]	= "BEP",
 };
 
 const char *intel_pt_pkt_name(enum intel_pt_pkt_type type)
@@ -280,6 +284,55 @@ static int intel_pt_get_pwrx(const unsigned char *buf, size_t len,
 	return 7;
 }
 
+static int intel_pt_get_bbp(const unsigned char *buf, size_t len,
+			    struct intel_pt_pkt *packet)
+{
+	if (len < 3)
+		return INTEL_PT_NEED_MORE_BYTES;
+	packet->type = INTEL_PT_BBP;
+	packet->count = buf[2] >> 7;
+	packet->payload = buf[2] & 0x1f;
+	return 3;
+}
+
+static int intel_pt_get_bip_4(const unsigned char *buf, size_t len,
+			      struct intel_pt_pkt *packet)
+{
+	if (len < 5)
+		return INTEL_PT_NEED_MORE_BYTES;
+	packet->type = INTEL_PT_BIP;
+	packet->count = buf[0] >> 3;
+	memcpy_le64(&packet->payload, buf + 1, 4);
+	return 5;
+}
+
+static int intel_pt_get_bip_8(const unsigned char *buf, size_t len,
+			      struct intel_pt_pkt *packet)
+{
+	if (len < 9)
+		return INTEL_PT_NEED_MORE_BYTES;
+	packet->type = INTEL_PT_BIP;
+	packet->count = buf[0] >> 3;
+	memcpy_le64(&packet->payload, buf + 1, 8);
+	return 9;
+}
+
+static int intel_pt_get_bep(size_t len, struct intel_pt_pkt *packet)
+{
+	if (len < 2)
+		return INTEL_PT_NEED_MORE_BYTES;
+	packet->type = INTEL_PT_BEP;
+	return 2;
+}
+
+static int intel_pt_get_bep_ip(size_t len, struct intel_pt_pkt *packet)
+{
+	if (len < 2)
+		return INTEL_PT_NEED_MORE_BYTES;
+	packet->type = INTEL_PT_BEP_IP;
+	return 2;
+}
+
 static int intel_pt_get_ext(const unsigned char *buf, size_t len,
 			    struct intel_pt_pkt *packet)
 {
@@ -320,6 +373,12 @@ static int intel_pt_get_ext(const unsigned char *buf, size_t len,
 		return intel_pt_get_pwre(buf, len, packet);
 	case 0xA2: /* PWRX */
 		return intel_pt_get_pwrx(buf, len, packet);
+	case 0x63: /* BBP */
+		return intel_pt_get_bbp(buf, len, packet);
+	case 0x33: /* BEP no IP */
+		return intel_pt_get_bep(len, packet);
+	case 0xb3: /* BEP with IP */
+		return intel_pt_get_bep_ip(len, packet);
 	default:
 		return INTEL_PT_BAD_PACKET;
 	}
@@ -468,7 +527,8 @@ static int intel_pt_get_mtc(const unsigned char *buf, size_t len,
 }
 
 static int intel_pt_do_get_packet(const unsigned char *buf, size_t len,
-				  struct intel_pt_pkt *packet)
+				  struct intel_pt_pkt *packet,
+				  enum intel_pt_pkt_ctx ctx)
 {
 	unsigned int byte;
 
@@ -478,6 +538,22 @@ static int intel_pt_do_get_packet(const unsigned char *buf, size_t len,
 		return INTEL_PT_NEED_MORE_BYTES;
 
 	byte = buf[0];
+
+	switch (ctx) {
+	case INTEL_PT_NO_CTX:
+		break;
+	case INTEL_PT_BLK_4_CTX:
+		if ((byte & 0x7) == 4)
+			return intel_pt_get_bip_4(buf, len, packet);
+		break;
+	case INTEL_PT_BLK_8_CTX:
+		if ((byte & 0x7) == 4)
+			return intel_pt_get_bip_8(buf, len, packet);
+		break;
+	default:
+		break;
+	};
+
 	if (!(byte & BIT(0))) {
 		if (byte == 0)
 			return intel_pt_get_pad(packet);
@@ -516,15 +592,65 @@ static int intel_pt_do_get_packet(const unsigned char *buf, size_t len,
 	}
 }
 
+void intel_pt_upd_pkt_ctx(const struct intel_pt_pkt *packet,
+			  enum intel_pt_pkt_ctx *ctx)
+{
+	switch (packet->type) {
+	case INTEL_PT_BAD:
+	case INTEL_PT_PAD:
+	case INTEL_PT_TSC:
+	case INTEL_PT_TMA:
+	case INTEL_PT_MTC:
+	case INTEL_PT_FUP:
+	case INTEL_PT_CYC:
+	case INTEL_PT_CBR:
+	case INTEL_PT_MNT:
+	case INTEL_PT_EXSTOP:
+	case INTEL_PT_EXSTOP_IP:
+	case INTEL_PT_PWRE:
+	case INTEL_PT_PWRX:
+	case INTEL_PT_BIP:
+		break;
+	case INTEL_PT_TNT:
+	case INTEL_PT_TIP:
+	case INTEL_PT_TIP_PGD:
+	case INTEL_PT_TIP_PGE:
+	case INTEL_PT_MODE_EXEC:
+	case INTEL_PT_MODE_TSX:
+	case INTEL_PT_PIP:
+	case INTEL_PT_OVF:
+	case INTEL_PT_VMCS:
+	case INTEL_PT_TRACESTOP:
+	case INTEL_PT_PSB:
+	case INTEL_PT_PSBEND:
+	case INTEL_PT_PTWRITE:
+	case INTEL_PT_PTWRITE_IP:
+	case INTEL_PT_MWAIT:
+	case INTEL_PT_BEP:
+	case INTEL_PT_BEP_IP:
+		*ctx = INTEL_PT_NO_CTX;
+		break;
+	case INTEL_PT_BBP:
+		if (packet->count)
+			*ctx = INTEL_PT_BLK_4_CTX;
+		else
+			*ctx = INTEL_PT_BLK_8_CTX;
+		break;
+	default:
+		break;
+	}
+}
+
 int intel_pt_get_packet(const unsigned char *buf, size_t len,
-			struct intel_pt_pkt *packet)
+			struct intel_pt_pkt *packet, enum intel_pt_pkt_ctx *ctx)
 {
 	int ret;
 
-	ret = intel_pt_do_get_packet(buf, len, packet);
+	ret = intel_pt_do_get_packet(buf, len, packet, *ctx);
 	if (ret > 0) {
 		while (ret < 8 && len > (size_t)ret && !buf[ret])
 			ret += 1;
+		intel_pt_upd_pkt_ctx(packet, ctx);
 	}
 	return ret;
 }
@@ -602,8 +728,10 @@ int intel_pt_pkt_desc(const struct intel_pt_pkt *packet, char *buf,
 		return snprintf(buf, buf_len, "%s 0x%llx IP:0", name, payload);
 	case INTEL_PT_PTWRITE_IP:
 		return snprintf(buf, buf_len, "%s 0x%llx IP:1", name, payload);
+	case INTEL_PT_BEP:
 	case INTEL_PT_EXSTOP:
 		return snprintf(buf, buf_len, "%s IP:0", name);
+	case INTEL_PT_BEP_IP:
 	case INTEL_PT_EXSTOP_IP:
 		return snprintf(buf, buf_len, "%s IP:1", name);
 	case INTEL_PT_MWAIT:
@@ -621,6 +749,12 @@ int intel_pt_pkt_desc(const struct intel_pt_pkt *packet, char *buf,
 				(unsigned int)((payload >> 4) & 0xf),
 				(unsigned int)(payload & 0xf),
 				(unsigned int)((payload >> 8) & 0xf));
+	case INTEL_PT_BBP:
+		return snprintf(buf, buf_len, "%s SZ %s-byte Type 0x%llx",
+				name, packet->count ? "4" : "8", payload);
+	case INTEL_PT_BIP:
+		return snprintf(buf, buf_len, "%s ID 0x%02x Value 0x%llx",
+				name, packet->count, payload);
 	default:
 		break;
 	}
diff --git a/tools/perf/util/intel-pt-decoder/intel-pt-pkt-decoder.h b/tools/perf/util/intel-pt-decoder/intel-pt-pkt-decoder.h
index a7aefaa08588..17ca9b56d72f 100644
--- a/tools/perf/util/intel-pt-decoder/intel-pt-pkt-decoder.h
+++ b/tools/perf/util/intel-pt-decoder/intel-pt-pkt-decoder.h
@@ -50,6 +50,10 @@ enum intel_pt_pkt_type {
 	INTEL_PT_MWAIT,
 	INTEL_PT_PWRE,
 	INTEL_PT_PWRX,
+	INTEL_PT_BBP,
+	INTEL_PT_BIP,
+	INTEL_PT_BEP,
+	INTEL_PT_BEP_IP,
 };
 
 struct intel_pt_pkt {
@@ -58,10 +62,25 @@ struct intel_pt_pkt {
 	uint64_t		payload;
 };
 
+/*
+ * Decoding of BIP packets conflicts with single-byte TNT packets. Since BIP
+ * packets only occur in the context of a block (i.e. between BBP and BEP), that
+ * context must be recorded and passed to the packet decoder.
+ */
+enum intel_pt_pkt_ctx {
+	INTEL_PT_NO_CTX,	/* BIP packets are invalid */
+	INTEL_PT_BLK_4_CTX,	/* 4-byte BIP packets */
+	INTEL_PT_BLK_8_CTX,	/* 8-byte BIP packets */
+};
+
 const char *intel_pt_pkt_name(enum intel_pt_pkt_type);
 
 int intel_pt_get_packet(const unsigned char *buf, size_t len,
-			struct intel_pt_pkt *packet);
+			struct intel_pt_pkt *packet,
+			enum intel_pt_pkt_ctx *ctx);
+
+void intel_pt_upd_pkt_ctx(const struct intel_pt_pkt *packet,
+			  enum intel_pt_pkt_ctx *ctx);
 
 int intel_pt_pkt_desc(const struct intel_pt_pkt *packet, char *buf, size_t len);
 
diff --git a/tools/perf/util/intel-pt.c b/tools/perf/util/intel-pt.c
index 8ed51f4e9e30..893cef494a43 100644
--- a/tools/perf/util/intel-pt.c
+++ b/tools/perf/util/intel-pt.c
@@ -177,13 +177,14 @@ static void intel_pt_dump(struct intel_pt *pt __maybe_unused,
 	int ret, pkt_len, i;
 	char desc[INTEL_PT_PKT_DESC_MAX];
 	const char *color = PERF_COLOR_BLUE;
+	enum intel_pt_pkt_ctx ctx = INTEL_PT_NO_CTX;
 
 	color_fprintf(stdout, color,
 		      ". ... Intel Processor Trace data: size %zu bytes\n",
 		      len);
 
 	while (len) {
-		ret = intel_pt_get_packet(buf, len, &packet);
+		ret = intel_pt_get_packet(buf, len, &packet, &ctx);
 		if (ret > 0)
 			pkt_len = ret;
 		else
