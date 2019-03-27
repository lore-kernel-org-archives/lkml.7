Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 991EAC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 18:16:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 650B720449
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 18:16:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553710612;
	bh=sFDxrXnxffdyrAb0+iSbHw0T/NRFR6zALWXH+44/vHQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=BkmX9IiMDasyDFfT6iOUF6j8WUfdxifo1TZ14ullV3RxucZW14jxqgn4mFRYy3XJX
	 MUMZRAlNNcCztLkG4Hr6MvObruZ5cXyzz93bUAwZzNzjzUwzWPg3YYEuv6j7UPlMs2
	 YlQt+pn4qyPl1+kIrOc1izXi7MASydHB8uWolBoE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390144AbfC0SQv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 14:16:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:32884 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390125AbfC0SQr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 14:16:47 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E78172184D;
        Wed, 27 Mar 2019 18:16:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553710606;
        bh=sFDxrXnxffdyrAb0+iSbHw0T/NRFR6zALWXH+44/vHQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dzJLdUfWNiEiwdpZFB2eoCVrYG5I/ebWDy5l4PpttXjNFL8SFZV31blzGaTVxu54o
         6Ed7DADtR8bA47K9pUbvl02kYsbJMuhOj8AZEdywfwiUnRqu1qdGoABvKlNxVZJLy3
         1z2hkAp+e1OmsLTqO5mK4y0f0N1qkfG3B4a2WUfc=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Arnd Bergmann <arnd@arndb.de>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>, netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 4.14 011/123] enic: fix build warning without CONFIG_CPUMASK_OFFSTACK
Date:   Wed, 27 Mar 2019 14:14:35 -0400
Message-Id: <20190327181628.15899-11-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190327181628.15899-1-sashal@kernel.org>
References: <20190327181628.15899-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

[ Upstream commit 43d281662fdb46750d49417559b71069f435298d ]

The enic driver relies on the CONFIG_CPUMASK_OFFSTACK feature to
dynamically allocate a struct member, but this is normally intended for
local variables.

Building with clang, I get a warning for a few locations that check the
address of the cpumask_var_t:

drivers/net/ethernet/cisco/enic/enic_main.c:122:22: error: address of array 'enic->msix[i].affinity_mask' will always evaluate to 'true' [-Werror,-Wpointer-bool-conversion]

As far as I can tell, the code is still correct, as the truth value of
the pointer is what we need in this configuration. To get rid of
the warning, use cpumask_available() instead of checking the
pointer directly.

Fixes: 322cf7e3a4e8 ("enic: assign affinity hint to interrupts")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Reviewed-by: Nathan Chancellor <natechancellor@gmail.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/cisco/enic/enic_main.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/cisco/enic/enic_main.c b/drivers/net/ethernet/cisco/enic/enic_main.c
index ced348e15a63..19f374b180fc 100644
--- a/drivers/net/ethernet/cisco/enic/enic_main.c
+++ b/drivers/net/ethernet/cisco/enic/enic_main.c
@@ -119,7 +119,7 @@ static void enic_init_affinity_hint(struct enic *enic)
 
 	for (i = 0; i < enic->intr_count; i++) {
 		if (enic_is_err_intr(enic, i) || enic_is_notify_intr(enic, i) ||
-		    (enic->msix[i].affinity_mask &&
+		    (cpumask_available(enic->msix[i].affinity_mask) &&
 		     !cpumask_empty(enic->msix[i].affinity_mask)))
 			continue;
 		if (zalloc_cpumask_var(&enic->msix[i].affinity_mask,
@@ -148,7 +148,7 @@ static void enic_set_affinity_hint(struct enic *enic)
 	for (i = 0; i < enic->intr_count; i++) {
 		if (enic_is_err_intr(enic, i)		||
 		    enic_is_notify_intr(enic, i)	||
-		    !enic->msix[i].affinity_mask	||
+		    !cpumask_available(enic->msix[i].affinity_mask) ||
 		    cpumask_empty(enic->msix[i].affinity_mask))
 			continue;
 		err = irq_set_affinity_hint(enic->msix_entry[i].vector,
@@ -161,7 +161,7 @@ static void enic_set_affinity_hint(struct enic *enic)
 	for (i = 0; i < enic->wq_count; i++) {
 		int wq_intr = enic_msix_wq_intr(enic, i);
 
-		if (enic->msix[wq_intr].affinity_mask &&
+		if (cpumask_available(enic->msix[wq_intr].affinity_mask) &&
 		    !cpumask_empty(enic->msix[wq_intr].affinity_mask))
 			netif_set_xps_queue(enic->netdev,
 					    enic->msix[wq_intr].affinity_mask,
-- 
2.19.1

