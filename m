Return-Path: <SRS0=BPXs=SN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6D5CC10F13
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 12:48:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B6DEE21871
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 12:48:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="Y9VX6vF2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727185AbfDKMsS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Apr 2019 08:48:18 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:35025 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726832AbfDKMsQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Apr 2019 08:48:16 -0400
Received: by mail-qk1-f193.google.com with SMTP id a71so3344841qkg.2
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2019 05:48:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=v8YRfd9/nj3nRdlwjpQLHs10suvZojy3m14ocFvDPe4=;
        b=Y9VX6vF2V1EJfosrzQrn4ay9uuwewLljC4/FiNawTYohOkPKfDhpyfVWKSE4wRsPcE
         r/61hfBw4a8V/rSNVObB863dCOJQlGBjm3Ukcj46RHvOhvQ1yzfxIJjB8sSCipRh/7v3
         8uBYQ5+QtmQX+pN54gNHpmdwcMSJXV2pcNOaPCecMRlPSEFOzccuh++bB0Qj84I+1PxT
         Rkd397UkPCcbZCniuV9cigeB2KfAPfwKyrsdiOrwoILojl07jnOAy/D0gQpHJ5Tx+Rt4
         q+CaAq3pY/1lq8YuFqrc1DIl8VC0rvFZAdLHkWZ1+5t4rHR7UCw4+e8U9LW2nzNtDsDe
         UBOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=v8YRfd9/nj3nRdlwjpQLHs10suvZojy3m14ocFvDPe4=;
        b=MTtgLs8Xs+Zbeb1gOcm87yJBaS6iE3rH+kkutzGdNYCflmOpeUVj7RuGVKciMfanFd
         3VVluNlqQoWn7wYn+Fna85+hqvj3JKBJ2ElOvPNyZxe+jIhwnIn85AlbzqkYQA1gEkch
         7S6CXZ9RKQ2pm6Egt5FMcS+ur5RwPql22PJJrhkiS4z5HioWE7/I+KShH3i4YcX3Lwcr
         SzIvOOmR21xd96KEw4clmC9VDt6Hs+77fRKmkqft9ya6viqxD9718wHeuVQg5dGU03tT
         POsr3iXb88io2aDNuGDC+sBm+Umntt9k02T2m0/l1dj/SV6wQVOHpPXA08cfLIK1IpTT
         +Yrg==
X-Gm-Message-State: APjAAAUE85B1BeW4Rdb+21dk/Wy4CAN4D0U41NaLL1nYIlqkqdic7nO+
        9ZFgeTY+AuXPPSCoI3g8HO8+CCURU+0=
X-Google-Smtp-Source: APXvYqzJO6AqlihTSDk0OKRS6AaYTxiEL6t84h+G7QNTt9KrjNL6e4bxpTt8yZFhioQyHIrDxrJoyQ==
X-Received: by 2002:ae9:e002:: with SMTP id m2mr38822766qkk.178.1554986895974;
        Thu, 11 Apr 2019 05:48:15 -0700 (PDT)
Received: from Qians-MBP.fios-router.home (pool-71-184-117-43.bstnma.fios.verizon.net. [71.184.117.43])
        by smtp.gmail.com with ESMTPSA id q6sm24745152qkj.87.2019.04.11.05.48.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 11 Apr 2019 05:48:15 -0700 (PDT)
From:   Qian Cai <cai@lca.pw>
To:     gregkh@linuxfoundation.org
Cc:     rjw@rjwysocki.net, khilman@kernel.org, ulf.hansson@linaro.org,
        pavel@ucw.cz, len.brown@intel.com, lina.iyer@linaro.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Qian Cai <cai@lca.pw>
Subject: [PATCH -next] power/domain_governor: fix a compilation error
Date:   Thu, 11 Apr 2019 08:47:39 -0400
Message-Id: <20190411124739.5542-1-cai@lca.pw>
X-Mailer: git-send-email 2.20.1 (Apple Git-117)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The commit 50899f7d5078 ("PM / Domains: Add genpd governor for CPUs")
introduced a compilation error on arm64 with CONFIG_CPU_IDLE=n because
cpuidle_devices is undefined there.

drivers/base/power/domain_governor.o: In function `cpu_power_down_ok':
drivers/base/power/domain_governor.c:263: undefined reference to
'cpuidle_devices' ld: drivers/base/power/domain_governor.o: relocation
R_AARCH64_ADR_PREL_PG_HI21 against symbol 'cpuidle_devices' which may
bind externally can not be used when making a shared object; recompile
with -fPIC
drivers/base/power/domain_governor.c:263:(.text+0x638): dangerous
relocation: unsupported relocation
drivers/base/power/domain_governor.c:263: undefined reference to
'cpuidle_devices'
make: *** [Makefile:1047: vmlinux] Error 1

Signed-off-by: Qian Cai <cai@lca.pw>
---
 drivers/base/power/domain_governor.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/drivers/base/power/domain_governor.c b/drivers/base/power/domain_governor.c
index 39c8a699cb53..252d88fcf760 100644
--- a/drivers/base/power/domain_governor.c
+++ b/drivers/base/power/domain_governor.c
@@ -270,11 +270,13 @@ static bool cpu_power_down_ok(struct dev_pm_domain *pd)
 	 */
 	domain_wakeup = ktime_set(KTIME_SEC_MAX, 0);
 	for_each_cpu_and(cpu, genpd->cpus, cpu_online_mask) {
-		dev = per_cpu(cpuidle_devices, cpu);
-		if (dev) {
-			next_hrtimer = READ_ONCE(dev->next_hrtimer);
-			if (ktime_before(next_hrtimer, domain_wakeup))
-				domain_wakeup = next_hrtimer;
+		if (IS_ENABLED(CONFIG_CPU_IDLE)) {
+			dev = per_cpu(cpuidle_devices, cpu);
+			if (dev) {
+				next_hrtimer = READ_ONCE(dev->next_hrtimer);
+				if (ktime_before(next_hrtimer, domain_wakeup))
+					domain_wakeup = next_hrtimer;
+			}
 		}
 	}
 
-- 
2.20.1 (Apple Git-117)

