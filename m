Return-Path: <SRS0=X8En=XO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 776A0C49ED7
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Sep 2019 14:06:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4EABE20882
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Sep 2019 14:06:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b="A48WL858"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389451AbfISOGd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Sep 2019 10:06:33 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:33739 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389025AbfISOGd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Sep 2019 10:06:33 -0400
Received: by mail-lj1-f193.google.com with SMTP id a22so3793812ljd.0
        for <linux-kernel@vger.kernel.org>; Thu, 19 Sep 2019 07:06:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=zBTcMpOyl2bLXBXPvlZrHA8WBZZACi7gNqiyseLnytg=;
        b=A48WL858gPJVbFagBB2BTpTgHdTGMt1R9BC01trDu5z3ENfmhWS7RiqjnfWx20RoUY
         E0iQrrx0deYrkinYfpODZNFzuVCQBajUDYXy09Qkmb+GV1iPmOdfGkZktLbOEyqsuOiz
         8Rwokwielo8W6w7zis9sx6uJ5V5kHfsVwrS8I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=zBTcMpOyl2bLXBXPvlZrHA8WBZZACi7gNqiyseLnytg=;
        b=bJkL9KYgsnye1qpy5NJThl76iyW4uq9XOQeoJ5OJ64nio+Of+w9323ryoK0Q+IU/hq
         LITSCm564JWBcdxUPzKRhOmYxLL0P1dwAJcfINrVX9tSuBVWr/IWnSTyV9uUZ9GMIeDP
         /AvxBqXt8WXTA3DLKPp9/nvaqci8u2fETyKqJCdyUPAT/fcu7yr7cqnm4e4NAihjm9M+
         ghk/epH8gPLp5KPEQHRlBCdgsxVCdgk9supx6GrKuAqAD5ltCoPNG3wJd75D65Uv/AKu
         1HJSuWA4T2tDErnJSoJZ/Ksra8vfjzzBKf0xcNrVRTy6OueCw/sJkTujix/gb+HrjuxM
         7Asw==
X-Gm-Message-State: APjAAAVAnHqYsbZcrcRRzfN4D7qdeGRx+m8lXE+pMzKBe6kAOCuh/p7W
        BV4KJsddEf4cQ6dDh4Bzx2s+cw==
X-Google-Smtp-Source: APXvYqz80XnBinuoIhjkWosIvpazzODW2CaBBl25zB2SkJzfe+uW+0Y8qIL/RSBMCTZSD3oY/92ueA==
X-Received: by 2002:a2e:6e18:: with SMTP id j24mr5534397ljc.158.1568901990286;
        Thu, 19 Sep 2019 07:06:30 -0700 (PDT)
Received: from prevas-ravi.prevas.se ([81.216.59.226])
        by smtp.gmail.com with ESMTPSA id h3sm1687886ljf.12.2019.09.19.07.06.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Sep 2019 07:06:29 -0700 (PDT)
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Lee Jones <lee.jones@linaro.org>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc:     Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        linux-pwm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/5] backlight: pwm_bl: eliminate a 64/32 division
Date:   Thu, 19 Sep 2019 16:06:17 +0200
Message-Id: <20190919140620.32407-2-linux@rasmusvillemoes.dk>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190919140620.32407-1-linux@rasmusvillemoes.dk>
References: <20190919140620.32407-1-linux@rasmusvillemoes.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

lightness*1000 is nowhere near overflowing 32 bits, so we can just use
an ordinary 32/32 division, which is much cheaper than the 64/32 done
via do_div().

Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
---
 drivers/video/backlight/pwm_bl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/video/backlight/pwm_bl.c b/drivers/video/backlight/pwm_bl.c
index be36be1cacb7..9252d51f31b9 100644
--- a/drivers/video/backlight/pwm_bl.c
+++ b/drivers/video/backlight/pwm_bl.c
@@ -177,7 +177,7 @@ static u64 cie1931(unsigned int lightness, unsigned int scale)
 	 */
 	lightness *= 100;
 	if (lightness <= (8 * scale)) {
-		retval = DIV_ROUND_CLOSEST_ULL(lightness * 10, 9033);
+		retval = DIV_ROUND_CLOSEST(lightness * 10, 9033);
 	} else {
 		retval = int_pow((lightness + (16 * scale)) / 116, 3);
 		retval = DIV_ROUND_CLOSEST_ULL(retval, (scale * scale));
-- 
2.20.1

