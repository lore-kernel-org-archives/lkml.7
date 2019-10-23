Return-Path: <SRS0=OaAC=YQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4A7DCA9EAE
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 04:31:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 843B72086D
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 04:31:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d/UeAKEW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730650AbfJWEb6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Oct 2019 00:31:58 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:46564 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725773AbfJWEb5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Oct 2019 00:31:57 -0400
Received: by mail-io1-f65.google.com with SMTP id c6so23217265ioo.13
        for <linux-kernel@vger.kernel.org>; Tue, 22 Oct 2019 21:31:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=NGMLML8IKQMLZFW+6VDxAD0zaTRhNeximY488B0GKP8=;
        b=d/UeAKEWSl2GIHhIhh59Fw6MWWVs03I81D+6yD/uYU9lsHjSLqSLCP1BrR06rHgYpK
         v8XAGA8YLOjIZ30TDhKpz4cbDUksFA8mY4MSnA+m0K/npj+PaasdTPkjNjQOUSTFtwvF
         3UB3Jj7z0af7pH8cYjqjfoCE6VEJ/XAEiTWzk3UgxMgUZZ6N0NwWfDjfRrLeXUn5xyp6
         C/U3S6XbGb/lb+FlxIkYYZ5E+BWvNaCettAFeKRF63zIDICvuLi8ADDyRDmhWI2bO/Eu
         8JVcthF/p2uQ4qaJIn6B8MIc/26eOgjABdjwyzl8QKVqjlbn5ov8MftpO4CboIVPb9xd
         QeGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=NGMLML8IKQMLZFW+6VDxAD0zaTRhNeximY488B0GKP8=;
        b=XSSPw7oQkcdTjpbQRh8ub90O/Wo6iH56TJQ7zASctl8DmN8h9/SJd5V5QM6aTCQBKy
         Ctz1jlbXir4CpRfwWbgkJyqzUqnBauYYReWJ1UtBFbHKXisL5JgKvgSWrxsTKnZ/5yxg
         36XMhaY3BikU4DYxYg+rWajN5AZqEYJCDbGo1tSSuehOcz3aG9WS3hBVrrWUzxC1aYX2
         YCVFAUF3dqAo5Fak24tv1ABJ4EVcT1ntLxTdWQImJsdJoS/bEbFFZv7aUK5qjtgmcCQP
         HN1sy9kAzqljK2vXLaYJKr/WGsotrGvxrCSQcVpb2QyV0fzsixU+AAObFhHCc93YdxNu
         urdg==
X-Gm-Message-State: APjAAAXkOjgom28tTEQx0mMuyFCAWtK0LWIwWu5MIcv1bFigG+QI/YRB
        QJIjeckXQDsKEEsLnNYs2PI=
X-Google-Smtp-Source: APXvYqwa+rk7FC4WOm3QHKl1zrKosjgaiN7I+AkChk0t8STWUALPGtx8Cerovi0+YAEwwtIdTzW8jg==
X-Received: by 2002:a02:ce9c:: with SMTP id y28mr7623711jaq.84.1571805116709;
        Tue, 22 Oct 2019 21:31:56 -0700 (PDT)
Received: from cs-dulles.cs.umn.edu (cs-dulles.cs.umn.edu. [128.101.35.54])
        by smtp.googlemail.com with ESMTPSA id k2sm6298667ios.19.2019.10.22.21.31.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Oct 2019 21:31:55 -0700 (PDT)
From:   Navid Emamdoost <navid.emamdoost@gmail.com>
To:     michal.simek@xilinx.com
Cc:     emamd001@umn.edu, smccaman@umn.edu, kjlu@umn.edu,
        Markus.Elfring@web.de, Navid Emamdoost <navid.emamdoost@gmail.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2] clocksource/drivers: Fix memory leak in ttc_setup_clockevent
Date:   Tue, 22 Oct 2019 23:31:38 -0500
Message-Id: <20191023043139.31183-1-navid.emamdoost@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <2a6cdb63-397b-280a-7379-740e8f43ddf6@xilinx.com>
References: <2a6cdb63-397b-280a-7379-740e8f43ddf6@xilinx.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In the implementation of ttc_setup_clockevent() release the allocated
memory for ttcce if clk_notifier_register() fails.

Fixes: 70504f311d4b ("clocksource/drivers/cadence_ttc: Convert init function to return error")
Signed-off-by: Navid Emamdoost <navid.emamdoost@gmail.com>
---
Changes in v2:
	- Added goto label for error handling
	- Update description and fix typo

 drivers/clocksource/timer-cadence-ttc.c | 19 ++++++++++---------
 1 file changed, 10 insertions(+), 9 deletions(-)

diff --git a/drivers/clocksource/timer-cadence-ttc.c b/drivers/clocksource/timer-cadence-ttc.c
index 88fe2e9ba9a3..0caacbc67102 100644
--- a/drivers/clocksource/timer-cadence-ttc.c
+++ b/drivers/clocksource/timer-cadence-ttc.c
@@ -411,10 +411,8 @@ static int __init ttc_setup_clockevent(struct clk *clk,
 	ttcce->ttc.clk = clk;
 
 	err = clk_prepare_enable(ttcce->ttc.clk);
-	if (err) {
-		kfree(ttcce);
-		return err;
-	}
+	if (err)
+		goto release_ttcce;
 
 	ttcce->ttc.clk_rate_change_nb.notifier_call =
 		ttc_rate_change_clockevent_cb;
@@ -424,7 +422,7 @@ static int __init ttc_setup_clockevent(struct clk *clk,
 				    &ttcce->ttc.clk_rate_change_nb);
 	if (err) {
 		pr_warn("Unable to register clock notifier.\n");
-		return err;
+		goto release_ttcce;
 	}
 
 	ttcce->ttc.freq = clk_get_rate(ttcce->ttc.clk);
@@ -453,15 +451,18 @@ static int __init ttc_setup_clockevent(struct clk *clk,
 
 	err = request_irq(irq, ttc_clock_event_interrupt,
 			  IRQF_TIMER, ttcce->ce.name, ttcce);
-	if (err) {
-		kfree(ttcce);
-		return err;
-	}
+	if (err)
+		goto release_ttcce;
 
 	clockevents_config_and_register(&ttcce->ce,
 			ttcce->ttc.freq / PRESCALE, 1, 0xfffe);
 
 	return 0;
+
+release_ttcce:
+
+	kfree(ttcce);
+	return err;
 }
 
 /**
-- 
2.17.1

