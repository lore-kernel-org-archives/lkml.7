Return-Path: <SRS0=fSNO=YI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A566EECE59D
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Oct 2019 22:57:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 617DD20873
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Oct 2019 22:57:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mCWYtCkM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387612AbfJOW5q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Oct 2019 18:57:46 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:38550 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727120AbfJOW5p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Oct 2019 18:57:45 -0400
Received: by mail-wr1-f68.google.com with SMTP id y18so16279929wrn.5
        for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2019 15:57:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=dxsR+jE7HQ+WwH+XNT4goBtNaDbshv4XV8JQAUdUe/Y=;
        b=mCWYtCkMlxCQLcNFRhscJ1ikgpdYrHHAxxvJNrjS9S75FvygxTgBv7Ibzm5m09JXFK
         JNfYmSGWe+Byu4hPnLmJWifBxS1xcDe8pa+zNxzf1l7nsow01mpBy1xYL6pmyO+vCQ9h
         sUmwcnXDqIk1Pj+OMGetWdzWd2lhNVVA0bDOQWaa+OnqvObmSw5U6YtGioCDKRbYhGl2
         v/ol+6DivktrI1vT45Zx4D4oBsYEVWDZ98a0fiQD/putQk93O3/jj+U9Pmu5UD7jbb9I
         1xZKPLxroi6/0SMouMoHVddLj6ivPoyjx/2LIhbH3PjV5hF/YTDkHY5GoC+dzt50qEF1
         HF7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=dxsR+jE7HQ+WwH+XNT4goBtNaDbshv4XV8JQAUdUe/Y=;
        b=LTGZVjgenUCcRYpM6yMGY2+V2cjlv8ym4ZA7IKIe3+GglPnn1ygQTdKHJhTByPanm8
         LD5im9+6CUWUaZSN9GIGJoHA0JNJ+HHFb7WWI4XmmhPGCzu44UOYgIExaQxlq9OGKK06
         2t8LS0o7vREKlWYrJFVaspkHxbBQJISGb+Gm6N+kLrvmBc0XvgMjTYTqsIxvzZQOPmDB
         pEgmBCBo+q+OQsjZrjcQdiapnEly4FQ8YcB83fS/8qDu1obro9cE50LBiZsn08/W2HBK
         4UmcItLH6AY43T9QHoHA2OJDCwwc1ec0PLUuFkAibHAOS2MreUzTYLMv1C9BQI+3ChaC
         knMA==
X-Gm-Message-State: APjAAAWbBcdWFWiAV7rszVZoRqvhsA83z2Xq+tavwGQWQoiZrpgw0SDe
        JDZJXT8deElhq1bWmLFLWA==
X-Google-Smtp-Source: APXvYqxTkw7MiBW3P+2HgzrNX82Rmz2hAKkCFbk+A2y/km9QlmMAqxHlGBeNELopUOF9q2jfF5l5rw==
X-Received: by 2002:adf:c641:: with SMTP id u1mr564599wrg.361.1571180262270;
        Tue, 15 Oct 2019 15:57:42 -0700 (PDT)
Received: from ninjahub.lan (host-2-102-13-201.as13285.net. [2.102.13.201])
        by smtp.googlemail.com with ESMTPSA id e3sm530596wme.39.2019.10.15.15.57.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Oct 2019 15:57:41 -0700 (PDT)
From:   Jules Irenge <jbi.octave@gmail.com>
To:     outreachy-kernel@googlegroups.com
Cc:     eric@anholt.net, wahrenst@gmx.net, gregkh@linuxfoundation.org,
        bcm-kernel-feedback-list@broadcom.com,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, Jules Irenge <jbi.octave@gmail.com>
Subject: [PATCH] staging: vc04_services: fix line over 80 characters checks warning
Date:   Tue, 15 Oct 2019 23:57:16 +0100
Message-Id: <20191015225716.10563-1-jbi.octave@gmail.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix line over 80 characters checks warning.
Issue detected by checkpatch tool.

Signed-off-by: Jules Irenge <jbi.octave@gmail.com>
---
 .../vc04_services/interface/vchi/vchi_cfg.h   | 150 ++++++++++--------
 1 file changed, 88 insertions(+), 62 deletions(-)

