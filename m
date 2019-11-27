Return-Path: <SRS0=G/Om=ZT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D8C6C43215
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 21:41:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4B7CE2075C
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 21:41:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574890900;
	bh=2pRONMT9Wb0FmlOGGCaXMgsOEB5HUk+wXh22ByjWyUo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=mfQ9EGld8nQeOF/Stjbo1rWMKnHpXFXgvF/sRk4dG8BvvSStNX45MlfcBaRZufxz8
	 FL1oymk2JMZx8UrLmeFhA0r5BG3bIQ1m5gYL/w3beyXdtFQNTyBhfmkYXnhE3Z5yUZ
	 Te4v1InrrE65Iiywx6XmzKCoXKvI3T63Gkdq+yps=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728216AbfK0UlX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Nov 2019 15:41:23 -0500
Received: from mail.kernel.org ([198.145.29.99]:46478 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729151AbfK0UlU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Nov 2019 15:41:20 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6C09520863;
        Wed, 27 Nov 2019 20:41:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574887279;
        bh=2pRONMT9Wb0FmlOGGCaXMgsOEB5HUk+wXh22ByjWyUo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=u2eW+24ytfQJHlrDe0UjEVgYkenYR0aHqKfYhkKf3U5VIB3tgHQJsxcc3QZclvsaU
         G7hiRJ9QaxSeue8KQ3Kj4WLhVNISg080ZXwTr5q/PWMHmHzFPI/JOA5Vwan4t+OiAd
         e2eJviMKt6N3vwlbRqxv70UBWAM/QKH+qKH1201M=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Thomas Richter <tmricht@linux.ibm.com>,
        Hendrik Brueckner <brueckner@linux.ibm.com>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.9 048/151] s390/perf: Return error when debug_register fails
Date:   Wed, 27 Nov 2019 21:30:31 +0100
Message-Id: <20191127203029.239833434@linuxfoundation.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191127203000.773542911@linuxfoundation.org>
References: <20191127203000.773542911@linuxfoundation.org>
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
index 96e4fcad57bf7..f46e5c0cb6d95 100644
--- a/arch/s390/kernel/perf_cpum_sf.c
+++ b/arch/s390/kernel/perf_cpum_sf.c
@@ -1611,14 +1611,17 @@ static int __init init_cpum_sampling_pmu(void)
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
 
@@ -1627,6 +1630,7 @@ static int __init init_cpum_sampling_pmu(void)
 		pr_cpumsf_err(RS_INIT_FAILURE_PERF);
 		unregister_external_irq(EXT_IRQ_MEASURE_ALERT,
 					cpumf_measurement_alert);
+		debug_unregister(sfdbg);
 		goto out;
 	}
 
-- 
2.20.1



