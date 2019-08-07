Return-Path: <SRS0=/Haq=WD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0
	tests=BUG6152_INVALID_DATE_TZ_ABSURD,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,INVALID_DATE_TZ_ABSURD,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35C67C433FF
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Aug 2019 22:27:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0FDC7214C6
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Aug 2019 22:27:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389474AbfHGW1S (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Aug 2019 18:27:18 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:51810 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388848AbfHGW1S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Aug 2019 18:27:18 -0400
Received: from [5.158.153.52] (helo=g2noscherz.tec.linutronix.de.)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA1:256)
        (Exim 4.80)
        (envelope-from <john.ogness@linutronix.de>)
        id 1hvUOa-0007mg-KE; Thu, 08 Aug 2019 00:27:02 +0200
From:   John Ogness <john.ogness@linutronix.de>
To:     linux-kernel@vger.kernel.org
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrea Parri <andrea.parri@amarulasolutions.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Brendan Higgins <brendanhiggins@google.com>
Subject: [RFC PATCH v4 4/9] printk-rb: initialize new descriptors as invalid
Date:   Thu,  8 Aug 2019 00:32:29 +0206
Message-Id: <20190807222634.1723-5-john.ogness@linutronix.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190807222634.1723-1-john.ogness@linutronix.de>
References: <20190807222634.1723-1-john.ogness@linutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Initialize never-used descriptors as permanently invalid so there
is no risk of the descriptor unexpectedly being determined as
valid due to dataring head overflowing/wrapping.

Signed-off-by: John Ogness <john.ogness@linutronix.de>
---
 kernel/printk/dataring.c   | 42 +++++++++++++++++++++++++++-----------
 kernel/printk/dataring.h   | 12 +++++++++++
 kernel/printk/ringbuffer.c |  5 +++++
 kernel/printk/ringbuffer.h |  7 ++++++-
 4 files changed, 53 insertions(+), 13 deletions(-)

diff --git a/kernel/printk/dataring.c b/kernel/printk/dataring.c
index 6642e085a05d..345c46dba5bb 100644
--- a/kernel/printk/dataring.c
+++ b/kernel/printk/dataring.c
@@ -316,8 +316,8 @@ static unsigned long _dataring_pop(struct dataring *dr,
 	 * If dB reads from gA, then dD reads from fH.
 	 * If dB reads from gA, then dE reads from fE.
 	 *
-	 * Note that if dB reads from gA, then dC cannot read from fC.
-	 * Note that if dB reads from gA, then dD cannot read from fD.
+	 * Note that if dB reads from gA, then dC cannot read from fC->nA.
+	 * Note that if dB reads from gA, then dD cannot read from fC->nB.
 	 *
 	 * Relies on:
 	 *
@@ -489,6 +489,30 @@ static bool get_new_lpos(struct dataring *dr, unsigned int size,
 	}
 }
 
+/**
+ * dataring_desc_init() - Initialize a descriptor to be permanently invalid.
+ *
+ * @desc: The descriptor to initialize.
+ *
+ * Setting a descriptor to be permanently invalid means that there is no risk
+ * of the descriptor later unexpectedly being determined as valid due to
+ * overflowing/wrapping of @head_lpos.
+ */
+void dataring_desc_init(struct dr_desc *desc)
+{
+	/*
+	 * An unaligned @begin_lpos can never point to a data block and
+	 * having the same value for @begin_lpos and @next_lpos is also
+	 * invalid.
+	 */
+
+	/* nA: */
+	WRITE_ONCE(desc->begin_lpos, 1);
+
+	/* nB: */
+	WRITE_ONCE(desc->next_lpos, 1);
+}
+
 /**
  * dataring_push() - Reserve a data block in the data array.
  *
@@ -568,20 +592,14 @@ char *dataring_push(struct dataring *dr, unsigned int size,
 
 		if (!ret) {
 			/*
+			 * fC:
+			 *
 			 * Force @desc permanently invalid to minimize risk
 			 * of the descriptor later unexpectedly being
 			 * determined as valid due to overflowing/wrapping of
-			 * @head_lpos. An unaligned @begin_lpos can never
-			 * point to a data block and having the same value
-			 * for @begin_lpos and @next_lpos is also invalid.
+			 * @head_lpos.
 			 */
-
-			/* fC: */
-			WRITE_ONCE(desc->begin_lpos, 1);
-
-			/* fD: */
-			WRITE_ONCE(desc->next_lpos, 1);
-
+			dataring_desc_init(desc);
 			return NULL;
 		}
 	/* fE: */
diff --git a/kernel/printk/dataring.h b/kernel/printk/dataring.h
index 346a455a335a..413ee95f4dd6 100644
--- a/kernel/printk/dataring.h
+++ b/kernel/printk/dataring.h
@@ -43,6 +43,17 @@ struct dr_desc {
 	unsigned long	next_lpos;
 };
 
+/*
+ * Initialize a descriptor to be permanently invalid so there is no risk
+ * of the descriptor later unexpectedly being determined as valid due to
+ * overflowing/wrapping of @head_lpos.
+ */
+#define __DR_DESC_INITIALIZER		\
+	{				\
+		.begin_lpos	= 1,	\
+		.next_lpos	= 1,	\
+	}
+
 /**
  * struct dataring - A data ringbuffer with support for entry IDs.
  *
@@ -90,6 +101,7 @@ void dataring_datablock_setid(struct dataring *dr, struct dr_desc *desc,
 struct dr_datablock *dataring_getdatablock(struct dataring *dr,
 					   struct dr_desc *desc, int *size);
 bool dataring_datablock_isvalid(struct dataring *dr, struct dr_desc *desc);
+void dataring_desc_init(struct dr_desc *desc);
 void dataring_desc_copy(struct dr_desc *dst, struct dr_desc *src);
 
 #endif /* _KERNEL_PRINTK_DATARING_H */
diff --git a/kernel/printk/ringbuffer.c b/kernel/printk/ringbuffer.c
index b9fc13597b10..9be841761ea2 100644
--- a/kernel/printk/ringbuffer.c
+++ b/kernel/printk/ringbuffer.c
@@ -345,6 +345,11 @@ static bool assign_desc(struct prb_reserved_entry *e)
 			if (i < DESCS_COUNT(rb)) {
 				d = &rb->descs[i];
 				atomic_long_set(&d->id, i);
+				/*
+				 * Initialize the new descriptor such that
+				 * it is permanently invalid.
+				 */
+				dataring_desc_init(&d->desc);
 				break;
 			}
 		}
diff --git a/kernel/printk/ringbuffer.h b/kernel/printk/ringbuffer.h
index 9fe54a09fbc2..462b4d3a3ee2 100644
--- a/kernel/printk/ringbuffer.h
+++ b/kernel/printk/ringbuffer.h
@@ -178,7 +178,12 @@ struct dr_desc *prb_getdesc(unsigned long id, void *arg);
 char _##name##_data[(1 << ((avgdatabits) + (descbits))) +		\
 				 sizeof(long)]				\
 	__aligned(__alignof__(long));					\
-struct prb_desc _##name##_descs[1 << (descbits)];			\
+struct prb_desc _##name##_descs[1 << (descbits)] = {			\
+		{							\
+			.id	= ATOMIC_LONG_INIT(0),			\
+			.desc	= __DR_DESC_INITIALIZER,		\
+		},							\
+	};								\
 struct printk_ringbuffer name = {					\
 	.desc_count_bits	= descbits,				\
 	.descs			= &_##name##_descs[0],			\
-- 
2.20.1

