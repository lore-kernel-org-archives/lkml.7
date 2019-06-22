Return-Path: <SRS0=kYop=UV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AC48C43613
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Jun 2019 06:37:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 462A42070B
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Jun 2019 06:37:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="P0qoTgLm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726162AbfFVGhw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 22 Jun 2019 02:37:52 -0400
Received: from terminus.zytor.com ([198.137.202.136]:36143 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726070AbfFVGhv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Jun 2019 02:37:51 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x5M6bRB82004944
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Fri, 21 Jun 2019 23:37:27 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x5M6bRB82004944
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019061801; t=1561185447;
        bh=8u1wahMkJ0xlG/KtM9P36InjJ1/0mShh+sjtaHvdXvY=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=P0qoTgLm9rAKts+XUf+X72nBs/eB7KZNm2K8dmynd8mhIFY1lWSARACihKvGdfnkH
         b1s6MzOJ43lBnzk4pyVXV8vZgLmlVST3aZbrfegSu0LYZG3apUTNe9WERD9Cgibld9
         mGqfF9YweKTdvGir4fNWM4ALUtxN7dAMAPc52NF6tp5cQ2YY8Lzu5mcrOwHD2yGtwL
         fZS48uIn3qsegHvvuSRXj9WEOMD6nw/TRcTLQYAQRrtH2KP6mAFAo0y8YyrTLvIxNq
         +fdgClqdIg1+oX1HatTHyH7iFhLCx29O6HVObMjdJtoLpHafqPLhObiHlBUrOgErpw
         pE2ASRSD+YUEA==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x5M6bR7g2004941;
        Fri, 21 Jun 2019 23:37:27 -0700
Date:   Fri, 21 Jun 2019 23:37:27 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Adrian Hunter <tipbot@zytor.com>
Message-ID: <tip-4c35595e1ea7585d09eb80096f47af237061e795@git.kernel.org>
Cc:     linux-kernel@vger.kernel.org, tglx@linutronix.de, jolsa@redhat.com,
        acme@redhat.com, hpa@zytor.com, mingo@kernel.org,
        adrian.hunter@intel.com
Reply-To: adrian.hunter@intel.com, mingo@kernel.org, hpa@zytor.com,
          acme@redhat.com, jolsa@redhat.com, tglx@linutronix.de,
          linux-kernel@vger.kernel.org
In-Reply-To: <20190610072803.10456-4-adrian.hunter@intel.com>
References: <20190610072803.10456-4-adrian.hunter@intel.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf intel-pt: Add decoder support for PEBS via PT
Git-Commit-ID: 4c35595e1ea7585d09eb80096f47af237061e795
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

Commit-ID:  4c35595e1ea7585d09eb80096f47af237061e795
Gitweb:     https://git.kernel.org/tip/4c35595e1ea7585d09eb80096f47af237061e795
Author:     Adrian Hunter <adrian.hunter@intel.com>
AuthorDate: Mon, 10 Jun 2019 10:27:55 +0300
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Mon, 17 Jun 2019 15:57:17 -0300

perf intel-pt: Add decoder support for PEBS via PT

PEBS data is encoded in Block Item Packets (BIP). Populate a new structure
intel_pt_blk_items with the values and, upon a Block End Packet (BEP),
report them as a new Intel PT sample type INTEL_PT_BLK_ITEMS.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Link: http://lkml.kernel.org/r/20190610072803.10456-4-adrian.hunter@intel.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 .../perf/util/intel-pt-decoder/intel-pt-decoder.c  |  78 +++++++++++-
 .../perf/util/intel-pt-decoder/intel-pt-decoder.h  | 137 +++++++++++++++++++++
 2 files changed, 214 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/intel-pt-decoder/intel-pt-decoder.c b/tools/perf/util/intel-pt-decoder/intel-pt-decoder.c
index 2f7791d4034f..f8b71bf2bb4c 100644
--- a/tools/perf/util/intel-pt-decoder/intel-pt-decoder.c
+++ b/tools/perf/util/intel-pt-decoder/intel-pt-decoder.c
@@ -134,6 +134,9 @@ struct intel_pt_decoder {
 	struct intel_pt_stack stack;
 	enum intel_pt_pkt_state pkt_state;
 	enum intel_pt_pkt_ctx pkt_ctx;
+	enum intel_pt_pkt_ctx prev_pkt_ctx;
+	enum intel_pt_blk_type blk_type;
+	int blk_type_pos;
 	struct intel_pt_pkt packet;
 	struct intel_pt_pkt tnt;
 	int pkt_step;
@@ -167,6 +170,7 @@ struct intel_pt_decoder {
 	bool set_fup_mwait;
 	bool set_fup_pwre;
 	bool set_fup_exstop;
+	bool set_fup_bep;
 	bool sample_cyc;
 	unsigned int fup_tx_flags;
 	unsigned int tx_flags;
@@ -560,6 +564,7 @@ static int intel_pt_get_split_packet(struct intel_pt_decoder *decoder)
 	memcpy(buf + len, decoder->buf, n);
 	len += n;
 
+	decoder->prev_pkt_ctx = decoder->pkt_ctx;
 	ret = intel_pt_get_packet(buf, len, &decoder->packet, &decoder->pkt_ctx);
 	if (ret < (int)old_len) {
 		decoder->next_buf = decoder->buf;
@@ -885,6 +890,7 @@ static int intel_pt_get_next_packet(struct intel_pt_decoder *decoder)
 				return ret;
 		}
 
+		decoder->prev_pkt_ctx = decoder->pkt_ctx;
 		ret = intel_pt_get_packet(decoder->buf, decoder->len,
 					  &decoder->packet, &decoder->pkt_ctx);
 		if (ret == INTEL_PT_NEED_MORE_BYTES && BITS_PER_LONG == 32 &&
@@ -1124,6 +1130,14 @@ static bool intel_pt_fup_event(struct intel_pt_decoder *decoder)
 		decoder->state.to_ip = 0;
 		ret = true;
 	}
+	if (decoder->set_fup_bep) {
+		decoder->set_fup_bep = false;
+		decoder->state.type |= INTEL_PT_BLK_ITEMS;
+		decoder->state.type &= ~INTEL_PT_BRANCH;
+		decoder->state.from_ip = decoder->ip;
+		decoder->state.to_ip = 0;
+		ret = true;
+	}
 	return ret;
 }
 
@@ -1609,6 +1623,46 @@ static void intel_pt_calc_cyc_timestamp(struct intel_pt_decoder *decoder)
 	intel_pt_log_to("Setting timestamp", decoder->timestamp);
 }
 
+static void intel_pt_bbp(struct intel_pt_decoder *decoder)
+{
+	if (decoder->prev_pkt_ctx == INTEL_PT_NO_CTX) {
+		memset(decoder->state.items.mask, 0, sizeof(decoder->state.items.mask));
+		decoder->state.items.is_32_bit = false;
+	}
+	decoder->blk_type = decoder->packet.payload;
+	decoder->blk_type_pos = intel_pt_blk_type_pos(decoder->blk_type);
+	if (decoder->blk_type == INTEL_PT_GP_REGS)
+		decoder->state.items.is_32_bit = decoder->packet.count;
+	if (decoder->blk_type_pos < 0) {
+		intel_pt_log("WARNING: Unknown block type %u\n",
+			     decoder->blk_type);
+	} else if (decoder->state.items.mask[decoder->blk_type_pos]) {
+		intel_pt_log("WARNING: Duplicate block type %u\n",
+			     decoder->blk_type);
+	}
+}
+
+static void intel_pt_bip(struct intel_pt_decoder *decoder)
+{
+	uint32_t id = decoder->packet.count;
+	uint32_t bit = 1 << id;
+	int pos = decoder->blk_type_pos;
+
+	if (pos < 0 || id >= INTEL_PT_BLK_ITEM_ID_CNT) {
+		intel_pt_log("WARNING: Unknown block item %u type %d\n",
+			     id, decoder->blk_type);
+		return;
+	}
+
+	if (decoder->state.items.mask[pos] & bit) {
+		intel_pt_log("WARNING: Duplicate block item %u type %d\n",
+			     id, decoder->blk_type);
+	}
+
+	decoder->state.items.mask[pos] |= bit;
+	decoder->state.items.val[pos][id] = decoder->packet.payload;
+}
+
 /* Walk PSB+ packets when already in sync. */
 static int intel_pt_walk_psbend(struct intel_pt_decoder *decoder)
 {
@@ -2063,10 +2117,31 @@ next:
 			return 0;
 
 		case INTEL_PT_BBP:
+			intel_pt_bbp(decoder);
+			break;
+
 		case INTEL_PT_BIP:
+			intel_pt_bip(decoder);
+			break;
+
 		case INTEL_PT_BEP:
+			decoder->state.type = INTEL_PT_BLK_ITEMS;
+			decoder->state.from_ip = decoder->ip;
+			decoder->state.to_ip = 0;
+			return 0;
+
 		case INTEL_PT_BEP_IP:
-			break;
+			err = intel_pt_get_next_packet(decoder);
+			if (err)
+				return err;
+			if (decoder->packet.type == INTEL_PT_FUP) {
+				decoder->set_fup_bep = true;
+				no_tip = true;
+			} else {
+				intel_pt_log_at("ERROR: Missing FUP after BEP",
+						decoder->pos);
+			}
+			goto next;
 
 		default:
 			return intel_pt_bug(decoder);
@@ -2335,6 +2410,7 @@ static int intel_pt_sync_ip(struct intel_pt_decoder *decoder)
 	decoder->set_fup_mwait = false;
 	decoder->set_fup_pwre = false;
 	decoder->set_fup_exstop = false;
+	decoder->set_fup_bep = false;
 
 	if (!decoder->branch_enable) {
 		decoder->pkt_state = INTEL_PT_STATE_IN_SYNC;
diff --git a/tools/perf/util/intel-pt-decoder/intel-pt-decoder.h b/tools/perf/util/intel-pt-decoder/intel-pt-decoder.h
index 754efa8b501f..9957f2ccdca8 100644
--- a/tools/perf/util/intel-pt-decoder/intel-pt-decoder.h
+++ b/tools/perf/util/intel-pt-decoder/intel-pt-decoder.h
@@ -30,6 +30,7 @@ enum intel_pt_sample_type {
 	INTEL_PT_CBR_CHG	= 1 << 8,
 	INTEL_PT_TRACE_BEGIN	= 1 << 9,
 	INTEL_PT_TRACE_END	= 1 << 10,
+	INTEL_PT_BLK_ITEMS	= 1 << 11,
 };
 
 enum intel_pt_period_type {
@@ -61,6 +62,141 @@ enum intel_pt_param_flags {
 	INTEL_PT_FUP_WITH_NLIP	= 1 << 0,
 };
 
+enum intel_pt_blk_type {
+	INTEL_PT_GP_REGS	= 1,
+	INTEL_PT_PEBS_BASIC	= 4,
+	INTEL_PT_PEBS_MEM	= 5,
+	INTEL_PT_LBR_0		= 8,
+	INTEL_PT_LBR_1		= 9,
+	INTEL_PT_LBR_2		= 10,
+	INTEL_PT_XMM		= 16,
+	INTEL_PT_BLK_TYPE_MAX
+};
+
+/*
+ * The block type numbers are not sequential but here they are given sequential
+ * positions to avoid wasting space for array placement.
+ */
+enum intel_pt_blk_type_pos {
+	INTEL_PT_GP_REGS_POS,
+	INTEL_PT_PEBS_BASIC_POS,
+	INTEL_PT_PEBS_MEM_POS,
+	INTEL_PT_LBR_0_POS,
+	INTEL_PT_LBR_1_POS,
+	INTEL_PT_LBR_2_POS,
+	INTEL_PT_XMM_POS,
+	INTEL_PT_BLK_TYPE_CNT
+};
+
+/* Get the array position for a block type */
+static inline int intel_pt_blk_type_pos(enum intel_pt_blk_type blk_type)
+{
+#define BLK_TYPE(bt) [INTEL_PT_##bt] = INTEL_PT_##bt##_POS + 1
+	const int map[INTEL_PT_BLK_TYPE_MAX] = {
+		BLK_TYPE(GP_REGS),
+		BLK_TYPE(PEBS_BASIC),
+		BLK_TYPE(PEBS_MEM),
+		BLK_TYPE(LBR_0),
+		BLK_TYPE(LBR_1),
+		BLK_TYPE(LBR_2),
+		BLK_TYPE(XMM),
+	};
+#undef BLK_TYPE
+
+	return blk_type < INTEL_PT_BLK_TYPE_MAX ? map[blk_type] - 1 : -1;
+}
+
+#define INTEL_PT_BLK_ITEM_ID_CNT	32
+
+/*
+ * Use unions so that the block items can be accessed by name or by array index.
+ * There is an array of 32-bit masks for each block type, which indicate which
+ * values are present. Then arrays of 32 64-bit values for each block type.
+ */
+struct intel_pt_blk_items {
+	union {
+		uint32_t mask[INTEL_PT_BLK_TYPE_CNT];
+		struct {
+			uint32_t has_rflags:1;
+			uint32_t has_rip:1;
+			uint32_t has_rax:1;
+			uint32_t has_rcx:1;
+			uint32_t has_rdx:1;
+			uint32_t has_rbx:1;
+			uint32_t has_rsp:1;
+			uint32_t has_rbp:1;
+			uint32_t has_rsi:1;
+			uint32_t has_rdi:1;
+			uint32_t has_r8:1;
+			uint32_t has_r9:1;
+			uint32_t has_r10:1;
+			uint32_t has_r11:1;
+			uint32_t has_r12:1;
+			uint32_t has_r13:1;
+			uint32_t has_r14:1;
+			uint32_t has_r15:1;
+			uint32_t has_unused_0:14;
+			uint32_t has_ip:1;
+			uint32_t has_applicable_counters:1;
+			uint32_t has_timestamp:1;
+			uint32_t has_unused_1:29;
+			uint32_t has_mem_access_address:1;
+			uint32_t has_mem_aux_info:1;
+			uint32_t has_mem_access_latency:1;
+			uint32_t has_tsx_aux_info:1;
+			uint32_t has_unused_2:28;
+			uint32_t has_lbr_0;
+			uint32_t has_lbr_1;
+			uint32_t has_lbr_2;
+			uint32_t has_xmm;
+		};
+	};
+	union {
+		uint64_t val[INTEL_PT_BLK_TYPE_CNT][INTEL_PT_BLK_ITEM_ID_CNT];
+		struct {
+			struct {
+				uint64_t rflags;
+				uint64_t rip;
+				uint64_t rax;
+				uint64_t rcx;
+				uint64_t rdx;
+				uint64_t rbx;
+				uint64_t rsp;
+				uint64_t rbp;
+				uint64_t rsi;
+				uint64_t rdi;
+				uint64_t r8;
+				uint64_t r9;
+				uint64_t r10;
+				uint64_t r11;
+				uint64_t r12;
+				uint64_t r13;
+				uint64_t r14;
+				uint64_t r15;
+				uint64_t unused_0[INTEL_PT_BLK_ITEM_ID_CNT - 18];
+			};
+			struct {
+				uint64_t ip;
+				uint64_t applicable_counters;
+				uint64_t timestamp;
+				uint64_t unused_1[INTEL_PT_BLK_ITEM_ID_CNT - 3];
+			};
+			struct {
+				uint64_t mem_access_address;
+				uint64_t mem_aux_info;
+				uint64_t mem_access_latency;
+				uint64_t tsx_aux_info;
+				uint64_t unused_2[INTEL_PT_BLK_ITEM_ID_CNT - 4];
+			};
+			uint64_t lbr_0[INTEL_PT_BLK_ITEM_ID_CNT];
+			uint64_t lbr_1[INTEL_PT_BLK_ITEM_ID_CNT];
+			uint64_t lbr_2[INTEL_PT_BLK_ITEM_ID_CNT];
+			uint64_t xmm[INTEL_PT_BLK_ITEM_ID_CNT];
+		};
+	};
+	bool is_32_bit;
+};
+
 struct intel_pt_state {
 	enum intel_pt_sample_type type;
 	int err;
@@ -81,6 +217,7 @@ struct intel_pt_state {
 	enum intel_pt_insn_op insn_op;
 	int insn_len;
 	char insn[INTEL_PT_INSN_BUF_SZ];
+	struct intel_pt_blk_items items;
 };
 
 struct intel_pt_insn;
