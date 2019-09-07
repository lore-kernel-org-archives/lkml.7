Return-Path: <SRS0=QEJJ=XC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09E45C43331
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Sep 2019 10:48:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C4F1920854
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Sep 2019 10:48:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (4096-bit key) header.d=kolabnow.com header.i=@kolabnow.com header.b="yJ+1PZLi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388924AbfIGKst (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 7 Sep 2019 06:48:49 -0400
Received: from mx.kolabnow.com ([95.128.36.42]:58222 "EHLO mx.kolabnow.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726027AbfIGKss (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Sep 2019 06:48:48 -0400
Received: from localhost (unknown [127.0.0.1])
        by ext-mx-out001.mykolab.com (Postfix) with ESMTP id 916304CA;
        Sat,  7 Sep 2019 12:48:45 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kolabnow.com; h=
        content-transfer-encoding:mime-version:message-id:date:date
        :subject:subject:from:from:received:received:received; s=
        dkim20160331; t=1567853325; x=1569667726; bh=s4gr8NLGKecf6qvFVJs
        NMewjZepELQCEmC/ws5mgdw0=; b=yJ+1PZLisVt1Mk2jAkVTTZs44KA8dKSwy5l
        GKfl4pFO7CC5JtGtEnQbHWG3M3NR/h80e115G/UynZszdNBfOjeZNG4lJXErt21W
        7r3DEzgFETPaeSx+viq6HZIQdU/6sQJh51tumLWIB060X5+JziOwk3cnSF7zFzN2
        gKPwNVVptvUyDRmbAjspypVAaY1PyiyHhLri1C/hXIcc1XAYoXnrIrTSi7paIUfm
        nclOa22/V7dSN65wV/nr/ZcVvGuvYH/luq/tUK8FNjOxWVnrooLhnizQ89Efc1ZG
        1BJcPQG11ynq2HGV3x6nUgbVQMfl18q0lOvUHK7wMsvhpYuQSptnCSStGpyQ88uC
        ui0RIlh46ftpGRFNmxFfKoeRZ4cANwLDguF938ATZb9ipfsRqWAEWPAN468ai2I7
        pTSWEcKdFa1IXt93ZQOWVZo4XW3MSoHSXJnJZ1/l2sl1f6kgly9EFSqXOnxPqo95
        kQosSfSuuIW79HcXrLkQ6PI7u31H6ZutY/XyT+Tm0MvyZp01zx66uVN1F7mLIF5G
        ZnL903DBcR6Wgtuv7XOT7xazOn13jrUMswZeRhu0s71vhLtwsJnT4HLQzeBazchx
        4/ACdnbel5Pevxed6bJL147A3c5jsQSpLCaiwYITYmg3+5sBpURq2aXGUQHSaAB9
        DL3Us1ys=
X-Virus-Scanned: amavisd-new at mykolab.com
Received: from mx.kolabnow.com ([127.0.0.1])
        by localhost (ext-mx-out001.mykolab.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id x1c4Vl1SHofg; Sat,  7 Sep 2019 12:48:45 +0200 (CEST)
Received: from int-mx001.mykolab.com (unknown [10.9.13.1])
        by ext-mx-out001.mykolab.com (Postfix) with ESMTPS id 164092DE;
        Sat,  7 Sep 2019 12:48:44 +0200 (CEST)
Received: from ext-subm003.mykolab.com (unknown [10.9.6.3])
        by int-mx001.mykolab.com (Postfix) with ESMTPS id A0EEF125D;
        Sat,  7 Sep 2019 12:48:44 +0200 (CEST)
From:   Federico Vaga <federico.vaga@vaga.pv.it>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        Federico Vaga <federico.vaga@vaga.pv.it>
Subject: [PATCH v2] doc:lock: remove reference to clever use of read-write lock
Date:   Sat,  7 Sep 2019 12:48:41 +0200
Message-Id: <20190907104841.18928-1-federico.vaga@vaga.pv.it>
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

