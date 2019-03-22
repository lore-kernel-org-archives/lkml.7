Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA325C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 03:42:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A36A821902
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 03:42:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=endlessm-com.20150623.gappssmtp.com header.i=@endlessm-com.20150623.gappssmtp.com header.b="aVWyXbT0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727651AbfCVDmv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Mar 2019 23:42:51 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:33179 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725999AbfCVDmu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Mar 2019 23:42:50 -0400
Received: by mail-pg1-f196.google.com with SMTP id b12so542656pgk.0
        for <linux-kernel@vger.kernel.org>; Thu, 21 Mar 2019 20:42:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=endlessm-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=1M2sFDfk6+MiOYr7J7OGqVMfGnaLzwrDZ9t2ITrAcQY=;
        b=aVWyXbT0a/4rS11uCRM5RNZFwj9ZbZcHhV14FHeDzJjBTlOkzulnRgXRXeCZgxtytM
         SHspYAGlc6WlFtxb8yQ00gLmUVqTTgowTSXI6ntOQjNA4KRx7x+0i3TWsn9P6E4ZSjO0
         ix45JAOweaEksoxVesHP7s54gAxkHW2relgm/SUtiWwHc4f4q5wlOGK6vd9gsZAK5DpB
         /8Ww+Dc7W6AZb/MwmqPlBirP1WVxxqqsqUYlFYT6Lwo9khhYvZuTEQX2Bl2jXR0ygqyH
         gWwO3LG6eAamP4HPNAe3LSgq7xYsfokUxuXODUmy+TuRVMNA6lOn+JXM5aZKZVdNmO9y
         t6Hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1M2sFDfk6+MiOYr7J7OGqVMfGnaLzwrDZ9t2ITrAcQY=;
        b=qvI5KHJmccyOCr4d9pMsCsgdLBekUcpj2mWRevurhimUV6OwSpO3eNhUOMVL6RkcZY
         pBlU0N6UzHlxMI2b3nwj/+yaHt5CXW4qSbZrhKF16U9swI9YWGjeDGLBnM0TjxaO+eQp
         jGSMS1yolUr4YuL2VgcYsR/y8AHkuiGeMz2KyPpo1CECMH4mUyTOb2PgcS2zNgzqyPNa
         T9pO7TJbjTsfpJQpcavBTPbcA3PZbEB0lf7za0tQlTmyFQz7dyNk64UENuqqI4KpU4ok
         sFByYy6pgZD7G7mknEYVlYlUR0wy2KYoNZi090RywFB2MPP6rfG2hSQC5uShIQIVgB6s
         nfcA==
X-Gm-Message-State: APjAAAUlvAQEsHE2aI/aeKsEcERjbQ+HyDj9Wt+FoyAjAWmJzPAAot8z
        JV7nJHS9WlUdYfVR+9U4kMEE9A==
X-Google-Smtp-Source: APXvYqxV2ldvM/A8o6d/IF13JK6AzL8vqOzwryJLd/BMdL0tyc8Xk8kTsGSNhbRCuMb/IS9c3OkTyA==
X-Received: by 2002:a65:4381:: with SMTP id m1mr6316927pgp.97.1553226170170;
        Thu, 21 Mar 2019 20:42:50 -0700 (PDT)
Received: from localhost.localdomain (123-204-46-122.static.seed.net.tw. [123.204.46.122])
        by smtp.gmail.com with ESMTPSA id g2sm14028826pfm.144.2019.03.21.20.42.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 21 Mar 2019 20:42:49 -0700 (PDT)
From:   Jian-Hong Pan <jian-hong@endlessm.com>
To:     Takashi Iwai <tiwai@suse.com>
Cc:     Kailang Yang <kailang@realtek.com>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, linux@endlessm.com,
        Jian-Hong Pan <jian-hong@endlessm.com>,
        Daniel Drake <drake@endlessm.com>
Subject: [PATCH 3/3] ALSA: hda/realtek: Enable headset MIC of ASUS X430UN and X512DK with ALC256
Date:   Fri, 22 Mar 2019 11:37:22 +0800
Message-Id: <20190322033719.10793-3-jian-hong@endlessm.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190322033719.10793-1-jian-hong@endlessm.com>
References: <20190322033719.10793-1-jian-hong@endlessm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The ASUS X430UN and X512DK with ALC256 cannot detect the headset MIC
until ALC256_FIXUP_ASUS_MIC_NO_PRESENCE quirk applied.

Signed-off-by: Jian-Hong Pan <jian-hong@endlessm.com>
Signed-off-by: Daniel Drake <drake@endlessm.com>
---
 sound/pci/hda/patch_realtek.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index b8efb20916ba..af0b1bd650f8 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -7347,6 +7347,10 @@ static const struct snd_hda_pin_quirk alc269_pin_fixup_tbl[] = {
 		{0x12, 0x90a60130},
 		{0x14, 0x90170110},
 		{0x21, 0x03211020}),
+	SND_HDA_PIN_QUIRK(0x10ec0256, 0x1043, "ASUS", ALC256_FIXUP_ASUS_MIC_NO_PRESENCE,
+		{0x12, 0x90a60130},
+		{0x14, 0x90170110},
+		{0x21, 0x04211020}),
 	SND_HDA_PIN_QUIRK(0x10ec0256, 0x1043, "ASUS", ALC256_FIXUP_ASUS_MIC_NO_PRESENCE,
 		{0x1a, 0x90a70130},
 		{0x1b, 0x90170110},
-- 
2.20.1

