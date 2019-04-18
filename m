Return-Path: <SRS0=NWWL=SU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB7E7C10F14
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 18:17:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B4DC420675
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 18:17:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555611445;
	bh=vKW2ZYmrzwxvbkiRzw3k8QMWzApHq9ueCTomN9vrEvA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=czonURFbF2zdhaxhaHWOOAyhzv1sWVqQhDY48zeO27jFIAZyxxA7GrLkIk6s+eK55
	 FmQPPaVN+P8gLJfcx9AJPLV18QbezwZVgD9dPD6c7nx3gNysCYc/TU6BMFaNWv1n/n
	 7rnZHqjyvRYDHnsOnCT75+4oMh3k8RWiCQmlhmcA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404219AbfDRSL1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Apr 2019 14:11:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:43662 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390953AbfDRSLY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Apr 2019 14:11:24 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BB2B520675;
        Thu, 18 Apr 2019 18:11:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1555611084;
        bh=vKW2ZYmrzwxvbkiRzw3k8QMWzApHq9ueCTomN9vrEvA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=rjYZS6pNXgqh4vnHwJ0wvBJqjhVqbz3v+BHAGZ1EtfZrfzyehbOCFEVsUHfeigRb7
         gCpol9zOwbZRkkilaWl1zEq2cIpAw3Wfr30h2gReQOtipnOvP9dlgG7o1bpv4FMQ6F
         07Ji1fl1qWo+/i8NLVhbh5sKxCzQcl+J/PDdFFj0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Loic Pallardy <loic.pallardy@st.com>,
        Fabien Dessenne <fabien.dessenne@st.com>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.0 53/93] irqchip/stm32: Dont clear rising/falling config registers at init
Date:   Thu, 18 Apr 2019 19:57:31 +0200
Message-Id: <20190418160443.040864186@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190418160436.781762249@linuxfoundation.org>
References: <20190418160436.781762249@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Upstream commit 0dda09666f50eae9c5b794dd89b1fd8a8d89d714 ]

Falling and rising configuration and status registers are not banked.
As they are shared with M4 co-processor, they should not be cleared
at probe time, else M4 co-processor configuration will be lost.

Fixes: f9fc1745501e ("irqchip/stm32: Add host and driver data structures")
Signed-off-by: Loic Pallardy <loic.pallardy@st.com>
Signed-off-by: Fabien Dessenne <fabien.dessenne@st.com>
Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/irqchip/irq-stm32-exti.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/irqchip/irq-stm32-exti.c b/drivers/irqchip/irq-stm32-exti.c
index a93296b9b45d..162a7f547f9e 100644
--- a/drivers/irqchip/irq-stm32-exti.c
+++ b/drivers/irqchip/irq-stm32-exti.c
@@ -735,11 +735,6 @@ stm32_exti_chip_data *stm32_exti_chip_init(struct stm32_exti_host_data *h_data,
 	 */
 	writel_relaxed(0, base + stm32_bank->imr_ofst);
 	writel_relaxed(0, base + stm32_bank->emr_ofst);
-	writel_relaxed(0, base + stm32_bank->rtsr_ofst);
-	writel_relaxed(0, base + stm32_bank->ftsr_ofst);
-	writel_relaxed(~0UL, base + stm32_bank->rpr_ofst);
-	if (stm32_bank->fpr_ofst != UNDEF_REG)
-		writel_relaxed(~0UL, base + stm32_bank->fpr_ofst);
 
 	pr_info("%pOF: bank%d\n", h_data->node, bank_idx);
 
-- 
2.19.1



