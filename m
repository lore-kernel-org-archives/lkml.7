Return-Path: <SRS0=rNeM=SR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 236B9C10F0E
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 11:09:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EE92E20848
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 11:09:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727289AbfDOLJj convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Apr 2019 07:09:39 -0400
Received: from mga06.intel.com ([134.134.136.31]:44216 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726359AbfDOLJj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Apr 2019 07:09:39 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 15 Apr 2019 04:09:38 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,353,1549958400"; 
   d="scan'208";a="150967757"
Received: from irsmsx101.ger.corp.intel.com ([163.33.3.153])
  by orsmga002.jf.intel.com with ESMTP; 15 Apr 2019 04:09:37 -0700
Received: from irsmsx104.ger.corp.intel.com ([169.254.5.44]) by
 IRSMSX101.ger.corp.intel.com ([169.254.1.115]) with mapi id 14.03.0415.000;
 Mon, 15 Apr 2019 12:09:36 +0100
From:   "Rojewski, Cezary" <cezary.rojewski@intel.com>
To:     "stefani@seibold.net" <stefani@seibold.net>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [RFC] kfifo: Add support for copying to and from IO space.
Thread-Topic: [RFC] kfifo: Add support for copying to and from IO space.
Thread-Index: AdTzeUdD9OBJi2hDRue45y3Us1ta6AAARshA
Date:   Mon, 15 Apr 2019 11:09:35 +0000
Message-ID: <3BD9CEE4EBD5E74B98FE2D277EB60E0B38F53CB6@IRSMSX104.ger.corp.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ctpclassification: CTP_NT
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiYjNlOTU2NDItNDI1OS00ZGQ5LWJlYTgtNTA5MzNjYTkxZWU0IiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoiTTlPNldQNjl0VUlsY1lVQ0JFc21SWFRnRjVPcEpUbStabzZrNHArZGJsYUpyNHhmeFRZQjFzRFppVWs5aGhuQSJ9
dlp-product: dlpe-windows
dlp-version: 11.0.600.7
dlp-reaction: no-action
x-originating-ip: [163.33.239.182]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Behind the scenes kfifo_in and kfifo_out use memcpy explicitly. This is
not suitable when dealing with IO space. Declare simple IO equivalents in
form of kfifo_fromio and kfifo_toio which make use of memcpy_fromio and
memcpy_toio respectively. While doing so, don't forget about their
spinlocked friends.

Additional thoughts:

As one can see, this code is mostly borrowed from kfifo_in and kfifo_out.
Wanted to avoid any duplications at the beginning, yet to do so, function
pointer would have to be provided as function parameter. That is, for some
base, "generic" function that would handle memcpy - given the pointer - from
that point onward. memcpy_fromio / memcpy_toio have different declarations
compared to memcpy, what impacts their caller declaration, thus this idea
quickly cease to exist.

Why no macros? While meta approach is suitable for most kfifos, when it comes
to IO space everyone simply operates on bytes and there is already basic kfifo
struct for that defined in the very kfifo.h header file. Need no more.

Why no esize? Same as for previous one. Since we are dealing with unsigned
chars here, I believe there is no need to complicate kfifo_fromio/ kfifo_toio
implementation with them.

I might be wrong with all or none of above. Feedback is greatly appreciated.
Documentation is missing - will be added later if idea is accepted, in non-RFC
mail.


Signed-off-by: Cezary Rojewski <cezary.rojewski@intel.com>
---
 include/linux/kfifo.h | 32 ++++++++++++++++++++
 lib/kfifo.c           | 68 +++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 100 insertions(+)

diff --git a/include/linux/kfifo.h b/include/linux/kfifo.h index 89fc8dc7bf38..db1a1b6a3d8a 100644
--- a/include/linux/kfifo.h
+++ b/include/linux/kfifo.h
@@ -769,6 +769,38 @@ __kfifo_uint_must_check_helper( \
 }) \
 )
 
