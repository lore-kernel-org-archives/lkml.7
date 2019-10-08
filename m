Return-Path: <SRS0=XKeO=YB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24B99ECE58C
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Oct 2019 01:06:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EE42920867
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Oct 2019 01:06:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ingics-com.20150623.gappssmtp.com header.i=@ingics-com.20150623.gappssmtp.com header.b="HqRZYN2L"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729514AbfJHBGm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Oct 2019 21:06:42 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:40155 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729212AbfJHBGl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Oct 2019 21:06:41 -0400
Received: by mail-pl1-f195.google.com with SMTP id d22so7702591pll.7
        for <linux-kernel@vger.kernel.org>; Mon, 07 Oct 2019 18:06:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ingics-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=WqnV/qH3yoorGVEmxS1ufT5RoHEh6iEuQ0EMZ9KSkIE=;
        b=HqRZYN2LwrbkQ0yxFRsYwTKIfVxD2iSb/s4PR2ip9IDjQ5NWEC1EETcIELJ5NWttaz
         NjXWXam+SlyVXQweK0igSvHPWJITEA5jataFPS1MdpyjYwKLUKWUf4GazQiBnti+GkKp
         JSF8pSYpwFM0rwvtIlE+fAGT09ugitnMP1hsFIRaFwBciQCEDncCibcrFqbQmkD4iUD3
         c/2rfpOjtss6xhAOKOJjtwgNiE7ZNex0WbJAAGoiYCQGFtOucRDOMPykM8rBDdxAXV8C
         QrzInRl9EwVgGkaBJT2BAibykOtrf18qITMAaw3IM+imf8paH0d8KuVxDfPXd0byY/Z4
         Jqjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=WqnV/qH3yoorGVEmxS1ufT5RoHEh6iEuQ0EMZ9KSkIE=;
        b=oKTpp7FbkXZaCfGAGkKewIAdNbJPrLwL8+cnz/yBM8Rwv+kVZWhT9OPpz+thmWhOx7
         /AgZTWGNIqH1SKpeS879BEHe5TwLU0pNPOWfqxjlGYwL/q3w54DyDkrY7E6HAYViLk5e
         DpegWouYWiIw9kav7dRapA2vf000fmXEngCyfBhghXPpwREdBWVSldOR/8XXBkHr1X8e
         v9/61zE5uyXOyIcTSBE11FTJ3/H2ZNYvmpI7qoB0bF09DBORmzEcAlHdOJhagRXcgCAO
         n16Jzu6hEgXD+ox5N/Wjinl7vyBIm89qK8W9XNE/MMrjdd7rNxFHgsUgffRep1+DvczK
         4Vxg==
X-Gm-Message-State: APjAAAWOl5iazGJfQXAwvNRvxgpcDROKT4qJohF9bNbbF8BaQ+WgJWPR
        kpaFMHMqJLdX0kQsC5VildPZog==
X-Google-Smtp-Source: APXvYqwTJu873qY50Zzy3FpKw/OvQhdPMIs5noquC0eqxq91glDspJLlpl0InP5HBYIO5Ip9MYnYCw==
X-Received: by 2002:a17:902:b110:: with SMTP id q16mr31981345plr.262.1570496799685;
        Mon, 07 Oct 2019 18:06:39 -0700 (PDT)
Received: from localhost.localdomain (122-117-179-2.HINET-IP.hinet.net. [122.117.179.2])
        by smtp.gmail.com with ESMTPSA id 18sm15563898pfp.100.2019.10.07.18.06.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Oct 2019 18:06:39 -0700 (PDT)
From:   Axel Lin <axel.lin@ingics.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     Heiko Stuebner <heiko@sntech.de>,
        Tony Xie <tony.xie@rock-chips.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org, Axel Lin <axel.lin@ingics.com>
Subject: [PATCH 2/3] regulator: rk808: Fix warning message in rk817_set_ramp_delay
Date:   Tue,  8 Oct 2019 09:06:27 +0800
Message-Id: <20191008010628.8513-2-axel.lin@ingics.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191008010628.8513-1-axel.lin@ingics.com>
References: <20191008010628.8513-1-axel.lin@ingics.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The default in rk817_set_ramp_delay is 25MV rather than 10MV.

Signed-off-by: Axel Lin <axel.lin@ingics.com>
---
 drivers/regulator/rk808-regulator.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/regulator/rk808-regulator.c b/drivers/regulator/rk808-regulator.c
index eda056fce65f..d0d1b868b0cd 100644
--- a/drivers/regulator/rk808-regulator.c
+++ b/drivers/regulator/rk808-regulator.c
@@ -388,7 +388,7 @@ static int rk817_set_ramp_delay(struct regulator_dev *rdev, int ramp_delay)
 		break;
 	default:
 		dev_warn(&rdev->dev,
-			 "%s ramp_delay: %d not supported, setting 10000\n",
+			 "%s ramp_delay: %d not supported, setting 25000\n",
 			 rdev->desc->name, ramp_delay);
 	}
 
-- 
2.20.1

