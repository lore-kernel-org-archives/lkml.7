Return-Path: <SRS0=Pa1K=VP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A4DFC76192
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jul 2019 03:03:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E930B21852
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jul 2019 03:03:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1563419015;
	bh=rku9e+gLZXd0cXvofkio1Hv3SFZniVvGJAakdWxEiW0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=r9BiCOTVioI7GWIaa5I5QL+RiEYOwpXJduWcDFi8VFJrlr+/w5lyLZ5syXHJgq1U5
	 f3qSyBrI3ia5T+/jPzckhe3HMXe1xM8352vUwVffslJuM9Ov2mXUzofvzDdDQoHjgY
	 H3rKVsdNL/LzlP+1jPLWntEu8/nKpc5e2yadTSEY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389386AbfGRDDe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jul 2019 23:03:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:34244 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389356AbfGRDDc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jul 2019 23:03:32 -0400
Received: from localhost (115.42.148.210.bf.2iij.net [210.148.42.115])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E3EA621849;
        Thu, 18 Jul 2019 03:03:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563419011;
        bh=rku9e+gLZXd0cXvofkio1Hv3SFZniVvGJAakdWxEiW0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=YBf6j1Jd9BjeM5ArR6Dy8YGnLIeOgMju66PHtwOl2n0j4lguamAh+ey0xdqigJi8A
         l0xzfedEXwKvSP0B05Yrq2H2bFzZ/F6j23PBSkeyG/+sGKPRqQpTrOK3TpDge+8bc1
         JO+FkjfXI/osxpdJQTcELBJGN1yp4/U0d3wSBu20=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <marc.zyngier@arm.com>
Subject: [PATCH 5.2 08/21] genirq: Fix misleading synchronize_irq() documentation
Date:   Thu, 18 Jul 2019 12:01:26 +0900
Message-Id: <20190718030032.145247589@linuxfoundation.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190718030030.456918453@linuxfoundation.org>
References: <20190718030030.456918453@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thomas Gleixner <tglx@linutronix.de>

commit 1d21f2af8571c6a6a44e7c1911780614847b0253 upstream.

The function might sleep, so it cannot be called from interrupt
context. Not even with care.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Marc Zyngier <marc.zyngier@arm.com>
Link: https://lkml.kernel.org/r/20190628111440.189241552@linutronix.de
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 kernel/irq/manage.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

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


