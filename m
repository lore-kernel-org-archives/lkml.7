Return-Path: <SRS0=s1fu=UU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3EC8C43613
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Jun 2019 10:10:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AD4DB208CA
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Jun 2019 10:10:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qzp0hTRF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726653AbfFUKKs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Jun 2019 06:10:48 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:46886 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726250AbfFUKKr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jun 2019 06:10:47 -0400
Received: by mail-lf1-f67.google.com with SMTP id z15so4579210lfh.13;
        Fri, 21 Jun 2019 03:10:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=lsi49V042X5SWmg6BSidCYgRSFhgOwzB87kQ9VdAW8o=;
        b=qzp0hTRFCDIDeoedMK9BpRKxqzS6C1pI6+esntEEcYfmqtwkzp5NXC4jYaXwteqygK
         CqSGWHVG4k4v7+yE3LAeTBcAiHNN3io20g6hwRYSaf/EXL/SVMtxrXQ3vxqEm414BIyD
         VX3HQASBQiKO21CBcyZ89utPkHakicR2L24Bp9iCgOUH2vMaBe+ZrNcIpq3rp3jvECHg
         pwiCLWYionUUf99aMOat0gj+kNg30X0z4PreIKxyEZPb6RwYutO+rw4X8aMFqNlueZ/g
         AyuzlddU1T6d9qZujNvPgdwxfvDMJgzhZCvpnN3VPDESyZdPzg5Q3w5LGBo8QjNpC4+r
         +LBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=lsi49V042X5SWmg6BSidCYgRSFhgOwzB87kQ9VdAW8o=;
        b=gdWsf0y75rqBCGcU696TfrLI0TaVvbHXqJyDBE57/jkFNT5PWQNc4Uviw3hLRrDdIm
         Lh1aK7W7JOnzuby85n52bhoes6X5vE7mAhG4sZhMiwXBFw/dJe9jYynATD/1aTJuUqeF
         0SLsFHhZVAotrHjEJOGofuSG2BC0FtDSKG8iO1TfBU4fJHoeOODryilu/b6ditYFACFP
         +bk6TKH01aARqIjHbA679wjLfbWTs4HwnxPUDhvPYgQ8wbr4CrVGb6lc8EOiaNxmE421
         n0vXNCH7BIepyleGuY9mPkz+JUZFkspfGLItT86A7YML9p5LSYBUD898xpnpPERvAo09
         0xXw==
X-Gm-Message-State: APjAAAXptU5SpiSKsZqKPkdo8xwRyynfBkHXpoKVykplWIUP3vvVvmdc
        FuHfygmDzudOZa1bp0KjHC4=
X-Google-Smtp-Source: APXvYqx/9ppnZW4xbdyg4lcYqhaoRIjkyukoC0ZmlidFFnVnqDqiiVdEvCJdVq1ZJqgC6LBzCFWoQg==
X-Received: by 2002:a05:6512:15a:: with SMTP id m26mr24145742lfo.71.1561111845230;
        Fri, 21 Jun 2019 03:10:45 -0700 (PDT)
Received: from localhost.localdomain ([2a02:a315:5445:5300:a5e4:32fe:c6e4:d5eb])
        by smtp.googlemail.com with ESMTPSA id r24sm365944ljb.72.2019.06.21.03.10.43
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 21 Jun 2019 03:10:44 -0700 (PDT)
From:   =?UTF-8?q?Pawe=C5=82=20Chmiel?= <pawel.mikolaj.chmiel@gmail.com>
To:     kgene@kernel.org
Cc:     krzk@kernel.org, rjw@rjwysocki.net, viresh.kumar@linaro.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [RESEND,v2] cpufreq: s5pv210: Don't flood kernel log after cpufreq change
Date:   Fri, 21 Jun 2019 12:10:43 +0200
Message-Id: <20190621101043.10549-1-pawel.mikolaj.chmiel@gmail.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This commit replaces printk with pr_debug, so we don't flood kernel log.

Signed-off-by: Paweł Chmiel <pawel.mikolaj.chmiel@gmail.com>
Acked-by: Krzysztof Kozlowski <krzk@kernel.org>
---
Changes from v1:
  - Added Acked-by
---
 drivers/cpufreq/s5pv210-cpufreq.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/cpufreq/s5pv210-cpufreq.c b/drivers/cpufreq/s5pv210-cpufreq.c
index 5b4289460bc9..c7b7d1e65b08 100644
--- a/drivers/cpufreq/s5pv210-cpufreq.c
+++ b/drivers/cpufreq/s5pv210-cpufreq.c
@@ -481,7 +481,7 @@ static int s5pv210_target(struct cpufreq_policy *policy, unsigned int index)
 				arm_volt, arm_volt_max);
 	}
 
-	printk(KERN_DEBUG "Perf changed[L%d]\n", index);
+	pr_debug("Perf changed[L%d]\n", index);
 
 exit:
 	mutex_unlock(&set_freq_lock);
-- 
2.17.1

