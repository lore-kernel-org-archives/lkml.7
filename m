Return-Path: <SRS0=FrXW=TP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DE1CC04AB4
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 00:55:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E88762082E
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 00:54:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726503AbfEOAy6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 May 2019 20:54:58 -0400
Received: from seldsegrel01.sonyericsson.com ([37.139.156.29]:15861 "EHLO
        SELDSEGREL01.sonyericsson.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726044AbfEOAy6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 May 2019 20:54:58 -0400
X-Greylist: delayed 604 seconds by postgrey-1.27 at vger.kernel.org; Tue, 14 May 2019 20:53:46 EDT
From:   Chenxi Mao <chenxi.mao@sony.com>
To:     <akpm@linux-foundation.org>
CC:     <gaoxiang25@huawei.com>, <linux-kernel@vger.kernel.org>,
        <roy.feng@sony.com>, <yuanli.xu@sony.com>, <robert.alm@sony.com>,
        <masaya.a.takahashi@sony.com>, "chenxi . mao" <chenxi.mao@sony.com>
Subject: [PATCH 1/1] LZ4: Port LZ4 1.9.x FAST_DEC_LOOP and enable it on x86 and ARM64
Date:   Wed, 15 May 2019 08:43:36 +0800
Message-ID: <20190515004336.66555-1-chenxi.mao@sony.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

FAST_DEC_LOOP was introduced from LZ4 1.9.
This change would be introduce 10% on decompress operation
according to LZ4 benchmark result on X86 devices.
Meanwhile, LZ4 with FAST_DEC_LOOP could get improvements,
however clang compiler has downgrade if FAST_DEC_LOOP enabled.

So FAST_DEC_LOOP only enabled on X86/X86-64 or ARM64 with GCC build.

Here is the test result on ARM64(cortex-A53)

Benchmark via ZRAM:

Test case:
fio --bs=32k --randrepeat=1 --randseed=100 --refill_buffers \
--buffer_compress_percentage=75 \
--scramble_buffers=1 --direct=1 --loops=100 --numjobs=8 \
--filename=/dev/block/zram0 --name=seq-write --rw=write --stonewall \
--name=seq-read --rw=read --stonewall --name=seq-readwrite \
--rw=rw --stonewall --name=rand-readwrite --rw=randrw --stonewall

Patched:
   READ: bw=7077MiB/s (7421MB/s)
Vanilla:
   READ: bw=5134MiB/s (5384MB/s)

Reference:
1. https://github.com/lz4/lz4/pull/645
2. https://github.com/lz4/lz4/pull/707

Signed-off-by: chenxi.mao <chenxi.mao@sony.com>
---
 lib/lz4/lz4_decompress.c | 425 +++++++++++++++++++++++++++++++++------
 1 file changed, 361 insertions(+), 64 deletions(-)

diff --git a/lib/lz4/lz4_decompress.c b/lib/lz4/lz4_decompress.c
index 0c9d3ad17e0f..a4c87e32b3c0 100644
--- a/lib/lz4/lz4_decompress.c
+++ b/lib/lz4/lz4_decompress.c
@@ -50,6 +50,131 @@
 #define assert(condition) ((void)0)
 #endif
 
+#ifndef LZ4_FAST_DEC_LOOP
+#if defined(__i386__) || defined(__x86_64__)
+#define LZ4_FAST_DEC_LOOP 1
+#elif defined(__aarch64__) && !defined(__clang__)
+     /* On aarch64, we disable this optimization for clang because on certain
+      * mobile chipsets and clang, it reduces performance. For more information
+      * refer to https://github.com/lz4/lz4/pull/707. */
+#define LZ4_FAST_DEC_LOOP 1
+#else
+#define LZ4_FAST_DEC_LOOP 0
+#endif
+#endif
+
+static const unsigned inc32table[8] = { 0, 1, 2, 1, 0, 4, 4, 4 };
+static const int dec64table[8] = { 0, 0, 0, -1, -4, 1, 2, 3 };
+
+#if LZ4_FAST_DEC_LOOP
+#define FASTLOOP_SAFE_DISTANCE 64
+FORCE_INLINE void
+LZ4_memcpy_using_offset_base(BYTE * dstPtr, const BYTE * srcPtr, BYTE * dstEnd,
+			     const size_t offset)
+{
+	if (offset < 8) {
+		dstPtr[0] = srcPtr[0];
+
+		dstPtr[1] = srcPtr[1];
+		dstPtr[2] = srcPtr[2];
+		dstPtr[3] = srcPtr[3];
+		srcPtr += inc32table[offset];
+		memcpy(dstPtr + 4, srcPtr, 4);
+		srcPtr -= dec64table[offset];
+		dstPtr += 8;
+	} else {
+		memcpy(dstPtr, srcPtr, 8);
+		dstPtr += 8;
+		srcPtr += 8;
+	}
+
+	LZ4_wildCopy(dstPtr, srcPtr, dstEnd);
+}
+
+/* customized variant of memcpy, which can overwrite up to 32 bytes beyond dstEnd
+ * this version copies two times 16 bytes (instead of one time 32 bytes)
+ * because it must be compatible with offsets >= 16. */
+FORCE_INLINE void LZ4_wildCopy32(void *dstPtr, const void *srcPtr, void *dstEnd)
+{
+	BYTE *d = (BYTE *) dstPtr;
+	const BYTE *s = (const BYTE *)srcPtr;
+	BYTE *const e = (BYTE *) dstEnd;
+
+	do {
+		memcpy(d, s, 16);
+		memcpy(d + 16, s + 16, 16);
+		d += 32;
+		s += 32;
+	} while (d < e);
+}
+
+FORCE_INLINE void
+LZ4_memcpy_using_offset(BYTE *dstPtr, const BYTE *srcPtr, BYTE *dstEnd,
+			const size_t offset)
+{
+	BYTE v[8];
+	switch (offset) {
+
+	case 1:
+		memset(v, *srcPtr, 8);
+		goto copy_loop;
+	case 2:
+		memcpy(v, srcPtr, 2);
+		memcpy(&v[2], srcPtr, 2);
+		memcpy(&v[4], &v[0], 4);
+		goto copy_loop;
+	case 4:
+		memcpy(v, srcPtr, 4);
+		memcpy(&v[4], srcPtr, 4);
+		goto copy_loop;
+	default:
+		LZ4_memcpy_using_offset_base(dstPtr, srcPtr, dstEnd, offset);
+		return;
+	}
+
+      copy_loop:
+	memcpy(dstPtr, v, 8);
+	dstPtr += 8;
+	while (dstPtr < dstEnd) {
+		memcpy(dstPtr, v, 8);
+		dstPtr += 8;
+	}
+}
+
+/* Read the variable-length literal or match length.
+ *
+ * ip - pointer to use as input.
+ * lencheck - end ip.  Return an error if ip advances >= lencheck.
+ * loop_check - check ip >= lencheck in body of loop.  Returns loop_error if so.
+ * initial_check - check ip >= lencheck before start of loop.  Returns initial_error if so.
+ * error (output) - error code.  Should be set to 0 before call.
+ */
+typedef enum { loop_error = -2, initial_error = -1, ok = 0} variable_length_error;
+FORCE_INLINE unsigned read_variable_length(const BYTE **ip,
+					   const BYTE *lencheck,
+					   int loop_check, int initial_check,
+					   variable_length_error *error)
+{
+	unsigned length = 0;
+	unsigned s;
+	if (initial_check && unlikely((*ip) >= lencheck)) {	/* overflow detection */
+		*error = initial_error;
+		return length;
+	}
+	do {
+		s = **ip;
+		(*ip)++;
+		length += s;
+		if (loop_check && unlikely((*ip) >= lencheck)) {	/* overflow detection */
+			*error = loop_error;
+			return length;
+		}
+	} while (s == 255);
+
+	return length;
+}
+#endif
+
 /*
  * LZ4_decompress_generic() :
  * This generic decompression function covers all use cases.
@@ -80,25 +205,28 @@ static FORCE_INLINE int LZ4_decompress_generic(
 	 const size_t dictSize
 	 )
 {
-	const BYTE *ip = (const BYTE *) src;
-	const BYTE * const iend = ip + srcSize;
+	const BYTE *ip = (const BYTE *)src;
+	const BYTE *const iend = ip + srcSize;
 
 	BYTE *op = (BYTE *) dst;
-	BYTE * const oend = op + outputSize;
+	BYTE *const oend = op + outputSize;
 	BYTE *cpy;
 
-	const BYTE * const dictEnd = (const BYTE *)dictStart + dictSize;
-	static const unsigned int inc32table[8] = {0, 1, 2, 1, 0, 4, 4, 4};
-	static const int dec64table[8] = {0, 0, 0, -1, -4, 1, 2, 3};
+	const BYTE *const dictEnd = (const BYTE *)dictStart + dictSize;
 
 	const int safeDecode = (endOnInput == endOnInputSize);
 	const int checkOffset = ((safeDecode) && (dictSize < (int)(64 * KB)));
 
 	/* Set up the "end" pointers for the shortcut. */
 	const BYTE *const shortiend = iend -
-		(endOnInput ? 14 : 8) /*maxLL*/ - 2 /*offset*/;
+	    (endOnInput ? 14 : 8) /*maxLL*/ - 2 /*offset*/;
 	const BYTE *const shortoend = oend -
-		(endOnInput ? 14 : 8) /*maxLL*/ - 18 /*maxML*/;
+	    (endOnInput ? 14 : 8) /*maxLL*/ - 18 /*maxML*/;
+
+	const BYTE *match;
+	size_t offset;
+	unsigned int token;
+	size_t length;
 
 	DEBUGLOG(5, "%s (srcSize:%i, dstSize:%i)", __func__,
 		 srcSize, outputSize);
@@ -117,15 +245,194 @@ static FORCE_INLINE int LZ4_decompress_generic(
 	if ((endOnInput) && unlikely(srcSize == 0))
 		return -1;
 
-	/* Main Loop : decode sequences */
+#if LZ4_FAST_DEC_LOOP
+	if ((oend - op) < FASTLOOP_SAFE_DISTANCE) {
+		DEBUGLOG(6, "skip fast decode loop");
+		goto safe_decode;
+	}
+
+	/* Fast loop : decode sequences as long as output < iend-FASTLOOP_SAFE_DISTANCE */
 	while (1) {
-		size_t length;
-		const BYTE *match;
-		size_t offset;
+		/* Main fastloop assertion: We can always wildcopy FASTLOOP_SAFE_DISTANCE */
+		assert(oend - op >= FASTLOOP_SAFE_DISTANCE);
+		if (endOnInput) {
+			assert(ip < iend);
+		}
+		token = *ip++;
+		length = token >> ML_BITS;	/* literal length */
+
+		assert(!endOnInput || ip <= iend);	/* ip < iend before the increment */
+
+		/* decode literal length */
+		if (length == RUN_MASK) {
+			variable_length_error error = ok;
+			length +=
+			    read_variable_length(&ip, iend - RUN_MASK,
+						 endOnInput, endOnInput,
+						 &error);
+			if (error == initial_error) {
+				goto _output_error;
+			}
+			if ((safeDecode)
+			    && unlikely((uptrval) (op) + length <
+					(uptrval) (op))) {
+				goto _output_error;
+			}	/* overflow detection */
+			if ((safeDecode)
+			    && unlikely((uptrval) (ip) + length <
+					(uptrval) (ip))) {
+				goto _output_error;
+			}
+
+			/* overflow detection */
+			/* copy literals */
+			cpy = op + length;
+			LZ4_STATIC_ASSERT(MFLIMIT >= WILDCOPYLENGTH);
+			if (endOnInput) {	/* LZ4_decompress_safe() */
+				if ((cpy > oend - 32)
+				    || (ip + length > iend - 32)) {
+					goto safe_literal_copy;
+				}
+				LZ4_wildCopy32(op, ip, cpy);
+			} else {	/* LZ4_decompress_fast() */
+				if (cpy > oend - 8) {
+					goto safe_literal_copy;
+				}
+				LZ4_wildCopy(op, ip, cpy);
+				/* LZ4_decompress_fast() cannot copy more than 8 bytes at a time */
+				/* it doesn't know input length, and only relies on end-of-block */
+				/* properties */
+			}
+			ip += length;
+			op = cpy;
+		} else {
+			cpy = op + length;
+			if (endOnInput) {	/* LZ4_decompress_safe() */
+				DEBUGLOG(7,
+					 "copy %u bytes in a 16-bytes stripe",
+					 (unsigned)length);
+				/* We don't need to check oend */
+				/* since we check it once for each loop below */
+				if (ip > iend - (16 + 1)) {	/*max lit + offset + nextToken */
+					goto safe_literal_copy;
+				}
+				/* Literals can only be 14, but hope compilers optimize */
+				/*if we copy by a register size */
+				memcpy(op, ip, 16);
+			} else {
+				/* LZ4_decompress_fast() cannot copy more than 8 bytes at a time */
+				/* it doesn't know input length, and relies on end-of-block */
+				/* properties */
+				memcpy(op, ip, 8);
+				if (length > 8) {
+					memcpy(op + 8, ip + 8, 8);
+				}
+			}
+			ip += length;
+			op = cpy;
+		}
+
+		/* get offset */
+		offset = LZ4_readLE16(ip);
+		ip += 2;	/* end-of-block condition violated */
+		match = op - offset;
+
+		/* get matchlength */
+		length = token & ML_MASK;
 
-		/* get literal length */
-		unsigned int const token = *ip++;
-		length = token>>ML_BITS;
+		if ((checkOffset) && (unlikely(match + dictSize < lowPrefix))) {
+			goto _output_error;
+		}
+		/* Error : offset outside buffers */
+		if (length == ML_MASK) {
+			variable_length_error error = ok;
+			length +=
+			    read_variable_length(&ip, iend - LASTLITERALS + 1,
+						 endOnInput, 0, &error);
+			if (error != ok) {
+				goto _output_error;
+			}
+			if ((safeDecode)
+			    && unlikely((uptrval) (op) + length < (uptrval) op)) {
+				goto _output_error;
+			}	/* overflow detection */
+			length += MINMATCH;
+			if (op + length >= oend - FASTLOOP_SAFE_DISTANCE) {
+				goto safe_match_copy;
+			}
+		} else {
+			length += MINMATCH;
+			if (op + length >= oend - FASTLOOP_SAFE_DISTANCE) {
+				goto safe_match_copy;
+			}
+
+			/* Fastpath check: Avoids a branch in LZ4_wildCopy32 if true */
+			if (!(dict == usingExtDict) || (match >= lowPrefix)) {
+				if (offset >= 8) {
+					memcpy(op, match, 8);
+					memcpy(op + 8, match + 8, 8);
+					memcpy(op + 16, match + 16, 2);
+					op += length;
+					continue;
+				}
+			}
+		}
+
+		/* match starting within external dictionary */
+		if ((dict == usingExtDict) && (match < lowPrefix)) {
+			if (unlikely(op + length > oend - LASTLITERALS)) {
+				if (partialDecoding) {
+					/* reach end of buffer */
+					length =
+					    min(length, (size_t) (oend - op));
+				} else {
+					/* end-of-block condition violated */
+					goto _output_error;
+				}
+			}
+
+			if (length <= (size_t) (lowPrefix - match)) {
+				/* match fits entirely within external dictionary : just copy */
+				memmove(op, dictEnd - (lowPrefix - match), length);
+				op += length;
+			} else {
+				/* match stretches into both external dict and current block */
+				size_t const copySize =
+				    (size_t) (lowPrefix - match);
+				size_t const restSize = length - copySize;
+				memcpy(op, dictEnd - copySize, copySize);
+				op += copySize;
+				if (restSize > (size_t) (op - lowPrefix)) {	/* overlap copy */
+					BYTE *const endOfMatch = op + restSize;
+					const BYTE *copyFrom = lowPrefix;
+					while (op < endOfMatch) {
+						*op++ = *copyFrom++;
+					}
+				} else {
+					memcpy(op, lowPrefix, restSize);
+					op += restSize;
+				}
+			}
+			continue;
+		}
+
+		/* copy match within block */
+		cpy = op + length;
+
+		assert((op <= oend) && (oend - op >= 32));
+		if (unlikely(offset < 16)) {
+			LZ4_memcpy_using_offset(op, match, cpy, offset);
+		} else {
+			LZ4_wildCopy32(op, match, cpy);
+		}
+
+		op = cpy;	/* wildcopy correction */
+	}
+      safe_decode:
+#endif
+	/* Main Loop : decode sequences */
+	while (1) {
+		length = token >> ML_BITS;
 
 		/* ip < iend before the increment */
 		assert(!endOnInput || ip <= iend);
@@ -143,26 +450,27 @@ static FORCE_INLINE int LZ4_decompress_generic(
 		 * combined check for both stages).
 		 */
 		if ((endOnInput ? length != RUN_MASK : length <= 8)
-		   /*
-		    * strictly "less than" on input, to re-enter
-		    * the loop with at least one byte
-		    */
-		   && likely((endOnInput ? ip < shortiend : 1) &
-			     (op <= shortoend))) {
+		    /*
+		     * strictly "less than" on input, to re-enter
+		     * the loop with at least one byte
+		     */
+		    && likely((endOnInput ? ip < shortiend : 1) &
+			      (op <= shortoend))) {
 			/* Copy the literals */
 			memcpy(op, ip, endOnInput ? 16 : 8);
-			op += length; ip += length;
+			op += length;
+			ip += length;
 
 			/*
 			 * The second stage:
 			 * prepare for match copying, decode full info.
 			 * If it doesn't work out, the info won't be wasted.
 			 */
-			length = token & ML_MASK; /* match length */
+			length = token & ML_MASK;	/* match length */
 			offset = LZ4_readLE16(ip);
 			ip += 2;
 			match = op - offset;
-			assert(match <= op); /* check overflow */
+			assert(match <= op);	/* check overflow */
 
 			/* Do not deal with overlapping matches. */
 			if ((length != ML_MASK) &&
@@ -187,28 +495,24 @@ static FORCE_INLINE int LZ4_decompress_generic(
 
 		/* decode literal length */
 		if (length == RUN_MASK) {
-			unsigned int s;
 
-			if (unlikely(endOnInput ? ip >= iend - RUN_MASK : 0)) {
-				/* overflow detection */
+			variable_length_error error = ok;
+			length +=
+			    read_variable_length(&ip, iend - RUN_MASK,
+						 endOnInput, endOnInput,
+						 &error);
+			if (error == initial_error)
 				goto _output_error;
-			}
-			do {
-				s = *ip++;
-				length += s;
-			} while (likely(endOnInput
-				? ip < iend - RUN_MASK
-				: 1) & (s == 255));
 
 			if ((safeDecode)
-			    && unlikely((uptrval)(op) +
-					length < (uptrval)(op))) {
+			    && unlikely((uptrval) (op) +
+					length < (uptrval) (op))) {
 				/* overflow detection */
 				goto _output_error;
 			}
 			if ((safeDecode)
-			    && unlikely((uptrval)(ip) +
-					length < (uptrval)(ip))) {
+			    && unlikely((uptrval) (ip) +
+					length < (uptrval) (ip))) {
 				/* overflow detection */
 				goto _output_error;
 			}
@@ -216,11 +520,15 @@ static FORCE_INLINE int LZ4_decompress_generic(
 
 		/* copy literals */
 		cpy = op + length;
+#if LZ4_FAST_DEC_LOOP
+	      safe_literal_copy:
+#endif
 		LZ4_STATIC_ASSERT(MFLIMIT >= WILDCOPYLENGTH);
 
 		if (((endOnInput) && ((cpy > oend - MFLIMIT)
-			|| (ip + length > iend - (2 + 1 + LASTLITERALS))))
-			|| ((!endOnInput) && (cpy > oend - WILDCOPYLENGTH))) {
+				      || (ip + length >
+					  iend - (2 + 1 + LASTLITERALS))))
+		    || ((!endOnInput) && (cpy > oend - WILDCOPYLENGTH))) {
 			if (partialDecoding) {
 				if (cpy > oend) {
 					/*
@@ -231,7 +539,7 @@ static FORCE_INLINE int LZ4_decompress_generic(
 					length = oend - op;
 				}
 				if ((endOnInput)
-					&& (ip + length > iend)) {
+				    && (ip + length > iend)) {
 					/*
 					 * Error :
 					 * read attempt beyond
@@ -241,7 +549,7 @@ static FORCE_INLINE int LZ4_decompress_generic(
 				}
 			} else {
 				if ((!endOnInput)
-					&& (cpy != oend)) {
+				    && (cpy != oend)) {
 					/*
 					 * Error :
 					 * block decoding must
@@ -250,7 +558,7 @@ static FORCE_INLINE int LZ4_decompress_generic(
 					goto _output_error;
 				}
 				if ((endOnInput)
-					&& ((ip + length != iend)
+				    && ((ip + length != iend)
 					|| (cpy > oend))) {
 					/*
 					 * Error :
@@ -288,29 +596,14 @@ static FORCE_INLINE int LZ4_decompress_generic(
 			goto _output_error;
 		}
 
-		/* costs ~1%; silence an msan warning when offset == 0 */
-		/*
-		 * note : when partialDecoding, there is no guarantee that
-		 * at least 4 bytes remain available in output buffer
-		 */
-		if (!partialDecoding) {
-			assert(oend > op);
-			assert(oend - op >= 4);
-
-			LZ4_write32(op, (U32)offset);
-		}
-
 		if (length == ML_MASK) {
-			unsigned int s;
-
-			do {
-				s = *ip++;
-
-				if ((endOnInput) && (ip > iend - LASTLITERALS))
-					goto _output_error;
 
-				length += s;
-			} while (s == 255);
+			variable_length_error error = ok;
+			length +=
+			    read_variable_length(&ip, iend - LASTLITERALS + 1,
+						 endOnInput, 0, &error);
+			if (error != ok)
+				goto _output_error;
 
 			if ((safeDecode)
 				&& unlikely(
@@ -322,6 +615,10 @@ static FORCE_INLINE int LZ4_decompress_generic(
 
 		length += MINMATCH;
 
+#if LZ4_FAST_DEC_LOOP
+safe_match_copy:
+#endif
+
 		/* match starting within external dictionary */
 		if ((dict == usingExtDict) && (match < lowPrefix)) {
 			if (unlikely(op + length > oend - LASTLITERALS)) {
-- 
2.17.1