diff --git a/drivers/staging/vc04_services/interface/vchi/vchi_cfg.h b/drivers/staging/vc04_services/interface/vchi/vchi_cfg.h
index 89aa4e6122cd..dbb6a5f07a79 100644
--- a/drivers/staging/vc04_services/interface/vchi/vchi_cfg.h
+++ b/drivers/staging/vc04_services/interface/vchi/vchi_cfg.h
@@ -4,13 +4,17 @@
 #ifndef VCHI_CFG_H_
 #define VCHI_CFG_H_
 
-/****************************************************************************************
- * Defines in this first section are part of the VCHI API and may be examined by VCHI
- * services.
- ***************************************************************************************/
-
-/* Required alignment of base addresses for bulk transfer, if unaligned transfers are not enabled */
-/* Really determined by the message driver, and should be available from a run-time call. */
+/*****************************************************************************
+ * Defines in this first section are part of the VCHI API and may be examined
+ * by VCHI services.
+ *****************************************************************************/
+
+/* Required alignment of base addresses for bulk transfer, if unaligned
+ * transfers are not enabled
+ *
+ * Really determined by the message driver, and should be available from
+ * a run-time call.
+ */
 #ifndef VCHI_BULK_ALIGN
 #   if __VCCOREVER__ >= 0x04000000
 #       define VCHI_BULK_ALIGN 32 // Allows for the need to do cache cleans
@@ -19,12 +23,15 @@
 #   endif
 #endif
 
-/* Required length multiple for bulk transfers, if unaligned transfers are not enabled */
-/* May be less than or greater than VCHI_BULK_ALIGN */
-/* Really determined by the message driver, and should be available from a run-time call. */
+/* Required length multiple for bulk transfers, if unaligned transfers are
+ * not enabled
+ * May be less than or greater than VCHI_BULK_ALIGN
+ * Really determined by the message driver, and should be available from
+ * a run-time call.
+ */
 #ifndef VCHI_BULK_GRANULARITY
 #   if __VCCOREVER__ >= 0x04000000
-#       define VCHI_BULK_GRANULARITY 32 // Allows for the need to do cache cleans
+#	define VCHI_BULK_GRANULARITY 32 // Allows for the need of cache cleans
 #   else
 #       define VCHI_BULK_GRANULARITY 16
 #   endif
@@ -39,19 +46,22 @@
 #   endif
 #endif
 
-/******************************************************************************************
- * Defines below are system configuration options, and should not be used by VCHI services.
- *****************************************************************************************/
+/*******************************************************************************
+ * Defines below are system configuration options, and should not be used by
+ * VCHI services.
+ ******************************************************************************/
 
-/* How many connections can we support? A localhost implementation uses 2 connections,
- * 1 for host-app, 1 for VMCS, and these are hooked together by a loopback MPHI VCFW
- * driver. */
+/* How many connections can we support? A localhost implementation
+ * uses 2 connections, 1 for host-app, 1 for VMCS,
+ * and these are hooked together by a loopback MPHI VCFW  driver.
+ */
 #ifndef VCHI_MAX_NUM_CONNECTIONS
 #   define VCHI_MAX_NUM_CONNECTIONS 3
 #endif
 
-/* How many services can we open per connection? Extending this doesn't cost processing time, just a small
- * amount of static memory. */
+/* How many services can we open per connection? Extending this doesn't cost
+ * processing time, just a small amount of static memory.
+ */
 #ifndef VCHI_MAX_SERVICES_PER_CONNECTION
 #  define VCHI_MAX_SERVICES_PER_CONNECTION 36
 #endif
@@ -66,8 +76,9 @@
 #   define VCHI_MAX_BULK_RX_CHANNELS_PER_CONNECTION 1 // 1 MPHI
 #endif
 
-/* How many receive slots do we use. This times VCHI_MAX_MSG_SIZE gives the effective
- * receive queue space, less message headers. */
+/* How many receive slots do we use. This times VCHI_MAX_MSG_SIZE gives
+ * the effective receive queue space, less message headers.
+ */
 #ifndef VCHI_NUM_READ_SLOTS
 #  if defined(VCHI_LOCAL_HOST_PORT)
 #     define VCHI_NUM_READ_SLOTS 4
@@ -76,92 +87,107 @@
 #  endif
 #endif
 
