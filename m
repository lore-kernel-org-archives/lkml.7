Return-Path: <SRS0=SjSX=S5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65F35C43219
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 16:34:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2AE3620693
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 16:34:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XA0RhfXe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726199AbfD0QeG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 27 Apr 2019 12:34:06 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:42862 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725942AbfD0QeG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Apr 2019 12:34:06 -0400
Received: by mail-io1-f66.google.com with SMTP id m188so5473559ioa.9;
        Sat, 27 Apr 2019 09:34:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=XEvDpPUhRZq1dLEcwfgrpdw5Bqx40j/OhihVlJzo794=;
        b=XA0RhfXe0wftUHw2AzmePmRF1GUeiky6OfulKPNLYdpW7HhiRN4jkF6bYsbfaYbA8S
         8O/P33bxVoUk31zZ2nZ39qPGNU5Ibgx90mqcxE4mWi15cE570m8z1eQxlqsk9KArwt+h
         89qkQ/T8oFvFfOFKiSAyNrt73sIiD9cw+XiEz/RnuLZAiiAvIvQbIv1MIIDrxg1IBKoV
         4xDjOb7c0TlNNUbk0DUkCqTrIR2enEJAHBw7RHYthzZmUyLp4ygemcUH8VmHbrD8MGj+
         k7NMQmWsyth0pkTFt2jDzxTKXZT3ah4sgDHpr6extxuiow9FEA0dvFZQtk8M9ZeOP+6z
         QaMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=XEvDpPUhRZq1dLEcwfgrpdw5Bqx40j/OhihVlJzo794=;
        b=MlDcFqjkCmjSVkHMkyKgcNIH/cZeJsuWwvM0UyiPUtLGdcArf2WIlvG80rLz06aNEj
         7hff005AX4DJgi7bBJ0LZhTC1PG8HD3tavMij6whRP4JpZLyXUb2DAVHIqJaOmG2u5uZ
         qP/fYBpe/5ypgUn8BHLqwqt1Djfo7OYlurEW4k/nUgxRDf+FfhwW+LHcJsl45wOTxf3n
         5V+T/p4O1WokwHxxco4DUf9Nmjd71um3wZhqO/IklF/yICso0GOIG6KnOQlRMhjHVzoU
         Bj4BeUEaSbElU60pXQYzCZ9yz4y/HX/fPxlo17CtPRtP6ViDeRh0IFbqup3S53rQ27NE
         1bJA==
X-Gm-Message-State: APjAAAXhExLClco4326ZKPmWlieHEkc42cEkod7EGN3NHjTq7/VpOGtW
        G1SRV8fz3ZSARKpjZvudekM=
X-Google-Smtp-Source: APXvYqwbHJI7m792lzw+7MV7zVXopqousiFs9iR5NQkQAUbNwEXONOfjgk5bFmmS2Hom81KafuR+ug==
X-Received: by 2002:a6b:ba57:: with SMTP id k84mr26041475iof.211.1556382845471;
        Sat, 27 Apr 2019 09:34:05 -0700 (PDT)
Received: from localhost.localdomain (c-73-243-191-173.hsd1.co.comcast.net. [73.243.191.173])
        by smtp.gmail.com with ESMTPSA id p67sm13781876itb.11.2019.04.27.09.34.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 27 Apr 2019 09:34:04 -0700 (PDT)
From:   Kelsey Skunberg <skunberg.kelsey@gmail.com>
To:     sudipm.mukherjee@gmail.com, teddy.wang@siliconmotion.com,
        gregkh@linuxfoundation.org, linux-fbdev@vger.kernel.org,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Cc:     skhan@linuxfoundation.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        Kelsey Skunberg <skunberg.kelsey@gmail.com>
Subject: [PATCH] Staging: sm750fb: Change *array into *const array
Date:   Sat, 27 Apr 2019 10:33:34 -0600
Message-Id: <20190427163334.7109-1-skunberg.kelsey@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Resolve checkpatch warning for static const char * array by using const
pointers.

Checkpatch Warning in sm750.c:
static const char * array should probably be static const char * const

Signed-off-by: Kelsey Skunberg <skunberg.kelsey@gmail.com>
---
 drivers/staging/sm750fb/sm750.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/sm750fb/sm750.c b/drivers/staging/sm750fb/sm750.c
index 105089b97bf5..59568d18ce23 100644
--- a/drivers/staging/sm750fb/sm750.c
+++ b/drivers/staging/sm750fb/sm750.c
@@ -748,7 +748,7 @@ static int lynxfb_set_fbinfo(struct fb_info *info, int index)
 		lynx750_ext, NULL, vesa_modes,
 	};
 	int cdb[] = {ARRAY_SIZE(lynx750_ext), 0, VESA_MODEDB_SIZE};
-	static const char *mdb_desc[] = {
+	static const char * const mdb_desc[] = {
 		"driver prepared modes",
 		"kernel prepared default modedb",
 		"kernel HELPERS prepared vesa_modes",
-- 
2.20.1

