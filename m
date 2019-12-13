Return-Path: <SRS0=7lyw=2D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E560EC751E7
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Dec 2019 20:39:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 18CD6247D8
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Dec 2019 20:39:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KRu9Zcpt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728472AbfLMQGD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Dec 2019 11:06:03 -0500
Received: from mail-yw1-f68.google.com ([209.85.161.68]:34351 "EHLO
        mail-yw1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728134AbfLMQGA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Dec 2019 11:06:00 -0500
Received: by mail-yw1-f68.google.com with SMTP id b186so57909ywc.1;
        Fri, 13 Dec 2019 08:05:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=hCFeVYA6+RMPn0stbhBhFtInrR3a9YnA+SCG0eFw6ss=;
        b=KRu9ZcptwlfRuMpd1K0x3+VKrHELW1DD0NiRUOldvlD6I/wGFYfW+V4R07cIwqFP9P
         qdLunf2YL5iIbPCzuknZ0mbjT4VI4DDihzrlLcMGEUfaUo8JSocxFLSY3Jtg/M2kVFeO
         a66RfOtlN55JbmgVnTcbijLi9/SIfc0DZ5gNsJELJN0L/OGF/3qk5m3SFGApYeIdo+oO
         MBGbnORIl+1COu3Lzv78zTgFU+BfFygtzOWv+6YW1jciCs/DKHA2oJrp47ghkpiH2LYk
         HDs0uzc2hEVIFHcLqnmvSdmR4+PXMrNqkgfqs74IVYjhhJTskxjim8Jx8R2vtL7RZu5/
         6j2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=hCFeVYA6+RMPn0stbhBhFtInrR3a9YnA+SCG0eFw6ss=;
        b=ry9Of3daqUI260a2DzWQne/7vlXA0Tdfqwy72Ea3d8BQSzZYD0VROlvnCgZksnhfm1
         Za77TGV+F/HqWUqQDIQn9warD7n44Q/oDk2DgBwfTIAdsXg2hwag0gZkPjpq9A6sKhI8
         52uYAXb9Bfu23t0QDeya0UvDwUL90qmoqQythxbC22WHg/h9uuIj73vWacI55duPAtcB
         Mt4Ao8WTNYDdq7gUYeEb/VLWGmsPjVaOC4I/hCtj+R+gQbhE7o+dZOgMaUQzrW+j+yKo
         MWLBUJ2W5mZUXXuSXwHeiiPSxxyUgUO1+SNDUsQqEv7mZjcRLo9BWT3cQEw1ukDR9a+y
         pDvw==
X-Gm-Message-State: APjAAAVBtI85Jf6gGCE9Su8FmWP+C4du5kTaKL7Sa1bc2UeZytN8bfcI
        ZPPxkY0NDVNIwYWM6diFVIE=
X-Google-Smtp-Source: APXvYqz5xPZ+LNDsnzedJYC7m3a0/JGAPYzF/1XJcMZ16q7iiHdzl9cWrivtSTB+eePdtQ+NgJB9eQ==
X-Received: by 2002:a81:145:: with SMTP id 66mr4954091ywb.292.1576253158875;
        Fri, 13 Dec 2019 08:05:58 -0800 (PST)
Received: from localhost.localdomain (c-73-37-219-234.hsd1.mn.comcast.net. [73.37.219.234])
        by smtp.gmail.com with ESMTPSA id v38sm3984694ywh.63.2019.12.13.08.05.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Dec 2019 08:05:58 -0800 (PST)
From:   Adam Ford <aford173@gmail.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     peng.fan@nxp.com, ping.bai@nxp.com, Adam Ford <aford173@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH V2 4/7] dt-bindings: imx-gpcv2: Update bindings to support i.MX8M Mini
Date:   Fri, 13 Dec 2019 10:05:39 -0600
Message-Id: <20191213160542.15757-5-aford173@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191213160542.15757-1-aford173@gmail.com>
References: <20191213160542.15757-1-aford173@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The with the recent additions to the driver, the GPCv2 driver can
support the i.MX8M Mini, but it needs updated 'compatible' entry
to use the proper table.

This patch adds the i.MX8MM to the compatible list of devices.

Signed-off-by: Adam Ford <aford173@gmail.com>
---
V2:  No Change

 Documentation/devicetree/bindings/power/fsl,imx-gpcv2.txt | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/power/fsl,imx-gpcv2.txt b/Documentation/devicetree/bindings/power/fsl,imx-gpcv2.txt
index 7c7e972aaa42..576a79097a4c 100644
--- a/Documentation/devicetree/bindings/power/fsl,imx-gpcv2.txt
+++ b/Documentation/devicetree/bindings/power/fsl,imx-gpcv2.txt
@@ -9,6 +9,7 @@ Required properties:
 - compatible: Should be one of:
 	- "fsl,imx7d-gpc"
 	- "fsl,imx8mq-gpc"
+	- "fsl,imx8mm-gpc"
 
 - reg: should be register base and length as documented in the
   datasheet
@@ -24,8 +25,9 @@ which, in turn, is expected to contain the following:
 Required properties:
 
 - reg: Power domain index. Valid values are defined in
-  include/dt-bindings/power/imx7-power.h for fsl,imx7d-gpc and
-  include/dt-bindings/power/imx8m-power.h for fsl,imx8mq-gpc
+  include/dt-bindings/power/imx7-power.h for fsl,imx7d-gpc,
+  include/dt-bindings/power/imx8m-power.h for fsl,imx8mq-gpc, and
+  include/dt-bindings/power/imx8m-power.h for fsl,imx8mm-gpc
 
 - #power-domain-cells: Should be 0
 
-- 
2.20.1

