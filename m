Return-Path: <SRS0=uyI7=RK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54B18C43381
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 22:36:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2405F2081B
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 22:36:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jsPvuxfL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726332AbfCGWgu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Mar 2019 17:36:50 -0500
Received: from mail-ed1-f68.google.com ([209.85.208.68]:36645 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726237AbfCGWgu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Mar 2019 17:36:50 -0500
Received: by mail-ed1-f68.google.com with SMTP id g9so14858041eds.3;
        Thu, 07 Mar 2019 14:36:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=cSY72fXaEZa0BLhi/dO9UGYmKDTjiMARYNRRFx7Fp00=;
        b=jsPvuxfL46W0ha6bigCDs0qoq7kJthTVV7y+GjqiRl2RXt+/y/s/lZIE6kIk7xeNVd
         XzN58e/1Nk8A6oxJ4waLZZf+C0ihv5MSTqKBCvmptbVC/InBimX7jLg26WYTLaxTdO4v
         V9mBe0xv2iLKD5Q5lTNjw/XlNjgN3d2O06gVgVxNirrA/YTY+35opmfVxDpdtiYukP4F
         lHOobXOk79LmglxbE8YqqIIxVgjoxewhsEt6BboF1D66NuIFksfRrA9Jp/+yRqB/sByt
         Mg2x/+u0jugaksZ3wI99pLg9HTJoCrYzLh2yuE6BhrzaQXK0iDuGFXRbG9Bkw1y12G3e
         8VaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=cSY72fXaEZa0BLhi/dO9UGYmKDTjiMARYNRRFx7Fp00=;
        b=D6dRVUpUWRwT3OTgHuXZX1y4JimKFsog+R4B3gL7YS6Y4xiB5nXFdQ+CrSvMuL6n7l
         UbTo3i/+nbD3YCaKaL5P3lHtCzZRTQ9l680tfi3vZgzO/pbU3Obl2guL6NVwBCAE0n4U
         g8MRVTodinM7kzbWKkQtKVpHaFuuwL4CHbpxnqnZoS6pnxBFba/ZNMVGrPuMwXFlmKz4
         HaCygnVExc19YbG3aPWLwNMTA1vD79A1+61dxS2tZyjvG41ZYS1JpM+jW8nY3Aau67WZ
         pZar3RwNeNpIYsuLtPypqDh1D2eNgJ9VAXHadP/eBCtWMbEyZnctnHdVb5Cz3rL/EV6E
         ffyg==
X-Gm-Message-State: APjAAAUDtOPJ+349L0LFcDakOf3s+TthrBdqwvJ2iEflM0FwyWVg3fAD
        Elf0M5wauZobvkHjPgfzG7Q=
X-Google-Smtp-Source: APXvYqxwiv5we6wZtXmAV3EC3kWKi14n3jYo44O9xWqGckqpzHfK84X/xnhAoYyDxMe+NJIAnQ428Q==
X-Received: by 2002:a50:aa83:: with SMTP id q3mr29752743edc.63.1551998208011;
        Thu, 07 Mar 2019 14:36:48 -0800 (PST)
Received: from localhost.localdomain ([2a01:4f9:2a:1fae::2])
        by smtp.gmail.com with ESMTPSA id b24sm1677058ede.93.2019.03.07.14.36.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 07 Mar 2019 14:36:47 -0800 (PST)
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org,
        clang-built-linux@googlegroups.com,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nathan Chancellor <natechancellor@gmail.com>
Subject: [PATCH] pwm: img: Turn final 'else if' into 'else' in img_pwm_config
Date:   Thu,  7 Mar 2019 15:36:28 -0700
Message-Id: <20190307223628.21270-1-natechancellor@gmail.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
X-Patchwork-Bot: notify
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When building with -Wsometimes-uninitialized, Clang warns:

drivers/pwm/pwm-img.c:126:13: error: variable 'timebase' is used
uninitialized whenever 'if' condition is false
[-Werror,-Wsometimes-uninitialized]

The final else if functions as an else; make that explicit so that Clang
understands that timebase cannot be used uninitialized.

Link: https://github.com/ClangBuiltLinux/linux/issues/400
Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
---
 drivers/pwm/pwm-img.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pwm/pwm-img.c b/drivers/pwm/pwm-img.c
index 815f5333bb8f..1cc5fbe1e1d3 100644
--- a/drivers/pwm/pwm-img.c
+++ b/drivers/pwm/pwm-img.c
@@ -123,7 +123,7 @@ static int img_pwm_config(struct pwm_chip *chip, struct pwm_device *pwm,
 	} else if (mul <= max_timebase * 512) {
 		div = PWM_CTRL_CFG_SUB_DIV0_DIV1;
 		timebase = DIV_ROUND_UP(mul, 512);
-	} else if (mul > max_timebase * 512) {
+	} else {
 		dev_err(chip->dev,
 			"failed to configure timebase steps/divider value\n");
 		return -EINVAL;
-- 
2.21.0

