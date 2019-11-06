Return-Path: <SRS0=fWiu=Y6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8ECEAFC6196
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Nov 2019 22:40:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 60E22217F4
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Nov 2019 22:40:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lktGWLr3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732789AbfKFWkU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Nov 2019 17:40:20 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:33377 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726817AbfKFWkU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Nov 2019 17:40:20 -0500
Received: by mail-pf1-f196.google.com with SMTP id c184so255405pfb.0;
        Wed, 06 Nov 2019 14:40:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=G+wFREXzWnU4DvNTPp24jRK6gxHaykXaWaMf/sx6ATg=;
        b=lktGWLr3/bgx3/ucB1j1LiAdjYxPUv/VzQAxdgfeHQb4IreqFBsad+ABk5LnWp4VXN
         ttc8B0sCWR9Tq6/LAX6Yn0gAa7L65tRj/gmKJ9zUIL0NKQUkxTvG4bp0Qebbfy66Y7bq
         vi7UAHgEEPOAraCB0IiaShYNCUimetDf6pirOFAiteCULQyL45HCKkN8turz6u7Nhr0O
         7UN2l2E1izSVZdI8eeq7HuujZr48EwEkvt+F7lW8Iwb6j8Dily2nOEFPcsRNZ19Xji28
         2dJ9tmA18ToYOSAuVgtV7aQ2FnO0HDU1YkQpJ3GiWjcufjmcCCE5zCcPbeVJ0/mc5e1i
         X4GA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=G+wFREXzWnU4DvNTPp24jRK6gxHaykXaWaMf/sx6ATg=;
        b=Y6/XxNbokdhXLNjn4IN0ob2oPfQISynM9UqH6a0+qW+oMZckhmN/PMQEHd9xFFGO41
         hc6KoJVd9B22B5tNr7EOU+90WtTFMD9KwmPO4W5lHVeKZeJOfvTy0/cHLvVk5JCmWoin
         g5jbugCwFOgAKfpXwvLJ2RNQyt/Z9OPTu8lsfKNF6XrHqNvF6vTu1CCBErSGuUunuByG
         kQ6R+yi/M6jNKw4LE2vZycUNAZAkoisyuc5zn5LC33MmjtEOxlKEGekooqdbLIo0hXM6
         DYIoaiDzuOBRLEAX1yuZwglyvcCwPduf8BWJGuh8/mH9VcYDeOj4e4ncSuMGV72h5T+p
         /glQ==
X-Gm-Message-State: APjAAAVQeATF0jkYvZcQtLOb1IDN+kXCrMn30CLPJisXrT0+fyFBR2XC
        6GWiceGB+tpDa6qWmsirEXPftoveh4s=
X-Google-Smtp-Source: APXvYqxvCPKVks8a1VhUTjXjnqv1qXKWQbwY0UcGGC+kQVTDOwaguh/Hl96NDqbeuoc4aVExN+jJ/Q==
X-Received: by 2002:a63:934d:: with SMTP id w13mr283470pgm.185.1573080019554;
        Wed, 06 Nov 2019 14:40:19 -0800 (PST)
Received: from odroid.ad.adelaide.edu.au (staff-249-202.wireless.adelaide.edu.au. [129.127.249.202])
        by smtp.googlemail.com with ESMTPSA id v2sm96783pgf.39.2019.11.06.14.40.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 06 Nov 2019 14:40:19 -0800 (PST)
From:   Marian Mihailescu <mihailescu2m@gmail.com>
To:     linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, krzk@kernel.org, robh+dt@kernel.org,
        mark.rutland@arm.com, kgene@kernel.org
Cc:     Marian Mihailescu <mihailescu2m@gmail.com>
Subject: [PATCH v3 1/2] dt-bindings: gpu: mali-midgard: add samsung exynos 5420 compatible
Date:   Thu,  7 Nov 2019 09:10:07 +1030
Message-Id: <20191106224008.7588-1-mihailescu2m@gmail.com>
X-Mailer: git-send-email 2.14.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add "samsung,exynos5420-mali" binding

Signed-off-by: Marian Mihailescu <mihailescu2m@gmail.com>
---
 Documentation/devicetree/bindings/gpu/arm,mali-midgard.yaml | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/gpu/arm,mali-midgard.yaml b/Documentation/devicetree/bindings/gpu/arm,mali-midgard.yaml
index 47bc1ac36426..41b928bce4ea 100644
--- a/Documentation/devicetree/bindings/gpu/arm,mali-midgard.yaml
+++ b/Documentation/devicetree/bindings/gpu/arm,mali-midgard.yaml
@@ -38,9 +38,12 @@ properties:
           - enum:
              - samsung,exynos5433-mali
           - const: arm,mali-t760
+      - items:
+          - enum:
+             - samsung,exynos5420-mali
+          - const: arm,mali-t628
 
           # "arm,mali-t624"
-          # "arm,mali-t628"
           # "arm,mali-t830"
           # "arm,mali-t880"
 
-- 
2.14.1

