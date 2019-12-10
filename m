Return-Path: <SRS0=jko7=2A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04FEEC3F68F
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 14:54:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D8D3F2077B
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 14:54:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727793AbfLJOy0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Dec 2019 09:54:26 -0500
Received: from foss.arm.com ([217.140.110.172]:47166 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727705AbfLJOyP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Dec 2019 09:54:15 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8F36C1396;
        Tue, 10 Dec 2019 06:54:14 -0800 (PST)
Received: from usa.arm.com (e107155-lin.cambridge.arm.com [10.1.196.42])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id D72D53F67D;
        Tue, 10 Dec 2019 06:54:13 -0800 (PST)
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Sudeep Holla <sudeep.holla@arm.com>,
        Cristian Marussi <cristian.marussi@arm.com>
Subject: [PATCH 11/15] firmware: arm_scmi: Match scmi device by both name and protocol id
Date:   Tue, 10 Dec 2019 14:53:41 +0000
Message-Id: <20191210145345.11616-12-sudeep.holla@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191210145345.11616-1-sudeep.holla@arm.com>
References: <20191210145345.11616-1-sudeep.holla@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The scmi bus now has support to match the driver with devices not only
based on their protocol id but also based on their device name if one is
available. This was added to cater the need to support multiple devices
and drivers for the same protocol.

Let us add the name "genpd" to scmi_device_id table in the driver so
that in matches only with device with the same name and protocol id
SCMI_PROTOCOL_POWER.

Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
---
 drivers/firmware/arm_scmi/scmi_pm_domain.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/firmware/arm_scmi/scmi_pm_domain.c b/drivers/firmware/arm_scmi/scmi_pm_domain.c
index 87f737e01473..bafbfe358f97 100644
--- a/drivers/firmware/arm_scmi/scmi_pm_domain.c
+++ b/drivers/firmware/arm_scmi/scmi_pm_domain.c
@@ -112,7 +112,7 @@ static int scmi_pm_domain_probe(struct scmi_device *sdev)
 }

 static const struct scmi_device_id scmi_id_table[] = {
-	{ SCMI_PROTOCOL_POWER },
+	{ SCMI_PROTOCOL_POWER, "genpd" },
 	{ },
 };
 MODULE_DEVICE_TABLE(scmi, scmi_id_table);
--
2.17.1

