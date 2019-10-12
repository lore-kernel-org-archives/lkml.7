Return-Path: <SRS0=7jSw=YF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A949C4360C
	for <linux-kernel@archiver.kernel.org>; Sat, 12 Oct 2019 18:05:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E29252087E
	for <linux-kernel@archiver.kernel.org>; Sat, 12 Oct 2019 18:05:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KWZNug1A"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729541AbfJLSFr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 12 Oct 2019 14:05:47 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:33633 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728162AbfJLSFq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Oct 2019 14:05:46 -0400
Received: by mail-pg1-f196.google.com with SMTP id i76so7657394pgc.0
        for <linux-kernel@vger.kernel.org>; Sat, 12 Oct 2019 11:05:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=rEqM4BCyfUITd7RdLp49O2Q3WbdzE0IG1F6T4kHRZAI=;
        b=KWZNug1AcDq/W0jwMjpePq5XKlvmtwyDJzLebAZhTG8ZEv+uot4od+LcCKqBjIH3NY
         b6C3z0eBsJJmlz/qI4Z0tX3t6tq/+d8w3/s4xxTr+6YGxluAd2rDnIdMnKdr9K9l5RJB
         g4rZHv+3GNUATi4IjBDbSXlssN4PzVeNkIHDHtO0xzZmwSdxr0gjCfXv2oKN0tTuzBHu
         UJyEZwyAGfTGZ+WSw2qsxU0cBzxny6oSejaat6NRI2wkzrAuDh6xYCvV9aZCQwvzbFci
         scevGaTknAHgYz403wAdwID8nbbPsQN8RrRdogJVsY69wYqJmAiz5VLZ2MWdfu4JfKmV
         TxgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=rEqM4BCyfUITd7RdLp49O2Q3WbdzE0IG1F6T4kHRZAI=;
        b=gH4jEqzjLEpz/71lK/fmQRFQd1dZxhQ+C4MDLRQovo2QtWZDy4ZEZ7qj/umX0M8Z+o
         uU7gheHWcorzK0vgBRLsvIGzSKGzXMGBWnGLvpx5QCxoYrCn9TfmDiGDoiL8mm+Ok46n
         f6oEQbvsAC46UsBg+RW6PVsgCd9ngj7tFHWcL54o14bZGUVn9CyXUnlQ+LaLrl0Sbisf
         bWAFzOwXnswoQa7aBR/dKRjArcfw+iIt1+70t2I34Iv7nZW8I2Mnv3crmW1YhBVOoScb
         7JVuuwvk1P9NQqsHmLc8GA2ZkheTkus7xGEjf5SCOpDu/ROetrxjjvO8GyyNTG/MqhG8
         waiA==
X-Gm-Message-State: APjAAAVG/eRvHbtRlsgd4+rzraXU6P1MEizOHIdResnxYpKESYQ724tw
        +iflNyqWewB4VEUZpCc9p8Y=
X-Google-Smtp-Source: APXvYqzJCoUmkEg42cKJfx38MmmjpETXoC9oUnyc7bm55AHAqdKg1/CrDdSh4FDZvPEvClvtn78OoQ==
X-Received: by 2002:a63:d754:: with SMTP id w20mr4961065pgi.156.1570903545606;
        Sat, 12 Oct 2019 11:05:45 -0700 (PDT)
Received: from wambui.zuku.co.ke ([197.237.61.225])
        by smtp.googlemail.com with ESMTPSA id p17sm12183475pfn.50.2019.10.12.11.05.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Oct 2019 11:05:45 -0700 (PDT)
From:   Wambui Karuga <wambui.karugax@gmail.com>
To:     outreachy-kernel@googlegroups.com
Cc:     gregkh@linuxfoundation.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org,
        Wambui Karuga <wambui.karugax@gmail.com>
Subject: [PATCH v2 1/5] staging: octeon: remove typedef declaration for cvmx_wqe
Date:   Sat, 12 Oct 2019 21:04:31 +0300
Message-Id: <fa82104ea8d7ff54dc66bfbfedb6cca541701991.1570821661.git.wambui.karugax@gmail.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <cover.1570821661.git.wambui.karugax@gmail.com>
References: <cover.1570821661.git.wambui.karugax@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove typedef declaration from struct cvmx_wqe.
Also replace its previous uses with new struct declaration.
Issue found by checkpatch.pl

Signed-off-by: Wambui Karuga <wambui.karugax@gmail.com>
---
 drivers/staging/octeon/ethernet-rx.c  |  6 +++---
 drivers/staging/octeon/ethernet-tx.c  |  2 +-
 drivers/staging/octeon/ethernet.c     |  2 +-
 drivers/staging/octeon/octeon-stubs.h | 22 +++++++++++-----------
 4 files changed, 16 insertions(+), 16 deletions(-)

diff --git a/drivers/staging/octeon/ethernet-rx.c b/drivers/staging/octeon/ethernet-rx.c
index 0e65955c746b..2c16230f993c 100644
--- a/drivers/staging/octeon/ethernet-rx.c
+++ b/drivers/staging/octeon/ethernet-rx.c
@@ -60,7 +60,7 @@ static irqreturn_t cvm_oct_do_interrupt(int irq, void *napi_id)
  *
  * Returns Non-zero if the packet can be dropped, zero otherwise.
  */
-static inline int cvm_oct_check_rcv_error(cvmx_wqe_t *work)
+static inline int cvm_oct_check_rcv_error(struct cvmx_wqe *work)
 {
 	int port;
 
@@ -135,7 +135,7 @@ static inline int cvm_oct_check_rcv_error(cvmx_wqe_t *work)
 	return 0;
 }
 
