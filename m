Return-Path: <SRS0=wu79=TZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 141D1C07542
	for <linux-kernel@archiver.kernel.org>; Sat, 25 May 2019 18:43:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DDA0720862
	for <linux-kernel@archiver.kernel.org>; Sat, 25 May 2019 18:43:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="V2509mVz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727514AbfEYSnG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 25 May 2019 14:43:06 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:35343 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725838AbfEYSnA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 May 2019 14:43:00 -0400
Received: by mail-wr1-f66.google.com with SMTP id m3so13001456wrv.2;
        Sat, 25 May 2019 11:42:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/BXVDsarFTRUazUo4dgncRjwz7qqivgpQXkEsG5qr/A=;
        b=V2509mVz46xNeb2AFiUyTgKK3LQv62jXAR4XzrF0gbJb01Ql2EHQEAhVaniRQSCjYr
         q5+IzqQotlFy1h6MiSVLRvRqzTnd0Zd4D6OQuSuS6EuVDdPmTXC+rwdWczVMvdT3iEJ1
         MjccrfHm1wflZ3/0OHB3APawxTLYIBKpoUgOVJZe26avayGNsK8mAyx2ZsOaByVhFr6A
         qukkm0nW6jWAHIKIfTWPmxZ1diNDcn8ShOATHn1TZk7LsNSdqy/HQF22o1JtNtsMnBza
         Rj5ZIMWKcrOunHmFWRyqVgzIUYVRDwIn9N1wKlNBDiMUjR0fWXD5DXCo7FlblwY1QrfW
         VxyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/BXVDsarFTRUazUo4dgncRjwz7qqivgpQXkEsG5qr/A=;
        b=qTkgeKXMOvUPh4M3bGo3bMMCedyrbbTQhM0VHomRoQ2bA1Q3EB+sppPqh25GIhHKVw
         sp5e/GT644ZkC+C+A4xkwjUIsQ500V8bk7NsCPHaNlbXmcOoUpjf2MreRuAAvPne2nNU
         DUtgdxN/GHP5Y0kDtt4yLw5xbqAu+4plQK13m66AaX39W96aHfP5IzwZHwweWMXD3wdt
         EiOyf2h/KpnYKa6Myr9KOtivFrc1PNjJFO1GU82yUGHUV2ks0OQa3bHcZuMUhJHR9Z7p
         gVGd0TB3+RPKXJr53vjNF8sZCksi2BELh//kZ1KGW0Mapuqo5/D14+UjCzpijr6Osmhr
         mheg==
X-Gm-Message-State: APjAAAUaujbl8wHGZBCnvXrk7QrB5UAeEBGIb0sVWxEKGqMTMYFSdyaH
        kM33k+tnxeB+f5bbndffsZydTOh5
X-Google-Smtp-Source: APXvYqwDyFKXlwGoxgbo2oy86MnaWJDA0d2MBAYF6xtgJ/BHLFG5DScOmv3lnUmW/OwTtMdc3jLVbg==
X-Received: by 2002:adf:b447:: with SMTP id v7mr67716393wrd.267.1558809778106;
        Sat, 25 May 2019 11:42:58 -0700 (PDT)
Received: from blackbox.darklights.net (p200300F133DDA4007CB8841254CD64FD.dip0.t-ipconnect.de. [2003:f1:33dd:a400:7cb8:8412:54cd:64fd])
        by smtp.googlemail.com with ESMTPSA id f20sm5327546wmh.22.2019.05.25.11.42.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 25 May 2019 11:42:57 -0700 (PDT)
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
To:     linux-clk@vger.kernel.org, mturquette@baylibre.com,
        sboyd@kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: [PATCH 1/1] clk: pwm: implement the .get_duty_cycle callback
Date:   Sat, 25 May 2019 20:42:53 +0200
Message-Id: <20190525184253.3088-2-martin.blumenstingl@googlemail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190525184253.3088-1-martin.blumenstingl@googlemail.com>
References: <20190525184253.3088-1-martin.blumenstingl@googlemail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 9fba738a53dda2 ("clk: add duty cycle support") added support for
getting and setting the duty cycle of a clock. This implements the
get_duty_cycle callback for PWM based clocks so the duty cycle is shown
in the debugfs output (/sys/kernel/debug/clk/clk_summary).

Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
---
 drivers/clk/clk-pwm.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/clk/clk-pwm.c b/drivers/clk/clk-pwm.c
index 02b472a1f9b0..c0cd6a0ff7f8 100644
--- a/drivers/clk/clk-pwm.c
+++ b/drivers/clk/clk-pwm.c
@@ -47,10 +47,24 @@ static unsigned long clk_pwm_recalc_rate(struct clk_hw *hw,
 	return clk_pwm->fixed_rate;
 }
 
+static int clk_pwm_get_duty_cycle(struct clk_hw *hw, struct clk_duty *duty)
+{
+	struct clk_pwm *clk_pwm = to_clk_pwm(hw);
+	struct pwm_state state;
+
+	pwm_get_state(clk_pwm->pwm, &state);
+
+	duty->num = state.duty_cycle;
+	duty->den = state.period;
+
+	return 0;
+}
+
 static const struct clk_ops clk_pwm_ops = {
 	.prepare = clk_pwm_prepare,
 	.unprepare = clk_pwm_unprepare,
 	.recalc_rate = clk_pwm_recalc_rate,
+	.get_duty_cycle = clk_pwm_get_duty_cycle,
 };
 
 static int clk_pwm_probe(struct platform_device *pdev)
-- 
2.21.0

