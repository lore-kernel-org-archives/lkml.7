Return-Path: <SRS0=KBKa=UT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87073C43613
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Jun 2019 14:11:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 529DD2083B
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Jun 2019 14:11:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OCjzf4bR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732147AbfFTOLF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Jun 2019 10:11:05 -0400
Received: from mail-lf1-f44.google.com ([209.85.167.44]:43774 "EHLO
        mail-lf1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732087AbfFTOK7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jun 2019 10:10:59 -0400
Received: by mail-lf1-f44.google.com with SMTP id j29so2532177lfk.10
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jun 2019 07:10:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=3IBX0vCKuuub4QoFCKXI+uf4RfZ3iyxgXq2Nc0Ia41E=;
        b=OCjzf4bRSHaMPoizPU0siee37M9IT4T2G/6OQGUAlJrKi/W2dhRAtM5pCZJdNJDWU7
         xGSN1QZBuZkw2nQCi7dBi63YZZUF2B/ywShVqz4AvKxTBWKTzNG2vs8YeKqZaMLmBYI/
         hzIBfxB8YH17M9ajHXTWHps67xk+UYDTynSGzuCGjqPNPHfN9jZ+ddzE1/kP0gelHDB7
         5N/JBZqlzuhM2jK0Ni9/6csrxwlhgmiASPw5BEpc1uvcU1YIHWALqhUSadSvj9zCC8OI
         6K3KAL+L9o10N/87jmGm/5kWI+CTTzSbIPgwrgIFwxZJ96q1ZJUpbxfjxLiq/+iQh08Q
         h+oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=3IBX0vCKuuub4QoFCKXI+uf4RfZ3iyxgXq2Nc0Ia41E=;
        b=fnZT7+/tuq7+P/QvSLiyHg3RUNyNZRNxPFz5X5+AMo+5ARfuc3Uc6u71v7Ipxo7PkV
         xphmi2WAK6N7abKKtwRRxuzzQHXsEZnh5KlZ27AvHWpeI/Q+s46YqvVgWGrtqeAZ4+gU
         JDBDqvhusIPR4KcrmYnAnlAzyRUS/qpFRvV968fqBYL2luHQQItM0D8SRTyhIoMh7y7H
         X7/0mukEP/7eFClAlALNq3WKNWQqKGHy5+IFw/mo6jZ7laPJNKyxyY3IMSD1jZlL7BOj
         aAEYJzGscFEYHtoiKN21GgZTOUkYLlvBubyV6kC4Z77qttj9tYa0G5AKx68slhxgubUW
         x9ZQ==
X-Gm-Message-State: APjAAAWj8TSFIoNqsdC9grjSBaY30cmMo5E+r7ZnhIE1yEx3qAMeLEY4
        lD1ZvDVsbYZSzQhaVgZpY1cbhbsF
X-Google-Smtp-Source: APXvYqzMuj4/mi/QTB7dgBDr4IUuD2Q5y9E+Av7Y99Aq8KwZaX+BMUoe5funeOBWp4EZ9d/q9245uA==
X-Received: by 2002:ac2:518d:: with SMTP id u13mr844946lfi.40.1561039856555;
        Thu, 20 Jun 2019 07:10:56 -0700 (PDT)
Received: from localhost.localdomain (v902-804.aalto.fi. [130.233.11.55])
        by smtp.gmail.com with ESMTPSA id 27sm3524684ljw.97.2019.06.20.07.10.55
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 20 Jun 2019 07:10:55 -0700 (PDT)
From:   Ferdinand Blomqvist <ferdinand.blomqvist@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH v2 7/7] rslib: Fix remaining decoder flaws
Date:   Thu, 20 Jun 2019 17:10:39 +0300
Message-Id: <20190620141039.9874-8-ferdinand.blomqvist@gmail.com>
X-Mailer: git-send-email 2.17.2
In-Reply-To: <20190620141039.9874-1-ferdinand.blomqvist@gmail.com>
References: <20190620141039.9874-1-ferdinand.blomqvist@gmail.com>
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
 lib/reed_solomon/decode_rs.c | 88 ++++++++++++++++++++++++++++--------
 1 file changed, 68 insertions(+), 20 deletions(-)

diff --git a/lib/reed_solomon/decode_rs.c b/lib/reed_solomon/decode_rs.c
index b7264a712d46..805de84ae83d 100644
--- a/lib/reed_solomon/decode_rs.c
+++ b/lib/reed_solomon/decode_rs.c
@@ -22,6 +22,7 @@
 	uint16_t *index_of = rs->index_of;
 	uint16_t u, q, tmp, num1, num2, den, discr_r, syn_error;
 	int count = 0;
+	int num_corrected;
 	uint16_t msk = (uint16_t) rs->nn;
 
 	/*
@@ -184,6 +185,15 @@
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
@@ -197,6 +207,12 @@
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
@@ -231,7 +247,9 @@
 	/*
 	 * Compute error values in poly-form. num1 = omega(inv(X(l))), num2 =
 	 * inv(X(l))**(fcr-1) and den = lambda_pr(inv(X(l))) all in poly-form
+	 * Note: we reuse the buffer for b to store the correction pattern
 	 */
+	num_corrected = 0;
 	for (j = count - 1; j >= 0; j--) {
 		num1 = 0;
 		for (i = deg_omega; i >= 0; i--) {
@@ -239,6 +257,13 @@
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
 
@@ -250,29 +275,52 @@
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

