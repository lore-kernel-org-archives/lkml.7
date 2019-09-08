Return-Path: <SRS0=sd1o=XD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E040FC4332F
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Sep 2019 06:29:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ACF4F214DB
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Sep 2019 06:29:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (4096-bit key) header.d=kolabnow.com header.i=@kolabnow.com header.b="DTQLkRYy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728404AbfIHG3H (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 8 Sep 2019 02:29:07 -0400
Received: from mx.kolabnow.com ([95.128.36.42]:3938 "EHLO mx.kolabnow.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725844AbfIHG3H (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Sep 2019 02:29:07 -0400
Received: from localhost (unknown [127.0.0.1])
        by ext-mx-out003.mykolab.com (Postfix) with ESMTP id 4A0C54053A;
        Sun,  8 Sep 2019 08:29:05 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kolabnow.com; h=
        content-transfer-encoding:mime-version:message-id:date:date
        :subject:subject:from:from:received:received:received; s=
        dkim20160331; t=1567924144; x=1569738545; bh=IDdnHi1R5fjcjWMd+Ah
        iszr3G9hOkBsHRfzixT980PY=; b=DTQLkRYyZuu1uiDVlN034v1fmegX+oc8uyO
        N1wuZLWSLzDKdVBJKLCmjrYdFYNFytMJigaIGvO2LVfVpq08jnlqKmRrJX1vt92E
        ilA+O2a6zBNXD3Nbnr7LWeXJ8xfAGKljnsxSjF7H12UKYTyJtf5+CVkDwI2LUdbV
        nBi48lHTVFztL8OEC7Y83cD/nLlP2I1S94czcNIJNO70SMF5VLZCyKW21vVJ62Vm
        XrH4PrnPKcrkqUiTxkcRJulYtas/Y8K30XdLra+NNdJuGiLmuJT0s069DXS5P/+v
        9n7dkMW/hgQIBdGbDyIOj+B9Py23iwBtDYT0NZnj/unmV/mXM4lNIvALF69sFusE
        drNofU2Yh4EnptdS3AFU4PaiLJgfQHhitEGLAGO/tobHmnT648BeJSYeSZRDUF4/
        Fm531GJKns0Lx7EGMAWw6rzg12f3ZHxmklznXa0jtqvLGQtBJrYHLUuR5e8Ej7HS
        UTFPlbgDgiC2ygldeBArXTVsQFHRsB/XTkfI99UkBRaUHV67suqgOu42oNGCiilu
        LkltLx/N7Zw3Va/2hT6xpF57fhy6uqsw/Sfk3NoNuEKr+13LDK/L9s5DVv046cP4
        gOMkSNTTXtYTgWooNvueiSnwT13F45CIFuWtFEplnDf1eLbx/pqR3izpAb+Wcl55
        DkbSPLpQ=
X-Virus-Scanned: amavisd-new at mykolab.com
Received: from mx.kolabnow.com ([127.0.0.1])
        by localhost (ext-mx-out003.mykolab.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id VQGp1COnr6Ls; Sun,  8 Sep 2019 08:29:04 +0200 (CEST)
Received: from int-mx003.mykolab.com (unknown [10.9.13.3])
        by ext-mx-out003.mykolab.com (Postfix) with ESMTPS id B0B46404DA;
        Sun,  8 Sep 2019 08:29:04 +0200 (CEST)
Received: from ext-subm002.mykolab.com (unknown [10.9.6.2])
        by int-mx003.mykolab.com (Postfix) with ESMTPS id 434983EAE;
        Sun,  8 Sep 2019 08:29:04 +0200 (CEST)
From:   Federico Vaga <federico.vaga@vaga.pv.it>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        Federico Vaga <federico.vaga@vaga.pv.it>
Subject: [PATCH v3] doc:lock: remove reference to clever use of read-write lock
Date:   Sun,  8 Sep 2019 08:29:01 +0200
Message-Id: <20190908062901.4218-1-federico.vaga@vaga.pv.it>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove the clever example about read-write lock because this type of
lock is not reccomended anymore (according to the very same document).
So there is no reason to teach cleaver things that people should not do.

Signed-off-by: Federico Vaga <federico.vaga@vaga.pv.it>
---
 Documentation/locking/spinlocks.rst | 12 ------------
 1 file changed, 12 deletions(-)

diff --git a/Documentation/locking/spinlocks.rst b/Documentation/locking/spinlocks.rst
index e93ec6645238..66e3792f8a36 100644
--- a/Documentation/locking/spinlocks.rst
+++ b/Documentation/locking/spinlocks.rst
@@ -139,18 +139,6 @@ on other CPU's, because an interrupt on another CPU doesn't interrupt the
 CPU that holds the lock, so the lock-holder can continue and eventually
 releases the lock).
 
-Note that you can be clever with read-write locks and interrupts. For
-example, if you know that the interrupt only ever gets a read-lock, then
-you can use a non-irq version of read locks everywhere - because they
-don't block on each other (and thus there is no dead-lock wrt interrupts.
-But when you do the write-lock, you have to use the irq-safe version.
-
-For an example of being clever with rw-locks, see the "waitqueue_lock"
-handling in kernel/sched/core.c - nothing ever _changes_ a wait-queue from
-within an interrupt, they only read the queue in order to know whom to
-wake up. So read-locks are safe (which is good: they are very common
-indeed), while write-locks need to protect themselves against interrupts.
-
 		Linus
 
 ----
-- 
2.21.0

