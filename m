Return-Path: <SRS0=nnGO=2J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C44D8C2D0C1
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Dec 2019 10:37:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 92FB621D7D
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Dec 2019 10:37:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VLU136fI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727020AbfLSKhu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Dec 2019 05:37:50 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:37947 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726752AbfLSKhh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Dec 2019 05:37:37 -0500
Received: by mail-wm1-f67.google.com with SMTP id u2so5066701wmc.3;
        Thu, 19 Dec 2019 02:37:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ZYQSBkLnONYX/PnkBykc7VPkafXkRFxOt23+Xt4Hyj4=;
        b=VLU136fIRhESLlmFupey/sOBNdND3IphP7G4RS2aD5W99DW1K9xk08F8ijrBhVmEEV
         fhCrhlJ/lmuKTAdbbh0yyam7nxUljnzgdR2vpB4DZp8RIvZveyDVdZuQbzx6MsaDiQT8
         IlFCJixXEySbDSfF8TBsO+nSYoK8qjok47B7NqXPwymjfp3moisC0nTXn5uoGTrFlk5t
         AXlTOPrdtgB9CA3JnP5OcmBADwBr4Yj6BEXdFKKR4tjAkDw3XJClggezcuINKQiG0Trn
         94rViwrz41fJzPVOriYRHXA0KSxptr8svwKTAcMx6zXFcW/FgTsSKrGSf5brglFCXT4D
         Fe5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ZYQSBkLnONYX/PnkBykc7VPkafXkRFxOt23+Xt4Hyj4=;
        b=GEwUZYC9fmyaGniP9yD5d5YaHYO0TTnvKbB5G5BQ3wKTAwvN215VQ7v0UxPAOBwUmR
         dR1m4KckmZQkBqfL9MR2SKxaGwKneh4HWAh/UngaMFWcB90Mb00g1doJ0ZJKXTMYw0K8
         8VXa31aBqVAGa62uMYMF0hej4vCoXsZbAWJV3kqPyEDh+ZOwCNac7Tk2Mdu/FzP5GzvT
         43wo7LW9RbV8o41+7wlaHJDIIN4cwelI3qRBTqai1mFIDLxc57Wquj1pVRCwc2kcKRBJ
         a2SaI11FChKKHt9vM5Kqqc6bgBe7PTFhW1BzXfQ0+CCtFh0okZOKqdk0lh35u4T5ZThh
         2RoQ==
X-Gm-Message-State: APjAAAWQJnHR6o3H5kJwwQwju5TROCxkiNJiy0rcDi2KfeayZN3DjmV1
        Apx+CDlQiqV57H/ALAWkEgE=
X-Google-Smtp-Source: APXvYqyu4CHHESJHwWO4mQD0gvyVXS4oLZQKp6t1SFS0IkfogPWz2i84Y2s+k8MRk78EjXoRa9jTQg==
X-Received: by 2002:a1c:4c10:: with SMTP id z16mr9657235wmf.136.1576751855275;
        Thu, 19 Dec 2019 02:37:35 -0800 (PST)
Received: from localhost.localdomain (p5B3F677C.dip0.t-ipconnect.de. [91.63.103.124])
        by smtp.gmail.com with ESMTPSA id c68sm5735147wme.13.2019.12.19.02.37.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Dec 2019 02:37:34 -0800 (PST)
From:   Saravanan Sekar <sravanhome@gmail.com>
To:     sravanhome@gmail.com, lgirdwood@gmail.com, broonie@kernel.org,
        robh+dt@kernel.org, mark.rutland@arm.com, mripard@kernel.org,
        heiko@sntech.de, shawnguo@kernel.org,
        laurent.pinchart@ideasonboard.com, icenowy@aosc.io,
        mchehab+samsung@kernel.org, davem@davemloft.net,
        gregkh@linuxfoundation.org, Jonathan.Cameron@huawei.com
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: [PATCH 4/4] MAINTAINERS: Add entry for mpq7920 PMIC driver
Date:   Thu, 19 Dec 2019 11:37:21 +0100
Message-Id: <20191219103721.10935-5-sravanhome@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191219103721.10935-1-sravanhome@gmail.com>
References: <20191219103721.10935-1-sravanhome@gmail.com>
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

