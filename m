Return-Path: <SRS0=yJb2=SB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A8C8C4360F
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Mar 2019 18:30:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 05A122082C
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Mar 2019 18:30:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eLGCx6o2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731096AbfC3SaW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 30 Mar 2019 14:30:22 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:38429 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731028AbfC3SaT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Mar 2019 14:30:19 -0400
Received: by mail-lf1-f67.google.com with SMTP id a6so3576403lfl.5
        for <linux-kernel@vger.kernel.org>; Sat, 30 Mar 2019 11:30:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=eydMur+Q8L72gEONci33eWYjeUAVI0OFYtVbznXtpnU=;
        b=eLGCx6o2pC6XEEX+oSH8Jk3+9z0vbqE16gHMhjDNiQPTlqo1sK39keU9sREn8a737B
         iFxx7T8LNuar1pySJzlOgT83xZRGKHK2tRrEdaFev9AjkM4JiO01l0JMgFNOVF+2AUlA
         D6Wss2kM4CVmW3HfoYGhEy6PVjdA6c+zTzOdrkl2/tMQJDmNxGdBqQIGGY9zDfnzbP8W
         r1RLWYuMQrsmdobCsFjGT/ZDvZcanD/gjTxI+/eAn3UGWlcRG6G7cGwBCz+ohaDMg3O1
         s4C3UqrWSAaGYSCAya3RHdEi49x+6JvTCvDS0ougqVtRxjCJ7YGR6qOwecdGzMLaua5Z
         cKiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=eydMur+Q8L72gEONci33eWYjeUAVI0OFYtVbznXtpnU=;
        b=lAl24cHVDHhUmLp1T0h06k9IHMxJ0jiS9wZmoiIKak4ozspIpRtv6XN56Nxbk9gaPr
         B8ewpxFJ2z7qLdPxaslTYpOAp79UFSx4gvhFurCcr4TimTgy3hFS4nCP/JdUNfC61XaJ
         rHk1i4zvHEckDiJkHmbBdW/fYUuzQC+c2X3OW79Fn9s2M3IFS+DQ7yGPLzzZiIDSKRED
         DezaFQT8oJFbxIbY8K5FqKVbbU/m5NsaV0rmFh94GexrpU6F561uxTuTRYvUP+wcgrQO
         4lz6RqpR/SCx8xvqFgcD10n0NzabRd7MfFXgDZrdB4vjUxhqx1E8PtU852ML6gdjgaAO
         wHEQ==
X-Gm-Message-State: APjAAAU1GssYKvktXYagF0qHIQtWjNFN0J9+0K2jxUXc0GzI1lR6BU1Q
        eZATpfQMSoD1/BUboRXotLN7y9Ji
X-Google-Smtp-Source: APXvYqwWBAGKyJGTS8WEOX3QsZag+IZkRxC67bf6KV678dP5MBgig4WHNBjnZdXvCeQfm6/dnLPWlw==
X-Received: by 2002:ac2:5595:: with SMTP id v21mr14200458lfg.163.1553970616625;
        Sat, 30 Mar 2019 11:30:16 -0700 (PDT)
Received: from localhost.localdomain (v902-731.aalto.fi. [130.233.10.238])
        by smtp.gmail.com with ESMTPSA id o7sm1060058ljj.23.2019.03.30.11.30.15
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 30 Mar 2019 11:30:16 -0700 (PDT)
From:   Ferdinand Blomqvist <ferdinand.blomqvist@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Thomas Gleixner <tglx@linutronix.de>
Subject: [RFC PATCH 7/7] rslib: Fix remaining decoder flaws
Date:   Sat, 30 Mar 2019 20:29:47 +0200
Message-Id: <20190330182947.8823-8-ferdinand.blomqvist@gmail.com>
X-Mailer: git-send-email 2.17.2
In-Reply-To: <20190330182947.8823-1-ferdinand.blomqvist@gmail.com>
References: <20190330182947.8823-1-ferdinand.blomqvist@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The decoder is flawed in the following ways:

- The decoder sometimes fails silently, i.e. it announces success but
  returns a word that is not a codeword.