+extern unsigned int kfifo_fromio(struct kfifo *fifo,
+	const void __iomem *addr, unsigned int len);
+
+static inline unsigned int
+kfifo_fromio_spinlocked(struct kfifo *fifo, const void __iomem *addr,
+		unsigned int len, spinlock_t *lock)
+{
+	unsigned long flags;
+	unsigned int ret;
+
+	spin_lock_irqsave(lock, flags);
+	ret = kfifo_fromio(fifo, addr, len);
+	spin_unlock_irqrestore(lock, flags);
+	return ret;
+}
+
+extern unsigned int kfifo_toio(struct kfifo *fifo,
+	void __iomem *addr, unsigned int len);
+
+static inline unsigned int __must_check kfifo_toio_spinlocked(struct 
+kfifo *fifo, void __iomem *addr,
+		unsigned int len, spinlock_t *lock)
+{
+	unsigned long flags;
+	unsigned int ret;
+
+	spin_lock_irqsave(lock, flags);
+	ret = kfifo_toio(fifo, addr, len);
+	spin_unlock_irqrestore(lock, flags);
+	return ret;
+}
+
 extern int __kfifo_alloc(struct __kfifo *fifo, unsigned int size,
 	size_t esize, gfp_t gfp_mask);
 
diff --git a/lib/kfifo.c b/lib/kfifo.c
index 015656aa8182..f7009326adf3 100644
--- a/lib/kfifo.c
+++ b/lib/kfifo.c
@@ -138,6 +138,74 @@ unsigned int __kfifo_in(struct __kfifo *fifo,  }  EXPORT_SYMBOL(__kfifo_in);
 
+static void kfifo_copy_fromio(struct __kfifo *fifo, const void __iomem *src,
+		unsigned int len, unsigned int off)
+{
+	unsigned int size = fifo->mask + 1;
+	unsigned int l;
+
+	off &= fifo->mask;
+	l = min(len, size - off);
+
+	memcpy_fromio(fifo->data + off, src, l);
+	memcpy_fromio(fifo->data, src + l, len - l);
+	/*
+	 * make sure that the data in the fifo is up to date before
+	 * incrementing the fifo->in index counter
+	 */
+	smp_wmb();
+}
+
+unsigned int kfifo_fromio(struct kfifo *fifo,
+		const void __iomem *addr, unsigned int len) {
+	struct __kfifo *__fifo = &fifo->kfifo;
+	unsigned int l;
+
+	l = kfifo_unused(__fifo);
+	if (len > l)
+		len = l;
+
+	kfifo_copy_fromio(__fifo, addr, len, __fifo->in);
+	__fifo->in += len;
+	return len;
+}
+EXPORT_SYMBOL(kfifo_fromio);
+
+static void kfifo_copy_toio(struct __kfifo *fifo, void __iomem *dst,
+		unsigned int len, unsigned int off)
+{
+	unsigned int size = fifo->mask + 1;
+	unsigned int l;
+
+	off &= fifo->mask;
+	l = min(len, size - off);
+
+	memcpy_toio(dst, fifo->data + off, l);
+	memcpy_toio(dst + l, fifo->data, len - l);
+	/*
+	 * make sure that the data is copied before
+	 * incrementing the fifo->out index counter
+	 */
+	smp_wmb();
+}
+
+unsigned int __must_check kfifo_toio(struct kfifo *fifo,
+		void __iomem *addr, unsigned int len) {
+	struct __kfifo *__fifo = &fifo->kfifo;
+	unsigned int l;
+
+	l = __fifo->in - __fifo->out;
+	if (len > l)
+		len = l;
+
+	kfifo_copy_toio(__fifo, addr, len, __fifo->out);
+	__fifo->out += len;
+	return len;
+}
+EXPORT_SYMBOL(kfifo_toio);
+
 static void kfifo_copy_out(struct __kfifo *fifo, void *dst,
 		unsigned int len, unsigned int off)
 {
--
2.17.1

