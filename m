Return-Path: <SRS0=RThv=TD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9AD7C43219
	for <linux-kernel@archiver.kernel.org>; Fri,  3 May 2019 15:42:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9BA4A2081C
	for <linux-kernel@archiver.kernel.org>; Fri,  3 May 2019 15:42:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="uZfp/N3A"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728016AbfECPme (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 May 2019 11:42:34 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:41383 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727460AbfECPme (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 May 2019 11:42:34 -0400
Received: by mail-lf1-f67.google.com with SMTP id d8so4714612lfb.8
        for <linux-kernel@vger.kernel.org>; Fri, 03 May 2019 08:42:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=hxoy1ZV5sToffY4PE/tTqurkXva76ASJNTG/Gm0iUtc=;
        b=uZfp/N3AZYMWXt5Qex8B7lqHo+QCVU0lHkKBJ7/OsujvSrSe/6pCz3Tx/Fi9EzN5MH
         4jcT8gkcTgrPnCoo0P9vfF+6iCLssr6QFtKBslx199cYK4OJTJbpS+BzwLFO3fNnGR9b
         VV2/ovqWA8W5ztSfjC8UYtL1loIfqqFXPq5PVQxDXjllaDkSGlGoRpcF2xCH40qpsyiy
         96McdV4eFzJOBsohHc8zfmOaseibnvi5v5D/B6K48C9GCV0/jkvl2LfwuhXtVXBBpdpe
         mKLwvvII1dMDaDBYVc/tupFgRk7th1DURgzTvLxVX4NxKO9XBDRzZt6m+n8HojOyywtw
         VHXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=hxoy1ZV5sToffY4PE/tTqurkXva76ASJNTG/Gm0iUtc=;
        b=CZOjgnIyDIohAxT/vGDtBCvcqe2epsP8Nf7exCZHCZjvDTbyu0yCcUi4dvXslMZwp6
         znjY+k3aNKQ0F9uMbTivd4Ba8GNWnsljmFtZpZ+T1z6iT08ZxChSVZhmAxQPqo9QkOjA
         ZCk/qRkEUGp+UiMH3u4hZ1Opj3+jLB+0FOsvYG5zhl8wngSFlTDHRHUzLnoWD04kEe23
         ZHHNKmB9bAxG0gLw4pV6MVMmwKREOo+Loq3Dd8shXni2AYnjB/hqNgRAK6KYtAFFZB69
         5rVpvEJ0NVOZOVcmaZkJ2olGuPURt+eogr0niNQpPdhv5SIbfb+4jjtBdvgTdLofmKzZ
         GMmQ==
X-Gm-Message-State: APjAAAWZ5HG3++ppa/9CjnEERcPgVyRYzZHTTcvQuEy1wf9znnSEcLkZ
        j3ygpFXlbwFptKMqED6m1KPtOg==
X-Google-Smtp-Source: APXvYqyU4uQeJLG/OtvlrhNPGDGwC02F9Y9cEMoD1VswE6z2M+2QplpwXLVYjy+XAotMFpGdXNqlcw==
X-Received: by 2002:a19:f60f:: with SMTP id x15mr5444261lfe.95.1556898152317;
        Fri, 03 May 2019 08:42:32 -0700 (PDT)
Received: from localhost (c-573670d5.07-21-73746f28.bbcust.telenor.se. [213.112.54.87])
        by smtp.gmail.com with ESMTPSA id 63sm486077lfz.2.2019.05.03.08.42.31
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 03 May 2019 08:42:31 -0700 (PDT)
From:   Anders Roxell <anders.roxell@linaro.org>
To:     a.zummo@towertech.it, alexandre.belloni@bootlin.com,
        shawnguo@kernel.org, s.hauer@pengutronix.de
Cc:     linux-rtc@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Anders Roxell <anders.roxell@linaro.org>
Subject: [PATCH] rtc: imxdi: remove unused variable
Date:   Fri,  3 May 2019 17:42:17 +0200
Message-Id: <20190503154217.13205-1-anders.roxell@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This variable is no longer used and the compiler rightly complains that
it should be removed.

../drivers/rtc/rtc-imxdi.c: In function ‘dryice_rtc_set_alarm’:
../drivers/rtc/rtc-imxdi.c:633:16: warning: unused variable ‘now’ [-Wunused-variable]
  unsigned long now;
                ^~~

Rework to remove the unused variable.

Fixes: 629d488a3eb6 ("rtc: imxdi: remove unnecessary check")
Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
---
 drivers/rtc/rtc-imxdi.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/rtc/rtc-imxdi.c b/drivers/rtc/rtc-imxdi.c
index 6342bc403645..3f3d652a0b0f 100644
--- a/drivers/rtc/rtc-imxdi.c
+++ b/drivers/rtc/rtc-imxdi.c
@@ -630,7 +630,6 @@ static int dryice_rtc_read_alarm(struct device *dev, struct rtc_wkalrm *alarm)
 static int dryice_rtc_set_alarm(struct device *dev, struct rtc_wkalrm *alarm)
 {
 	struct imxdi_dev *imxdi = dev_get_drvdata(dev);
-	unsigned long now;
 	int rc;
 
 	/* write the new alarm time */
-- 
2.20.1