-/* Do we utilise overrun facility for receive message slots? Can aid peer transmit
- * performance. Only define on VideoCore end, talking to host.
+/* Do we utilise overrun facility for receive message slots? Can aid peer
+ * transmit performance. Only define on VideoCore end, talking to host.
  */
 //#define VCHI_MSG_RX_OVERRUN
 
-/* How many transmit slots do we use. Generally don't need many, as the hardware driver
- * underneath VCHI will usually have its own buffering. */
+/* How many transmit slots do we use. Generally don't need many,
+ * as the hardware driver underneath VCHI will usually have its own buffering
+ */
 #ifndef VCHI_NUM_WRITE_SLOTS
 #  define VCHI_NUM_WRITE_SLOTS 4
 #endif
 
-/* If a service has held or queued received messages in VCHI_XOFF_THRESHOLD or more slots,
- * then it's taking up too much buffer space, and the peer service will be told to stop
- * transmitting with an XOFF message. For this to be effective, the VCHI_NUM_READ_SLOTS
- * needs to be considerably bigger than VCHI_NUM_WRITE_SLOTS, or the transmit latency
- * is too high. */
+/* If a service has held or queued received messages in VCHI_XOFF_THRESHOLD
+ * or more slots, then it's taking up too much buffer space, and the peer
+ * service will be told to stop transmitting with an XOFF message.
+ * For this to be effective, the VCHI_NUM_READ_SLOTS needs to be considerably
+ * bigger than VCHI_NUM_WRITE_SLOTS, or the transmit latency is too high.
+ */
 #ifndef VCHI_XOFF_THRESHOLD
 #  define VCHI_XOFF_THRESHOLD (VCHI_NUM_READ_SLOTS / 2)
 #endif
 
-/* After we've sent an XOFF, the peer will be told to resume transmission once the local
- * service has dequeued/released enough messages that it's now occupying
- * VCHI_XON_THRESHOLD slots or fewer. */
+/* After we've sent an XOFF, the peer will be told to resume transmission once
+ * the local service has dequeued/released enough messages that it's now
+ * occupying VCHI_XON_THRESHOLD slots or fewer.
+ */
 #ifndef VCHI_XON_THRESHOLD
 #  define VCHI_XON_THRESHOLD (VCHI_NUM_READ_SLOTS / 4)
 #endif
 
-/* A size below which a bulk transfer omits the handshake completely and always goes
- * via the message channel, if bulk auxiliary is being sent on that service. (The user
- * can guarantee this by enabling unaligned transmits).
- * Not API. */
+/* A size below which a bulk transfer omits the handshake completely and always
+ * goes via the message channel, if bulk auxiliary is being sent on that
+ * service. (The user can guarantee this by enabling unaligned transmits).
+ * Not API.
+ */
 #ifndef VCHI_MIN_BULK_SIZE
 #  define VCHI_MIN_BULK_SIZE    (VCHI_MAX_MSG_SIZE / 2 < 4096 ? VCHI_MAX_MSG_SIZE / 2 : 4096)
 #endif
 
-/* Maximum size of bulk transmission chunks, for each interface type. A trade-off between
- * speed and latency; the smaller the chunk size the better change of messages and other
- * bulk transmissions getting in when big bulk transfers are happening. Set to 0 to not
- * break transmissions into chunks.
+/* Maximum size of bulk transmission chunks, for each interface type.
+ * A trade-off between speed and latency; the smaller the chunk size
+ * the better change of messages and other bulk transmissions getting
+ * in when big bulk transfers are happening.
+ * Set to 0 to not break transmissions into chunks.
  */
 #ifndef VCHI_MAX_BULK_CHUNK_SIZE_MPHI
 #  define VCHI_MAX_BULK_CHUNK_SIZE_MPHI (16 * 1024)
 #endif
 
-/* NB Chunked CCP2 transmissions violate the letter of the CCP2 spec by using "JPEG8" mode
- * with multiple-line frames. Only use if the receiver can cope. */
+/* NB Chunked CCP2 transmissions violate the letter of the CCP2 spec
+ * by using "JPEG8" mode with multiple-line frames. Only use if the
+ * receiver can cope.
+ */
 #ifndef VCHI_MAX_BULK_CHUNK_SIZE_CCP2
 #  define VCHI_MAX_BULK_CHUNK_SIZE_CCP2 0
 #endif
 
