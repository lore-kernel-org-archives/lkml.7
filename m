Return-Path: <SRS0=ebdT=SX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D62AC10F14
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Apr 2019 15:06:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F24192086A
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Apr 2019 15:06:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="o+/AFTrM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727585AbfDUPGA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 21 Apr 2019 11:06:00 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:33894 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727228AbfDUPF7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Apr 2019 11:05:59 -0400
Received: by mail-lj1-f196.google.com with SMTP id j89so8400390ljb.1;
        Sun, 21 Apr 2019 08:05:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=neW9Z2muRazppX6r3acCm70v3rfLtaqcH4W12B5drpc=;
        b=o+/AFTrMli4ngfSDgiYGmOvdi82hmpAFcHuglD8KEWrLybW7kbwdniFUnBRw7sCVyt
         Fnk4Bb5znq2xAhhgPWvM3vLq7/OMC7BVQoiy8EIb8roE7Fmb3HxHItJlaruDBgkrAWUI
         gzXr+kP6H9l0zKKdL675ovXU7so4n1mdhnOnoklnoyxTVybyKgAAU4cwcz/3DDpFxku8
         DGKBLtjwUoIcyMAPXTwQlR4k8AVCfZX11iHImVyLRKPUQecfd1HWU1l+ckcjI3UfEK7p
         tFzww97WmJ+dhOeYC2xT1KiZpWmE11YRxgNbRSqBUA/+9zZk8znpcBp7VRFyZ5jrp+SA
         LBQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=neW9Z2muRazppX6r3acCm70v3rfLtaqcH4W12B5drpc=;
        b=nxjiQiZysbf0D197nKwPADAWEs4PoZxQvPVPNjBN1C7ESgVHfACBL2Z9Dd7pCzfo9n
         lsMy7tQvUZ44EpYbEiWerQ7du9lrvT9pI4NhpThxlLm7XZjM9wI79C0Fe5T7+2BHKFME
         x5HTZ3qyNXbBeZv7xjesxhXmPZp7TYe4H+QOZMm+EaQ5K0j5mdQi+APR3YgnhCODIsRt
         OYXgCsdo4TGymyCYW/mA7PY49Py90Rw2mczXSCdeRZBHH0ZYxwJT56uDdErjh7vDiW2U
         eQJhXVcofYE/uN/Jjqfb2wmpyMRGj7O+BgOsm+py10HoWchr5U9gjUpNq+sTCiYg+1II
         MiyQ==
X-Gm-Message-State: APjAAAWwh4Qmu1lYMlg7CdvdUw2Np5A1LIJwrxsWk9Kau7bJ0L0t5uHm
        tPXYD414MdnHavOHbyY0IJw=
X-Google-Smtp-Source: APXvYqyfjLII0YN0iGw64oR1f1UTki9rXy2FvbkgQnZ2aAcVROyECaQpfUwzKCa4EcKDOQxHHnkXnA==
X-Received: by 2002:a2e:8316:: with SMTP id a22mr7752585ljh.171.1555859157352;
        Sun, 21 Apr 2019 08:05:57 -0700 (PDT)
Received: from localhost.localdomain (87-181-108.netrun.cytanet.com.cy. [87.228.181.108])
        by smtp.gmail.com with ESMTPSA id v11sm2498981lfb.68.2019.04.21.08.05.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 21 Apr 2019 08:05:56 -0700 (PDT)
From:   mohankumar718@gmail.com
To:     rjw@rjwysocki.net
Cc:     viresh.kumar@linaro.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, lkp@intel.com,
        Mohan Kumar <mohankumar718@gmail.com>
Subject: [RESEND] drivers: cpufreq: use kstrtoul instead of obsolete simple_strtoul issue fixed
Date:   Sun, 21 Apr 2019 18:05:56 +0300
Message-Id: <20190421150556.23341-1-mohankumar718@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Mohan Kumar <mohankumar718@gmail.com>

Replace the obsolte simple_strtoul function with kstrtoul.

Signed-off-by: Mohan Kumar <mohankumar718@gmail.com>
---
 drivers/cpufreq/elanfreq.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/cpufreq/elanfreq.c b/drivers/cpufreq/elanfreq.c
index 03419f064752..6d861c2364e2 100644
--- a/drivers/cpufreq/elanfreq.c
+++ b/drivers/cpufreq/elanfreq.c
@@ -184,7 +184,8 @@ static int elanfreq_cpu_init(struct cpufreq_policy *policy)
  */
 static int __init elanfreq_setup(char *str)
 {
-	max_freq = simple_strtoul(str, &str, 0);
+	unsigned long int val = 0;
+	max_freq = kstrtoul(str, 0, &val);
 	pr_warn("You're using the deprecated elanfreq command line option. Use elanfreq.max_freq instead, please!\n");
 	return 1;
 }
-- 
2.17.1

