Return-Path: <SRS0=91bA=RH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED912C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 08:24:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BA14021473
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 08:24:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551687880;
	bh=GqrSWFwnblErk301gDd4tZ48+bd5m799+eMLB+1fZ2k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Cykg2/bdk1xhFECd/Z00fwHTBsn4XrI9wbsu59uWShSA0BDeB+gScONLyoCh5SkJo
	 TM//J3eos6P3ADvNfVfIYFZUanQR6fCjsX6G+EaJmiRdkQg2wrY4cSkks0ciBRXMjn
	 9oEF03ycmx/CnTcbEe3Kqv9j6O13eEEcnnot3CKA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726897AbfCDIYj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Mar 2019 03:24:39 -0500
Received: from mail.kernel.org ([198.145.29.99]:42692 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726860AbfCDIYf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Mar 2019 03:24:35 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7A57B20823;
        Mon,  4 Mar 2019 08:24:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551687875;
        bh=GqrSWFwnblErk301gDd4tZ48+bd5m799+eMLB+1fZ2k=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=AeJJTHQxJcds9pvgRqulhZ64cW6kl29y4acn1dWw/DOh/x75SqMQMOTtBIbQ5bar3
         0tfdHE7lVH3K/9tUCjjalsrNpPKLEYmYBvArAckp8cwT4hT1++HnpsgVFKZy3ldxBZ
         P01yw+jMGYeJikrbxLfQiI3OrJmGbSIbqBIHvzDw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Srinivas Ramana <sramana@codeaurora.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-arm-msm@vger.kernel.org, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 16/52] genirq: Make sure the initial affinity is not empty
Date:   Mon,  4 Mar 2019 09:22:14 +0100
Message-Id: <20190304081618.030955047@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190304081617.159014799@linuxfoundation.org>
References: <20190304081617.159014799@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

[ Upstream commit bddda606ec76550dd63592e32a6e87e7d32583f7 ]

If all CPUs in the irq_default_affinity mask are offline when an interrupt
is initialized then irq_setup_affinity() can set an empty affinity mask for
a newly allocated interrupt.

Fix this by falling back to cpu_online_mask in case the resulting affinity
mask is zero.

Signed-off-by: Srinivas Ramana <sramana@codeaurora.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: linux-arm-msm@vger.kernel.org
Link: https://lkml.kernel.org/r/1545312957-8504-1-git-send-email-sramana@codeaurora.org
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/irq/manage.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/kernel/irq/manage.c b/kernel/irq/manage.c
index 4cd85870f00e6..6c877d28838f2 100644
--- a/kernel/irq/manage.c
+++ b/kernel/irq/manage.c
@@ -360,6 +360,9 @@ int irq_setup_affinity(struct irq_desc *desc)
 	}
 
 	cpumask_and(&mask, cpu_online_mask, set);
+	if (cpumask_empty(&mask))
+		cpumask_copy(&mask, cpu_online_mask);
+
 	if (node != NUMA_NO_NODE) {
 		const struct cpumask *nodemask = cpumask_of_node(node);
 
-- 
2.19.1



