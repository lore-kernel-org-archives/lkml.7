Return-Path: <SRS0=6dNS=X4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A63BEC10F14
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 16:19:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7576C215EA
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 16:19:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570119569;
	bh=T+aCyAiEDOzNUK91tdmqUu+c6rJ8cwy/8kf1dw1hA2g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=grXx0043v/PKa8lRZ34hq043dIa8EHIfC5+J/zkX5BE/6Z2wHHIibwWG0JA/WYbSo
	 dFPPFAgEcrQRClUhJT7dRIPzUDS6JDenEjPAwwUt4mC/QPJiXHMPkYo2TcPK0tD50E
	 BXFyGCyHmHTWRRFbBrG1EL/c7Mr1AmwPxmDqj6dI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389543AbfJCQT2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Oct 2019 12:19:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:46282 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389491AbfJCQTS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Oct 2019 12:19:18 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 371BD21783;
        Thu,  3 Oct 2019 16:19:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570119558;
        bh=T+aCyAiEDOzNUK91tdmqUu+c6rJ8cwy/8kf1dw1hA2g=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=CuTbhTTuoxiVBR3sgm05gDzZt6wEzpVKty55HqEZ9b1jAVfd5wCKxY5S5Yc65ikxi
         y9RT4O7+E7/eFMaxTdZeNzyI0Zmh5nP/HiWi2ALqWMH5Weqgr88fGQ5KYK8+VlAEeT
         CTjPcBeUz+1kM2lOSdatde9t9NI/ftUQlcaZbsVI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, djuran@redhat.com,
        Neil Horman <nhorman@tuxdriver.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 108/211] x86/apic/vector: Warn when vector space exhaustion breaks affinity
Date:   Thu,  3 Oct 2019 17:52:54 +0200
Message-Id: <20191003154511.950306304@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191003154447.010950442@linuxfoundation.org>
References: <20191003154447.010950442@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Neil Horman <nhorman@tuxdriver.com>

[ Upstream commit 743dac494d61d991967ebcfab92e4f80dc7583b3 ]

On x86, CPUs are limited in the number of interrupts they can have affined
to them as they only support 256 interrupt vectors per CPU. 32 vectors are
reserved for the CPU and the kernel reserves another 22 for internal
purposes. That leaves 202 vectors for assignement to devices.

When an interrupt is set up or the affinity is changed by the kernel or the
administrator, the vector assignment code attempts to honor the requested
affinity mask. If the vector space on the CPUs in that affinity mask is
exhausted the code falls back to a wider set of CPUs and assigns a vector
on a CPU outside of the requested affinity mask silently.

While the effective affinity is reflected in the corresponding
/proc/irq/$N/effective_affinity* files the silent breakage of the requested
affinity can lead to unexpected behaviour for administrators.

Add a pr_warn() when this happens so that adminstrators get at least
informed about it in the syslog.

[ tglx: Massaged changelog and made the pr_warn() more informative ]

Reported-by: djuran@redhat.com
Signed-off-by: Neil Horman <nhorman@tuxdriver.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Tested-by: djuran@redhat.com
Link: https://lkml.kernel.org/r/20190822143421.9535-1-nhorman@tuxdriver.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/x86/kernel/apic/vector.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/arch/x86/kernel/apic/vector.c b/arch/x86/kernel/apic/vector.c
index 10e1d17aa0608..c352ca2e1456f 100644
--- a/arch/x86/kernel/apic/vector.c
+++ b/arch/x86/kernel/apic/vector.c
@@ -400,6 +400,17 @@ static int activate_reserved(struct irq_data *irqd)
 		if (!irqd_can_reserve(irqd))
 			apicd->can_reserve = false;
 	}
+
+	/*
+	 * Check to ensure that the effective affinity mask is a subset
+	 * the user supplied affinity mask, and warn the user if it is not
+	 */
+	if (!cpumask_subset(irq_data_get_effective_affinity_mask(irqd),
+			    irq_data_get_affinity_mask(irqd))) {
+		pr_warn("irq %u: Affinity broken due to vector space exhaustion.\n",
+			irqd->irq);
+	}
+
 	return ret;
 }
 
-- 
2.20.1



