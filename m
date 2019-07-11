Return-Path: <SRS0=G0tX=VI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19CA3C74A52
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jul 2019 12:21:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E0AB821655
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jul 2019 12:21:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ingics-com.20150623.gappssmtp.com header.i=@ingics-com.20150623.gappssmtp.com header.b="L+vpPUbD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728644AbfGKMVx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Jul 2019 08:21:53 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:39296 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725926AbfGKMVx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Jul 2019 08:21:53 -0400
Received: by mail-pg1-f196.google.com with SMTP id u17so2865564pgi.6
        for <linux-kernel@vger.kernel.org>; Thu, 11 Jul 2019 05:21:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ingics-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=wKzIIBt+fcwYgb1WijLtPF2IxcS5FD6tOy9+Xwn7eRw=;
        b=L+vpPUbDCRBwU4yazk9+F8bwJqmJigvHwVXp4eq3fOgsh9/qfyxNpBEqYZAa1ZGHw+
         xPsbICepNF8tts7VNy9XEl411b8wrDJ4xP4ylGtHMjl51cfexb4NVqDVoq4ZDd9oVBdO
         FWKtvQiH7KZ0cyqPId695lzZsnHo1DmocnbCdp57KCEBTh79/HuVVyl1yy9fkshmEsL8
         kWOUUr+LabStYDubFOzEUDnqTvRvMsxenK0lo7Zjvgu1cBcO5y/6WrTZdijqyXEz3jrl
         5fFidPqProEzoXu+IYxfAJGuawolucezD0gz3OaBr8howW7E7q0i3Ilfp/l7DPl6UmcP
         Yizw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=wKzIIBt+fcwYgb1WijLtPF2IxcS5FD6tOy9+Xwn7eRw=;
        b=EGdf5Zf2Ze33c4eLFXh7rLfKSAFI3mah2FLZ0B2M1d12HCtoMcFivUaAjiXwmjUP5y
         Fkdtbcn63XxyU3M0bGPFrGJKYVSYd70qGaARFrab9vBrvQEBaMInmyInM1Ic4tDcW1p3
         Oik3uMHQdao9j/eki1kW21fLX2rFwjMtVMhEekYzeqFrCsPhgau3JijDYCGv/nojfO+S
         HAAhA/s4rmGTMeIcI8SFfpiDP5h2CTuvWHky1qCDLSkYwT09pl2juPnpHiYaeHXEkMV8
         qd2kFFaMtONXeg/2E1bdOsMKJxecWEFZ2Yu0I3YrxtYuu79Zh8AI/EwlPazccIQYNRB5
         XW8Q==
X-Gm-Message-State: APjAAAWUB/umQAn/0yBGW4QhByXArvk8BRzu/tZhBRtWPYSb+KKRFlNw
        08udppOxoZpP8ESoyJ6oZ5A=
X-Google-Smtp-Source: APXvYqxO5be22E/+NEO0kWVy0NthtjTtcUlIEV+ywC+Gd1B7Kzo1wwJW00IsEVZV2kMl/CRvK46uLg==
X-Received: by 2002:a17:90a:ab01:: with SMTP id m1mr4366676pjq.69.1562847712344;
        Thu, 11 Jul 2019 05:21:52 -0700 (PDT)
Received: from localhost.localdomain (36-239-228-246.dynamic-ip.hinet.net. [36.239.228.246])
        by smtp.gmail.com with ESMTPSA id q1sm11284536pfn.178.2019.07.11.05.21.48
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 11 Jul 2019 05:21:51 -0700 (PDT)
From:   Axel Lin <axel.lin@ingics.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     Heiko Stuebner <heiko@sntech.de>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org, Axel Lin <axel.lin@ingics.com>
Subject: [PATCH] regulator: rk808: Return REGULATOR_MODE_INVALID for invalid mode
Date:   Thu, 11 Jul 2019 20:21:38 +0800
Message-Id: <20190711122138.5221-1-axel.lin@ingics.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

-EINVAL is not a valid return value for .of_map_mode, return
REGULATOR_MODE_INVALID instead.

Signed-off-by: Axel Lin <axel.lin@ingics.com>
---
 drivers/regulator/rk808-regulator.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/regulator/rk808-regulator.c b/drivers/regulator/rk808-regulator.c
index e7af0c53d449..61bd5ef0806c 100644
--- a/drivers/regulator/rk808-regulator.c
+++ b/drivers/regulator/rk808-regulator.c
@@ -606,7 +606,7 @@ static unsigned int rk8xx_regulator_of_map_mode(unsigned int mode)
 	case 2:
 		return REGULATOR_MODE_NORMAL;
 	default:
-		return -EINVAL;
+		return REGULATOR_MODE_INVALID;
 	}
 }
 
-- 
2.20.1

