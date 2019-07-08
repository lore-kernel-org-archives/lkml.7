Return-Path: <SRS0=4ODY=VF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4EE7C606A7
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 09:22:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7DEB22086C
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 09:22:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729803AbfGHJWk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jul 2019 05:22:40 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:38828 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729152AbfGHJWk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jul 2019 05:22:40 -0400
Received: from localhost ([127.0.0.1] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtp (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1hkPr0-0004on-Vp; Mon, 08 Jul 2019 11:22:35 +0200
Date:   Mon, 08 Jul 2019 09:05:37 -0000
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org
Subject: [GIT pull] core/rslib for 5.3-rc1
References: <156257673794.14831.1593297636367057887.tglx@nanos.tec.linutronix.de>
Message-ID: <156257673794.14831.15719816342504721108.tglx@nanos.tec.linutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

please pull the latest core-rslib-for-linus git tree from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git core-rslib-for-linus

up to:  ede7c247abfa: rslib: Make some functions static

A cleanup and fixes series from Ferdinand Blomqvist who analyzed the
original Reed-Solomon library from Phil Karn on which the kernel
implementation is based on. This comes with a test module which verifies
all the various corner cases for correctness.

Thanks,

	tglx

------------------>
Ferdinand Blomqvist (7):
      rslib: Add tests for the encoder and decoder
      rslib: Fix decoding of shortened codes
      rslib: decode_rs: Fix length parameter check
      rslib: decode_rs: Code cleanup
      rslib: Fix handling of of caller provided syndrome
      rslib: Update documentation
      rslib: Fix remaining decoder flaws

YueHaibing (1):
      rslib: Make some functions static


 lib/Kconfig.debug               |  12 +
 lib/reed_solomon/Makefile       |   2 +-
 lib/reed_solomon/decode_rs.c    | 115 ++++++---
 lib/reed_solomon/reed_solomon.c |  12 +-
 lib/reed_solomon/test_rslib.c   | 518 ++++++++++++++++++++++++++++++++++++++++
 5 files changed, 624 insertions(+), 35 deletions(-)
 create mode 100644 lib/reed_solomon/test_rslib.c

diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index cbdfae379896..b0d71d9293dc 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -1754,6 +1754,18 @@ config RBTREE_TEST
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
index ba9d7a3329eb..5d4fa68f26cb 100644
--- a/lib/reed_solomon/Makefile
+++ b/lib/reed_solomon/Makefile
@@ -4,4 +4,4 @@
 #
 
 obj-$(CONFIG_REED_SOLOMON) += reed_solomon.o
-
+obj-$(CONFIG_REED_SOLOMON_TEST) += test_rslib.o
diff --git a/lib/reed_solomon/decode_rs.c b/lib/reed_solomon/decode_rs.c
index 1db74eb098d0..805de84ae83d 100644
--- a/lib/reed_solomon/decode_rs.c
+++ b/lib/reed_solomon/decode_rs.c
@@ -22,6 +22,7 @@
 	uint16_t *index_of = rs->index_of;
 	uint16_t u, q, tmp, num1, num2, den, discr_r, syn_error;
 	int count = 0;
+	int num_corrected;
 	uint16_t msk = (uint16_t) rs->nn;
 
 	/*
@@ -39,11 +40,21 @@
 
 	/* Check length parameter for validity */
 	pad = nn - nroots - len;
-	BUG_ON(pad < 0 || pad >= nn);
+	BUG_ON(pad < 0 || pad >= nn - nroots);
 
 	/* Does the caller provide the syndrome ? */
-	if (s != NULL)
-		goto decode;
+	if (s != NULL) {
+		for (i = 0; i < nroots; i++) {
+			/* The syndrome is in index form,
+			 * so nn represents zero
+			 */
+			if (s[i] != nn)
+				goto decode;
+		}
+
+		/* syndrome is zero, no errors to correct  */
+		return 0;
+	}
 
 	/* form the syndromes; i.e., evaluate data(x) at roots of
 	 * g(x) */
@@ -88,8 +99,7 @@
 		/* if syndrome is zero, data[] is a codeword and there are no
 		 * errors to correct. So return data[] unmodified
 		 */
-		count = 0;
-		goto finish;
+		return 0;
 	}
 
  decode:
@@ -99,9 +109,9 @@
 	if (no_eras > 0) {
 		/* Init lambda to be the erasure locator polynomial */
 		lambda[1] = alpha_to[rs_modnn(rs,
-					      prim * (nn - 1 - eras_pos[0]))];
+					prim * (nn - 1 - (eras_pos[0] + pad)))];
 		for (i = 1; i < no_eras; i++) {
-			u = rs_modnn(rs, prim * (nn - 1 - eras_pos[i]));
+			u = rs_modnn(rs, prim * (nn - 1 - (eras_pos[i] + pad)));
 			for (j = i + 1; j > 0; j--) {
 				tmp = index_of[lambda[j - 1]];
 				if (tmp != nn) {
@@ -175,6 +185,15 @@
 		if (lambda[i] != nn)
 			deg_lambda = i;
 	}
+
+	if (deg_lambda == 0) {
+		/*
+		 * deg(lambda) is zero even though the syndrome is non-zero
+		 * => uncorrectable error detected
+		 */
+		return -EBADMSG;
+	}
+
 	/* Find roots of error+erasure locator polynomial by Chien search */
 	memcpy(&reg[1], &lambda[1], nroots * sizeof(reg[0]));
 	count = 0;		/* Number of roots of lambda(x) */
@@ -188,6 +207,12 @@
 		}
 		if (q != 0)
 			continue;	/* Not a root */
+
+		if (k < pad) {
+			/* Impossible error location. Uncorrectable error. */
+			return -EBADMSG;
+		}
+
 		/* store root (index-form) and error location number */
 		root[count] = i;
 		loc[count] = k;
@@ -202,8 +227,7 @@
 		 * deg(lambda) unequal to number of roots => uncorrectable
 		 * error detected
 		 */
-		count = -EBADMSG;
-		goto finish;
+		return -EBADMSG;
 	}
 	/*
 	 * Compute err+eras evaluator poly omega(x) = s(x)*lambda(x) (modulo
@@ -223,7 +247,9 @@
 	/*
 	 * Compute error values in poly-form. num1 = omega(inv(X(l))), num2 =
 	 * inv(X(l))**(fcr-1) and den = lambda_pr(inv(X(l))) all in poly-form
+	 * Note: we reuse the buffer for b to store the correction pattern
 	 */
