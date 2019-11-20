Return-Path: <SRS0=PPSE=ZM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30325C432C3
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 13:22:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0D8442251F
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 13:22:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730299AbfKTNV1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Nov 2019 08:21:27 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:56758 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730216AbfKTNVS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Nov 2019 08:21:18 -0500
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1iXPut-00075R-16; Wed, 20 Nov 2019 14:21:07 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id ABECC1C1998;
        Wed, 20 Nov 2019 14:21:01 +0100 (CET)
Date:   Wed, 20 Nov 2019 13:21:01 -0000
From:   "tip-bot2 for Lina Iyer" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: irq/core] irqdomain: Add bus token DOMAIN_BUS_WAKEUP
Cc:     Stephen Boyd <swboyd@chromium.org>,
        Lina Iyer <ilina@codeaurora.org>,
        Marc Zyngier <maz@kernel.org>, Ingo Molnar <mingo@kernel.org>,
        Borislav Petkov <bp@alien8.de>, linux-kernel@vger.kernel.org
In-Reply-To: <1573855915-9841-2-git-send-email-ilina@codeaurora.org>
References: <1573855915-9841-2-git-send-email-ilina@codeaurora.org>
MIME-Version: 1.0
Message-ID: <157425606157.12247.11399374334124634860.tip-bot2@tip-bot2>
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the irq/core branch of tip:

Commit-ID:     d46bca2b5d06cbb5f3e66945080f275bcfab7181
Gitweb:        https://git.kernel.org/tip/d46bca2b5d06cbb5f3e66945080f275bcfab7181
Author:        Lina Iyer <ilina@codeaurora.org>
AuthorDate:    Fri, 15 Nov 2019 15:11:44 -07:00
Committer:     Marc Zyngier <maz@kernel.org>
CommitterDate: Sat, 16 Nov 2019 10:18:52 

irqdomain: Add bus token DOMAIN_BUS_WAKEUP

A single controller can handle normal interrupts and wake-up interrupts
independently, with a different numbering space. It is thus crucial to
allow the driver for such a controller discriminate between the two.

A simple way to do so is to tag the wake-up irqdomain with a "bus token"
that indicates the wake-up domain. This slightly abuses the notion of
bus, but also radically simplifies the design of such a driver. Between
two evils, we choose the least damaging.

Suggested-by: Stephen Boyd <swboyd@chromium.org>
Signed-off-by: Lina Iyer <ilina@codeaurora.org>
Signed-off-by: Marc Zyngier <maz@kernel.org>
Reviewed-by: Stephen Boyd <swboyd@chromium.org>
Link: https://lore.kernel.org/r/1573855915-9841-2-git-send-email-ilina@codeaurora.org
---
 include/linux/irqdomain.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/linux/irqdomain.h b/include/linux/irqdomain.h
index 583e7ab..3c340db 100644
--- a/include/linux/irqdomain.h
+++ b/include/linux/irqdomain.h
@@ -83,6 +83,7 @@ enum irq_domain_bus_token {
 	DOMAIN_BUS_IPI,
 	DOMAIN_BUS_FSL_MC_MSI,
 	DOMAIN_BUS_TI_SCI_INTA_MSI,
+	DOMAIN_BUS_WAKEUP,
 };
 
 /**
