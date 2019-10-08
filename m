Return-Path: <SRS0=XKeO=YB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52C50C10F14
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Oct 2019 12:05:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 27BF1206C2
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Oct 2019 12:05:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b="ELuDRuvE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730921AbfJHMFZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Oct 2019 08:05:25 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:44890 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730904AbfJHMFY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Oct 2019 08:05:24 -0400
Received: by mail-lj1-f196.google.com with SMTP id m13so17191546ljj.11
        for <linux-kernel@vger.kernel.org>; Tue, 08 Oct 2019 05:05:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=t1XvNBeL5bYKnc6NbbptU+vm2vXQBBrTO687+/k8huo=;
        b=ELuDRuvEPbxHn+tPF2h2RxCruUdG8zM+LbvVMlIluH8Z/3Nz3rM48QruNf6Jjzt6Qx
         s+T3vGwTXw/HUazqjiUT8y6NaXwohlIowNQCdfwlwMsrwKqKmMOt9HlxSOwPJeCD4YOl
         uaNX5F5hIsDxJs3FYKG+NK0+p/NucTLWFjocY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=t1XvNBeL5bYKnc6NbbptU+vm2vXQBBrTO687+/k8huo=;
        b=DKFlYMgYXFDrgLvgHa24PcuxeqVfHUfPSiPer6LVsq8D2xF+c/08sgeAWarrpq5JFM
         96pTm2xmpo4nUAwuB7xW/ECpf3pDzmczdNUo36cQWn58tVRk1V/3SxH211ZapQquYZGA
         OoH8pX7wK5bhhWcG0gZj2uTfAA1KJLjbdaZs8+Bd6q9xzohJ1ChqWQolEhnLb8LvFK07
         HyQ0tvMRvlE2m/2NQghDvrt1O6HQ0eK77LkbLg3ne1ielc8HoKFEIa2FEliapFGawqlH
         tHMJtyleFs7alCAegkmJsbZurLJbuxlxKfBzXw+4bdJ8j9rWQOQePkisU9WSJ2N/J366
         /t5g==
X-Gm-Message-State: APjAAAVWZKwV+O+TVGp2JE1esOZiBVrHukC09fK3ki4EQU2vJZaeTLE0
        9Y2+tyPUO+L5F5i6is1c6CaNFw==
X-Google-Smtp-Source: APXvYqwr3eVj5VGcs9c4XwSP3Lzo4ODiUPJZt5VqFcpdr7xw+mtUtMYtWeZVNZS+BWY7vjjUDAVqgQ==
X-Received: by 2002:a2e:9d16:: with SMTP id t22mr19624221lji.207.1570536321581;
        Tue, 08 Oct 2019 05:05:21 -0700 (PDT)
Received: from prevas-ravi.prevas.se ([81.216.59.226])
        by smtp.gmail.com with ESMTPSA id z18sm3918033ljh.17.2019.10.08.05.05.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Oct 2019 05:05:19 -0700 (PDT)
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
Subject: [PATCH v2 2/4] backlight: pwm_bl: eliminate a 64/32 division
Date:   Tue,  8 Oct 2019 14:03:25 +0200
Message-Id: <20191008120327.24208-3-linux@rasmusvillemoes.dk>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191008120327.24208-1-linux@rasmusvillemoes.dk>
References: <20191008120327.24208-1-linux@rasmusvillemoes.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

lightness*1000 is nowhere near overflowing 32 bits, so we can just use
an ordinary 32/32 division, which is much cheaper than the 64/32 done
via do_div().

Reviewed-by: Daniel Thompson <daniel.thompson@linaro.org>
Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
---
 drivers/video/backlight/pwm_bl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/video/backlight/pwm_bl.c b/drivers/video/backlight/pwm_bl.c
index cc44a02e95c7..672c5e7cfcd1 100644
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

