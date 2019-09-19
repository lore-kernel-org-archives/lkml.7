Return-Path: <SRS0=X8En=XO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD1D6C49ED7
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Sep 2019 06:39:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 93FDF218AF
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Sep 2019 06:39:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="PMxExpOI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388408AbfISGjQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Sep 2019 02:39:16 -0400
Received: from mail-pg1-f178.google.com ([209.85.215.178]:42857 "EHLO
        mail-pg1-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388094AbfISGjQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Sep 2019 02:39:16 -0400
Received: by mail-pg1-f178.google.com with SMTP id z12so1278703pgp.9
        for <linux-kernel@vger.kernel.org>; Wed, 18 Sep 2019 23:39:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=wpuMn03tUIQsR8rZavj+GiJJtBb+wUvitnysLC3OpiU=;
        b=PMxExpOIXlUFXAFa3Moc3DfVHDnJscDeFnXV/qaxLuAv2F7DbqFqoz9P2w/LypXfKI
         5xZwMOLHP7oblg4tNGly6XXBws+o4YSonS36H5xvLXAenzN0AheQQ6+JjT/7dIdsyu2A
         xpcCStC9zyaH6IcNgFcxquUrX/jUNPrmmpjbzJ2dYeVDAiS3SuaTK6WuTadsiZBF6niW
         +EA/Lp6VeIM1hNl/E/doXLlBN3jJeKzw1IDNihxrOCLx2y9JJxvUWRb+ZvUwyHhv6g4W
         KM2+RJeUMKNU5+lDY0qJzkEh1Qs4aOqXR28Q7Cjk3/nbH5iK6CLU2shH7STEELSyDSy8
         YolA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=wpuMn03tUIQsR8rZavj+GiJJtBb+wUvitnysLC3OpiU=;
        b=Tk/sofmoU5eEpPy2m6ofJicsdyawQ9CSGkOw9E/XkcwwSIugN3GaSOyY9E8YSXXEe3
         aXVlux6JxogtzM8pwNKDdq6xtis/j5cCoOEnwMfluyDYbxCe2Gryr/TtuSvCh1z12fe6
         oeaGiKSzpDhe6vZnegTM40bwPHIrn45H5wF0ZOaLGsqDVuhhLX2EFJQ5XN/akhR1fPKb
         xQh9AQoeeIZR77Sh/8Y1BNRVkIAE/41NWfw0x70YYUvwbVwDr6846y0qhEl9RavLJu+1
         MUtF6Xg8VMwz0ojxm1tSgSmW8ruQCufCmKAF3KBy771Aoi0vhzxMAzvu3OC4GKdiRiT+
         hFHw==
X-Gm-Message-State: APjAAAWK/Y3USQyXUF9yxTmGByoU9qrJDhTilWNJ/3qVbQsNnSXPZocg
        IKGyzF3fXhTtvtOTIpu6anFrtw==
X-Google-Smtp-Source: APXvYqwHp1zJz34n8tT1pKbEoEETsbDLuoiL8pzuyfr/mZ7BuShBULuW5Pa7A5XuIVS9Qqs0wjqKXw==
X-Received: by 2002:a17:90a:3086:: with SMTP id h6mr1972443pjb.1.1568875155727;
        Wed, 18 Sep 2019 23:39:15 -0700 (PDT)
Received: from pragneshp.open-silicon.com ([114.143.65.226])
        by smtp.gmail.com with ESMTPSA id v5sm11550757pfv.76.2019.09.18.23.39.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 18 Sep 2019 23:39:15 -0700 (PDT)
From:   Pragnesh Patel <pragnesh.patel@sifive.com>
To:     lgirdwood@gmail.com, broonie@kernel.org
Cc:     Pragnesh Patel <pragnesh.patel@sifive.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: [PATCH] fixed-regulator: dt-bindings: Fixed building error for compatible property
Date:   Thu, 19 Sep 2019 12:09:04 +0530
Message-Id: <1568875145-2864-1-git-send-email-pragnesh.patel@sifive.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Compatible property is not of type 'string', so remove const:
from it.

Signed-off-by: Pragnesh Patel <pragnesh.patel@sifive.com>
---
 Documentation/devicetree/bindings/regulator/fixed-regulator.yaml | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/regulator/fixed-regulator.yaml b/Documentation/devicetree/bindings/regulator/fixed-regulator.yaml
index a78150c..f324169 100644
--- a/Documentation/devicetree/bindings/regulator/fixed-regulator.yaml
+++ b/Documentation/devicetree/bindings/regulator/fixed-regulator.yaml
@@ -30,8 +30,8 @@ if:
 properties:
   compatible:
     enum:
-      - const: regulator-fixed
-      - const: regulator-fixed-clock
+      - regulator-fixed
+      - regulator-fixed-clock
 
   regulator-name: true
 
-- 
2.7.4

