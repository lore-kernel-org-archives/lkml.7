Return-Path: <SRS0=7h0X=2M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0255FC2D0C8
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Dec 2019 20:45:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C7E47206CB
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Dec 2019 20:45:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rz9bV/wX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726861AbfLVUp1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 22 Dec 2019 15:45:27 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:39621 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726783AbfLVUpZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Dec 2019 15:45:25 -0500
Received: by mail-wr1-f66.google.com with SMTP id y11so14613257wrt.6;
        Sun, 22 Dec 2019 12:45:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ZYQSBkLnONYX/PnkBykc7VPkafXkRFxOt23+Xt4Hyj4=;
        b=rz9bV/wXLTg8FsHmJJf7rtxSZ8PjoML4HZTwLi0OVUllyK97OsVcH+tlHOEyKxWWAE
         FW7SU0ANt8SeyM8ku/QdB9LXyiN+GmggPaEEFq/iFDa7pgGxtRZznrMI3LBbuqE/UYYY
         hQKVMH5vVkFlkQ93yUb8SOqZBHA2A3ZALHs+NwYpUPMtHRi76ZQOOearViMWddXWp4Wd
         NnzGpvmcRGWjvGk0zMqqoTHXfcjfihpO0TzIHs/TpNGvU1+k9tZB+ear4uhqD9haiT16
         NVXKagUZmpwtczKt3hcek3MA14CU0PpOWX6RaMWCapRXtAjQH2rMsoeLPzkJyU8vrbVX
         RWzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ZYQSBkLnONYX/PnkBykc7VPkafXkRFxOt23+Xt4Hyj4=;
        b=O5vKIDKe1H/J9inOacxRuttSVp10i0PBsbDbG+NNKid6N6ziao6AFdhf6pd+C8lQTq
         XcJA4E/LVufsjM1bslInwmDxDvlWOr3TO785Uok/N2yzUtdzMKdgdBj98/b2chKPvLWx
         GtT7nkRMMTerbDKcDUoa7WVSvISPTeIgOZHMO3+rPjAK2HbztnKzu7n31zV+fm+7TXEo
         VDRMYCE+OZlQ7/gXeLmleycX5loUHMdnkPN6rVdI8ecahBsFwbjUALcFzH2mG0p9V6QD
         GS1yKHWN3ejsP41aKWJq0xrA2HlGyxKaJ2b+PxBniVnknjIEu2SgWREn9XJ0xgE6vaZp
         z8lw==
X-Gm-Message-State: APjAAAXD6via0MHy/8Z0C16+rngYJUwse6tvOFB3yfOinpZC949bJtfi
        WpEpJQxH4WiAa1j4s8gUmhQ=
X-Google-Smtp-Source: APXvYqwMuExLfp6yHG61F+5pal/ooHNqmHf2+2NUXbuhaNdzWXDQHkY5cMvBQDPIy4c4VVL//vM0jg==
X-Received: by 2002:a5d:4ed0:: with SMTP id s16mr25774842wrv.144.1577047523680;
        Sun, 22 Dec 2019 12:45:23 -0800 (PST)
Received: from localhost.localdomain (p5B3F6AB6.dip0.t-ipconnect.de. [91.63.106.182])
        by smtp.gmail.com with ESMTPSA id o4sm17603792wrx.25.2019.12.22.12.45.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Dec 2019 12:45:23 -0800 (PST)
From:   Saravanan Sekar <sravanhome@gmail.com>
To:     sravanhome@gmail.com, lgirdwood@gmail.com, broonie@kernel.org,
        robh+dt@kernel.org, mark.rutland@arm.com, mripard@kernel.org,
        shawnguo@kernel.org, heiko@sntech.de, sam@ravnborg.org,
        icenowy@aosc.io, laurent.pinchart@ideasonboard.com,
        gregkh@linuxfoundation.org, Jonathan.Cameron@huawei.com,
        davem@davemloft.net, mchehab+samsung@kernel.org
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 4/4] MAINTAINERS: Add entry for mpq7920 PMIC driver
Date:   Sun, 22 Dec 2019 21:45:07 +0100
Message-Id: <20191222204507.32413-5-sravanhome@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191222204507.32413-1-sravanhome@gmail.com>
References: <20191222204507.32413-1-sravanhome@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add MAINTAINERS entry for Monolithic Power Systems mpq7920 PMIC driver.

Signed-off-by: Saravanan Sekar <sravanhome@gmail.com>
---
 MAINTAINERS | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 0fd82e674cf4..8a31285b59c6 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -11128,6 +11128,13 @@ S:	Maintained
 F:	Documentation/driver-api/serial/moxa-smartio.rst
 F:	drivers/tty/mxser.*
 
+MONOLITHIC POWER SYSTEM PMIC DRIVER
+M:	Saravanan Sekar <sravanhome@gmail.com>
+S:	Maintained
+F:	Documentation/devicetree/bindings/regulator/mpq7920.yaml
+F:	drivers/regulator/mpq7920.c
+F:	drivers/regulator/mpq7920.h
+
 MR800 AVERMEDIA USB FM RADIO DRIVER
 M:	Alexey Klimov <klimov.linux@gmail.com>
 L:	linux-media@vger.kernel.org
-- 
2.17.1

