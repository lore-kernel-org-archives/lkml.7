Return-Path: <SRS0=/WLL=WS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75768C3A5A1
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 14:35:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5166823400
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 14:35:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388389AbfHVOfG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Aug 2019 10:35:06 -0400
Received: from charlotte.tuxdriver.com ([70.61.120.58]:55463 "EHLO
        smtp.tuxdriver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731461AbfHVOfF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Aug 2019 10:35:05 -0400
Received: from cpe-2606-a000-111b-43ee-0-0-0-162e.dyn6.twc.com ([2606:a000:111b:43ee::162e] helo=localhost)
        by smtp.tuxdriver.com with esmtpsa (TLSv1:AES256-SHA:256)
        (Exim 4.63)
        (envelope-from <nhorman@tuxdriver.com>)
        id 1i0oB2-0001wV-5G; Thu, 22 Aug 2019 10:35:03 -0400
From:   Neil Horman <nhorman@tuxdriver.com>
To:     linux-kernel@vger.kernel.org
Cc:     x86@kernel.org, Neil Horman <nhorman@tuxdriver.com>,
        djuran@redhat.com, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>
Subject: [PATCH V2] x86: Add irq spillover warning
Date:   Thu, 22 Aug 2019 10:34:21 -0400
Message-Id: <20190822143421.9535-1-nhorman@tuxdriver.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Intel hardware, cpus are limited in the number of irqs they can
have affined to them (currently 240), based on section 10.5.2 of:
https://www.intel.com/content/dam/www/public/us/en/documents/manuals/64-ia-32-architectures-software-developer-vol-3a-part-1-manual.pdf

assign_irq_vector_any_locked() will attempt to honor the affining
request, but if the 240 vector limitation documented above is crossed, a
new mask will be selected that is potentially outside the requested cpu
set silently.  This can lead to unexpected behavior for administrators.

Mitigate this problem by checking the affinity mask after its been
assigned in activate_reserved so that adminstrators get a logged warning
about the change.

Tested successfully by the reporter

Change Notes:
V1->V2)
	* Moved the check for this condition to activate_reserved from
do_IRQ, taking it out of the hot path (request by tglx@lintronix.de)

Signed-off-by: Neil Horman <nhorman@tuxdriver.com>
Reported-by: djuran@redhat.com
CC: Thomas Gleixner <tglx@linutronix.de>
CC: Ingo Molnar <mingo@redhat.com>
CC: Borislav Petkov <bp@alien8.de>
CC: "H. Peter Anvin" <hpa@zytor.com>
CC: x86@kernel.org
---
 arch/x86/kernel/apic/vector.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/x86/kernel/apic/vector.c b/arch/x86/kernel/apic/vector.c
index fdacb864c3dd..b8ed0406d41f 100644
--- a/arch/x86/kernel/apic/vector.c
+++ b/arch/x86/kernel/apic/vector.c
@@ -398,6 +398,16 @@ static int activate_reserved(struct irq_data *irqd)
 		if (!irqd_can_reserve(irqd))
 			apicd->can_reserve = false;
 	}
+
+	/*
+	 * Check to ensure that the effective affinity mask is a subset
+	 * the user supplied affinity mask, and warn the user if it is not
+	 */
+	if (!cpumask_subset(irq_data_get_effective_affinity_mask(irqd),
+	     irq_data_get_affinity_mask(irqd)))
+		pr_warn("irq %d has been assigned to a cpu outside of its user affinity mask\n",
+			irqd->irq);
+
 	return ret;
 }
 
-- 
2.21.0

