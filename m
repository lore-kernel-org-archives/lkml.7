Return-Path: <SRS0=5wok=UM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-21.3 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E4F4C31E45
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 18:50:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E808F2147A
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 18:50:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ZNmrxIDG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729087AbfFMSuF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Jun 2019 14:50:05 -0400
Received: from mail-qt1-f201.google.com ([209.85.160.201]:47870 "EHLO
        mail-qt1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727922AbfFMSuF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jun 2019 14:50:05 -0400
Received: by mail-qt1-f201.google.com with SMTP id s9so18239312qtn.14
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jun 2019 11:50:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=iJr+4ggl20eIHBVlJYsDbfpCyG/SofOdghTKFndlSZ8=;
        b=ZNmrxIDGISYo8WckRqA+U9BeAMfdaZgYUeKcQK7fqG1we20mp4O5NLtseFdKS5ovVQ
         mVvM7smCjfbZn21w0Dc+HJALtNy4FX71JUunI1r7qtidj3JlFGmMM4kN6LUGbQQfwqGu
         l0BiTL2Tj/qD0qEMEIEdt8W1xjodgCc8PIPMCUDv1d5cG04G4lfrRFsp7Z2FtAjAwo4G
         UYhbibGtJHebHm8ekp4H8FTx5qtAWgrXJlBzD88dHmBzkCB0eGIozvLcbvXPa6foCDaR
         623GQqP2YExDAwSdh3ZxV6LtEhqOQMqin5MIjLf4Ryrx2qywPAItgttFSnoHpbWJQ5jT
         5O2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=iJr+4ggl20eIHBVlJYsDbfpCyG/SofOdghTKFndlSZ8=;
        b=D35aV75Zu5tdiRDl6PbO9ftp0AJPVd6gNCDmR1GDEjK5IT4zV8M84dZP7iGTIaNxOF
         t4qEaTfzgAwPTzvy6+MzTPvpzLfIj+IxgXl2SK2inrDIbbh5TCy3pmBZNjPiEyA4g3eR
         GOTU2OFQaH6sI/AU6CZNjkU3btPNJnbntb0Sr9nmDB1eBsFQGWgAPUAGu8E/Q9JKTzPE
         hji+Fu46J19fcj2UbczbACJoqW2mi0bya+pubEbJrt2/TOHkj5pOMS2w0EQk5Xgh5C2S
         XSed1upK47HdHGc1S3Au+6kX6SRD0AT9QRYPYxfs9pO0eOLouOzLQTZX5e+5+dfuC7dX
         5now==
X-Gm-Message-State: APjAAAWOttzvHarawu8Lq1vwhw/0Ua0mchEGYm7XVl9jjTvCf7AUM2qG
        rrT0vXwQMngeW4EoUKU6C7YaMYuoYg==
X-Google-Smtp-Source: APXvYqwhjG00MYYwYwHHJbawQhq3fK3to0Ed8wqqChYuKXI3+Et4oxHXvuWz9NCupF34Rw4x45Pi6oYfAQ==
X-Received: by 2002:ac8:2bd4:: with SMTP id n20mr67510092qtn.131.1560451804213;
 Thu, 13 Jun 2019 11:50:04 -0700 (PDT)
Date:   Thu, 13 Jun 2019 11:49:23 -0700
Message-Id: <20190613184923.245935-1-nhuck@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.22.0.rc2.383.gf4fbbf30c2-goog
Subject: [PATCH] thermal: armada: Fix -Wshift-negative-value
From:   Nathan Huckleberry <nhuck@google.com>
To:     miquel.raynal@bootlin.com, rui.zhang@intel.com,
        edubezval@gmail.com, daniel.lezcano@linaro.org
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Nathan Huckleberry <nhuck@google.com>,
        clang-built-linux@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Clang produces the following warning

drivers/thermal/armada_thermal.c:270:33: warning: shifting a negative
signed value is undefined [-Wshift-negative-value]
1 warning        reg &= ~CONTROL1_TSEN_AVG_MASK <<
CONTROL1_TSEN_AVG_SHIFT; generated
.
               ~~~~~~~~~~~~~~~~~~~~~~~ ^

CONTROL1_TSEN_AVG_SHIFT is defined to be zero.
Since shifting by zero does nothing this variable can be removed.

Cc: clang-built-linux@googlegroups.com
Link: https://github.com/ClangBuiltLinux/linux/issues/532
Signed-off-by: Nathan Huckleberry <nhuck@google.com>
---
 drivers/thermal/armada_thermal.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/thermal/armada_thermal.c b/drivers/thermal/armada_thermal.c
index 8c07a393dc2e..709a22f455e9 100644
--- a/drivers/thermal/armada_thermal.c
+++ b/drivers/thermal/armada_thermal.c
@@ -53,7 +53,6 @@
 #define CONTROL0_TSEN_MODE_EXTERNAL	0x2
 #define CONTROL0_TSEN_MODE_MASK		0x3
 
-#define CONTROL1_TSEN_AVG_SHIFT		0
 #define CONTROL1_TSEN_AVG_MASK		0x7
 #define CONTROL1_EXT_TSEN_SW_RESET	BIT(7)
 #define CONTROL1_EXT_TSEN_HW_RESETn	BIT(8)
@@ -267,8 +266,8 @@ static void armada_cp110_init(struct platform_device *pdev,
 
 	/* Average the output value over 2^1 = 2 samples */
 	regmap_read(priv->syscon, data->syscon_control1_off, &reg);
-	reg &= ~CONTROL1_TSEN_AVG_MASK << CONTROL1_TSEN_AVG_SHIFT;
-	reg |= 1 << CONTROL1_TSEN_AVG_SHIFT;
+	reg &= ~CONTROL1_TSEN_AVG_MASK;
+	reg |= 1;
 	regmap_write(priv->syscon, data->syscon_control1_off, reg);
 }
 
-- 
2.22.0.rc2.383.gf4fbbf30c2-goog

