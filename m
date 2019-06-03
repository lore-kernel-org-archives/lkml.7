Return-Path: <SRS0=cV2B=UC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66C76C04AB6
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 03:46:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 401C627B1F
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 03:46:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Waeh71G0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727025AbfFCDqa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Jun 2019 23:46:30 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:45785 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726774AbfFCDq2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Jun 2019 23:46:28 -0400
Received: by mail-pf1-f193.google.com with SMTP id s11so9747771pfm.12
        for <linux-kernel@vger.kernel.org>; Sun, 02 Jun 2019 20:46:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=u2+3ufyPAWIhb1gzUN3AC00i4o3W7fSexVAwlsvXQ3Q=;
        b=Waeh71G0Ao1gbz1gGuip9FpIHrx26lgkHbAgkR19pHfCu7TvYgueGuaPVx4Mcdy6Ef
         vQNKz9k9oxD/jly0kskdV8xH2XSdTex2YlfZr4jp7qyThgug7nJcl+DbCT4XvB4BTTVk
         NspEAHxABmDsYqqJgS4E4rwrHOTXf5aOGXzXQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=u2+3ufyPAWIhb1gzUN3AC00i4o3W7fSexVAwlsvXQ3Q=;
        b=p7W0POh7O5UNns4721bBGrE4aUwGUQhZPYSFPZPDBRycClxvMHCOL59YZqXGBwmZ3l
         qASDhQYDUXowzDHJNrImIopAJzhPbuOKJupGAwucFjMnYlKlQLDcTt5LXgTYLihZp+yu
         hehm8pQdA/U3NlCzp6l6mEttZnU6K8o1keBe4KD5S7P7hVHmv+93EHN8ZlCVq4QfZ0lR
         2XoWsmAzlJml0Hh9fk/2WMwzeT+CZNSDBA7m0R2TjrBue6KY8iWeBhcp7tQqNiCN/IHm
         5ASsF9mH70Y40LvN4XF1j3vV3r9oVGfdGft737odLa5QfWcuhFL8rk2Gt+iGkIR0koQj
         jG7g==
X-Gm-Message-State: APjAAAWeILxiJFigxVSFMxjtzH+H7RBc9SAPVoOa0BT0tB88KrhDkJb0
        Fo03BIIGNfGlU96qDu5gHC2WyQ==
X-Google-Smtp-Source: APXvYqxA86g7RB5zmpCBeLVzvhTmzexBqmGiaS3L94z+SeYH3BCOZ2TPh9/hptbmEkwx7N5xz9seOw==
X-Received: by 2002:a62:1692:: with SMTP id 140mr27847686pfw.166.1559533587828;
        Sun, 02 Jun 2019 20:46:27 -0700 (PDT)
Received: from pihsun-z840.tpe.corp.google.com ([2401:fa00:1:10:7889:7a43:f899:134c])
        by smtp.googlemail.com with ESMTPSA id i73sm11878960pje.9.2019.06.02.20.46.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 02 Jun 2019 20:46:27 -0700 (PDT)
From:   Pi-Hsun Shih <pihsun@chromium.org>
Cc:     Pi-Hsun Shih <pihsun@chromium.org>, Rob Herring <robh@kernel.org>,
        Lee Jones <lee.jones@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Benson Leung <bleung@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Guenter Roeck <groeck@chromium.org>,
        devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED
        DEVICE TREE BINDINGS), linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v10 5/7] dt-bindings: Add binding for cros-ec-rpmsg.
Date:   Mon,  3 Jun 2019 11:45:10 +0800
Message-Id: <20190603034529.154969-6-pihsun@chromium.org>
X-Mailer: git-send-email 2.22.0.rc1.257.g3120a18244-goog
In-Reply-To: <20190603034529.154969-1-pihsun@chromium.org>
References: <20190603034529.154969-1-pihsun@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a DT binding documentation for ChromeOS EC driver over rpmsg.

Signed-off-by: Pi-Hsun Shih <pihsun@chromium.org>
Acked-by: Rob Herring <robh@kernel.org>
---
Changes from v9, v8, v7, v6:
 - No change.

Changes from v5:
 - New patch.
---
 Documentation/devicetree/bindings/mfd/cros-ec.txt | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/mfd/cros-ec.txt b/Documentation/devicetree/bindings/mfd/cros-ec.txt
index 6245c9b1a68b..4860eabd0f72 100644
--- a/Documentation/devicetree/bindings/mfd/cros-ec.txt
+++ b/Documentation/devicetree/bindings/mfd/cros-ec.txt
@@ -3,7 +3,7 @@ ChromeOS Embedded Controller
 Google's ChromeOS EC is a Cortex-M device which talks to the AP and
 implements various function such as keyboard and battery charging.
 
-The EC can be connect through various means (I2C, SPI, LPC) and the
+The EC can be connect through various means (I2C, SPI, LPC, RPMSG) and the
 compatible string used depends on the interface. Each connection method has
 its own driver which connects to the top level interface-agnostic EC driver.
 Other Linux driver (such as cros-ec-keyb for the matrix keyboard) connect to
@@ -17,6 +17,9 @@ Required properties (SPI):
 - compatible: "google,cros-ec-spi"
 - reg: SPI chip select
 
+Required properties (RPMSG):
+- compatible: "google,cros-ec-rpmsg"
+
 Optional properties (SPI):
 - google,cros-ec-spi-pre-delay: Some implementations of the EC need a little
   time to wake up from sleep before they can receive SPI transfers at a high
-- 
2.22.0.rc1.257.g3120a18244-goog

