Return-Path: <SRS0=G0tX=VI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3615C73C66
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jul 2019 17:49:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AB154208E4
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jul 2019 17:49:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a1U5AoD3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728860AbfGKRtP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Jul 2019 13:49:15 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:36913 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728479AbfGKRtO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Jul 2019 13:49:14 -0400
Received: by mail-pf1-f194.google.com with SMTP id 19so3103453pfa.4
        for <linux-kernel@vger.kernel.org>; Thu, 11 Jul 2019 10:49:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=Mrtm+42mKXJyXI1jqGIgzb23Y5WaFCmewuRRxjnIfds=;
        b=a1U5AoD3hkSIItL8HiNNo7PFR4wX/QYAlw457C7RrSX5rOFi4TkzHWxCKO0LUF0Ofp
         StIat4u1q9RTPUeU3gX0H4AqbIljtz35UoRLLzRRW6SSj996v3KIWMhtvagA9QVhw7HA
         iI9EgguM0sZmy7c130Md82ABD0glJ/vJHtfphaRS/45jT4LJviORGdt33qqmfIHw51zk
         heocyYKTaZ7DQjn5Z6+nv/Cb/1Md7cGwkrxCv5LpsVR19I+OpLBEp8OJCH+AZuYxh4yy
         CPKwXb9o7FPmndgG0JcHMZovsY254hE4eg8SN1ZDRGl4yULogViTchMWdeiXGCfv+cis
         yxlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=Mrtm+42mKXJyXI1jqGIgzb23Y5WaFCmewuRRxjnIfds=;
        b=WYZ8PfepkGaGTmgbaJzHx3evJDxnTc+o1agv+aCQjfsW+JFaN4+MNj69VPTCqfQaJ+
         tR59xyKQF5iSmanNShgbNKjPhGdEbGE+lsoBwAQOplyr6eJKBMQ1upTsMWE2XIxQzwi9
         nA0SSyKn1VS/ZPYae3XMy6LDSNoMcTeGq1pzZXErlZUEpMkGG1qui2NudqfZO0Ic/6bt
         nT1TTAP3SgfhiSAHoivvZ1bE/5OpWh3Zv5ty4AulEY5yLc26U9V6KyIm2reXgmwm9XUJ
         XU/ksY2qPy5Lf2k+akuIdQuP5ZO0ZMzBH8qzbLMuBiH/JTXLwVscNwU0qPlnMANkq0Ip
         hcEA==
X-Gm-Message-State: APjAAAWOTcd/vi1kcXAF72PNALCzfosrsnSrZPpqcRXqDblN8r3hgCOK
        04f+88SccVFPH+GUaXECfwA=
X-Google-Smtp-Source: APXvYqxCyTB+WLKmBXb76xa7SlBiPdhWde9HUOK2ZWNCd4igyy/yrwmLGCWZ37b9pSSSIlPgtws65Q==
X-Received: by 2002:a63:b46:: with SMTP id a6mr5801358pgl.235.1562867354148;
        Thu, 11 Jul 2019 10:49:14 -0700 (PDT)
Received: from hari-Inspiron-1545 ([183.83.86.126])
        by smtp.gmail.com with ESMTPSA id b11sm6834267pfd.18.2019.07.11.10.49.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 11 Jul 2019 10:49:13 -0700 (PDT)
Date:   Thu, 11 Jul 2019 23:19:06 +0530
From:   Hariprasad Kelam <hariprasad.kelam@gmail.com>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Vinod Koul <vkoul@kernel.org>,
        Wen Yang <wen.yang99@zte.com.cn>,
        Gen Zhang <blackgod016574@gmail.com>,
        Hariprasad Kelam <hariprasad.kelam@gmail.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Subject: [PATCH] sound: soc: codecs: wcd9335: fix "conversion to bool not
 needed here"
Message-ID: <20190711174906.GA10867@hari-Inspiron-1545>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix below issue reported by coccicheck
sound/soc/codecs/wcd9335.c:3991:25-30: WARNING: conversion to bool not
needed here

Signed-off-by: Hariprasad Kelam <hariprasad.kelam@gmail.com>
---
 sound/soc/codecs/wcd9335.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/sound/soc/codecs/wcd9335.c b/sound/soc/codecs/wcd9335.c
index 1bbbe42..85a8d10 100644
--- a/sound/soc/codecs/wcd9335.c
+++ b/sound/soc/codecs/wcd9335.c
@@ -3988,12 +3988,7 @@ static irqreturn_t wcd9335_slimbus_irq(int irq, void *data)
 		regmap_read(wcd->if_regmap,
 				WCD9335_SLIM_PGD_PORT_INT_RX_SOURCE0 + j, &val);
 		if (val) {
-			if (!tx)
-				reg = WCD9335_SLIM_PGD_PORT_INT_EN0 +
-					(port_id / 8);
-			else
-				reg = WCD9335_SLIM_PGD_PORT_INT_TX_EN0 +
-					(port_id / 8);
+			reg = WCD9335_SLIM_PGD_PORT_INT_TX_EN0 + (port_id / 8);
 			regmap_read(
 				wcd->if_regmap, reg, &int_val);
 			/*
-- 
2.7.4

