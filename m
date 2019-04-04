Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F013C4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 09:44:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6BCB120820
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 09:44:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554371079;
	bh=FDLj2gQDtfh77BzlMtLajaBM0hcPDgSPGsjfv2S5TZI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=RSKfDd1rO7QKVswG0Bvh9utR/RTOHwz87LfFwmPS8T+czBg2tY6HrKa8rGI7MO+vl
	 sqnY+syDMrGeOtJdGT/6DxMZn1/yCS53Lt9L0y06oJaoW3AEvMKTiN16Gw86//M7Il
	 6DNn1P/F8UDxigds+5QiFwaNK7tYdlKZj7eZUXSU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731112AbfDDI7l (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 04:59:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:35960 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731098AbfDDI7f (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 04:59:35 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E91E720652;
        Thu,  4 Apr 2019 08:59:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554368374;
        bh=FDLj2gQDtfh77BzlMtLajaBM0hcPDgSPGsjfv2S5TZI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=cjsTP5XnKK9cR+BWx0JVc98EfMbvIHANCRiLZwB/6zQ7ZtGvTuzi2vwzicpqHL8CH
         DfuBDW2HijHjbfjUUAaBA2R4rB1JsPRQ3cWtg17FVL1POSxmuGk0/s2KQjqD7WCX6N
         3IIwL6+X+TrDgb7xX/CrElI+QU6dITpssUuMH6AM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Nathan Chancellor <natechancellor@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 016/187] enic: fix build warning without CONFIG_CPUMASK_OFFSTACK
Date:   Thu,  4 Apr 2019 10:45:53 +0200
Message-Id: <20190404084603.861490774@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190404084603.119654039@linuxfoundation.org>
References: <20190404084603.119654039@linuxfoundation.org>
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

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

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
index 9a7f70db20c7..733d9172425b 100644
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



