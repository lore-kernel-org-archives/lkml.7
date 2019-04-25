Return-Path: <SRS0=Q+aa=S3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCFC2C43218
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 19:53:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F13022077C
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 19:53:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="CDD0L/r/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387788AbfDYTxe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Apr 2019 15:53:34 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:34144 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387764AbfDYTxc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Apr 2019 15:53:32 -0400
Received: by mail-pg1-f195.google.com with SMTP id v12so380725pgq.1
        for <linux-kernel@vger.kernel.org>; Thu, 25 Apr 2019 12:53:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=N4DXUAnG4MgIchB4rUOv3H8mFdzofOw3TD3XHtggT3U=;
        b=CDD0L/r/W2izojuuskGojdB9Ow0dJAX4t2ZenjRv1o7qzqSkLcLlw72oCgV1xJMS3O
         Jo3sUIyD0qmwZQlyDjWakW21UDQQ8PHGARuVSOSK3N6TgDsRLh7yJbEqyFKrdzUTE5CD
         92ubrlw2jtDZ3i23+nu0MVf1yIPToQPk2WMCXUDO7gwUH5CcknpnpyQiXRpco4+v0oNx
         AGsKETozDJ6SjDmy4xSBq2o1I3TiBGYUAbyPWD8AN2jEmV1hWHfC57XIp+frHEDPi4Oo
         JiOGrkYd1eBICgITyVvd2cp6s4UFDDkZyel0m3bETPcf1KkTKENFpEeuXkLYLsBcRoa8
         JoMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=N4DXUAnG4MgIchB4rUOv3H8mFdzofOw3TD3XHtggT3U=;
        b=cfQS/J3JwmtGp10jPIckDVViFdRM+HYxiPHmHRuGCL3flhRoDnFG4rwGj/OCcOkO/a
         9lx7CTD/84WV2oxc5OmF5Q/W06lcomwwdnUTzm+HYsbUHsHFjRUApVkhC6FpjfBFwJeQ
         GFDxV7PcpgEWp2zUuH2K+Qzz25q4a+3YUBqhgaX1NhQKhuOdEb8jwnyVuRoa6xbtuZ8K
         GzIT0ZPU6SzfyRulYYf2sijqO3FK+E7cA3xnY7PBsU05GV4dW4Zq17Rg9jpWOS3myklk
         e8F/fPrxCM7wTgM7tpXmWVTTYrwEU7Kt+c8Nvjv+4UtNC4Ekb0vnyr1V0lt1xrAsT/h7
         qttg==
X-Gm-Message-State: APjAAAVwww8gK4bjUGGqdnNObOy5KeSPLGfv4IUr3f/tLGHF8ARGkFzi
        hMlHdmh1K8/Cj/hPsgd6bfNyzaqTmn8=
X-Google-Smtp-Source: APXvYqxT5U9BnOdA/+MUn9f+/9U64PfrAibDha2xqQpYyoxg5hE30hcO11aN1iz+53jjtmDqATMtGQ==
X-Received: by 2002:a63:4241:: with SMTP id p62mr39140139pga.379.1556222011753;
        Thu, 25 Apr 2019 12:53:31 -0700 (PDT)
Received: from xps15.cg.shawcable.net (S0106002369de4dac.cg.shawcable.net. [68.147.8.254])
        by smtp.gmail.com with ESMTPSA id t64sm47261961pfa.86.2019.04.25.12.53.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 25 Apr 2019 12:53:31 -0700 (PDT)
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 15/32] coresight: etm4x: Skip selector pair 0
Date:   Thu, 25 Apr 2019 13:52:53 -0600
Message-Id: <20190425195310.31562-16-mathieu.poirier@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190425195310.31562-1-mathieu.poirier@linaro.org>
References: <20190425195310.31562-1-mathieu.poirier@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Resource selector pair 0 is always implemented and reserved.  As such
it should not be explicitly programmed.

Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
Reviewed-by: Suzuki K Poulose <suzuki.poulose@arm.com>
Tested-by: Leo Yan <leo.yan@linaro.org>
Tested-by: Robert Walker <robert.walker@arm.com>
---
 drivers/hwtracing/coresight/coresight-etm4x.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-etm4x.c b/drivers/hwtracing/coresight/coresight-etm4x.c
index 732ae12fca9b..d64192c29860 100644
--- a/drivers/hwtracing/coresight/coresight-etm4x.c
+++ b/drivers/hwtracing/coresight/coresight-etm4x.c
@@ -138,8 +138,11 @@ static int etm4_enable_hw(struct etmv4_drvdata *drvdata)
 			       drvdata->base + TRCCNTVRn(i));
 	}
 
-	/* Resource selector pair 0 is always implemented and reserved */
-	for (i = 0; i < drvdata->nr_resource * 2; i++)
+	/*
+	 * Resource selector pair 0 is always implemented and reserved.  As
+	 * such start at 2.
+	 */
+	for (i = 2; i < drvdata->nr_resource * 2; i++)
 		writel_relaxed(config->res_ctrl[i],
 			       drvdata->base + TRCRSCTLRn(i));
 
-- 
2.17.1

