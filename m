Return-Path: <SRS0=EIds=SH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91E2CC4360F
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 09:35:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5F040217D4
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 09:35:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="LEhEgFjx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730624AbfDEJe7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Apr 2019 05:34:59 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:40091 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730473AbfDEJe5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Apr 2019 05:34:57 -0400
Received: by mail-wm1-f68.google.com with SMTP id z24so6451679wmi.5
        for <linux-kernel@vger.kernel.org>; Fri, 05 Apr 2019 02:34:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ot7R4QQLGeHfNAz7vr6go3wsbBhXv9hbHqFpcoxW/Ms=;
        b=LEhEgFjxLvkvCxZxAsqX/2NFdHWcYbLvP02jo9H5B3/9YjwY1M2wCndnyPJpiM++Jz
         mD9+zohLsps1hefZ3F4//5nMgE24Z6TZfUSx4uAdtEOdALqOI80NxkzNc1qaS06VXMkv
         TLXVAKZD5n2fRTgTNAt/jtF/i0hGityNkTp06T4Vbywhu3R3QD8nXco/Pem+ip4qd6nA
         wY64LdNAWMeRihrRMbNs3SKjrp7k6g/UjmlKR73PTUPHXErGfKgB7buJrGn799mTiRjn
         ReTIGAenvni3Mi83jUMy64hGh98HZF1YzM+XNrRkMgADCVtlq3TOe03v4DowDCmOd709
         gAoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ot7R4QQLGeHfNAz7vr6go3wsbBhXv9hbHqFpcoxW/Ms=;
        b=L2N2ebXfT+9qxO8ZCSvHf82u4fo0OXDONCmETiR41z6kqSxOsTTkIXWmNjw6zCNOEG
         8tjNHaeQdS7KtIyquLkG1FAPjWmmvSN1Wrhgf0werCljGlCIfl0kMxeZwCUuPdALr6Y0
         3e2C9l9d0WDstgEyTrBV9sgJNd5Is4eiIfZGgj2jwNsNxEouJbJrWoD97uueuJ6Kr8+m
         WrolR45tlBeU/aHm+h4ProWVQV6ux4M8hSh4e0LWhyfE4bCXp5TnvsJ3fgmb7oDOVuEM
         l4QLU52KWmDdolbx8ufKxoJDWxSZKiAY49jBAljuD1/D/3CaE+u61k3Y/yBytvPhqy7A
         9o0g==
X-Gm-Message-State: APjAAAVLHOH2e5YT+/Z0E86ce6RIsrP4yiBszuGPIkP6+EHE4FmhyzLq
        ON5GCmW399uJoVU2CXMMEcxK8w==
X-Google-Smtp-Source: APXvYqxIOKP+poQeBr8GFahvuylKI6yxFSov0b9kxyWDoUR6zt0mzQwGW7iyCRMlMPJarQWE11x21Q==
X-Received: by 2002:a7b:c408:: with SMTP id k8mr7378186wmi.69.1554456895339;
        Fri, 05 Apr 2019 02:34:55 -0700 (PDT)
Received: from localhost.localdomain ([51.15.160.169])
        by smtp.googlemail.com with ESMTPSA id t15sm1954128wmt.2.2019.04.05.02.34.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 05 Apr 2019 02:34:54 -0700 (PDT)
From:   Alexandre Mergnat <amergnat@baylibre.com>
To:     robh+dt@kernel.org, mark.rutland@arm.com, jic23@kernel.org,
        knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net
Cc:     linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        baylibre-upstreaming@groups.io,
        Alexandre Mergnat <amergnat@baylibre.com>
Subject: [PATCH 2/3] dt-bindings: iio: ot: Add docs pat9125
Date:   Fri,  5 Apr 2019 09:34:29 +0000
Message-Id: <1554456870-8104-3-git-send-email-amergnat@baylibre.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1554456870-8104-1-git-send-email-amergnat@baylibre.com>
References: <1554456870-8104-1-git-send-email-amergnat@baylibre.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add documentation for the optical tracker PAT9125 and
"ot" directory for Optical Tracker chip.

Signed-off-by: Alexandre Mergnat <amergnat@baylibre.com>
---
 Documentation/devicetree/bindings/iio/ot/pat9125.txt | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/ot/pat9125.txt

diff --git a/Documentation/devicetree/bindings/iio/ot/pat9125.txt b/Documentation/devicetree/bindings/iio/ot/pat9125.txt
new file mode 100644
index 0000000..2ffacaa
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/ot/pat9125.txt
@@ -0,0 +1,18 @@
+PixArt Imaging PAT9125 Optical Tracking Miniature Chip device driver
+
+Required properties:
+	- compatible: must be "pixart,pat9125"
+	- reg: i2c address where to find the device
+	- interrupts : the sole interrupt generated by the device
+
+	Refer to interrupt-controller/interrupts.txt for generic
+	interrupt client node bindings.
+
+Example:
+
+pat9125@75 {
+	compatible = "pixart,pat9125";
+	reg = <0x75>;
+	interrupt-parent = <&gpio3>;
+	interrupts = <12 IRQ_TYPE_EDGE_FALLING>;
+};
-- 
2.7.4

