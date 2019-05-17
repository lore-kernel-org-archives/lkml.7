Return-Path: <SRS0=M1fl=TR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C8F6C04AAF
	for <linux-kernel@archiver.kernel.org>; Fri, 17 May 2019 01:45:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 23CC820848
	for <linux-kernel@archiver.kernel.org>; Fri, 17 May 2019 01:45:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726857AbfEQBpA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 May 2019 21:45:00 -0400
Received: from seldsegrel01.sonyericsson.com ([37.139.156.29]:10980 "EHLO
        SELDSEGREL01.sonyericsson.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725933AbfEQBpA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 May 2019 21:45:00 -0400
From:   Chenxi Mao <chenxi.mao@sony.com>
To:     <akpm@linux-foundation.org>
CC:     <gaoxiang25@huawei.com>, <linux-kernel@vger.kernel.org>,
        <roy.feng@sony.com>, <yuanli.xu@sony.com>, <robert.alm@sony.com>,
        <masaya.a.takahashi@sony.com>, <yann.collet.73@gmail.com>,
        <miaoxie@huawei.com>, "chenxi . mao" <chenxi.mao@sony.com>
Subject: [PATCH 1/1] LZ4: Port LZ4 1.9.x FAST_DEC_LOOP and enable it on x86 and ARM64
Date:   Fri, 17 May 2019 09:44:32 +0800
Message-ID: <20190517014432.173175-1-chenxi.mao@sony.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-SEG-SpamProfiler-Analysis: v=2.3 cv=CKNUoijD c=1 sm=1 tr=0 a=kIrCkORFHx6JeP9rmF/Kww==:117 a=E5NmQfObTbMA:10 a=GfcSYmySAAAA:20 a=z6gsHLkEAAAA:8 a=gHUY4FZ4cpBe57aJ7uAA:9 a=ELIGq2YhQRXRHQW8:21 a=6TFzYgpJ-9VuCOGe:21 a=d-OLMTCWyvARjPbQ-enb:22
X-SEG-SpamProfiler-Score: 0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

FAST_DEC_LOOP was introduced from LZ4 1.9[1].
This change would be introduce 10% on decompress operation
according to LZ4 benchmark result on X86 devices.
Meanwhile, LZ4 with FAST_DEC_LOOP could get improvements,
however clang compiler has downgrade if FAST_DEC_LOOP enabled.

So FAST_DEC_LOOP only enabled on X86/X86-64 or ARM64 with GCC build.

LZ4 FAST_DEC_LOOP bug fixes include as well.
1. fixed read-after input in LZ4_decompress_safe() (issue 681)
2. Fix out-of-bound read in LZ4_decompress_fast() (issue 676)

PS2:
1. Move common API to lz4defs.h
2. Add PPC related inline Macro defination.
3. Leverge specific LZ4_wildCopy32 for X86 and ARM64

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
   READ: bw=8757MiB/s (9182MB/s)
Vanilla:
   READ: bw=7765MiB/s (8142MB/s)

[1] https://github.com/lz4/lz4/releases/tag/v1.9.0

Signed-off-by: chenxi.mao <chenxi.mao@sony.com>
---
 lib/lz4/lz4_compress.c   |   4 +-
 lib/lz4/lz4_decompress.c | 414 ++++++++++++++++++++++++++++++++-------
 lib/lz4/lz4defs.h        |  60 +++++-
 lib/lz4/lz4hc_compress.c |   2 +-
 4 files changed, 409 insertions(+), 71 deletions(-)

diff --git a/lib/lz4/lz4_compress.c b/lib/lz4/lz4_compress.c
index cc7b6d4cc7c7..b703ed1ca57d 100644
--- a/lib/lz4/lz4_compress.c
+++ b/lib/lz4/lz4_compress.c
@@ -322,7 +322,7 @@ static FORCE_INLINE int LZ4_compress_generic(
 				*token = (BYTE)(litLength << ML_BITS);
 
 			/* Copy Literals */
-			LZ4_wildCopy(op, anchor, op + litLength);
+			LZ4_wildCopy8(op, anchor, op + litLength);
 			op += litLength;
 		}
 
@@ -628,7 +628,7 @@ static int LZ4_compress_destSize_generic(
 				*token = (BYTE)(litLength << ML_BITS);
 
 			/* Copy Literals */
-			LZ4_wildCopy(op, anchor, op + litLength);
+			LZ4_wildCopy8(op, anchor, op + litLength);
 			op += litLength;
 		}
 
diff --git a/lib/lz4/lz4_decompress.c b/lib/lz4/lz4_decompress.c
index 0c9d3ad17e0f..60c134e4699f 100644
--- a/lib/lz4/lz4_decompress.c
+++ b/lib/lz4/lz4_decompress.c
@@ -50,6 +50,113 @@
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
+#if LZ4_FAST_DEC_LOOP
+#define FASTLOOP_SAFE_DISTANCE 64
+FORCE_O2_INLINE_GCC_PPC64LE void
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
+	LZ4_wildCopy8(dstPtr, srcPtr, dstEnd);
+}
+
+/* customized variant of memcpy, which can overwrite up to 32 bytes beyond dstEnd
+ * this version copies two times 16 bytes (instead of one time 32 bytes)
+ * because it must be compatible with offsets >= 16. */
+FORCE_O2_INLINE_GCC_PPC64LE void
+LZ4_wildCopy32(void *dstPtr, const void *srcPtr, void *dstEnd)
+{
+	BYTE *d = (BYTE *) dstPtr;
+	const BYTE *s = (const BYTE *)srcPtr;
+	BYTE *const e = (BYTE *) dstEnd;
+
+#if defined(__i386__) || defined(__x86_64__)
+	do {
+		memcpy(d, s, 16);
+		memcpy(d + 16, s + 16, 16);
+		d += 32;
+		s += 32;
+	} while (d < e);
+#elif defined(__aarch64__) && !defined(__clang__)
+	do {
+		LZ4_copy8(d, s);
+		d += 8;
+		s += 8;
+		LZ4_copy8(d, s);
+		d += 8;
+		s += 8;
+		LZ4_copy8(d, s);
+		d += 8;
+		s += 8;
+		LZ4_copy8(d, s);
+		d += 8;
+		s += 8;
+	} while (d < e);
+#endif
+}
+
+FORCE_O2_INLINE_GCC_PPC64LE void
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
+#endif
+
 /*
  * LZ4_decompress_generic() :
  * This generic decompression function covers all use cases.
@@ -80,25 +187,28 @@ static FORCE_INLINE int LZ4_decompress_generic(
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
@@ -117,15 +227,195 @@ static FORCE_INLINE int LZ4_decompress_generic(
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
+				LZ4_wildCopy8(op, ip, cpy);
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
+
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
+				memmove(op, dictEnd - (lowPrefix - match),
+					length);
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
 
-		/* get literal length */
-		unsigned int const token = *ip++;
-		length = token>>ML_BITS;
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
@@ -143,26 +433,27 @@ static FORCE_INLINE int LZ4_decompress_generic(
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
@@ -187,28 +478,24 @@ static FORCE_INLINE int LZ4_decompress_generic(
 
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
@@ -216,11 +503,15 @@ static FORCE_INLINE int LZ4_decompress_generic(
 
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
@@ -231,7 +522,7 @@ static FORCE_INLINE int LZ4_decompress_generic(
 					length = oend - op;
 				}
 				if ((endOnInput)
-					&& (ip + length > iend)) {
+				    && (ip + length > iend)) {
 					/*
 					 * Error :
 					 * read attempt beyond
@@ -241,7 +532,7 @@ static FORCE_INLINE int LZ4_decompress_generic(
 				}
 			} else {
 				if ((!endOnInput)
-					&& (cpy != oend)) {
+				    && (cpy != oend)) {
 					/*
 					 * Error :
 					 * block decoding must
@@ -250,7 +541,7 @@ static FORCE_INLINE int LZ4_decompress_generic(
 					goto _output_error;
 				}
 				if ((endOnInput)
-					&& ((ip + length != iend)
+				    && ((ip + length != iend)
 					|| (cpy > oend))) {
 					/*
 					 * Error :
@@ -269,7 +560,7 @@ static FORCE_INLINE int LZ4_decompress_generic(
 				break;
 		} else {
 			/* may overwrite up to WILDCOPYLENGTH beyond cpy */
-			LZ4_wildCopy(op, ip, cpy);
+			LZ4_wildCopy8(op, ip, cpy);
 			ip += length;
 			op = cpy;
 		}
@@ -288,29 +579,14 @@ static FORCE_INLINE int LZ4_decompress_generic(
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
@@ -322,6 +598,10 @@ static FORCE_INLINE int LZ4_decompress_generic(
 
 		length += MINMATCH;
 
+#if LZ4_FAST_DEC_LOOP
+safe_match_copy:
+#endif
+
 		/* match starting within external dictionary */
 		if ((dict == usingExtDict) && (match < lowPrefix)) {
 			if (unlikely(op + length > oend - LASTLITERALS)) {
@@ -418,7 +698,7 @@ static FORCE_INLINE int LZ4_decompress_generic(
 			}
 
 			if (op < oCopyLimit) {
-				LZ4_wildCopy(op, match, oCopyLimit);
+				LZ4_wildCopy8(op, match, oCopyLimit);
 				match += oCopyLimit - op;
 				op = oCopyLimit;
 			}
@@ -427,7 +707,7 @@ static FORCE_INLINE int LZ4_decompress_generic(
 		} else {
 			LZ4_copy8(op, match);
 			if (length > 16)
-				LZ4_wildCopy(op + 8, match + 8, cpy);
+				LZ4_wildCopy8(op + 8, match + 8, cpy);
 		}
 		op = cpy; /* wildcopy correction */
 	}
diff --git a/lib/lz4/lz4defs.h b/lib/lz4/lz4defs.h
index 1a7fa9d9170f..9f09521fd2a7 100644
--- a/lib/lz4/lz4defs.h
+++ b/lib/lz4/lz4defs.h
@@ -40,6 +40,28 @@
 
 #define FORCE_INLINE __always_inline
 
+/* LZ4_FORCE_O2_GCC_PPC64LE and LZ4_FORCE_O2_INLINE_GCC_PPC64LE
+ * gcc on ppc64le generates an unrolled SIMDized loop for LZ4_wildCopy8,
+ * together with a simple 8-byte copy loop as a fall-back path.
+ * However, this optimization hurts the decompression speed by >30%,
+ * because the execution does not go to the optimized loop
+ * for typical compressible data, and all of the preamble checks
+ * before going to the fall-back path become useless overhead.
+ * This optimization happens only with the -O3 flag, and -O2 generates
+ * a simple 8-byte copy loop.
+ * With gcc on ppc64le, all of the LZ4_decompress_* and LZ4_wildCopy8
+ * functions are annotated with __attribute__((optimize("O2"))),
+ * and also LZ4_wildCopy8 is forcibly inlined, so that the O2 attribute
+ * of LZ4_wildCopy8 does not affect the compression speed.
+ */
+#if defined(__PPC64__) && defined(__LITTLE_ENDIAN__) && defined(__GNUC__) && !defined(__clang__)
+#  define FORCE_O2_GCC_PPC64LE __attribute__((optimize("O2")))
+#  define FORCE_O2_INLINE_GCC_PPC64LE (__attribute__((optimize("O2"))) FORCE_INLINE)
+#else
+#  define FORCE_O2_GCC_PPC64LE
+#  define FORCE_O2_INLINE_GCC_PPC64LE
+#endif
+
 /*-************************************
  *	Basic Types
  **************************************/
@@ -99,6 +121,9 @@ typedef uintptr_t uptrval;
 #define RUN_BITS (8 - ML_BITS)
 #define RUN_MASK ((1U << RUN_BITS) - 1)
 
+static const unsigned inc32table[8] = { 0, 1, 2, 1, 0, 4, 4, 4 };
+static const int dec64table[8] = { 0, 0, 0, -1, -4, 1, 2, 3 };
+
 /*-************************************
  *	Reading and writing into memory
  **************************************/
@@ -156,7 +181,7 @@ static FORCE_INLINE void LZ4_copy8(void *dst, const void *src)
  * customized variant of memcpy,
  * which can overwrite up to 7 bytes beyond dstEnd
  */
-static FORCE_INLINE void LZ4_wildCopy(void *dstPtr,
+static FORCE_O2_INLINE_GCC_PPC64LE void LZ4_wildCopy8(void *dstPtr,
 	const void *srcPtr, void *dstEnd)
 {
 	BYTE *d = (BYTE *)dstPtr;
@@ -220,6 +245,39 @@ static FORCE_INLINE unsigned int LZ4_count(
 	return (unsigned int)(pIn - pStart);
 }
 
+/* Read the variable-length literal or match length.
+ *
+ * ip - pointer to use as input.
+ * lencheck - end ip.  Return an error if ip advances >= lencheck.
+ * loop_check - check ip >= lencheck in body of loop.  Returns loop_error if so.
+ * initial_check - check ip >= lencheck before start of loop.  Returns initial_error if so.
+ * error (output) - error code.  Should be set to 0 before call.
+ */
+typedef enum { loop_error = -2, initial_error = -1, ok = 0} variable_length_error;
+static FORCE_INLINE unsigned read_variable_length(const BYTE **ip,
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
+
 typedef enum { noLimit = 0, limitedOutput = 1 } limitedOutput_directive;
 typedef enum { byPtr, byU32, byU16 } tableType_t;
 
diff --git a/lib/lz4/lz4hc_compress.c b/lib/lz4/lz4hc_compress.c
index 176f03b83e56..e02e041a01d9 100644
--- a/lib/lz4/lz4hc_compress.c
+++ b/lib/lz4/lz4hc_compress.c
@@ -293,7 +293,7 @@ static FORCE_INLINE int LZ4HC_encodeSequence(
 		*token = (BYTE)(length<<ML_BITS);
 
 	/* Copy Literals */
-	LZ4_wildCopy(*op, *anchor, (*op) + length);
+	LZ4_wildCopy8(*op, *anchor, (*op) + length);
 	*op += length;
 
 	/* Encode Offset */
-- 
2.17.1

