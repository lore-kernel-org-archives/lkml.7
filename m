Return-Path: <SRS0=N68d=SK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13C2BC10F14
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 21:44:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D49B32084F
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 21:44:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FL1aVqaz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728795AbfDHVof (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Apr 2019 17:44:35 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:37436 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726630AbfDHVnM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Apr 2019 17:43:12 -0400
Received: by mail-lj1-f194.google.com with SMTP id v13so12621426ljk.4;
        Mon, 08 Apr 2019 14:43:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=wVGmZYRQa/9aCw2opSqt9la4dXQ+gNuOGKIGTuXbWis=;
        b=FL1aVqazYKyeiRdnsIA7ddxCVe0Za9WN2WqRdAKtqzjisAhJH8ey3NCk58rCjxY6mv
         fF7EqAcyglUEgTqJURsbvfgy5oY0gn5c9XuNjxr/xRZdXCERpKpJq/oTbQpD98d3A97F
         rcf9w9K931fdlpf8y5dfwPaIl6LxeuOKyxpW9xOk8w3jeTXOWScmnEiiUBsN1162dYbM
         xlLtkOC1eRAUP4/qbCai8bRkhZmjJr5sC0YzY8+9CCdn9XKr3LBeWOSMpeb2UTspgbx6
         fLemcikKvnyD0Zc4D//MzbzWnZFjNu2vR0+yFQkkruz4JF+PbhtmDD3a++OEhxEaenLL
         vkMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wVGmZYRQa/9aCw2opSqt9la4dXQ+gNuOGKIGTuXbWis=;
        b=S8AA4Y92dCkLga5Dh8e++UGoLm67LOHiT805KLUyoVPWUSQvUf9zRegNFpxCyeR436
         PNYCmnmIShW8Ywr5e51yZFQjDoynbLXM0KrrwxI7HgsNgjBKut3Mftbz1TUCcpW0QfXn
         SAOTXUA7VFKwDJHy3gBMUn12N9bDQLc0+KfxSOvlNK/EeZ7A+rOokLbm1Sz1XMm0q/lM
         +tOlrI1hFPaNwHHjxJ8PoHKB0sBbXM52VfEdRSSJBzq/6+P0uWMDe5MdsmmZx3OCEQ1R
         YknsaVNnpCxrOVdpCjqKWdaPMRQL1SsZTebL5voIShMGRv1NBnpqQE393TRVCZv4rGMu
         tVpw==
X-Gm-Message-State: APjAAAVX6RPWd9J0ZUdIrdSY2m8iTi7oqw8Tk27LcVYlc6l1hUwmPyvI
        V02rxeK4W52X9uWiVsNMhLo=
X-Google-Smtp-Source: APXvYqzKeN1U1hF7Hdb+KN0Fz/pjr4bIGcje3CKRAxpZRdNWlFHPKkBSkgWqmEWNw2NfkC3tIol2wA==
X-Received: by 2002:a2e:9e4d:: with SMTP id g13mr14908111ljk.12.1554759789708;
        Mon, 08 Apr 2019 14:43:09 -0700 (PDT)
Received: from z50.gdansk-morena.vectranet.pl (109241207190.gdansk.vectranet.pl. [109.241.207.190])
        by smtp.gmail.com with ESMTPSA id j6sm5286048ljc.0.2019.04.08.14.43.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 08 Apr 2019 14:43:09 -0700 (PDT)
From:   Janusz Krzysztofik <jmkrzyszt@gmail.com>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     Sakari Ailus <sakari.ailus@linux.intel.com>,
        Hans Verkuil <hans.verkuil@cisco.com>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org, Janusz Krzysztofik <jmkrzyszt@gmail.com>
Subject: [PATCH 03/14] media: ov6650: Fix unverified arguments used in .set_fmt()
Date:   Mon,  8 Apr 2019 23:42:31 +0200
Message-Id: <20190408214242.9603-4-jmkrzyszt@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190408214242.9603-1-jmkrzyszt@gmail.com>
References: <20190408214242.9603-1-jmkrzyszt@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 717fd5b4907ad ("[media] v4l2: replace try_mbus_fmt by set_fmt")
converted a former ov6650_try_fmt() video operation callback to an
ov6650_set_fmt() pad operation callback.  However, the function does not
verify correctness of user provided format->which flag and pad config
pointer arguments.  Fix it.

Fixes: 717fd5b4907ad ("[media] v4l2: replace try_mbus_fmt by set_fmt")
Signed-off-by: Janusz Krzysztofik <jmkrzyszt@gmail.com>
Cc: stable@vger.kernel.org
---
 drivers/media/i2c/ov6650.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/media/i2c/ov6650.c b/drivers/media/i2c/ov6650.c
index 007f0ca24913..3062c9a6c57b 100644
--- a/drivers/media/i2c/ov6650.c
+++ b/drivers/media/i2c/ov6650.c
@@ -679,6 +679,17 @@ static int ov6650_set_fmt(struct v4l2_subdev *sd,
 	if (format->pad)
 		return -EINVAL;
 
+	switch (format->which) {
+	case V4L2_SUBDEV_FORMAT_ACTIVE:
+		break;
+	case V4L2_SUBDEV_FORMAT_TRY:
+		if (cfg)
+			break;
+		/* fall through */
+	default:
+		return -EINVAL;
+	}
+
 	if (is_unscaled_ok(mf->width, mf->height, &priv->rect))
 		v4l_bound_align_image(&mf->width, 2, W_CIF, 1,
 				&mf->height, 2, H_CIF, 1, 0);
-- 
2.21.0

