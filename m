Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CB28C10F13
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 15:41:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 593FF20868
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 15:41:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="loGj1EBL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729192AbfDPPln (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 11:41:43 -0400
Received: from mail-vs1-f73.google.com ([209.85.217.73]:56829 "EHLO
        mail-vs1-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725852AbfDPPlm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 11:41:42 -0400
Received: by mail-vs1-f73.google.com with SMTP id 2so4258622vsp.23
        for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2019 08:41:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=qsoE5OiVz6XGcPcZ4g01Dbmxl7qj2D8ouBvqI5bOjD4=;
        b=loGj1EBLulC3ulxRnibA6isQIAmg/rDKWJ5Od9OycGiqocd+UJHwagpQ7WPMRBSwIp
         33hQn2kFt4Ufos79Ev3h2L2J1zSuyI5bJvOFMYog883flLhAgQmnvvn/JDIvgJGjg29Q
         NIdxsUgUtvZDDYvCBQL8IN2gPlJVGPOw2M4aZOfLHjAicJP0L8gWaLuvRtQ91jMWupTG
         Sn1Z3UfxW2QUho1WVPd+Z3lDaXQe+ooow+mguGRVXJwXonLlAk3gbrNurNAcZJ0Z4Kqw
         Q99qPOyB3YbJanCin6S9NzILYCkWQo0iBMW31RNbceobKydM+8+haJcxkPogQZp5W7oW
         XRwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=qsoE5OiVz6XGcPcZ4g01Dbmxl7qj2D8ouBvqI5bOjD4=;
        b=KF7/7mEJf4qVC+kda8i01qKcr0E/vX8Q0naEqsC5aQBjtRN3IqmdswDHfTwij4DqZw
         ojqfGRNwH0EqIJsYHenEA0tZZjaFw6f6/FoI/SQi+iy9L25NU8yLS1bqOqLXf6CFnatB
         j4ph6lHU06WDeq527z7OqgInbMLEJGEqB21JP4TP/WleJWW6X0kpqKNlBDXykeuZJ6dZ
         roMNMVbgqswjxaWTvAAvQQjvc2BmH/MUyWcor45Oh9x6mdh0r9jGhsvmGEwH2acv2yfO
         Q1ffX37EGj5y833Rlq4+f9KVgRtgIhaY0ZusybJoiUk/TiGDAp3U08oNisfl0kfsLH3F
         uh1A==
X-Gm-Message-State: APjAAAV9DypVvkF1eNSOw8PVqtnDroYlr6qNbINEAFN+m7v+UlxMjXPV
        UHIuKket9YntCm9sw02T77kueeJNULeZ
X-Google-Smtp-Source: APXvYqxikGMaB3WlJ/aqRCYxtxl7eXmll9UtFU0sLOGx/4l9vZxkYG99O7gKhLx0hTgZplHdOZwZmquF990v
X-Received: by 2002:a67:e2d2:: with SMTP id i18mr8789830vsm.16.1555429301712;
 Tue, 16 Apr 2019 08:41:41 -0700 (PDT)
Date:   Tue, 16 Apr 2019 08:41:38 -0700
Message-Id: <20190416154138.124734-1-venture@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.21.0.392.gf8f6787159e-goog
Subject: [PATCH 1/2] dt-bindings: Add ir38064 as a trivial device
From:   Patrick Venture <venture@google.com>
To:     venture@google.com, robh+dt@kernel.org, mark.rutland@arm.com,
        trivial@kernel.org, linux@roeck-us.net
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The ir38064 is a voltage regulator from Infineon.

Signed-off-by: Patrick Venture <venture@google.com>
---
 Documentation/devicetree/bindings/trivial-devices.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/trivial-devices.yaml b/Documentation/devicetree/bindings/trivial-devices.yaml
index d79fb22bde39..92184ef0db2e 100644
--- a/Documentation/devicetree/bindings/trivial-devices.yaml
+++ b/Documentation/devicetree/bindings/trivial-devices.yaml
@@ -92,6 +92,8 @@ properties:
           - fsl,sgtl5000
             # G751: Digital Temperature Sensor and Thermal Watchdog with Two-Wire Interface
           - gmt,g751
+            # Infineon IR38064 Voltage Regulator
+          - infineon,ir38064
             # Infineon SLB9635 (Soft-) I2C TPM (old protocol, max 100khz)
           - infineon,slb9635tt
             # Infineon SLB9645 I2C TPM (new protocol, max 400khz)
-- 
2.21.0.392.gf8f6787159e-goog

