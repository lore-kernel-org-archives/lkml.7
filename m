Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1886C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 18:18:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6ED0F2146E
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 18:18:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="ePKf8xtG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728970AbfDASSa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 14:18:30 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:38450 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728798AbfDASS1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 14:18:27 -0400
Received: by mail-wr1-f67.google.com with SMTP id k11so13312092wro.5;
        Mon, 01 Apr 2019 11:18:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9ye1/MyKDhSO/ewzuKmbDnyUwPW1RDGDapSOkV4cGL0=;
        b=ePKf8xtGlM3Xw4gBPq6inPPXkjh+VtlbGbMXaQ+Rt6akR6bHQpjYcIcpHHQUMKgpiO
         ftMv3MYpzPta4C8/QU4lCE9u0aFmb88VfFSJRI3xNrOnOyFjmwBFYlBGHCdf6NF5uhHO
         0ZhOtjVUFyHqkFP2qydw4IjkjlcWeUA7yBxX7NhsCryLncF2+EkEX0+EqQJRa6DgYC4h
         RljSZcgokxPGRUI3wu6t+KhSqfz/MlV2LNWLMa2rksEeTCG3UyH835eFf/o0U+lULHAQ
         e8xdATQiAtrKEtH5JWgW0vAvuU2iQzEVBXPHAg/SGVoG0Dy8QX5a8fveEtnkuhgk/xSI
         fsRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9ye1/MyKDhSO/ewzuKmbDnyUwPW1RDGDapSOkV4cGL0=;
        b=k9SaVSOOsXeHiOmD3+WLQjmaObDaqZm4DJ9vmrX9gbJ936+jgEQ86WvmwOwJB417af
         Ktrj9E2s8oo7y0h0l6JDoXDC1jVPlToMZlj50biW7aJgPgVkN+wkLTimGwvSYq7O41Jn
         oW1rJ1W60cEP3c1CFj5nF17BPJW0XALfAZyutGgz8RmlsyWG8EvmEwXggUOSKvu6iYhn
         2ealbdEdYNeGFnUJpBPB0Yrk6bwi63trJ2OGfL3yapZNtISZWJ9GAydeyxbcTd6XyYZQ
         8SB105FeVVokde127cYhZmR8HhLPUfD+OmWSLpF4nrZcjlNd9uqyv5OquRM+ZmpQV1Z9
         l6cA==
X-Gm-Message-State: APjAAAVjOtrGZpwqzrWNo+mTI/MpL3HoWi9HwunIWsDG2cRsf+i/oxs9
        rNEUrzKp8rssRAwyuCs2N1E=
X-Google-Smtp-Source: APXvYqwQGTK6gmoLZn1yNvDpn8+7wW3OyahHbaWJL+s5vbSRarD51UwEVgNOFPyHgLHmZfrS8WXk9w==
X-Received: by 2002:a5d:4d42:: with SMTP id a2mr44948400wru.130.1554142705035;
        Mon, 01 Apr 2019 11:18:25 -0700 (PDT)
Received: from blackbox.darklights.net (p200300DCD73A0800C9C8A7BE25478D36.dip0.t-ipconnect.de. [2003:dc:d73a:800:c9c8:a7be:2547:8d36])
        by smtp.googlemail.com with ESMTPSA id h10sm18131127wrs.27.2019.04.01.11.18.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 01 Apr 2019 11:18:24 -0700 (PDT)
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
To:     thierry.reding@gmail.com, linux-pwm@vger.kernel.org,
        linux-amlogic@lists.infradead.org
Cc:     narmstrong@baylibre.com, jbrunet@baylibre.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        u.kleine-koenig@pengutronix.de, bichao.zheng@amlogic.com,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: [PATCH 1/2] pwm: meson: consider 128 a valid pre-divider
Date:   Mon,  1 Apr 2019 20:18:16 +0200
Message-Id: <20190401181817.11999-2-martin.blumenstingl@googlemail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190401181817.11999-1-martin.blumenstingl@googlemail.com>
References: <20190401181817.11999-1-martin.blumenstingl@googlemail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pre-divider allows configuring longer PWM periods compared to using
the input clock directly. The pre-divider is 7 bit wide, meaning it's
maximum value is 128 (the register value is off-by-one: 0x7f or 127).

Change the loop to also allow for the maximum possible value to be
considered valid.

Fixes: 211ed630753d2f ("pwm: Add support for Meson PWM Controller")
Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
---
 drivers/pwm/pwm-meson.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/pwm/pwm-meson.c b/drivers/pwm/pwm-meson.c
index f6e738ad7bd9..4b708c1fcb1d 100644
--- a/drivers/pwm/pwm-meson.c
+++ b/drivers/pwm/pwm-meson.c
@@ -188,7 +188,7 @@ static int meson_pwm_calc(struct meson_pwm *meson,
 	do_div(fin_ps, fin_freq);
 
 	/* Calc pre_div with the period */
-	for (pre_div = 0; pre_div < MISC_CLK_DIV_MASK; pre_div++) {
+	for (pre_div = 0; pre_div <= MISC_CLK_DIV_MASK; pre_div++) {
 		cnt = DIV_ROUND_CLOSEST_ULL((u64)period * 1000,
 					    fin_ps * (pre_div + 1));
 		dev_dbg(meson->chip.dev, "fin_ps=%llu pre_div=%u cnt=%u\n",
@@ -197,7 +197,7 @@ static int meson_pwm_calc(struct meson_pwm *meson,
 			break;
 	}
 
-	if (pre_div == MISC_CLK_DIV_MASK) {
+	if (pre_div > MISC_CLK_DIV_MASK) {
 		dev_err(meson->chip.dev, "unable to get period pre_div\n");
 		return -EINVAL;
 	}
-- 
2.21.0

