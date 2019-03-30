Return-Path: <SRS0=yJb2=SB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 173E5C43381
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Mar 2019 18:30:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C0E3D218A3
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Mar 2019 18:30:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="laoramfF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730679AbfC3Sas (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 30 Mar 2019 14:30:48 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:45113 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730203AbfC3SaN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Mar 2019 14:30:13 -0400
Received: by mail-lj1-f195.google.com with SMTP id y6so4631819ljd.12
        for <linux-kernel@vger.kernel.org>; Sat, 30 Mar 2019 11:30:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=/pwKwCm+7utZxtQXMR3Cp+3IS+yckwC84sr1oLtIOyQ=;
        b=laoramfFua8gDaOk+rN2anCM4nuGYNJFhd8b75HbcpYB0gwH5b/JVowmemoGJ+cmZp
         TrfGtYFtMaenykoWdkBqxtk8erd6+q8mrVD4Oi/rD8+YS3gmkQ0E2NOqhlo459dS+90H
         McAzXoa79l1Dvca2M+acmlDz1/zYEf+WZ8Hv1PbabCFMMRwpeNJBUoLv8EPy+JSeansZ
         toCVmohMFQxi7LiwCupX/gTT1QsWJrIHRfkaAJWE7ImJzDd3QUZbKaKtADrbbVSyng6M
         E+kBrn+wt3zZXEnGZnOIk/MUlsQ7XB3V3MDOBbtGAcvtCoV/qCFCQqjfJ5Ko7RAnJfY9
         Bigw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=/pwKwCm+7utZxtQXMR3Cp+3IS+yckwC84sr1oLtIOyQ=;
        b=bm/khNThw5adJrEQJ48zOuwbwTB+9nnTRTU2OA9NuDVV39B31ibq3NMJLC8lDLC+Kd
         V6QlHZpZyYO3scyyCd3xsT4LkLyljM/MqGT5kdnqN+Tw8n0aRStfM2jjCDceI0YE3Rj5
         gRwqm9VFh1gju6J9KLnzGua3LGlFdx/pPx2ABc3juuIZZccnte4eqVIv5zoY1hzwdvtm
         rzahEAkfamscLTh6YsnX8cQcwvxZKCXm5OYy8j8ubAaGWas3pUHtORrHKBj6KEqFM98n
         GW66UfRJxaz7pO1XfYRQtdIxAR21Gs9pRLD1a95X+mY4ylh1MlwUPfIn/YecR1WPWrMD
         BhTg==
X-Gm-Message-State: APjAAAX3f9lcnaqxRreSaDL3JaZXkpu0kApF3hXFRD28vbRyb+QhmZU1
        uad5n7fEwsLPLmcUnZQJwqAokRAn
X-Google-Smtp-Source: APXvYqznrqbYCoraTov3+fIrbzNRixnz8V8Lo1nidb1yKNtXNfN2tlEa8lVENrZWwf7ubq/u5RFdXA==
X-Received: by 2002:a2e:7e0f:: with SMTP id z15mr9738975ljc.122.1553970609535;
        Sat, 30 Mar 2019 11:30:09 -0700 (PDT)
Received: from localhost.localdomain (v902-731.aalto.fi. [130.233.10.238])
        by smtp.gmail.com with ESMTPSA id o7sm1060058ljj.23.2019.03.30.11.30.08
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 30 Mar 2019 11:30:08 -0700 (PDT)
From:   Ferdinand Blomqvist <ferdinand.blomqvist@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Thomas Gleixner <tglx@linutronix.de>
Subject: [RFC PATCH 1/7] rslib: Add tests for the encoder and decoder
Date:   Sat, 30 Mar 2019 20:29:41 +0200
Message-Id: <20190330182947.8823-2-ferdinand.blomqvist@gmail.com>
X-Mailer: git-send-email 2.17.2
In-Reply-To: <20190330182947.8823-1-ferdinand.blomqvist@gmail.com>
References: <20190330182947.8823-1-ferdinand.blomqvist@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A Reed-Solomon code with minimum distance d can correct any error and
erasure pattern that satisfies 2 * #error + #erasures < d. If the
error correction capacity is exceeded, then correct decoding cannot be
guaranteed. The decoder must, however, return a valid codeword or report
failure.