+	num_corrected = 0;
 	for (j = count - 1; j >= 0; j--) {
 		num1 = 0;
 		for (i = deg_omega; i >= 0; i--) {
@@ -231,6 +257,13 @@
 				num1 ^= alpha_to[rs_modnn(rs, omega[i] +
 							i * root[j])];
 		}
+
+		if (num1 == 0) {
+			/* Nothing to correct at this position */
+			b[j] = 0;
+			continue;
+		}
+
 		num2 = alpha_to[rs_modnn(rs, root[j] * (fcr - 1) + nn)];
 		den = 0;
 
@@ -242,30 +275,52 @@
 						       i * root[j])];
 			}
 		}
-		/* Apply error to data */
-		if (num1 != 0 && loc[j] >= pad) {
-			uint16_t cor = alpha_to[rs_modnn(rs,index_of[num1] +
-						       index_of[num2] +
-						       nn - index_of[den])];
-			/* Store the error correction pattern, if a
-			 * correction buffer is available */
-			if (corr) {
-				corr[j] = cor;
-			} else {
-				/* If a data buffer is given and the
-				 * error is inside the message,
-				 * correct it */
-				if (data && (loc[j] < (nn - nroots)))
-					data[loc[j] - pad] ^= cor;
-			}
+
+		b[j] = alpha_to[rs_modnn(rs, index_of[num1] +
+					       index_of[num2] +
+					       nn - index_of[den])];
+		num_corrected++;
+	}
+
+	/*
+	 * We compute the syndrome of the 'error' and check that it matches
+	 * the syndrome of the received word
+	 */
+	for (i = 0; i < nroots; i++) {
+		tmp = 0;
+		for (j = 0; j < count; j++) {
+			if (b[j] == 0)
+				continue;
+
+			k = (fcr + i) * prim * (nn-loc[j]-1);
+			tmp ^= alpha_to[rs_modnn(rs, index_of[b[j]] + k)];
 		}
+
+		if (tmp != alpha_to[s[i]])
+			return -EBADMSG;
 	}
 
