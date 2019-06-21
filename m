Return-Path: <SRS0=s1fu=UU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5DD0C43613
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Jun 2019 13:23:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B0DD6208C3
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Jun 2019 13:23:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="lTye1pRr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726163AbfFUNX1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Jun 2019 09:23:27 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:53456 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726018AbfFUNX0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jun 2019 09:23:26 -0400
Received: by mail-wm1-f65.google.com with SMTP id x15so6304565wmj.3
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jun 2019 06:23:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=Ivwcwk4wjlXTEFrBezW9m8Osb/vrzZPgsbaTndGY63w=;
        b=lTye1pRrvYZaUqUpAY6fIcyP/rdkZZeh1TaiSOM/mfknHGEy22SVpna5CjRIIwa1bl
         Dgw016BteCVdF+4HcJTkyQLXjmxEnozwPGmJwAJ1Nc+nP87UN6B8j1uyHwMEmJHqAmau
         byssz6VnmjMEZmF/DPqgWpfYmPBXNmeItqpwu56fXX/y4S77vtGkOxSkHsRrxpR/rBNj
         k3e+tXOsg3ycq1FtK/wrwuCRt8bOTCRyfzyCv14YsscKyFOeVWYZUYFeaxC5EORYMgk5
         Ds6ek3TI/7ZxwqWYSuz5MseJ0ww/p1NukAJLbKQ69SSdCpI0Z6KgPQxjntLWq1XfKeQt
         leBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=Ivwcwk4wjlXTEFrBezW9m8Osb/vrzZPgsbaTndGY63w=;
        b=c5qg3MAU2Lvaw82s3mXp5Br2oSDjWJX28VH7dhXJomt36wTDrG9qtZkEj2AEa2cRr6
         oGA6RpaZ1WgwgTxHy4V0Ho+gKZz77ukaQ1GVfshrhSIDfkijDgPq7UT3evW3SByHp9sr
         2t61dsXJwnxVTG181c4LR3fQNYB41bFFcWyDYIWbSYqTQ1w1BY8z2ozYJ1MvxH170f9J
         2ndsr50Am62w0bWqhWUTKC9+i5mdhm3QHjm97Z46VslKVup8UptEmhYt5oo75ql6lFkp
         pgpx0NGmokHS5+i/VMU3iO8Po1/wnnaV3U0ZELlZTssgGPe5+ezhGmSKLGJtQKlNKVrn
         9dvw==
X-Gm-Message-State: APjAAAULJkeRgR1y01BGyk79nmooxqKPjS+JIIcm437l0uMZhASuRzPO
        qiZfQw0B20wD6B6rqmgPhk2pGA==
X-Google-Smtp-Source: APXvYqx1UH9Z6qhqH1hBWaKqMdMAjh/YvMf9a9gg5RQh/ezlTfhGqx0ecaIVn/Ru2Plm8dK5aI0fFw==
X-Received: by 2002:a1c:39d6:: with SMTP id g205mr3957146wma.85.1561123404531;
        Fri, 21 Jun 2019 06:23:24 -0700 (PDT)
Received: from clegane.local (206.105.129.77.rev.sfr.net. [77.129.105.206])
        by smtp.gmail.com with ESMTPSA id s188sm1981234wmf.40.2019.06.21.06.23.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 21 Jun 2019 06:23:23 -0700 (PDT)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     viresh.kumar@linaro.org
Cc:     edubezval@gmail.com, linux-kernel@vger.kernel.org,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        linux-pm@vger.kernel.org (open list:CPU FREQUENCY SCALING FRAMEWORK)
Subject: [PATCH 1/6] cpufreq: Use existing stub functions instead of IS_ENABLED macro
Date:   Fri, 21 Jun 2019 15:22:57 +0200
Message-Id: <20190621132302.30414-1-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The functions stub already exist for the condition the IS_ENABLED
is trying to avoid.

Remove the IS_ENABLED macros as they are pointless.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/cpufreq/cpufreq.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
index 85ff958e01f1..7c72f7d3509c 100644
--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -1378,8 +1378,7 @@ static int cpufreq_online(unsigned int cpu)
 	if (cpufreq_driver->ready)
 		cpufreq_driver->ready(policy);
 
-	if (IS_ENABLED(CONFIG_CPU_THERMAL) &&
-	    cpufreq_driver->flags & CPUFREQ_IS_COOLING_DEV)
+	if (cpufreq_driver->flags & CPUFREQ_IS_COOLING_DEV)
 		policy->cdev = of_cpufreq_cooling_register(policy);
 
 	pr_debug("initialization complete\n");
@@ -1469,8 +1468,7 @@ static int cpufreq_offline(unsigned int cpu)
 		goto unlock;
 	}
 
-	if (IS_ENABLED(CONFIG_CPU_THERMAL) &&
-	    cpufreq_driver->flags & CPUFREQ_IS_COOLING_DEV) {
+	if (cpufreq_driver->flags & CPUFREQ_IS_COOLING_DEV) {
 		cpufreq_cooling_unregister(policy->cdev);
 		policy->cdev = NULL;
 	}
-- 
2.17.1