There are two main tests:

- Check for correct behaviour up to the error correction capacity
- Check for correct behaviour beyond error corrupted capacity

Both tests are simple:

1. Generate random data
2. Encode data with the chosen code
3. Add errors and erasures to data
4. Decode the corrupted word
5. Check for correct behaviour

When testing up to capacity we test for:

- Correct decoding
- Correct return value (i.e. the number of corrected symbols)
- That the returned error positions are correct

There are two kinds of erasures; the erased symbol can be corrupted or
not. When counting the number of corrected symbols, erasures without
symbol corruption should not be counted. Similarly, the returned error
positions should only include positions where a correction is necessary.

We run the up to capacity tests for three different interfaces of
decode_rs:

- Use the correction buffers
- Use the correction buffers with syndromes provided by the caller
- Error correction in place (does not check the error positions)

When testing beyond capacity we test for silent failures. A silent
failure is when the decoder returns success but the returned word is not
a valid codeword.

There are a couple of options for the tests:

- Verbosity.

- Whether to test for correct behaviour beyond capacity. Default is to
  test beyond capacity.

- Whether to allow erasures without symbol corruption. Defaults to yes.

Note that the tests take a couple of minutes to complete.

Signed-off-by: Ferdinand Blomqvist <ferdinand.blomqvist@gmail.com>
---
 lib/Kconfig.debug             |  12 +
 lib/reed_solomon/Makefile     |   2 +-
 lib/reed_solomon/test_rslib.c | 519 ++++++++++++++++++++++++++++++++++
 3 files changed, 532 insertions(+), 1 deletion(-)
 create mode 100644 lib/reed_solomon/test_rslib.c

diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index 0d9e81779e37..48f43583b3b6 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -1726,6 +1726,18 @@ config RBTREE_TEST
 	  A benchmark measuring the performance of the rbtree library.
 	  Also includes rbtree invariant checks.
 
+config REED_SOLOMON_TEST
+	tristate "Reed-Solomon library test"
+	depends on DEBUG_KERNEL || m
+	select REED_SOLOMON
+	select REED_SOLOMON_ENC16
+	select REED_SOLOMON_DEC16
+	help
+	  This option enables the self-test function of rslib at boot,
+	  or at module load time.
+
+	  If unsure, say N.
+
 config INTERVAL_TREE_TEST
 	tristate "Interval tree test"
 	depends on DEBUG_KERNEL
diff --git a/lib/reed_solomon/Makefile b/lib/reed_solomon/Makefile
index c3d7136827ed..e84ce076c6e5 100644
--- a/lib/reed_solomon/Makefile
+++ b/lib/reed_solomon/Makefile
@@ -3,4 +3,4 @@
 #
 
 obj-$(CONFIG_REED_SOLOMON) += reed_solomon.o
