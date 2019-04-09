Return-Path: <SRS0=D3m8=SL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A4B1C10F0E
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 13:00:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 14C722084F
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 13:00:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ingics-com.20150623.gappssmtp.com header.i=@ingics-com.20150623.gappssmtp.com header.b="n0AGHm3x"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727308AbfDINA4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Apr 2019 09:00:56 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:35149 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726035AbfDINA4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Apr 2019 09:00:56 -0400
Received: by mail-pf1-f194.google.com with SMTP id t21so7363405pfh.2
        for <linux-kernel@vger.kernel.org>; Tue, 09 Apr 2019 06:00:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ingics-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=4jr4q1rECNubN/2D1x2mEFq1Kbn6oDRoM8C7PviniXY=;
        b=n0AGHm3xpxVONXBv59bEdPJq2eROcYsVETSTxwDfQR194GZAYEdHGdcjsheu/ewxcP
         4y2XjDZPOf5+KTXmurpQWDQsA0Iei00WLFmTsniWLuHz5Ozm0pgYJLGez01RCd4uupJ2
         l6+pRmQ0IHAuQK/0a3usCY6Nn6X2TawmkWQUDPCRRh44y2VzvJQTwDfAmHL6tJChns/u
         dSqOxqcav0bUA5b5iqwj5oS7fExiYJ6nZyyRYayemHIaahv7MROYLb42q/00n8lSc7Xs
         q+dHMLpCqhClpQBXw0REEb7xsscTFMtammfE2cmaMpkC/bl5CNhWXJ8yRgbocWUg0dOc
         ryzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=4jr4q1rECNubN/2D1x2mEFq1Kbn6oDRoM8C7PviniXY=;
        b=P0HG2QQuCezK6zp3C4VjviuLPZAT2jymP7gkQ07SPDygbZg5SoFJRiN+oIbek0t6uI
         mS+kzEHw5zLJBQN+0hnYK9qG7aeUjw8tdcVEPnAbEyuUJdODvwF+E4zuUFFkRw0py8t+
         sYfBC3wXnsWi8Y5ouPc/XVRsA0IqRCfs1wKqYOYYYSTbZyf2+3s1u6kPycwKA/1ci2Es
         AKzOW92zhCzeKbr2IFrHQoUjVIYiYBqlZz/2H23sG+wfBtuhRhzIK0MiIykyuhn5ljzg
         O1gICNUn5eYOEzP4dL219U8GUPhi2gHabbNJy6fhwgmkZ+W4IRaPKu8aTSZmHuZ8xA0M
         TvCQ==
X-Gm-Message-State: APjAAAX8sQN+sE9nYlpQpuwjjmxBDyPCZmwkSDjQqcTexCNecxCOYeob
        MbSe9GCtdCPcxAxhS0m9Bk2XQw==
X-Google-Smtp-Source: APXvYqzXzR53WhfIMbt+EVDzLeQMGyFZMdtPtCkvh/49a8/hWT3cqvHWrxP44yoImdMaHCDYU4Tk9Q==
X-Received: by 2002:a62:1a06:: with SMTP id a6mr36667649pfa.18.1554814854920;
        Tue, 09 Apr 2019 06:00:54 -0700 (PDT)
Received: from localhost.localdomain (220-133-186-239.HINET-IP.hinet.net. [220.133.186.239])
        by smtp.gmail.com with ESMTPSA id h65sm82165259pfd.108.2019.04.09.06.00.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 09 Apr 2019 06:00:54 -0700 (PDT)
From:   Axel Lin <axel.lin@ingics.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     Sachin Kamat <sachin.kamat@linaro.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org, Axel Lin <axel.lin@ingics.com>
Subject: [PATCH] regulator: s2mpa01: Remove unused define for S2MPA01_REGULATOR_CNT
Date:   Tue,  9 Apr 2019 21:00:42 +0800
Message-Id: <20190409130042.4678-1-axel.lin@ingics.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The S2MPA01_REGULATOR_CNT is no longer used after converted to use
simplified DT parsing.

Signed-off-by: Axel Lin <axel.lin@ingics.com>
---
 drivers/regulator/s2mpa01.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/regulator/s2mpa01.c b/drivers/regulator/s2mpa01.c
index da11ac5c09f2..51f7e8b74d8c 100644
--- a/drivers/regulator/s2mpa01.c
+++ b/drivers/regulator/s2mpa01.c
@@ -17,8 +17,6 @@
 #include <linux/mfd/samsung/core.h>
 #include <linux/mfd/samsung/s2mpa01.h>
 
-#define S2MPA01_REGULATOR_CNT ARRAY_SIZE(regulators)
-
 struct s2mpa01_info {
 	int ramp_delay24;
 	int ramp_delay3;
-- 
2.17.1

