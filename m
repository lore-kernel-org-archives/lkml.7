Return-Path: <SRS0=HfRD=XN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E148FC4CEC9
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Sep 2019 12:01:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B4D442054F
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Sep 2019 12:01:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="eCbt59Bq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729384AbfIRMBN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Sep 2019 08:01:13 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:36892 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728813AbfIRMBN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Sep 2019 08:01:13 -0400
Received: by mail-pg1-f193.google.com with SMTP id c17so3953560pgg.4
        for <linux-kernel@vger.kernel.org>; Wed, 18 Sep 2019 05:01:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=WkQ76CITam9F7JiZEHEwL0RX83IOrZqz3Y++2Xoowf4=;
        b=eCbt59BqCWohhKOx9Y+Z8ftqpShDtgftW5+zz/dI+Ju0QCOAJrpXZrFORiiEptuIvK
         vhaDaD8/3pYuo+FrATD9qYuWzYLvQ0VZhqNfBX0TOh5x+ZjETAmFftVs2GzCGx0ENEIT
         cWJDlROlkMGsN+Ve2tEMn4TINILoLkNIr3ASNBPBbmqflF1dtZsIdyXJ2gFnresOc0Gv
         ZdLO/i7iTr6bC9IZ2eoT2XzBhLm/dwEPnG/8XzWtWbrDlho2sNidw7Xm0l5lEBbJQwi0
         tHitqC51imBnyvE+ZVAsrmvobrsRHw/s2SaB7sDs5bI66RgQkw8ZiHo4PUYTWBAzuAq6
         NJ8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=WkQ76CITam9F7JiZEHEwL0RX83IOrZqz3Y++2Xoowf4=;
        b=CGSzs75dDeuPR/SCbem8e8nJf5iCJSbghbkwjVTc4aqhBLuEVyqDdxgMp/pz5MvKJ5
         aXhel53i+IvT0lFJ6he41/Imu19S5MTrbvdyysKMyci1nQQs597U0LRIvPHCJCmKQ8vy
         WEGxlgjJNcUouihmgWaaef6cpd6Rhr3nPKfnVXmaXJfHLTjwg56OvsvnlhaSF2zES0JV
         1oyfjUWH9b62pZ7rxm1BTc2VelqN3CeHG3BKWbPG/6rryYieiAkOQmoCw6wXh/hruUaz
         meqj0wqpnWQmHYvXLiMOe6gsTFx88Jb2WRxmIdQ3zEZFOxT0UrGGFBir5mG2pd4fsRAO
         ha/w==
X-Gm-Message-State: APjAAAUfu0HCjxNJAy/H2qP33Q6H8gtO56Qe0w0snSt+UKdhguC9usT7
        vlhsDpMfLsEc/+tW5K9ACVfl8g==
X-Google-Smtp-Source: APXvYqybyNmzYSLFX4gGeI++WncUy4zJYIdFMkUqy0VPaTasXIn9sKMgm6+FthWofH2FZyQmGqRg8w==
X-Received: by 2002:a63:5626:: with SMTP id k38mr3667623pgb.134.1568808072722;
        Wed, 18 Sep 2019 05:01:12 -0700 (PDT)
Received: from pragneshp.open-silicon.com ([114.143.65.226])
        by smtp.gmail.com with ESMTPSA id z13sm6882241pfq.121.2019.09.18.05.01.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 18 Sep 2019 05:01:12 -0700 (PDT)
From:   Pragnesh Patel <pragnesh.patel@sifive.com>
To:     mripard@kernel.org
Cc:     Pragnesh Patel <pragnesh.patel@sifive.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Chen-Yu Tsai <wens@csie.org>, linux-media@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] media: dt-bindings: Fix building error for dt_binding_check
Date:   Wed, 18 Sep 2019 17:31:00 +0530
Message-Id: <1568808060-17516-1-git-send-email-pragnesh.patel@sifive.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

$id doesn't match the actual filename, so update the $id

Signed-off-by: Pragnesh Patel <pragnesh.patel@sifive.com>
---
 Documentation/devicetree/bindings/media/allwinner,sun4i-a10-csi.yaml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/media/allwinner,sun4i-a10-csi.yaml b/Documentation/devicetree/bindings/media/allwinner,sun4i-a10-csi.yaml
index 27f38ee..5dd1cf49 100644
--- a/Documentation/devicetree/bindings/media/allwinner,sun4i-a10-csi.yaml
+++ b/Documentation/devicetree/bindings/media/allwinner,sun4i-a10-csi.yaml
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
 %YAML 1.2
 ---
-$id: http://devicetree.org/schemas/arm/allwinner,sun4i-a10-csi.yaml#
+$id: http://devicetree.org/schemas/media/allwinner,sun4i-a10-csi.yaml#
 $schema: http://devicetree.org/meta-schemas/core.yaml#
 
 title: Allwinner A10 CMOS Sensor Interface (CSI) Device Tree Bindings
-- 
2.7.4