-
+obj-$(CONFIG_REED_SOLOMON_TEST) += test_rslib.o
diff --git a/lib/reed_solomon/test_rslib.c b/lib/reed_solomon/test_rslib.c
new file mode 100644
index 000000000000..c97b1dbadd4e
--- /dev/null
+++ b/lib/reed_solomon/test_rslib.c
@@ -0,0 +1,519 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Tests for Generic Reed Solomon encoder / decoder library
+ *
+ * Written by Ferdinand Blomqvist
+ * Based on previous work by Phil Karn, KA9Q
+ */
+#include <linux/rslib.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/moduleparam.h>
+#include <linux/random.h>
+#include <linux/slab.h>
+
+enum verbosity {
+	V_SILENT,
+	V_PROGRESS,
+	V_CSUMMARY
+};
+
+enum method {
+	CORR_BUFFER,
+	CALLER_SYNDROME,
+	IN_PLACE
+};
+
+#define __param(type, name, init, msg)		\
+	static type name = init;		\
+	module_param(name, type, 0444);		\
+	MODULE_PARM_DESC(name, msg)
+
+__param(int, v, V_PROGRESS, "Verbosity level");
+__param(int, ewsc, 1, "Erasures without symbol corruption");
+__param(int, bc, 1, "Test for correct behaviour beyond error correction capacity");
+
+struct etab {
+	int symsize;
+	int genpoly;
+	int fcs;
+	int prim;
+	int nroots;
+	int ntrials;
+};
+
+/* List of codes to test */
+static struct etab Tab[] = {
+	{2,	0x7,	1,	1,	1,	100000	},
+	{3,	0xb,	1,	1,	2,	100000	},
+	{3,	0xb,	1,	1,	3,	100000	},
+	{3,	0xb,	2,	1,	4,	100000	},
+	{4,	0x13,	1,	1,	4,	10000	},
+	{5,	0x25,	1,	1,	6,	1000	},
+	{6,	0x43,	3,	1,	8,	100	},
+	{7,	0x89,	1,	1,	10,	100	},
+	{8,	0x11d,	1,	1,	32,	100	},
+	{8,	0x187,	112,	11,	32,	100	},
+	/*
+	 * {9,	0x211,	1,	1,	32,	100	},
+	 * {10,	0x409,	1,	1,	32,	100	},
+	 * {11,	0x805,	1,	1,	32,	100	},
+	 * {12,	0x1053	1,	1,	32,	50	},
+	 * {12,	0x1053	1,	1,	64,	50	},
+	 * {13,	0x201b	1,	1,	32,	20	},
+	 * {13,	0x201b	1,	1,	64,	20	},
+	 * {14,	0x4443	1,	1,	32,	10	},
+	 * {14,	0x4443	1,	1,	64,	10	},
+	 * {15,	0x8003	1,	1,	32,	5	},
+	 * {15,	0x8003	1,	1,	64,	5	},
+	 * {16,	0x1100	1,	1,	32,	5	},
+	 */
+	{0, 0, 0, 0, 0, 0},
+};
+
+
+struct estat {
+	int dwrong;
+	int irv;
+	int wepos;
+	int nwords;
+};
+
+struct bcstat {
+	int rfail;
+	int rsuccess;
+	int noncw;
+	int nwords;
+};
+
+struct wspace {
+	uint16_t *c;		/* sent codeword */
+	uint16_t *r;		/* received word */
+	uint16_t *s;		/* syndrome */
+	uint16_t *corr;		/* correction buffer */
+	int *errlocs;
+	int *derrlocs;
+};
+
+static double Pad[] = {0, 0.25, 0.5, 0.75, 1.0};
+
+static struct wspace *alloc_ws(struct rs_codec *rs)
+{
+	int nn = rs->nn;
+	int nroots = rs->nroots;
+	struct wspace *ws;
+
+	ws = kzalloc(sizeof(*ws), GFP_KERNEL);
+	if (!ws)
+		return NULL;
+
+	ws->c = kmalloc_array(2 * (nn + nroots),
+				sizeof(uint16_t), GFP_KERNEL);
+	if (!ws->c)
+		goto err;
+
+	ws->r = ws->c + nn;
+	ws->s = ws->r + nn;
+	ws->corr = ws->s + nroots;
+
+	ws->errlocs = kmalloc_array(nn + nroots, sizeof(int), GFP_KERNEL);
+	if (!ws->c)
+		goto err;
+
+	ws->derrlocs = ws->errlocs + nn;
+	return ws;
+
+err:
+	kfree(ws->errlocs);
+	kfree(ws->c);
+	kfree(ws);
+	return NULL;
+}
+
+static void free_ws(struct wspace *ws)
+{
+	if (!ws)
+		return;
+
+	kfree(ws->errlocs);
+	kfree(ws->c);
+	kfree(ws);
+}
+
+/*
+ * Generates a random codeword and stores it in c. Generates random errors and
+ * erasures, and stores the random word with errors in r. Erasure positions are
+ * stored in derrlocs, while errlocs has one of three values in every position:
+ *
+ * 0 if there is no error in this position;
+ * 1 if there is a symbol error in this position;
+ * 2 if there is an erasure without symbol corruption.
+ *
+ * Returns the number of corrupted symbols.
+ */
+static int get_rcw_we(struct rs_control *rs, struct wspace *ws,
+			int len, int errs, int eras)
+{
+	int nn = rs->codec->nn;
+	int nroots = rs->codec->nroots;
+	uint16_t *c = ws->c;
+	uint16_t *r = ws->r;
+	int *errlocs = ws->errlocs;
+	int *derrlocs = ws->derrlocs;
+	int dlen = len - nroots;
+	int i;
+	int errval;
+	int errloc;
+
+	/* Load c with random data and encode */
+	for (i = 0; i < dlen; i++)
+		c[i] = prandom_u32() & nn;
+
+	memset(c + dlen, 0, nroots * sizeof(*c));
+	encode_rs16(rs, c, dlen, c + dlen, 0);
+
+	/* Make copyand add errors and erasures */
+	memcpy(r, c, len * sizeof(*r));
+	memset(errlocs, 0, len * sizeof(*errlocs));
+	memset(derrlocs, 0, nroots * sizeof(*derrlocs));
+
+	/* Generating random errors */
+	for (i = 0; i < errs; i++) {
+		do {
+			/* Error value must be nonzero */
+			errval = prandom_u32() & nn;
+		} while (errval == 0);
+
+		do {
+			/* Must not choose the same location twice */
+			errloc = prandom_u32() % len;
+		} while (errlocs[errloc] != 0);
+
+		errlocs[errloc] = 1;
+		r[errloc] ^= errval;
+	}
+
+	/* Generating random erasures */
+	for (i = 0; i < eras; i++) {
+		do {
+			/* Must not choose the same location twice */
+			errloc = prandom_u32() % len;
+		} while (errlocs[errloc] != 0);
+
+		derrlocs[i] = errloc;
+
+		if (ewsc && (prandom_u32() & 1)) {
+			/* Erasure with the symbol intact */
+			errlocs[errloc] = 2;
+		} else {
+			/* Erasure with corrupted symbol */
+			do {
+				/* Error value must be nonzero */
+				errval = prandom_u32() & nn;
+			} while (errval == 0);
+
+			errlocs[errloc] = 1;
+			r[errloc] ^= errval;
+			errs++;
+		}
+	}
+
+	return errs;
+}
+
+static void fix_err(uint16_t *data, int nerrs, uint16_t *corr, int *errlocs)
+{
+	int i;
+
+	for (i = 0; i < nerrs; i++)
+		data[errlocs[i]] ^= corr[i];
+}
+
+static void compute_syndrome(struct rs_control *rsc, uint16_t *data,
+				int len, uint16_t *syn)
+{
+	struct rs_codec *rs = rsc->codec;
+	int nroots = rs->nroots;
+	int fcr = rs->fcr;
+	int prim = rs->prim;
+	uint16_t *alpha_to = rs->alpha_to;
+	uint16_t *index_of = rs->index_of;
+	int i, j;
+
+	/* Calculating syndrome */
+	for (i = 0; i < nroots; i++) {
+		syn[i] = data[0];
+		for (j = 1; j < len; j++) {
+			if (syn[i] == 0) {
+				syn[i] = data[j];
+			} else {
+				syn[i] = data[j] ^
+					alpha_to[rs_modnn(rs, index_of[syn[i]]
+						+ (fcr + i) * prim)];
+			}
+		}
+	}
+
+	/* Convert to index form */
+	for (i = 0; i < nroots; i++)
+		syn[i] = rs->index_of[syn[i]];
+}
+
+/* Test up to error correction capacity */
+static void test_uc(struct rs_control *rs, int len, int errs,
+		int eras, int trials, struct estat *stat,
+		struct wspace *ws, int method)
+{
+	uint16_t *c = ws->c;
+	uint16_t *r = ws->r;
+	uint16_t *s = ws->s;
+	uint16_t *corr = ws->corr;
+	int *errlocs = ws->errlocs;
+	int *derrlocs = ws->derrlocs;
+	int nroots = rs->codec->nroots;
+	int dlen = len - nroots;
+	int derrs, nerrs, i, j;
+
+	for (j = 0; j < trials; j++) {
+		nerrs = get_rcw_we(rs, ws, len, errs, eras);
+
+		switch (method) {
+		case CORR_BUFFER:
+			derrs = decode_rs16(rs, r, r + dlen, dlen,
+					NULL, eras, derrlocs, 0, corr);
+			fix_err(r, derrs, corr, derrlocs);
+			break;
+		case CALLER_SYNDROME:
+			compute_syndrome(rs, r, len, s);
+			derrs = decode_rs16(rs, NULL, NULL, dlen,
+					s, eras, derrlocs, 0, corr);
+			fix_err(r, derrs, corr, derrlocs);
+			break;
+		case IN_PLACE:
+			derrs = decode_rs16(rs, r, r + dlen, dlen,
+					NULL, eras, derrlocs, 0, NULL);
+			break;
+		}
+
+		if (derrs != nerrs)
+			stat->irv++;
+
+		if (method != IN_PLACE) {
+			for (i = 0; i < derrs; i++) {
+				if (errlocs[derrlocs[i]] != 1)
+					stat->wepos++;
+			}
+		}
+
+		if (memcmp(r, c, len * sizeof(*r)))
+			stat->dwrong++;
+	}
+	stat->nwords += trials;
+}
+
+int ex_rs_helper(struct rs_control *rs, struct wspace *ws,
+		int len, int trials, int method)
+{
+	static const char * const desc[] = {
+		"Testing correction buffer interface...",
+		"Testing with caller provided syndrome...",
+		"Testing in-place interface..."
+	};
+
+	struct estat stat = {0, 0, 0, 0};
+	int nroots = rs->codec->nroots;
+	int errs, eras, retval;
+
+	if (v >= V_PROGRESS)
+		pr_info("  %s\n", desc[method]);
+
+	for (errs = 0; errs <= nroots / 2; errs++)
+		for (eras = 0; eras <= nroots - 2 * errs; eras++)
+			test_uc(rs, len, errs, eras, trials, &stat, ws, method);
+
+	if (v >= V_CSUMMARY) {
+		pr_info("    Decodes wrong:        %d / %d\n",
+				stat.dwrong, stat.nwords);
+		pr_info("    Wrong return value:   %d / %d\n",
+				stat.irv, stat.nwords);
+		if (method != IN_PLACE)
+			pr_info("    Wrong error position: %d\n", stat.wepos);
+	}
+
+	retval = stat.dwrong + stat.wepos + stat.irv;
+	if (retval && v >= V_PROGRESS)
+		pr_warn("    FAIL: %d decoding failures!\n", retval);
+
+	return retval;
+}
+
+int exercise_rs(struct rs_control *rs, struct wspace *ws,
+		int len, int trials)
+{
+
+	int retval = 0;
+	int i;
+
+	if (v >= V_PROGRESS)
+		pr_info("Testing up to error correction capacity...\n");
+
+	for (i = 0; i <= IN_PLACE; i++)
+		retval |= ex_rs_helper(rs, ws, len, trials, i);
+
+	return retval;
+}
+
+/* Tests for correct behaviour beyond error correction capacity */
+static void test_bc(struct rs_control *rs, int len, int errs,
+		int eras, int trials, struct bcstat *stat,
+		struct wspace *ws)
+{
+	uint16_t *r = ws->r;
+	uint16_t *corr = ws->corr;
+	int *derrlocs = ws->derrlocs;
+	int nroots = rs->codec->nroots;
+	int dlen = len - nroots;
+	int derrs, j;
+
+	for (j = 0; j < trials; j++) {
+		get_rcw_we(rs, ws, len, errs, eras);
+		derrs = decode_rs16(rs, r, r + dlen, dlen,
+				NULL, eras, derrlocs, 0, corr);
+		fix_err(r, derrs, corr, derrlocs);
+
+		if (derrs >= 0) {
+			stat->rsuccess++;
+
+			/*
+			 * We check that the returned word is actually a
+			 * codeword. The obious way to do this would be to
+			 * compute the syndrome, but we don't want to replicate
+			 * that code here. However, all the codes are in
+			 * systematic form, and therefore we can encode the
+			 * returned word, and see whether the parity changes or
+			 * not.
+			 */
+			memset(corr, 0, nroots * sizeof(*corr));
+			encode_rs16(rs, r, dlen, corr, 0);
+
+			if (memcmp(r + dlen, corr, nroots * sizeof(*corr)))
+				stat->noncw++;
+		} else {
+			stat->rfail++;
+		}
+	}
+	stat->nwords += trials;
+}
+
+int exercise_rs_bc(struct rs_control *rs, struct wspace *ws,
+		int len, int trials)
+{
+	struct bcstat stat = {0, 0, 0, 0};
+	int nroots = rs->codec->nroots;
+	int errs, eras, cutoff;
+
+	if (v >= V_PROGRESS)
+		pr_info("Testing beyond error correction capacity...\n");
+
+	for (errs = 1; errs <= nroots; errs++) {
+		eras = nroots - 2 * errs + 1;
+		if (eras < 0)
+			eras = 0;
+
+		cutoff = nroots <= len - errs ? nroots : len - errs;
+		for (; eras <= cutoff; eras++)
+			test_bc(rs, len, errs, eras, trials, &stat, ws);
+	}
+
+	if (v >= V_CSUMMARY) {
+		pr_info("  decoder gives up:        %d / %d\n",
+				stat.rfail, stat.nwords);
+		pr_info("  decoder returns success: %d / %d\n",
+				stat.rsuccess, stat.nwords);
+		pr_info("    not a codeword:        %d / %d\n",
+				stat.noncw, stat.rsuccess);
+	}
+
+	if (stat.noncw && v >= V_PROGRESS)
+		pr_warn("    FAIL: %d silent failures!\n", stat.noncw);
+
+	return stat.noncw;
+}
+
+static int run_exercise(struct etab *e)
+{
+	struct rs_control *rsc;
+	struct wspace *ws;
+	int nn = (1 << e->symsize) - 1;
+	int kk = nn - e->nroots;
+	int max_pad = kk - 1;
+	int prev_pad = -1;
+	int i;
+	int retval = -ENOMEM;
+
+	rsc = init_rs(e->symsize, e->genpoly, e->fcs, e->prim, e->nroots);
+	if (!rsc)
+		return retval;
+
+	ws = alloc_ws(rsc->codec);
+	if (!ws)
+		goto err;
+
+	retval = 0;
+	for (i = 0; i < ARRAY_SIZE(Pad); i++) {
+		int pad = Pad[i] * max_pad;
+		int len = nn - pad;
+
+		if (pad == prev_pad)
+			continue;
+
+		prev_pad = pad;
+		if (v >= V_PROGRESS) {
+			pr_info("Testing (%d,%d)_%d code...\n",
+					len, kk - pad, nn + 1);
+		}
+
+		retval |= exercise_rs(rsc, ws, len, e->ntrials);
+		if (bc)
+			retval |= exercise_rs_bc(rsc, ws, len, e->ntrials);
+	}
+
+	free_ws(ws);
+
+err:
+	free_rs(rsc);
+	return retval;
+}
+
+static int __init test_rslib_init(void)
+{
+	int fail, i;
+
+	for (i = 0; Tab[i].symsize != 0 ; i++) {
+		int retval;
+
+		retval = run_exercise(Tab + i);
+		if (retval < 0)
+			return -ENOMEM;
+
+		fail |= retval;
+	}
+
+	if (fail)
+		pr_warn("rslib: test failed\n");
+	else
+		pr_info("rslib: test ok\n");
+
+	return -EAGAIN; /* Fail will directly unload the module */
+}
+
+static void __exit test_rslib_exit(void)
+{
+}
+
+module_init(test_rslib_init)
+module_exit(test_rslib_exit)
+
+MODULE_LICENSE("GPL");
+MODULE_AUTHOR("Ferdinand Blomqvist");
+MODULE_DESCRIPTION("Reed-Solomon library test");
-- 
2.17.2