-/* How many TX messages can we have pending in our transmit slots. Once exhausted,
- * vchi_msg_queue will be blocked. */
+/* How many TX messages can we have pending in our transmit slots.
+ * Once exhausted, vchi_msg_queue will be blocked.
+ */
 #ifndef VCHI_TX_MSG_QUEUE_SIZE
 #  define VCHI_TX_MSG_QUEUE_SIZE           256
 #endif
 
-/* How many RX messages can we have parsed in the receive slots. Once exhausted, parsing
- * will be suspended until older messages are dequeued/released. */
+/* How many RX messages can we have parsed in the receive slots.
+ * Once exhausted, parsing
+ * will be suspended until older messages are dequeued/released.
+ */
 #ifndef VCHI_RX_MSG_QUEUE_SIZE
 #  define VCHI_RX_MSG_QUEUE_SIZE           256
 #endif
 
-/* Really should be able to cope if we run out of received message descriptors, by
- * suspending parsing as the comment above says, but we don't. This sweeps the issue
- * under the carpet. */
+/* Really should be able to cope if we run out of received message descriptors,
+ * by suspending parsing as the comment above says, but we don't.
+ * This sweeps the issue under the carpet.
+ */
 #if VCHI_RX_MSG_QUEUE_SIZE < (VCHI_MAX_MSG_SIZE/16 + 1) * VCHI_NUM_READ_SLOTS
 #  undef VCHI_RX_MSG_QUEUE_SIZE
 #  define VCHI_RX_MSG_QUEUE_SIZE ((VCHI_MAX_MSG_SIZE/16 + 1) * VCHI_NUM_READ_SLOTS)
 #endif
 
-/* How many bulk transmits can we have pending. Once exhausted, vchi_bulk_queue_transmit
- * will be blocked. */
+/* How many bulk transmits can we have pending. Once exhausted,
+ * vchi_bulk_queue_transmit  will be blocked.
+ */
 #ifndef VCHI_TX_BULK_QUEUE_SIZE
 #  define VCHI_TX_BULK_QUEUE_SIZE           64
 #endif
 
-/* How many bulk receives can we have pending. Once exhausted, vchi_bulk_queue_receive
- * will be blocked. */
+/* How many bulk receives can we have pending. Once exhausted,
+ * vchi_bulk_queue_receive will be blocked.
+ */
 #ifndef VCHI_RX_BULK_QUEUE_SIZE
 #  define VCHI_RX_BULK_QUEUE_SIZE           64
 #endif
 
-/* A limit on how many outstanding bulk requests we expect the peer to give us. If
- * the peer asks for more than this, VCHI will fail and assert. The number is determined
- * by the peer's hardware - it's the number of outstanding requests that can be queued
- * on all bulk channels. VC3's MPHI peripheral allows 16. */
+/* A limit on how many outstanding bulk requests we expect the peer to give us.
+ * If the peer asks for more than this, VCHI will fail and assert.
+ * The number is determined by the peer's hardware
+ *  - it's the number of outstanding requests that can be queued
+ * on all bulk channels. VC3's MPHI peripheral allows 16.
+ */
 #ifndef VCHI_MAX_PEER_BULK_REQUESTS
 #  define VCHI_MAX_PEER_BULK_REQUESTS       32
 #endif
@@ -173,15 +199,15 @@
 
 #ifndef VCHI_CCP2TX_MANUAL_POWER
 
-/* Timeout (in milliseconds) for putting the CCP2TX interface into IDLE state. Set
- * negative for no IDLE.
+/* Timeout (in milliseconds) for putting the CCP2TX interface into IDLE state.
+ * Set negative for no IDLE.
  */
 #  ifndef VCHI_CCP2TX_IDLE_TIMEOUT
 #    define VCHI_CCP2TX_IDLE_TIMEOUT        5
 #  endif
 
-/* Timeout (in milliseconds) for putting the CCP2TX interface into OFF state. Set
- * negative for no OFF.
+/* Timeout (in milliseconds) for putting the CCP2TX interface into OFF state.
+ * Set negative for no OFF.
  */
 #  ifndef VCHI_CCP2TX_OFF_TIMEOUT
 #    define VCHI_CCP2TX_OFF_TIMEOUT         1000
-- 
2.21.0