-finish:
-	if (eras_pos != NULL) {
-		for (i = 0; i < count; i++)
-			eras_pos[i] = loc[i] - pad;
+	/*
+	 * Store the error correction pattern, if a
+	 * correction buffer is available
+	 */
+	if (corr && eras_pos) {
+		j = 0;
+		for (i = 0; i < count; i++) {
+			if (b[i]) {
+				corr[j] = b[i];
+				eras_pos[j++] = loc[i] - pad;
+			}
+		}
+	} else if (data && par) {
+		/* Apply error to data and parity */
+		for (i = 0; i < count; i++) {
+			if (loc[i] < (nn - nroots))
+				data[loc[i] - pad] ^= b[i];
+			else
+				par[loc[i] - pad - len] ^= b[i];
+		}
 	}
-	return count;
 
+	return  num_corrected;
 }
diff --git a/lib/reed_solomon/reed_solomon.c b/lib/reed_solomon/reed_solomon.c
index e5fdc8b9e856..bbc01bad3053 100644
--- a/lib/reed_solomon/reed_solomon.c
+++ b/lib/reed_solomon/reed_solomon.c
@@ -340,7 +340,8 @@ EXPORT_SYMBOL_GPL(encode_rs8);
  *  @data:	data field of a given type
  *  @par:	received parity data field
  *  @len:	data length
- *  @s:		syndrome data field (if NULL, syndrome is calculated)
+ *  @s: 	syndrome data field, must be in index form
+ *		(if NULL, syndrome is calculated)
  *  @no_eras:	number of erasures
  *  @eras_pos:	position of erasures, can be NULL
  *  @invmsk:	invert data mask (will be xored on data, not on parity!)
@@ -354,7 +355,8 @@ EXPORT_SYMBOL_GPL(encode_rs8);
  *  decoding, so the caller has to ensure that decoder invocations are
  *  serialized.
  *
