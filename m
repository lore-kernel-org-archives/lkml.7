Return-Path: <SRS0=6dNS=X4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F169C32792
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 21:35:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5CD012133F
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 21:35:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ASTwwcBD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387483AbfJCVfG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Oct 2019 17:35:06 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:39968 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730020AbfJCVfG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Oct 2019 17:35:06 -0400
Received: by mail-pf1-f196.google.com with SMTP id x127so2550548pfb.7
        for <linux-kernel@vger.kernel.org>; Thu, 03 Oct 2019 14:35:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=7AHHcEKrWBM5y9wBFl/C7jzA4xtd9EY/YdeDi/hosms=;
        b=ASTwwcBDLKFauBJRi7fwuLBmPbFmPW/3m9tG2zvZzcpcFnfrephyeKAqsoDz/Gbc66
         sNU/cLXRpwM2QQGC5Tx0G9jDeC8pwZEfAnjhJVs59CzNawD20uQqRrHq58tGrC/fQblp
         hNqMsIa+vM2uuIefpEywLO5YYokaczyteqWGA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=7AHHcEKrWBM5y9wBFl/C7jzA4xtd9EY/YdeDi/hosms=;
        b=RfFz2e6bHVjDCxD59d4Okg3b1hLqCuA4oyWzcYFDRvGIEaV4K0L0kJ4OKtfUrnV8Ka
         aPeWq57GVHjZdvTvuCRWqhhaCqApBClOon9kMdM7CN9MizT6/N4cpzE3a4LK1XZopbFf
         BJ/lsCNOZJvQzj/pAEMYoEu4l7+Mjs8t3yY6O20wlBVmCyu5MrVcpdYpcNU4GP43oQ/k
         0Mrcssy45sb57OAsnuakiQPyADgeNd+dHJoA/wd/FCaYNg5VqGMVyYPDi1CHc/heWXvj
         7Lag40WtCkdAo/dCKx8ecQGq70WbmUYossQMJ2sEFGgZw364noqAY5QvoCXtwTsPndSm
         oiRw==
X-Gm-Message-State: APjAAAV4LszFNZG3lhJmpvBjDX3vr9wKZg/Jnws3qLSNRAAuRAORAFte
        znFvDNjQlW7vZtOZEeOz8mI7qQ==
X-Google-Smtp-Source: APXvYqwzXDfyh4cXIWrG9bwfnxsIwKRIIusw5EU7eFwaLpQRN0oyj60CNEvRM3XFeIwxxnCXAkV7kA==
X-Received: by 2002:a63:4d4e:: with SMTP id n14mr11552757pgl.88.1570138505256;
        Thu, 03 Oct 2019 14:35:05 -0700 (PDT)
Received: from localhost ([2620:15c:202:1:4fff:7a6b:a335:8fde])
        by smtp.gmail.com with ESMTPSA id 30sm3240647pjk.25.2019.10.03.14.35.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Oct 2019 14:35:04 -0700 (PDT)
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Lee Jones <lee.jones@linaro.org>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc:     Matthias Kaehlcke <mka@chromium.org>, linux-pwm@vger.kernel.org,
        linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] backlight: pwm_bl: Add missing curly branches in else branch
Date:   Thu,  3 Oct 2019 14:35:02 -0700
Message-Id: <20191003213502.102110-1-mka@chromium.org>
X-Mailer: git-send-email 2.23.0.444.g18eeb5a265-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add curly braces to an 'else' branch in pwm_backlight_update_status()
to match the corresponding 'if' branch.

Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
---

 drivers/video/backlight/pwm_bl.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/video/backlight/pwm_bl.c b/drivers/video/backlight/pwm_bl.c
index 746eebc411df..130abff2705f 100644
--- a/drivers/video/backlight/pwm_bl.c
+++ b/drivers/video/backlight/pwm_bl.c
@@ -125,8 +125,9 @@ static int pwm_backlight_update_status(struct backlight_device *bl)
 		state.duty_cycle = compute_duty_cycle(pb, brightness);
 		pwm_apply_state(pb->pwm, &state);
 		pwm_backlight_power_on(pb);
-	} else
+	} else {
 		pwm_backlight_power_off(pb);
+	}
 
 	if (pb->notify_after)
 		pb->notify_after(pb->dev, brightness);
-- 
2.23.0.444.g18eeb5a265-goog

