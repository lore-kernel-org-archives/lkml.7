Return-Path: <SRS0=k4ck=W3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C285FC3A5A6
	for <linux-kernel@archiver.kernel.org>; Sat, 31 Aug 2019 13:41:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 92DF1217D7
	for <linux-kernel@archiver.kernel.org>; Sat, 31 Aug 2019 13:41:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (4096-bit key) header.d=kolabnow.com header.i=@kolabnow.com header.b="YJlXYID/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728278AbfHaNlu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 31 Aug 2019 09:41:50 -0400
Received: from mx.kolabnow.com ([95.128.36.42]:11244 "EHLO mx.kolabnow.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726354AbfHaNlu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 31 Aug 2019 09:41:50 -0400
Received: from localhost (unknown [127.0.0.1])
        by ext-mx-out003.mykolab.com (Postfix) with ESMTP id 7D537403FB;
        Sat, 31 Aug 2019 15:41:46 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kolabnow.com; h=
        content-transfer-encoding:mime-version:message-id:date:date
        :subject:subject:from:from:received:received:received; s=
        dkim20160331; t=1567258905; x=1569073306; bh=RVPkgbu0sxV6mcZJE0j
        Oj7nmkVC+BNiaQ+8xHqgLNmM=; b=YJlXYID/w1UXyY4/Qpx9k/1UH1lvxS27JKB
        72vjWrrJbs+ltJOrFmL7hPz6FU+gG91pIGJlbsMmd4tHvmtvJeVg9CnFF0d5Iwep
        CYU1Ly40rHajx0W//Icob0D2hWH7kZgysrumuKMuT7vBZ9+ead5hUoG9mAYzufKK
        zN4Ac75vUNzqI+Nz7/QRz/7MqW87WxogUZeDC6TqpRmIcRPDN+r9hwblkFYa2gfA
        PxKTbRP2qeaWKUMHWPHk/IPf+cfxdifpZGDZpiBIoHAc358bxBX3xmi/X5lSOq95
        0CcJF+86AKuq5g52XXGGMGwYvQfT706R1RwxGhW7jaUJibSfI2jz6nD4xxzKM9GE
        mNZ+VxMasTVtwceyERpCujlUGJBdng+VG6AYwFBXWQe0KEUkRk1YQjmPRO2jm/LG
        v5+9p6ufhuYzyVTAjPgS3EEKH/qMkwTq+2aemMpxFq7PCqx3Hw5w1bETuIeil4Ev
        Cp4snbhf6LKjly2/AgK0rrfsCulrqyx59uX6+jiB9UADZJKFYBTAgxc1xBfVrC5B
        lBdcEjsVve7wnhCWutZcVeMVasqh3gckFqThHpTGy69lbdZpF27NiPxBjjbmzyfU
        B18phR57oiVK+UHsUltHnCsFbTi5er/SB7j+xylhGlguW5bu7OzAOEpugWWDIXZQ
        Yo59BX4U=
X-Virus-Scanned: amavisd-new at mykolab.com
Received: from mx.kolabnow.com ([127.0.0.1])
        by localhost (ext-mx-out003.mykolab.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id Qoz9PPGpPg2l; Sat, 31 Aug 2019 15:41:45 +0200 (CEST)
Received: from int-mx001.mykolab.com (unknown [10.9.13.1])
        by ext-mx-out003.mykolab.com (Postfix) with ESMTPS id BBA42403EB;
        Sat, 31 Aug 2019 15:41:45 +0200 (CEST)
Received: from ext-subm003.mykolab.com (unknown [10.9.6.3])
        by int-mx001.mykolab.com (Postfix) with ESMTPS id 3591A246A;
        Sat, 31 Aug 2019 15:41:45 +0200 (CEST)
From:   Federico Vaga <federico.vaga@vaga.pv.it>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        Federico Vaga <federico.vaga@vaga.pv.it>
Subject: [PATCH] doc:lock: remove reference to clever use of read-write lock
Date:   Sat, 31 Aug 2019 15:41:16 +0200
Message-Id: <20190831134116.25417-1-federico.vaga@vaga.pv.it>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove the clever example about read-write lock because these type of
lock is not reccomended anymore (according to the very same document).
So there is no reason to teach cleaver things that people should not do.

(and by the way there was a little typo)

Signed-off-by: Federico Vaga <federico.vaga@vaga.pv.it>
---
 Documentation/locking/spinlocks.rst | 14 +-------------
 1 file changed, 1 insertion(+), 13 deletions(-)

diff --git a/Documentation/locking/spinlocks.rst b/Documentation/locking/spinlocks.rst
index e93ec6645238..8053fd4c3544 100644
--- a/Documentation/locking/spinlocks.rst
+++ b/Documentation/locking/spinlocks.rst
@@ -106,7 +106,7 @@ and on other architectures it can be worse).
 
 If you have a case where you have to protect a data structure across
 several CPU's and you want to use spinlocks you can potentially use
-cheaper versions of the spinlocks. IFF you know that the spinlocks are
+cheaper versions of the spinlocks. If you know that the spinlocks are
 never used in interrupt handlers, you can use the non-irq versions::
 
 	spin_lock(&lock);
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

