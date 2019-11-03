Return-Path: <SRS0=Ba5y=Y3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE90CCA9EC7
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Nov 2019 00:59:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B9F5120862
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Nov 2019 00:59:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qe/QV06/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727387AbfKCA7L (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 2 Nov 2019 20:59:11 -0400
Received: from mail-yb1-f193.google.com ([209.85.219.193]:34794 "EHLO
        mail-yb1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727335AbfKCA7L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Nov 2019 20:59:11 -0400
Received: by mail-yb1-f193.google.com with SMTP id f6so1600066ybp.1
        for <linux-kernel@vger.kernel.org>; Sat, 02 Nov 2019 17:59:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=7q6Xq7rmHNSrovKS8aUtbAZiEFB5v4eQ1NKAasuvin0=;
        b=qe/QV06/xian0rDAQgM+qAbX7/ACLaPY6U1qvPK/JYxMuZyLu2TBZKiDYgtCNho9yN
         X/5uQFQKrr2HY5fpULDVYzwpvHhOFgiz7Fd4ZyBYRMyU2ETDArGOjhuYvUXOtANWQcac
         mI9wPqYc4Q73sSkILRIey5fKQbxxgp1Akcpc9cwO4HkDMu2b2iTk8/7ALLRm0pTYEVPd
         pWUd2f3unLUTvaCnhekTDYQuKrwTE4o13OL1L3RiKIlFlAsjiDxeyJ/QhK1Vmn8WtS7K
         6vd9nU2q0zw7sgG95ROLQ0qOptvzbgC/xh6BWQ0ay+Dc8LTqOs19AGR0dcJJWiTt1c43
         ytOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=7q6Xq7rmHNSrovKS8aUtbAZiEFB5v4eQ1NKAasuvin0=;
        b=js1t0gOsrEE5BKrPgMmPp9Sa+AEgfvRqIBC9yY6HesFjzkbZPA1Qk5yQGVWk5nS2cT
         vbIHw/LE8P8SawTFB7iNsbSNvltgpWPYgONkiukwd7naqNTdvDX5ewz/IX/VJccVVIMc
         1QG8d1mv7Vq6ohczQNL4RjDr4W5WG0pzmVO7LZkGVmi2zUrhlbzBzDfMcK0c1DQkDsDi
         M3jhAvpzxMk2f1UsWB68PcHWfo7bJfgxz4H5lJD5yI76sWwGrhRM13HlBJmCvuMn5weR
         twNWSSJzxz/ysfphKhrZl+0EjlWcUZ1OkQbh+0cpF6JwC1SG6TgOwjK5sMA+A8n2y4et
         ZiUg==
X-Gm-Message-State: APjAAAVkqrgZD8pcO6HCjaWnzEvgJMip8x1fibSu0Fwnj3FI8lWC47Gp
        zXbWSFGL6c7XsgrLCYPzrZ0=
X-Google-Smtp-Source: APXvYqxSp4k92cn+p3Zvs5Fp7XQQ7Lm/W5dD+hONzeMlFEuxTsXcX1OL+HSDoXeqW8IDYsqLL5yIHg==
X-Received: by 2002:a25:13ca:: with SMTP id 193mr17124173ybt.196.1572742750301;
        Sat, 02 Nov 2019 17:59:10 -0700 (PDT)
Received: from rkanasun-VirtualBox.ad.cirrus.com ([141.131.2.3])
        by smtp.gmail.com with ESMTPSA id 203sm5240896ywp.76.2019.11.02.17.59.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 02 Nov 2019 17:59:09 -0700 (PDT)
From:   rama <ramakumar.kanasundara@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     jeremy@azazel.net, nishadkamdar@gmail.com,
        linux-kernel@vger.kernel.org, devel@driverdev.osuosl.org,
        rama <ramakumar.kanasundara@gmail.com>
Subject: [PATCH] FBTFT: fb_sh: Changed udelay() to usleep_range() based on the Document, Documentation/timers/timers-howto.rst Excerpt from the document: -SLEEPING FOR ~USECS OR SMALL MSECS ( 10us - 20ms):           * Use usleep_range
Date:   Sat,  2 Nov 2019 19:59:06 -0500
Message-Id: <20191103005906.17112-1-ramakumar.kanasundara@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

---
 drivers/staging/fbtft/fb_agm1264k-fl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/fbtft/fb_agm1264k-fl.c b/drivers/staging/fbtft/fb_agm1264k-fl.c
index eeeeec97ad27..471a145e3c00 100644
--- a/drivers/staging/fbtft/fb_agm1264k-fl.c
+++ b/drivers/staging/fbtft/fb_agm1264k-fl.c
@@ -85,7 +85,7 @@ static void reset(struct fbtft_par *par)
 	dev_dbg(par->info->device, "%s()\n", __func__);
 
 	gpiod_set_value(par->gpio.reset, 0);
-	udelay(20);
+	usleep_range(20,20);
 	gpiod_set_value(par->gpio.reset, 1);
 	mdelay(120);
 }
-- 
2.17.1

