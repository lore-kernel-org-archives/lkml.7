Return-Path: <SRS0=P610=TX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3658CC282DD
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 12:19:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 05ACC21019
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 12:19:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gAft9RUQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730404AbfEWMTy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 May 2019 08:19:54 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:36458 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728309AbfEWMTx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 May 2019 08:19:53 -0400
Received: by mail-pf1-f196.google.com with SMTP id v80so3168678pfa.3
        for <linux-kernel@vger.kernel.org>; Thu, 23 May 2019 05:19:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=cb/Evthlm75QkClOwhS3DWYfXuweyGfVXTHPr+sRNR8=;
        b=gAft9RUQUH1U541JS+8Vlts7xBrE6Mxsw8lHvjaO0WozSFXP1jVZZgGZ4kM2+ff9cs
         b+rx0CG0KGqP7boLxGpppCVpT253cCIOsxfYc6VO/cQThkwK8ViaFRcM5pOPp525h7kB
         UMrqowGmWRBMc26a+90dRgLoAToHMalkiooZ704AzK8D9bnenBiafH0/TYoMYn8fpgMY
         otTG/+z+LvxlVqR89/L77eveP/8hia+bReTaUKn7Neju0T9HM0WkxmvlRsHfqhMFObzr
         Wp4l2/rvUDRfRRe7JwKhEeMzhqaJXcqroBuWScv2pKaEIoP8wYFrFhomilNWvrxWb62w
         0T9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=cb/Evthlm75QkClOwhS3DWYfXuweyGfVXTHPr+sRNR8=;
        b=or4DHKChbyIiV+PMl/C7csyIxCCskNRme7PwgfnXV/aVNK+VGgQzp4QoOm9Kc/xgD4
         cmcDZQT28zuQ+2ztwWOyEYSNBQ5gcPbfQnPGp2QLLtepGd22k1BmLe7R78ZFDubXdPVf
         qzACutehCN+2sTXaVAgivj33yGdWrnQZkN1fdWfOc4k3cw6r/91cjHUi+1t+DTuCPx3k
         EYn6Tipp17xa8e7yXI9Up/ZtX3QIYN+vCkYQOh1nlepU2DhNG6AoUFtDMW1t1OjHE6V7
         oufAVT56ie58eNlZnof1+lK3SH2liGgsKpYzHBF8LHGDNObVGTLEB/pw9Ox8zQ36yMMq
         Z9Lg==
X-Gm-Message-State: APjAAAWf4jCcPLsTcj2vZNEbpBnx+nzRdx9WdH5fzQ8mmbUY50+cE3uR
        1aDtP5CyM0jiY//YMqDhiBFhiF/FNN7RyA==
X-Google-Smtp-Source: APXvYqy3XwtF8Pw2WhJvGmrAy7A1gCCNClAZk01i29xaDo+Efcqv/6npvbl8ZP3bm2Aq4/r3XGWTFQ==
X-Received: by 2002:aa7:82cd:: with SMTP id f13mr103258059pfn.203.1558613993167;
        Thu, 23 May 2019 05:19:53 -0700 (PDT)
Received: from localhost.localdomain ([122.163.94.48])
        by smtp.gmail.com with ESMTPSA id c185sm32443314pfc.64.2019.05.23.05.19.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 23 May 2019 05:19:52 -0700 (PDT)
From:   Nishka Dasgupta <nishkadg.linux@gmail.com>
To:     gregkh@linuxfoundation.org, straube.linux@gmail.com,
        realwakka@gmail.com, hle@owl.eu.com, rico.schrage@gmail.com,
        sophie.matter@web.de, jbi.octave@gmail.com,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Cc:     Nishka Dasgupta <nishka.dasgupta@yahoo.com>
Subject: [PATCH] staging: pi433: Remove unnecessary return variable
Date:   Thu, 23 May 2019 17:49:27 +0530
Message-Id: <20190523121927.28806-1-nishkadg.linux@gmail.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nishka Dasgupta <nishka.dasgupta@yahoo.com>

The variable retval is initialised to 0 and assigned a constant value
later. Both of these can be returned separately, hence retval can be
removed.

Signed-off-by: Nishka Dasgupta <nishka.dasgupta@yahoo.com>
---
 drivers/staging/pi433/pi433_if.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/pi433/pi433_if.c b/drivers/staging/pi433/pi433_if.c
index c889f0bdf424..40c6f4e7632f 100644
--- a/drivers/staging/pi433/pi433_if.c
+++ b/drivers/staging/pi433/pi433_if.c
@@ -871,7 +871,6 @@ pi433_write(struct file *filp, const char __user *buf,
 static long
 pi433_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
 {
-	int			retval = 0;
 	struct pi433_instance	*instance;
 	struct pi433_device	*device;
 	struct pi433_tx_cfg	tx_cfg;
@@ -923,10 +922,10 @@ pi433_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
 		mutex_unlock(&device->rx_lock);
 		break;
 	default:
-		retval = -EINVAL;
+		return -EINVAL;
 	}
 
-	return retval;
+	return 0;
 }
 
 #ifdef CONFIG_COMPAT
-- 
2.19.1

