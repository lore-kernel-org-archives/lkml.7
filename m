Return-Path: <SRS0=FHjv=VA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36F11C5B578
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 08:17:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0F303218A3
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 08:17:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="z9RrXjIv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727362AbfGCIRF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Jul 2019 04:17:05 -0400
Received: from terminus.zytor.com ([198.137.202.136]:39749 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727142AbfGCIRE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jul 2019 04:17:04 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x638Grv13200370
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Wed, 3 Jul 2019 01:16:53 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x638Grv13200370
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019061801; t=1562141814;
        bh=C3HDRMLKb7ZFvwJEJA+A1L1B8w6R+VqyTzvzd1W3c8U=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=z9RrXjIvSw7FOoxnijH170pUgTICFTOrSWRAbsiA17IObteLlGCh33Wj0MZG52UDH
         +UEQTtHJjXxRbIE1CcGC8Sn8p5FYAAE6PXXVFt4P0xoFW5EmKqODkOcstJOcp8f3ST
         vkRdl2VR5RP7xcFeIFsqd/vFNxgW2fY40QvzBAdxCsGiWCuKqYLaUv+e2AJEMWfnSf
         4eN3w74ymhbgS08NcMKccVf8d625Fohq4gegDK5KZsxAC6zuDyrlZXxuC+ZL4FF7v7
         qrsBEYrL2eXIdlI7nWJr6FrtzO7PBePjGnB2PqeqyqRqmGOe+AMKCtgP/twzSmugVu
         ZxwFZrdcDLo/Q==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x638Gr6q3200367;
        Wed, 3 Jul 2019 01:16:53 -0700
Date:   Wed, 3 Jul 2019 01:16:53 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Thomas Gleixner <tipbot@zytor.com>
Message-ID: <tip-1d21f2af8571c6a6a44e7c1911780614847b0253@git.kernel.org>
Cc:     marc.zyngier@arm.com, linux-kernel@vger.kernel.org,
        mingo@kernel.org, hpa@zytor.com, tglx@linutronix.de
Reply-To: marc.zyngier@arm.com, mingo@kernel.org,
          linux-kernel@vger.kernel.org, hpa@zytor.com, tglx@linutronix.de
In-Reply-To: <20190628111440.189241552@linutronix.de>
References: <20190628111440.189241552@linutronix.de>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/apic] genirq: Fix misleading synchronize_irq()
 documentation
Git-Commit-ID: 1d21f2af8571c6a6a44e7c1911780614847b0253
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  1d21f2af8571c6a6a44e7c1911780614847b0253
Gitweb:     https://git.kernel.org/tip/1d21f2af8571c6a6a44e7c1911780614847b0253
Author:     Thomas Gleixner <tglx@linutronix.de>
AuthorDate: Fri, 28 Jun 2019 13:11:50 +0200
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Wed, 3 Jul 2019 10:12:29 +0200

genirq: Fix misleading synchronize_irq() documentation

The function might sleep, so it cannot be called from interrupt
context. Not even with care.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Marc Zyngier <marc.zyngier@arm.com>
Link: https://lkml.kernel.org/r/20190628111440.189241552@linutronix.de

---
 kernel/irq/manage.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/kernel/irq/manage.c b/kernel/irq/manage.c
index dc8b35f2d545..44fc505815d6 100644
--- a/kernel/irq/manage.c
+++ b/kernel/irq/manage.c
@@ -96,7 +96,8 @@ EXPORT_SYMBOL(synchronize_hardirq);
  *	to complete before returning. If you use this function while
  *	holding a resource the IRQ handler may need you will deadlock.
  *
- *	This function may be called - with care - from IRQ context.
+ *	Can only be called from preemptible code as it might sleep when
+ *	an interrupt thread is associated to @irq.
  */
 void synchronize_irq(unsigned int irq)
 {