- The return value of the decoder is incoherent with respect to how
  fixed erasures are counted. If the word to be decoded is a codeword,
  then the decoder always returns zero even if some erasures are given.
  On the other hand, if the word to be decoded contains errors, then the
  number of erasures is always included in the count of corrected
  symbols. So the decoder handles erasures without symbol corruption
  inconsistently. This inconsistency probably doesn't affect anyone
  using the decoder, but it is inconsistent with the documentation.

- The error positions returned in eras_pos include all erasures, but the
  corrections are only set in the correction buffer if there actually is
  a symbol error. So if there are erasures without symbol corruption,
  then the correction buffer will contain errors (unless initialized to
  zero before calling the decoder) or some values will be unset (if the
  correction buffer is uninitialized).

- When correcting data in-place the decoder does not correct errors in
  the parity. On the other hand, when returning the errors in correction
  buffers, errors in the parity are included.

The respective fixed are:

- The syndrome of a codeword is always zero, and the syndrome is linear,
  .i.e, S(x+e) = S(x) + S(e). So compute the syndrome for the error and
  check whether it equals the syndrome of the received word. If it does,
  then we have decoded to a valid codeword, otherwise we know that we
  have an uncorrectable error. Fortunately, some unrecoverable error
  conditions can be detected earlier in the decoding, which saves some
  processing power.

- Simply count and return the number of symbols actually corrected.

- Make sure to only return positions where symbols were corrected.

- Also fix errors in parity when correcting in-place. Another option
  would be to completely disregard errors in the parity, but then the
  interface makes it impossible to write tests that test for silent
  failures.

Other changes:

- Only fill the correction buffer and error position buffer if both of
  them are provided. Otherwise correct in place. Previously the error
  position buffer was always populated with the positions of the
  corrected errors, irrespective of whether a correction buffer was
  supplied or not. The rationale for this change is that there seems to
  be two use cases for the decoder; correct in-place or use the
  correction buffers. The caller does not need the positions of the
  corrected errors when in-place correction is used. If in-place
  correction is not used, then both the correction buffer and error
  position buffer need to be populated.

Signed-off-by: Ferdinand Blomqvist <ferdinand.blomqvist@gmail.com>
---
 lib/reed_solomon/decode_rs.c | 87 +++++++++++++++++++++++++++---------
 1 file changed, 67 insertions(+), 20 deletions(-)

diff --git a/lib/reed_solomon/decode_rs.c b/lib/reed_solomon/decode_rs.c
index 7ecc449e57e9..33621ea67f67 100644
--- a/lib/reed_solomon/decode_rs.c
+++ b/lib/reed_solomon/decode_rs.c
@@ -22,6 +22,7 @@
 	uint16_t *index_of = rs->index_of;
 	uint16_t u, q, tmp, num1, num2, den, discr_r, syn_error;
 	int count = 0;
+	int num_corrected;
 	uint16_t msk = (uint16_t) rs->nn;
 
 	/*
@@ -182,6 +183,15 @@
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
@@ -195,6 +205,12 @@
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
@@ -229,7 +245,9 @@
 	/*
 	 * Compute error values in poly-form. num1 = omega(inv(X(l))), num2 =
 	 * inv(X(l))**(fcr-1) and den = lambda_pr(inv(X(l))) all in poly-form
+	 * Note: we reuse the buffer for b to store the correction pattern
 	 */
+	num_corrected = 0;
 	for (j = count - 1; j >= 0; j--) {
 		num1 = 0;
 		for (i = deg_omega; i >= 0; i--) {
@@ -237,6 +255,12 @@
 				num1 ^= alpha_to[rs_modnn(rs, omega[i] +
 							i * root[j])];
 		}
+
+		if (num1 == 0) {
+			b[j] = 0;
+			continue;
+		}
+
 		num2 = alpha_to[rs_modnn(rs, root[j] * (fcr - 1) + nn)];
 		den = 0;
 
@@ -248,29 +272,52 @@
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
+	 * We compute the syndrome of the 'error' to and check that it matches
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
-- 
2.17.2

