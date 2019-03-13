Return-Path: <SRS0=dUEL=RQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B2FAC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 08:37:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DCB212171F
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 08:37:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="LNCVQhFp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727342AbfCMIhX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Mar 2019 04:37:23 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:36468 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727286AbfCMIhN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Mar 2019 04:37:13 -0400
Received: by mail-lj1-f194.google.com with SMTP id v10so761077lji.3
        for <linux-kernel@vger.kernel.org>; Wed, 13 Mar 2019 01:37:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=/i1P7RcZS0nPamy0F7apI0HkwNW2ZATDEDVSzcyhElI=;
        b=LNCVQhFpUnIOYlMOLUOr9mSM5ufWoZgXkbtMcNfVpkPXTftWr8Gw2KduEBb2OJid0k
         ZgI5gQqetdcd8ZwZ1dlP8lp+5epDmkQqxiM58kUOir8YdPU8LMaLu9ZgY+uGi/9ErKiD
         zEAy7Ub8jGCrBlsroVQjdMIu8iAXfQhexCgYPSAekZIXCy4cAX3QVSDP3Vf6oS4pm0i7
         RFkyE2vlRtqKEUq5AQJgmmnpEzPpn36k1ycO26wqVnn0ANSUeg3NhwmtMtoMy151QESE
         JJ03Nj4v4PLn9wg+fjV/QDj3/tUG1hFiqfV8AyxkgpkWyB1OCeoj83ql5ucPdrULMyg3
         gtcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=/i1P7RcZS0nPamy0F7apI0HkwNW2ZATDEDVSzcyhElI=;
        b=Xk9RHRstduuq2XQXknf0SRBS1NdUmoWHspE9Arzt7iwzlrkb0ytSL0nbLmu2QKWS0F
         3ZopNuHGv98plyzKwIAc8G4NVXGs39NJ5rEz++3Nyr6HXYB9CnJCQgvUfofZMI4f2iXW
         A6ycR4Oe6CD84xivLdRFEHIoZctYKFeBcekRqywwksN7q0qFVIxfs2JUd5WuK+h/QNve
         E6P6F/khB/lRBTktuo3+UCbarrwKYlnpVsXpxaDDV0Dlj7JHJGwiOEvuk2C0oXcEmae5
         xEAOvDl+n5VPO7qb0e0r34F9NcE07BfT7buk14SIKc7It3lRZFzIFXxrWNQtb6k90pao
         YW6g==
X-Gm-Message-State: APjAAAWaYC/0/tX0MKf6nBakfFBgIz819O74cM2GGPMvOzOWTARF25m8
        7bUfjLLGSZZscPNF9hE3fIVUqQ==
X-Google-Smtp-Source: APXvYqyz0xVl/9wVKjxyA7k3YPcw6zwyqcIHTFAw+4Quuz1CFeIEK39/+Z84eyG9JSC3B7vo5kED9Q==
X-Received: by 2002:a2e:80cd:: with SMTP id r13mr22164205ljg.34.1552466231095;
        Wed, 13 Mar 2019 01:37:11 -0700 (PDT)
Received: from localhost.localdomain (h-158-174-22-210.NA.cust.bahnhof.se. [158.174.22.210])
        by smtp.gmail.com with ESMTPSA id a23sm1707716ljd.20.2019.03.13.01.37.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 13 Mar 2019 01:37:10 -0700 (PDT)
From:   Ulf Hansson <ulf.hansson@linaro.org>
To:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>
Cc:     Sudeep Holla <sudeep.holla@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Lina Iyer <ilina@codeaurora.org>,
        Ulf Hansson <ulf.hansson@linaro.org>, linux-pm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 4/5] drivers: firmware: psci: Simplify error path of psci_dt_init()
Date:   Wed, 13 Mar 2019 09:36:58 +0100
Message-Id: <20190313083659.7100-5-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190313083659.7100-1-ulf.hansson@linaro.org>
References: <20190313083659.7100-1-ulf.hansson@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Instead of having each psci init function taking care of the of_node_put(),
let's deal with that from psci_dt_init(), as this enables a bit simpler
error path for each psci init function.

Cc: Lina Iyer <ilina@codeaurora.org>
Co-developed-by: Lina Iyer <lina.iyer@linaro.org>
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
Acked-by: Mark Rutland <mark.rutland@arm.com>
Reviewed-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Acked-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
---
 drivers/firmware/psci/psci.c | 23 ++++++++++-------------
 1 file changed, 10 insertions(+), 13 deletions(-)

diff --git a/drivers/firmware/psci/psci.c b/drivers/firmware/psci/psci.c
index 9788bfc1cf8b..e480e0af632c 100644
--- a/drivers/firmware/psci/psci.c
+++ b/drivers/firmware/psci/psci.c
@@ -609,9 +609,9 @@ static int __init psci_0_2_init(struct device_node *np)
 	int err;
 
 	err = get_set_conduit_method(np);
-
 	if (err)
-		goto out_put_node;
+		return err;
+
 	/*
 	 * Starting with v0.2, the PSCI specification introduced a call
 	 * (PSCI_VERSION) that allows probing the firmware version, so
@@ -619,11 +619,7 @@ static int __init psci_0_2_init(struct device_node *np)
 	 * can be carried out according to the specific version reported
 	 * by firmware
 	 */
-	err = psci_probe();
-
-out_put_node:
-	of_node_put(np);
-	return err;
+	return psci_probe();
 }
 
 /*
@@ -635,9 +631,8 @@ static int __init psci_0_1_init(struct device_node *np)
 	int err;
 
 	err = get_set_conduit_method(np);
-
 	if (err)
-		goto out_put_node;
+		return err;
 
 	pr_info("Using PSCI v0.1 Function IDs from DT\n");
 
@@ -661,9 +656,7 @@ static int __init psci_0_1_init(struct device_node *np)
 		psci_ops.migrate = psci_migrate;
 	}
 
-out_put_node:
-	of_node_put(np);
-	return err;
+	return 0;
 }
 
 static const struct of_device_id psci_of_match[] __initconst = {
@@ -678,6 +671,7 @@ int __init psci_dt_init(void)
 	struct device_node *np;
 	const struct of_device_id *matched_np;
 	psci_initcall_t init_fn;
+	int ret;
 
 	np = of_find_matching_node_and_match(NULL, psci_of_match, &matched_np);
 
@@ -685,7 +679,10 @@ int __init psci_dt_init(void)
 		return -ENODEV;
 
 	init_fn = (psci_initcall_t)matched_np->data;
-	return init_fn(np);
+	ret = init_fn(np);
+
+	of_node_put(np);
+	return ret;
 }
 
 #ifdef CONFIG_ACPI
-- 
2.17.1

