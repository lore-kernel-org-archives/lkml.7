Return-Path: <SRS0=a4+J=26=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0A0AC33CA2
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 11:26:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A61AC2077B
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 11:26:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YNsXrAnz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730671AbgAIL0Q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jan 2020 06:26:16 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:37487 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730633AbgAIL0D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jan 2020 06:26:03 -0500
Received: by mail-wr1-f67.google.com with SMTP id w15so7021037wru.4;
        Thu, 09 Jan 2020 03:26:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=pUBy/rRtKVsE5ggJf4XPwa/gCGmKhJig0r7Wp+RQ7hM=;
        b=YNsXrAnz80V8d0LjLUQtEPH9d/0ov1m6Hox308GTaEXBLx0DYD5/1pIEVgOee0tR9e
         UtyoyIY64EdXjYA7s7FLt2txNJtzR4q63r0b17R6lYYLiVc0vw04Xna7WFbe74gWX9qP
         M5DS8vuglw5vCNRL7Wfu7ed1JBiD+RoUwHNyxd6qFoTMtPMasJ2WuxxS3k9lNzLhSrxr
         1QX1Uoc9pEwyRkmPjbN8BxTzcG5JGGdx3egB/I2prNbHVhfWUU11JXoCXZoO7xb7egHa
         jXGmp1gzBhwmMwtv+lQT2+y7K6GwRUwRfSdO/jWkhWUcq3qqMx4nuEn84nbEr+YGiSp/
         vWVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=pUBy/rRtKVsE5ggJf4XPwa/gCGmKhJig0r7Wp+RQ7hM=;
        b=DJYR0Ljd7waKZXvKiD/aKgiZ6H2UgL4sUi0seHSfUL1kvP4kOvK+O9vVXwgNqjt33n
         11xiD6JPXZwOkalkEhrtP4Ro67D+tv/UfiHTLpXqXldEn8kLMxg9/8NSeM9P4Pu390Zi
         txg0enj61ehvEnyclRGTDfmKFtCttbOo/tsgGc6ts12sHNqZPPAZ1HPjgKMu2HCsEfhF
         ijuO3//L1bGmwdiJlt3VCn3nwTeP+GonwYztNdJJnkXjuHzDcq0P03MPIYCFY65O8nhY
         tPXFoNaMnHsFe8ZuT7QV7+BeYBmB0qJ2a66BZ+j4FZJUTikO/1f0jYlv65WQKle+i9gL
         1X0w==
X-Gm-Message-State: APjAAAXmBgAUqYlAjaRZfnAH4MFa4SuaO6m9yXfgu0ntu6QBSdwudgbl
        SXpcUIRwD8tbse7i/ewDT08=
X-Google-Smtp-Source: APXvYqzUncSVnLAwI/UsqKvTrjO+sSQX6IZF5K1bTaWn3lGLIy9BUJr9jF7glF/mOKM3gGJMf/jWiA==
X-Received: by 2002:adf:fe43:: with SMTP id m3mr10740686wrs.213.1578569161897;
        Thu, 09 Jan 2020 03:26:01 -0800 (PST)
Received: from localhost.localdomain (p5B3F655B.dip0.t-ipconnect.de. [91.63.101.91])
        by smtp.gmail.com with ESMTPSA id 60sm8298660wrn.86.2020.01.09.03.26.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jan 2020 03:26:00 -0800 (PST)
From:   Saravanan Sekar <sravanhome@gmail.com>
To:     sravanhome@gmail.com, lgirdwood@gmail.com, broonie@kernel.org,
        robh+dt@kernel.org, mark.rutland@arm.com, mripard@kernel.org,
        shawnguo@kernel.org, heiko@sntech.de, sam@ravnborg.org,
        icenowy@aosc.io, laurent.pinchart@ideasonboard.com,
        gregkh@linuxfoundation.org, Jonathan.Cameron@huawei.com,
        davem@davemloft.net, mchehab+samsung@kernel.org
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v6 4/4] MAINTAINERS: Add entry for mpq7920 PMIC driver
Date:   Thu,  9 Jan 2020 12:25:48 +0100
Message-Id: <20200109112548.23914-5-sravanhome@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200109112548.23914-1-sravanhome@gmail.com>
References: <20200109112548.23914-1-sravanhome@gmail.com>
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
index 8982c6e013b3..3eb7447dbff8 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -11143,6 +11143,13 @@ S:	Maintained
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

