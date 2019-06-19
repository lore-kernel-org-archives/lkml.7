Return-Path: <SRS0=wAGj=US=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 061DDC31E49
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Jun 2019 11:35:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CA4462080C
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Jun 2019 11:35:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="kxQEEkAR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731689AbfFSLfx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Jun 2019 07:35:53 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:33276 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731678AbfFSLfw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jun 2019 07:35:52 -0400
Received: by mail-pf1-f196.google.com with SMTP id x15so9598014pfq.0
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jun 2019 04:35:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=FbHOn34+83W+J2f3XHDBG84b3Et0zmkMSETpfTN9TuM=;
        b=kxQEEkARyeojCDFzYuUzvewk7k5NUoW6fOXRw1fAAx6pBEVaVHsSoG8181u8HnoUQR
         HCjSIYu4FDMdSwO9QBQ93ghJTvXQDRKOrxOtSZOl5PhFiiFU6XwXd5O8bak1li6slYht
         j7bdEzNIX25FMM2uw48OrNOWIXoFOwV4QbyMGJ2c5X6VGC1byZeaSeNgniZzuomvyMeP
         wg/5VA9N7vddpB/zl4Gn4MzYwj8Opeas3K04pBMwCaHvvk44VigdHc70Ckg6SH1QfY2F
         LI2WDPgEQokwMwp8Kj9Uzpoz+jkMOtbJ1IjU9IwjcE33zLlMikRaHo66K67Qmri+abuV
         2dYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=FbHOn34+83W+J2f3XHDBG84b3Et0zmkMSETpfTN9TuM=;
        b=jLTpwhytZTkeKX39dCqVC8UvIojESPVTT0DfoXqf1f3ORK7SfiV0E9yHnCHuuWMbJu
         doI8pJSFJfxFNSpN9k830S8C4Qly8HrYdmhFPCiYMJIaDJw700x+dHzeBAnoy2PSdKp/
         JM3ty4YPC7tDtcSkF2ZuL+TcRuVyrhM20e0/297y2CkMfTFOgMemUYKuGz6G1asyahvV
         Csmn4ocBZeJ1KrGXP5dF5aSszV2jESTRre1S3yPIbGTq+cnDnVbj2dK5MlekcNzmZ2Aj
         y4U9X0w4hNA2G7jynH/wkmCt0TvYbtY4P3mPTX+Jprui4Yzpni43L4GcduMNo1pzOzr7
         +PgQ==
X-Gm-Message-State: APjAAAUl36Vk40l2rVf6LmZTKzeXOL5zbb7YIgckiB4GsY0KvIYIdRyQ
        VT9vYFE08pGeTyoDgSiksHdjXQ==
X-Google-Smtp-Source: APXvYqwEaddn1dtM4dOCfxOC76QcrJ7ZTyHCY9/nBUUNPVUtC4wDY3jICstD5hqfyg1vgDSrr6sjxA==
X-Received: by 2002:a62:2b81:: with SMTP id r123mr82588812pfr.108.1560944151327;
        Wed, 19 Jun 2019 04:35:51 -0700 (PDT)
Received: from localhost ([122.172.66.84])
        by smtp.gmail.com with ESMTPSA id y22sm38252952pgj.38.2019.06.19.04.35.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 19 Jun 2019 04:35:50 -0700 (PDT)
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Rafael Wysocki <rjw@rjwysocki.net>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/6] cpufreq: Remove the redundant !setpolicy check
Date:   Wed, 19 Jun 2019 17:05:37 +0530
Message-Id: <b9bac95bcc36f5f70e910e4801be5d4f8fd32d0c.1560944014.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.21.0.rc0.269.g1a574e7a288b
In-Reply-To: <cover.1560944014.git.viresh.kumar@linaro.org>
References: <cover.1560944014.git.viresh.kumar@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

cpufreq_start_governor() is only called for !setpolicy case, checking it
again is not required.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/cpufreq/cpufreq.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
index 85ff958e01f1..54befd775bd6 100644
--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -2153,7 +2153,7 @@ static int cpufreq_start_governor(struct cpufreq_policy *policy)
 
 	pr_debug("%s: for CPU %u\n", __func__, policy->cpu);
 
-	if (cpufreq_driver->get && !cpufreq_driver->setpolicy)
+	if (cpufreq_driver->get)
 		cpufreq_update_current_freq(policy);
 
 	if (policy->governor->start) {
-- 
2.21.0.rc0.269.g1a574e7a288b

