Return-Path: <SRS0=G/Om=ZT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1DD3C432C0
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 20:48:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 88F3B21774
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 20:48:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574887732;
	bh=4JUphUXaKzuXi8JFfFbcAAFZaGvFQBHCrxl018O+3uk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=fMAIk2Sq5U1Tz8cx+rQT7KrceWZveJ4xy7tbQ/DNkGrPMByWZiOFxMiHY1du1408h
	 VAVHaD96BU4rgs2/1sefS+v0wwBi7ER4gXk6LlV8pnoMRo1uC7QJtCHLekzD5tQo1F
	 QgBTeAd61P5zbf9iTmknlAbmLXboT5WzIKFKeiEI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728280AbfK0Usu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Nov 2019 15:48:50 -0500
Received: from mail.kernel.org ([198.145.29.99]:34164 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730178AbfK0Uss (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Nov 2019 15:48:48 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4E20221774;
        Wed, 27 Nov 2019 20:48:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574887727;
        bh=4JUphUXaKzuXi8JFfFbcAAFZaGvFQBHCrxl018O+3uk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=nRa4gZyzmchbYLpOdpZ7x4pBlw11is09JSrtlGpsSmrosmqfGHyTcbgYgBal6fVa/
         jlcSwn20+9ytpZiFKzEXSQ7Bgbw6UHwKAfK0EqHTUlpNb5cUFaXbiplxwvRy7zJn49
         GXfPl6TlsA8I6RL9JLJGr2pK8YqkgjmKJCHpXHKE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Thomas Richter <tmricht@linux.ibm.com>,
        Hendrik Brueckner <brueckner@linux.ibm.com>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 071/211] s390/perf: Return error when debug_register fails
Date:   Wed, 27 Nov 2019 21:30:04 +0100
Message-Id: <20191127203100.566948109@linuxfoundation.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191127203049.431810767@linuxfoundation.org>
References: <20191127203049.431810767@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thomas Richter <tmricht@linux.ibm.com>

[ Upstream commit ec0c0bb489727de0d4dca6a00be6970ab8a3b30a ]

Return an error when the function debug_register() fails allocating
the debug handle.
Also remove the registered debug handle when the initialization fails
later on.

Signed-off-by: Thomas Richter <tmricht@linux.ibm.com>
Reviewed-by: Hendrik Brueckner <brueckner@linux.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/s390/kernel/perf_cpum_sf.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/arch/s390/kernel/perf_cpum_sf.c b/arch/s390/kernel/perf_cpum_sf.c
index d99155793c26e..2e2fd9535f865 100644
--- a/arch/s390/kernel/perf_cpum_sf.c
+++ b/arch/s390/kernel/perf_cpum_sf.c
@@ -1610,14 +1610,17 @@ static int __init init_cpum_sampling_pmu(void)
 	}
 
 	sfdbg = debug_register(KMSG_COMPONENT, 2, 1, 80);
-	if (!sfdbg)
+	if (!sfdbg) {
 		pr_err("Registering for s390dbf failed\n");
+		return -ENOMEM;
+	}
 	debug_register_view(sfdbg, &debug_sprintf_view);
 
 	err = register_external_irq(EXT_IRQ_MEASURE_ALERT,
 				    cpumf_measurement_alert);
 	if (err) {
 		pr_cpumsf_err(RS_INIT_FAILURE_ALRT);
+		debug_unregister(sfdbg);
 		goto out;
 	}
 
@@ -1626,6 +1629,7 @@ static int __init init_cpum_sampling_pmu(void)
 		pr_cpumsf_err(RS_INIT_FAILURE_PERF);
 		unregister_external_irq(EXT_IRQ_MEASURE_ALERT,
 					cpumf_measurement_alert);
+		debug_unregister(sfdbg);
 		goto out;
 	}
 
-- 
2.20.1



