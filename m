Return-Path: <SRS0=Yvat=2B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD0CBC43603
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 15:32:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 95FE022B48
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 15:32:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576078362;
	bh=R2iSsoYheVYUJsesqHMqyMD9vLzWbpg826TUGxQWD5g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=a/rBwrKEbzPcYLrulLvt/FquLkci0/gT5VqilE9C1QVRg3NKw1vca/8mC8AKGp6EQ
	 15zutMu9NaWthuzXsMgO9Ndnz0n4ZYQbUOCFVs4n6ojrcwGODY0KWMlTNCdUpB80gs
	 BXDW01tGiRdKTK7JuOm2EupfTlfP/EasnnpG3/BY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388038AbfLKPcl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Dec 2019 10:32:41 -0500
Received: from mail.kernel.org ([198.145.29.99]:35340 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387748AbfLKP2z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Dec 2019 10:28:55 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 45AE12467F;
        Wed, 11 Dec 2019 15:28:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576078134;
        bh=R2iSsoYheVYUJsesqHMqyMD9vLzWbpg826TUGxQWD5g=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=GSBexvDXOTEhpP/G4sNTUxZZFm00mYZX75nfAaSbA+nk5b4jVsXxASy0BC1rrf6Cp
         wYHCEb5P0ZBmqQQguRhk582BoMVWxloWI0v0L4kQdWLDSpulb1FSoax95SiNGnrqkB
         SX96cDxMdVdL3vrNRPW8S7dhAacogvKG2h8RlTKk=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        Marc Zyngier <maz@kernel.org>, Sasha Levin <sashal@kernel.org>,
        linux-mips@linux-mips.org
Subject: [PATCH AUTOSEL 4.14 22/58] irqchip/irq-bcm7038-l1: Enable parent IRQ if necessary
Date:   Wed, 11 Dec 2019 10:27:55 -0500
Message-Id: <20191211152831.23507-22-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191211152831.23507-1-sashal@kernel.org>
References: <20191211152831.23507-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Florian Fainelli <f.fainelli@gmail.com>

[ Upstream commit 27eebb60357ed5aa6659442f92907c0f7368d6ae ]

If the 'brcm,irq-can-wake' property is specified, make sure we also
enable the corresponding parent interrupt we are attached to.

Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
Signed-off-by: Marc Zyngier <maz@kernel.org>
Link: https://lore.kernel.org/r/20191024201415.23454-4-f.fainelli@gmail.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/irqchip/irq-bcm7038-l1.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/irqchip/irq-bcm7038-l1.c b/drivers/irqchip/irq-bcm7038-l1.c
index 0b9a8b709abf8..b32988cac80c6 100644
--- a/drivers/irqchip/irq-bcm7038-l1.c
+++ b/drivers/irqchip/irq-bcm7038-l1.c
@@ -284,6 +284,10 @@ static int __init bcm7038_l1_init_one(struct device_node *dn,
 		pr_err("failed to map parent interrupt %d\n", parent_irq);
 		return -EINVAL;
 	}
+
+	if (of_property_read_bool(dn, "brcm,irq-can-wake"))
+		enable_irq_wake(parent_irq);
+
 	irq_set_chained_handler_and_data(parent_irq, bcm7038_l1_irq_handle,
 					 intc);
 
-- 
2.20.1