- *  Returns the number of corrected bits or -EBADMSG for uncorrectable errors.
+ *  Returns the number of corrected symbols or -EBADMSG for uncorrectable
+ *  errors. The count includes errors in the parity.
  */
 int decode_rs8(struct rs_control *rsc, uint8_t *data, uint16_t *par, int len,
 	       uint16_t *s, int no_eras, int *eras_pos, uint16_t invmsk,
@@ -391,7 +393,8 @@ EXPORT_SYMBOL_GPL(encode_rs16);
  *  @data:	data field of a given type
  *  @par:	received parity data field
  *  @len:	data length
- *  @s:		syndrome data field (if NULL, syndrome is calculated)
+ *  @s: 	syndrome data field, must be in index form
+ *		(if NULL, syndrome is calculated)
  *  @no_eras:	number of erasures
  *  @eras_pos:	position of erasures, can be NULL
  *  @invmsk:	invert data mask (will be xored on data, not on parity!)
@@ -403,7 +406,8 @@ EXPORT_SYMBOL_GPL(encode_rs16);
  *  decoding, so the caller has to ensure that decoder invocations are
  *  serialized.
  *
- *  Returns the number of corrected bits or -EBADMSG for uncorrectable errors.
+ *  Returns the number of corrected symbols or -EBADMSG for uncorrectable
+ *  errors. The count includes errors in the parity.
  */
 int decode_rs16(struct rs_control *rsc, uint16_t *data, uint16_t *par, int len,
 		uint16_t *s, int no_eras, int *eras_pos, uint16_t invmsk,
diff --git a/lib/reed_solomon/test_rslib.c b/lib/reed_solomon/test_rslib.c
new file mode 100644
index 000000000000..4eb29f365ece
--- /dev/null
+++ b/lib/reed_solomon/test_rslib.c
@@ -0,0 +1,518 @@
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
+	int	symsize;
+	int	genpoly;
+	int	fcs;
+	int	prim;
+	int	nroots;
+	int	ntrials;
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
+	{6,	0x43,	3,	1,	8,	1000	},
+	{7,	0x89,	1,	1,	14,	500	},
+	{8,	0x11d,	1,	1,	30,	100	},
+	{8,	0x187,	112,	11,	32,	100	},
+	{9,	0x211,	1,	1,	33,	80	},
+	{0, 0, 0, 0, 0, 0},
+};
+
+
+struct estat {
+	int	dwrong;
+	int	irv;
+	int	wepos;
+	int	nwords;
+};
+
+struct bcstat {
+	int	rfail;
+	int	rsuccess;
+	int	noncw;
+	int	nwords;
+};
+
+struct wspace {
+	uint16_t	*c;		/* sent codeword */
+	uint16_t	*r;		/* received word */
+	uint16_t	*s;		/* syndrome */
+	uint16_t	*corr;		/* correction buffer */
+	int		*errlocs;
+	int		*derrlocs;
+};
+
+struct pad {
+	int	mult;
+	int	shift;
+};
+
+static struct pad pad_coef[] = {
+	{ 0, 0 },
+	{ 1, 2 },
+	{ 1, 1 },
+	{ 3, 2 },
+	{ 1, 0 },
+};
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
+static struct wspace *alloc_ws(struct rs_codec *rs)
+{
+	int nroots = rs->nroots;
+	struct wspace *ws;
+	int nn = rs->nn;
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
+	if (!ws->errlocs)
+		goto err;
+
+	ws->derrlocs = ws->errlocs + nn;
+	return ws;
+
+err:
+	free_ws(ws);
+	return NULL;
+}
+
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
+	int nroots = rs->codec->nroots;
+	int *derrlocs = ws->derrlocs;
+	int *errlocs = ws->errlocs;
+	int dlen = len - nroots;
+	int nn = rs->codec->nn;
+	uint16_t *c = ws->c;
+	uint16_t *r = ws->r;
+	int errval;
+	int errloc;
+	int i;
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
+	uint16_t *alpha_to = rs->alpha_to;
+	uint16_t *index_of = rs->index_of;
+	int nroots = rs->nroots;
+	int prim = rs->prim;
+	int fcr = rs->fcr;
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
+	int dlen = len - rs->codec->nroots;
+	int *derrlocs = ws->derrlocs;
+	int *errlocs = ws->errlocs;
+	uint16_t *corr = ws->corr;
+	uint16_t *c = ws->c;
+	uint16_t *r = ws->r;
+	uint16_t *s = ws->s;
+	int derrs, nerrs;
+	int i, j;
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
+		default:
+			continue;
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
+static int ex_rs_helper(struct rs_control *rs, struct wspace *ws,
+			int len, int trials, int method)
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
+static int exercise_rs(struct rs_control *rs, struct wspace *ws,
+		       int len, int trials)
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
+	int nroots = rs->codec->nroots;
+	int dlen = len - nroots;
+	int *derrlocs = ws->derrlocs;
+	uint16_t *corr = ws->corr;
+	uint16_t *r = ws->r;
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
+static int exercise_rs_bc(struct rs_control *rs, struct wspace *ws,
+			  int len, int trials)
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
+	int nn = (1 << e->symsize) - 1;
+	int kk = nn - e->nroots;
+	struct rs_control *rsc;
+	int retval = -ENOMEM;
+	int max_pad = kk - 1;
+	int prev_pad = -1;
+	struct wspace *ws;
+	int i;
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
+	for (i = 0; i < ARRAY_SIZE(pad_coef); i++) {
+		int pad = (pad_coef[i].mult * max_pad) >> pad_coef[i].shift;
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
+	int i, fail = 0;
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

