Return-Path: <SRS0=6SCO=RE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A713CC43381
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 14:20:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B9322084F
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 14:20:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ingics-com.20150623.gappssmtp.com header.i=@ingics-com.20150623.gappssmtp.com header.b="zwj202DD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388307AbfCAOUZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Mar 2019 09:20:25 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:42794 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727697AbfCAOUY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Mar 2019 09:20:24 -0500
Received: by mail-pg1-f195.google.com with SMTP id b2so11518729pgl.9
        for <linux-kernel@vger.kernel.org>; Fri, 01 Mar 2019 06:20:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ingics-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=KxWs5JMhI8F+XneY1k+3DAiU4brkFYjPoHEiYW11KKg=;
        b=zwj202DDeN3p1f+2CWLAm1bk4G2qMe6Qb0AGOhQLvZp6cGge1ReFeaR3j0xZ9lfa8K
         fbEFP2MXBdvTTjEQI0e5jumCbfKKzNt7rxrjqlnVWUM5WuWTv3Z3RdS3D2opR7Ds9vE3
         UOXrFYLmj+4vUM/PWYiqYf6OZfXlVpD2xfvtRiawUz4LpBgA3ko2/wclUpyf/9My0fKh
         W5t5EOheuzF1HKxhtXtNjs6YpjIXrlSo55m1B7NjGZd7UKnxHxw5Q73y5F1m6CvxqlNR
         EtuHA5/g4Q0jzynlWLjx+6NDj9P6M9TYnW5s8IAf8baE2gLX7W9xE+ZdKT1neKKmDamm
         ff3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=KxWs5JMhI8F+XneY1k+3DAiU4brkFYjPoHEiYW11KKg=;
        b=nTLZa4UnbsA0gi6UU1KERF/8iG1sW7gzMjK7HRqZhTHolqdtE2NiNXsKTYZZ1auZQa
         Lt0Y2PTm8AmX/HKOo90lV6bi1beyXDexSJUdLmejPQYFRCebADhjolgqwec7p7nUSSci
         Fm0HlxazxJ7ZcEAX+Jo5bnswKHgCHL/YLYAwFgie6NDYKjQRTjrGl17/y0Le6/GAGAeY
         6qRwWy0rwbR1UeQpodC4C5fN4kLv2ujHERPo1OiXX3t2Z7MSc/c7dt+E/gx68TMej7DL
         +OYyl++Qqt8nJww3Vzco4FdLtLrf0BX/d7ZoX6Kq3rdHotI4cPDW15xwO86V9JQ2nKdq
         JuqQ==
X-Gm-Message-State: APjAAAVU8cbSf/1NyXLq75qP7gdyFBwHG/xyjl5B05pKgUMkPTS+CMEY
        fu8lDfswfORumF0BETdk52h3ow==
X-Google-Smtp-Source: AHgI3IZKmycO08Fnh4FTHkSFCaqZIaTfVCTbg1QFPAEA4kBzBijvgKT9prekjbAp7CTitz5pmPajgA==
X-Received: by 2002:a62:5c4:: with SMTP id 187mr5695921pff.153.1551450023810;
        Fri, 01 Mar 2019 06:20:23 -0800 (PST)
Received: from localhost.localdomain (2001-b400-e303-1426-2dd7-86e1-088f-ff18.emome-ip6.hinet.net. [2001:b400:e303:1426:2dd7:86e1:88f:ff18])
        by smtp.gmail.com with ESMTPSA id f4sm22878052pgq.94.2019.03.01.06.20.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 01 Mar 2019 06:20:22 -0800 (PST)
From:   Axel Lin <axel.lin@ingics.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     Keerthy <j-keerthy@ti.com>, Nishanth Menon <nm@ti.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org, Axel Lin <axel.lin@ingics.com>
Subject: [PATCH] regulator: palmas: Constify palmas_smps_ramp_delay array
Date:   Fri,  1 Mar 2019 22:20:16 +0800
Message-Id: <20190301142016.24082-1-axel.lin@ingics.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The palmas_smps_ramp_delay array should never modify, make it const.

Signed-off-by: Axel Lin <axel.lin@ingics.com>
---
 drivers/regulator/palmas-regulator.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/regulator/palmas-regulator.c b/drivers/regulator/palmas-regulator.c
index c2cc392a27d4..7fb9e8dd834e 100644
--- a/drivers/regulator/palmas-regulator.c
+++ b/drivers/regulator/palmas-regulator.c
@@ -382,7 +382,7 @@ static struct palmas_sleep_requestor_info tps65917_sleep_req_info[] = {
 	EXTERNAL_REQUESTOR_TPS65917(LDO5, 2, 4),
 };
 
-static unsigned int palmas_smps_ramp_delay[4] = {0, 10000, 5000, 2500};
+static const unsigned int palmas_smps_ramp_delay[4] = {0, 10000, 5000, 2500};
 
 #define SMPS_CTRL_MODE_OFF		0x00
 #define SMPS_CTRL_MODE_ON		0x01
-- 
2.17.1

