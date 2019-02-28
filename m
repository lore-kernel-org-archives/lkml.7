Return-Path: <SRS0=g5d9=RD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0ADC1C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 13:59:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CE38120C01
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 13:59:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="uqYkkokA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732477AbfB1N7d (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Feb 2019 08:59:33 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:43525 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732379AbfB1N7a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Feb 2019 08:59:30 -0500
Received: by mail-lj1-f196.google.com with SMTP id z20so17191708ljj.10
        for <linux-kernel@vger.kernel.org>; Thu, 28 Feb 2019 05:59:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=2BruUQQ7aW9EaagD7/EmEPsgX/D81d/9BI5IBra5MPM=;
        b=uqYkkokAa+r7JCLMxm0hjne5g4aALwkukVEoYxwsWieJd65XUqpe/xT05mFKyU4ETu
         /j7xYRxWRYy8CYwB/WOGFMUC9v7DTuYHpqNeihCKdXdTTPwZmB/9STwM1CPfCf1b5GZB
         6OJ5OZ5uYtGMGi/GTVaVIIPjaEEnvJjQcb18EmCJy+x026RWta1Pd8pXfaG/uEK66fAQ
         /kuDTo1nGn8mTKuYcJFZHg8wlo7vlIoPNXNe0LWIm2eGVnw0G944PG+s7KkOkpSDhssW
         e/oT4Djp0KEcoaIuUpzFmATtlBXBfNsru9aa2AsPvvpXEZEtWw1Mq6rxE9Bqcf58N1Kx
         eUAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=2BruUQQ7aW9EaagD7/EmEPsgX/D81d/9BI5IBra5MPM=;
        b=A5HdXk0/3tthiWK79A+Sdz+uYpVM4y1yRehytVcgPH0SN8T4Rs924ut7oGzU9/pxs5
         RGbdy+Hfh94o6fNyha6TmcyCSaP9V1C0lpMiDhos6cxVa+nJTirftrtcwS4oeX4uyzqd
         +eWaAjM9TSBSUbtu/bcHc1p9DI43jitjamMcdsvFSZNZotY5Oc3x6RSifyhVhHztqnXR
         8MuasIozDK1+WM/3Qu8XSoQS1kxYB+ZJyl1BjlPCL7xnlZXbYP2Bn/iSC0K5vmliyaca
         SXoUe6Kcf50jjC/eDv7mcNJCNhFwSkci5D0xnpRZXasa6l6+F6V/X6gEcGCZNuG+E5rt
         L1yQ==
X-Gm-Message-State: AHQUAuZM23CRq/k65XhjqU5EEQI2iCnGW6s6g1Av5SzgyAMqWYzkGADB
        i3ZrIIeoRBCelb8lmYVqW6STLg==
X-Google-Smtp-Source: AHgI3Ia4KoBvSdBieOMCmVGsDRu9l4UaY/6HlXoArsaw2oUwTLF8t/J3LQb9JhW62pMGDKeI6dRweg==
X-Received: by 2002:a2e:5cc1:: with SMTP id q184mr4742565ljb.123.1551362368019;
        Thu, 28 Feb 2019 05:59:28 -0800 (PST)
Received: from uffe-XPS-13-9360.ideon.se ([85.235.10.227])
        by smtp.gmail.com with ESMTPSA id v20sm4090265ljv.83.2019.02.28.05.59.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 28 Feb 2019 05:59:27 -0800 (PST)
From:   Ulf Hansson <ulf.hansson@linaro.org>
To:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Lina Iyer <ilina@codeaurora.org>,
        Ulf Hansson <ulf.hansson@linaro.org>, linux-pm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/7] MAINTAINERS: Update files for PSCI
Date:   Thu, 28 Feb 2019 14:59:14 +0100
Message-Id: <20190228135919.3747-3-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190228135919.3747-1-ulf.hansson@linaro.org>
References: <20190228135919.3747-1-ulf.hansson@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The files for the PSCI firmware driver were moved to a sub-directory, let's
update MAINTAINERS to reflect that.

Suggested-by: Mark Rutland <mark.rutland@arm.com>
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 32b76cb95f57..ff998605b773 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -12182,7 +12182,7 @@ M:	Mark Rutland <mark.rutland@arm.com>
 M:	Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
 L:	linux-arm-kernel@lists.infradead.org
 S:	Maintained
-F:	drivers/firmware/psci*.c
+F:	drivers/firmware/psci/
 F:	include/linux/psci.h
 F:	include/uapi/linux/psci.h
 
-- 
2.17.1

