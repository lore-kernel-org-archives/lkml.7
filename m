Return-Path: <SRS0=TLrx=2G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFD7AC2D0C3
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 17:47:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B850420717
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 17:47:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="UzAut7oP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726560AbfLPRrq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Dec 2019 12:47:46 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:42586 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726227AbfLPRrq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Dec 2019 12:47:46 -0500
Received: by mail-pg1-f193.google.com with SMTP id s64so4108797pgb.9
        for <linux-kernel@vger.kernel.org>; Mon, 16 Dec 2019 09:47:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=hw5Av0omrpqDMS7vMjj661LVLxdnMyCAfz7uWvwVCL8=;
        b=UzAut7oPZ6MwulRVGd8z4CDfcsQG18oSMOJeImKi0I4vNbCimNPWgWxR6T1cuHUrkn
         QuhGtJyUnUuhh8/vFQAoC0pckg8wppSCIzyHSEO3UDa6otYVEjP5f+FFluCbxdOuQ3/r
         QgQj8JMj+hVg+QKXCgElrEGcaf2ifPzofkon8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=hw5Av0omrpqDMS7vMjj661LVLxdnMyCAfz7uWvwVCL8=;
        b=M9dUyqQtVCW/4b4iT5u3tYdKAufdvjI3jWwPdlf3hUXPWs1QbUU4UVG92lq+rY/m+t
         FTE0a8wNdfHfwZdnmX5NyKafN5qvJI5SKpbf3HRUc4rIHxxlUavwUh+zUIbIbQeZeSDS
         vPRYQnDmKtD+QXyz8vPBnuZb/SKQCyl7xQTl9nWai6u5dPRB5skPJISqd//8r0bNKBgO
         uTvKBryrYgMcqikpuV+SYloSbGGLWU/ZRKACaAfkQOYUc9oWBuHjVl8SQlAaUQUmkygC
         aaqv7C3VeyKHreJWfupeHAhYs2K/41VuJO3KyUoWdbnQdMG6y+Ckwst33abFmzYm/thp
         ZmkQ==
X-Gm-Message-State: APjAAAVfaRfTbsfN5aEwdWi+w9hGfjc4Tq64Ci/YUkg9h3XnlsNjI+Os
        8b8AaJgE1L1idpiedDFjlY3Hbw==
X-Google-Smtp-Source: APXvYqyXoQALeAM+zoIV40agZm7icWv+ejSDOE9brdNu2AiqwbmAeH5gOOEc/CZzDWaZYkhS1xv4Kg==
X-Received: by 2002:a63:5f91:: with SMTP id t139mr19298242pgb.185.1576518465339;
        Mon, 16 Dec 2019 09:47:45 -0800 (PST)
Received: from localhost.localdomain ([2405:201:c809:c7d5:6d28:a89:f9e1:1506])
        by smtp.gmail.com with ESMTPSA id a6sm22342924pgg.25.2019.12.16.09.47.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Dec 2019 09:47:44 -0800 (PST)
From:   Jagan Teki <jagan@amarulasolutions.com>
To:     Heiko Stuebner <heiko@sntech.de>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Akash Gajjar <akash@openedev.com>, Tom Cubie <tom@radxa.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-amarula@amarulasolutions.com,
        Jagan Teki <jagan@amarulasolutions.com>
Subject: [PATCH v3 1/4] dt-bindings: arm: rockchip: Add Rock Pi N10 binding
Date:   Mon, 16 Dec 2019 23:17:08 +0530
Message-Id: <20191216174711.17856-2-jagan@amarulasolutions.com>
X-Mailer: git-send-email 2.18.0.321.gffc6fa0e3
In-Reply-To: <20191216174711.17856-1-jagan@amarulasolutions.com>
References: <20191216174711.17856-1-jagan@amarulasolutions.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rock Pi N10 is a Rockchip RK3399Pro based SBC, which has
- VMARC RK3399Pro SOM (as per SMARC standard) from Vamrs.
- Compatible carrier board from Radxa.

VMARC RK3399Pro SOM need to mount on top of dalang carrier
board for making Rock PI N10 SBC.

Add dt-bindings for it.

Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
---
Changes for v3:
- Move som binding on board side

 Documentation/devicetree/bindings/arm/rockchip.yaml | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/rockchip.yaml b/Documentation/devicetree/bindings/arm/rockchip.yaml
index 45728fd22af8..c3eb32f1a9ee 100644
--- a/Documentation/devicetree/bindings/arm/rockchip.yaml
+++ b/Documentation/devicetree/bindings/arm/rockchip.yaml
@@ -423,6 +423,12 @@ properties:
           - const: radxa,rockpi4
           - const: rockchip,rk3399
 
+      - description: Radxa ROCK Pi N10
+        items:
+          - const: radxa,rockpi-n10
+          - const: vamrs,rk3399pro-vmarc-som
+          - const: rockchip,rk3399pro
+
       - description: Radxa Rock2 Square
         items:
           - const: radxa,rock2-square
-- 
2.18.0.321.gffc6fa0e3

