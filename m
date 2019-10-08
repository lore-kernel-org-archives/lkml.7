Return-Path: <SRS0=XKeO=YB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFE84C4360C
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Oct 2019 12:05:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C90AB21835
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Oct 2019 12:05:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b="iHfqd7In"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730940AbfJHMF3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Oct 2019 08:05:29 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:44907 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730922AbfJHMF1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Oct 2019 08:05:27 -0400
Received: by mail-lf1-f65.google.com with SMTP id q12so6781842lfc.11
        for <linux-kernel@vger.kernel.org>; Tue, 08 Oct 2019 05:05:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=GHqEF0WPzWee4xQdmsltBE/DbSJ8wdizxOO3R+g9Qfw=;
        b=iHfqd7InHpWSp9HtncYc/nGuUN2SQLNPz6EP4Z7c0utpCDEfBTHo79qRfdGdqnHjDc
         mUERS8N/Ezm1xJivvlU2FPSjziBCWfbM0Mp19xZKJ+DciElb5UKCU0Vr/UJTOEN7Raiq
         9nMDdC6cEjkuK79xMF6I9qmtVilDUGJ2/wvCs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=GHqEF0WPzWee4xQdmsltBE/DbSJ8wdizxOO3R+g9Qfw=;
        b=Ax41lVmKGy0Ed1e5TvcQG7Z9m3rBabPiBrvmmUYdSDUyGIBU/aOACLSeyOan5rVD+f
         CA8J62Ntm8nH/C9aWiYXNuJmbYSC2zIZk6rYxVTAUuhrOER0K5uOlCx21hKpRJbDoOEx
         aP4rMmAy7nejZiTt/C+C8Due27zsY0f4j4Scilsc46yuPBi/+VPYA4iCLMPmDp8aZl/Y
         e+5BD6VhwMuMeUMQawd94L82OO3LIO5mP8aiEmn0TmNnnv9yr5yQLeyblE+7TF5egGal
         ZPjtl2KCQ9d62T+mDwK29IwESrs08szmFr151av5+0wSdPh6HyiHlzIX8eb+Rq/qASXr
         3QYQ==
X-Gm-Message-State: APjAAAUsbJisZyhQZWKuADcEDIVzprU0hWk2++UP5Ol1Two1JHQ8Tsoj
        QW9BXzlNnpXRznzv4jKJXS8Tfg==
X-Google-Smtp-Source: APXvYqxCIRhO8rpvb/4039KpvxZ2HkirRtcoXz27yozPDPIZ8udJLy4ukMGlXb9inSVE+1v8hleq+g==
X-Received: by 2002:a19:90:: with SMTP id 138mr19176383lfa.111.1570536324544;
        Tue, 08 Oct 2019 05:05:24 -0700 (PDT)
Received: from prevas-ravi.prevas.se ([81.216.59.226])
        by smtp.gmail.com with ESMTPSA id z18sm3918033ljh.17.2019.10.08.05.05.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Oct 2019 05:05:22 -0700 (PDT)
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
To:     Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, Lee Jones <lee.jones@linaro.org>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc:     Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        linux-pwm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 3/4] backlight: pwm_bl: drop use of int_pow()
Date:   Tue,  8 Oct 2019 14:03:26 +0200
Message-Id: <20191008120327.24208-4-linux@rasmusvillemoes.dk>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191008120327.24208-1-linux@rasmusvillemoes.dk>
References: <20191008120327.24208-1-linux@rasmusvillemoes.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For a fixed small exponent of 3, it is more efficient to simply use
two explicit multiplications rather than calling the int_pow() library
function: Aside from the function call overhead, its implementation
using repeated squaring means it ends up doing four 64x64
multiplications.

Reviewed-by: Daniel Thompson <daniel.thompson@linaro.org>
Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
---
 drivers/video/backlight/pwm_bl.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/video/backlight/pwm_bl.c b/drivers/video/backlight/pwm_bl.c
index 672c5e7cfcd1..273d3fb628a0 100644
--- a/drivers/video/backlight/pwm_bl.c
+++ b/drivers/video/backlight/pwm_bl.c
@@ -179,7 +179,8 @@ static u64 cie1931(unsigned int lightness, unsigned int scale)
 	if (lightness <= (8 * scale)) {
 		retval = DIV_ROUND_CLOSEST(lightness * 10, 9033);
 	} else {
-		retval = int_pow((lightness + (16 * scale)) / 116, 3);
+		retval = (lightness + (16 * scale)) / 116;
+		retval *= retval * retval;
 		retval = DIV_ROUND_CLOSEST_ULL(retval, (scale * scale));
 	}
 
-- 
2.20.1