-static void copy_segments_to_skb(cvmx_wqe_t *work, struct sk_buff *skb)
+static void copy_segments_to_skb(struct cvmx_wqe *work, struct sk_buff *skb)
 {
 	int segments = work->word2.s.bufs;
 	union cvmx_buf_ptr segment_ptr = work->packet_ptr;
@@ -215,7 +215,7 @@ static int cvm_oct_poll(struct oct_rx_group *rx_group, int budget)
 		struct sk_buff *skb = NULL;
 		struct sk_buff **pskb = NULL;
 		int skb_in_hw;
-		cvmx_wqe_t *work;
+		struct cvmx_wqe *work;
 		int port;
 
 		if (USE_ASYNC_IOBDMA && did_work_request)
diff --git a/drivers/staging/octeon/ethernet-tx.c b/drivers/staging/octeon/ethernet-tx.c
index c64728fc21f2..a039882e4f70 100644
--- a/drivers/staging/octeon/ethernet-tx.c
+++ b/drivers/staging/octeon/ethernet-tx.c
@@ -515,7 +515,7 @@ int cvm_oct_xmit_pow(struct sk_buff *skb, struct net_device *dev)
 	void *copy_location;
 
 	/* Get a work queue entry */
-	cvmx_wqe_t *work = cvmx_fpa_alloc(CVMX_FPA_WQE_POOL);
+	struct cvmx_wqe *work = cvmx_fpa_alloc(CVMX_FPA_WQE_POOL);
 
 	if (unlikely(!work)) {
 		printk_ratelimited("%s: Failed to allocate a work queue entry\n",
diff --git a/drivers/staging/octeon/ethernet.c b/drivers/staging/octeon/ethernet.c
index cf8e9a23ebf9..f892f1ad4638 100644
--- a/drivers/staging/octeon/ethernet.c
+++ b/drivers/staging/octeon/ethernet.c
@@ -172,7 +172,7 @@ static void cvm_oct_configure_common_hw(void)
  */
 int cvm_oct_free_work(void *work_queue_entry)
 {
-	cvmx_wqe_t *work = work_queue_entry;
+	struct cvmx_wqe *work = work_queue_entry;
 
 	int segments = work->word2.s.bufs;
 	union cvmx_buf_ptr segment_ptr = work->packet_ptr;
diff --git a/drivers/staging/octeon/octeon-stubs.h b/drivers/staging/octeon/octeon-stubs.h
index b2e3c72205dd..7c29cfbd55d1 100644
--- a/drivers/staging/octeon/octeon-stubs.h
+++ b/drivers/staging/octeon/octeon-stubs.h
@@ -183,13 +183,13 @@ union cvmx_buf_ptr {
 	} s;
 };
 
-typedef struct {
+struct cvmx_wqe {
 	union cvmx_wqe_word0 word0;
 	union cvmx_wqe_word1 word1;
 	union cvmx_pip_wqe_word2 word2;
 	union cvmx_buf_ptr packet_ptr;
 	uint8_t packet_data[96];
-} cvmx_wqe_t;
+};
 
 typedef union {
 	uint64_t u64;
@@ -1198,7 +1198,7 @@ static inline uint64_t cvmx_scratch_read64(uint64_t address)
 static inline void cvmx_scratch_write64(uint64_t address, uint64_t value)
 { }
 
-static inline int cvmx_wqe_get_grp(cvmx_wqe_t *work)
+static inline int cvmx_wqe_get_grp(struct cvmx_wqe *work)
 {
 	return 0;
 }
@@ -1345,14 +1345,14 @@ static inline void cvmx_pow_work_request_async(int scr_addr,
 						       cvmx_pow_wait_t wait)
 { }
 
-static inline cvmx_wqe_t *cvmx_pow_work_response_async(int scr_addr)
+static inline struct cvmx_wqe *cvmx_pow_work_response_async(int scr_addr)
 {
-	cvmx_wqe_t *wqe = (void *)(unsigned long)scr_addr;
+	struct cvmx_wqe *wqe = (void *)(unsigned long)scr_addr;
 
 	return wqe;
 }
 
-static inline cvmx_wqe_t *cvmx_pow_work_request_sync(cvmx_pow_wait_t wait)
+static inline struct cvmx_wqe *cvmx_pow_work_request_sync(cvmx_pow_wait_t wait)
 {
 	return (void *)(unsigned long)wait;
 }
@@ -1390,21 +1390,21 @@ static inline cvmx_pko_status_t cvmx_pko_send_packet_finish(uint64_t port,
 	return ret;
 }
 
-static inline void cvmx_wqe_set_port(cvmx_wqe_t *work, int port)
+static inline void cvmx_wqe_set_port(struct cvmx_wqe *work, int port)
 { }
 
-static inline void cvmx_wqe_set_qos(cvmx_wqe_t *work, int qos)
+static inline void cvmx_wqe_set_qos(struct cvmx_wqe *work, int qos)
 { }
 
-static inline int cvmx_wqe_get_qos(cvmx_wqe_t *work)
+static inline int cvmx_wqe_get_qos(struct cvmx_wqe *work)
 {
 	return 0;
 }
 
-static inline void cvmx_wqe_set_grp(cvmx_wqe_t *work, int grp)
+static inline void cvmx_wqe_set_grp(struct cvmx_wqe *work, int grp)
 { }
 
-static inline void cvmx_pow_work_submit(cvmx_wqe_t *wqp, uint32_t tag,
+static inline void cvmx_pow_work_submit(struct cvmx_wqe *wqp, uint32_t tag,
 					enum cvmx_pow_tag_type tag_type,
 					uint64_t qos, uint64_t grp)
 { }
-- 
2.23.0

