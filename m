Return-Path: <SRS0=N68d=SK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DBADC282CE
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 21:43:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 69DB72148E
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 21:43:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Gz2yzpBF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726964AbfDHVnT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Apr 2019 17:43:19 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:41667 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726697AbfDHVnO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Apr 2019 17:43:14 -0400
Received: by mail-lj1-f194.google.com with SMTP id k8so12614235lja.8;
        Mon, 08 Apr 2019 14:43:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=rbgUHGjL1xlbhm4c7TA1e007Ia4N5yQjhJSCjSQrlG4=;
        b=Gz2yzpBFmZKAVC3+G4MSMz9MbVA6uZZz81GdKDIQjv2OLQa5OJgapvd/gWAoBN/W3N
         d5c/eacu7gHMpO8hDJ/6rSaRjLjvxqqA0XY2DrqFiiBr367oX3sS7y5y0GaSK9xUbnGD
         K0Y/q6X8Bnu67LGPv/vrGWRR8lTdKX/sCtqdWWDGVOSDDkexs3VlWDwVDH8Y/xPoZW8/
         /D6jFuIYw5geVquOTVdQUWouhxHvDCI8X2jL8UXcaPo61hIWAi74fCrdo+G8aRZxPzKv
         lZsl3F+jSolFiWISXm+qBAwtOQ6fXmcV1Q0gOcIFTiW6lizXlKi5JADSSsGTe5uZnCZn
         2l9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=rbgUHGjL1xlbhm4c7TA1e007Ia4N5yQjhJSCjSQrlG4=;
        b=Pzw9vsDbZJrfmQq38ya/ZSgYj1uy8phXcZsj3jBZRM6zcTpBqEa9iUod0orYhcyCci
         HVixrrQuBcqowsob3CrpBkUe+zHdRw2G0mPdqFsuMyi+5ah1vc3MyoghJ/f+c83GYota
         ZVBMKeEJWJV+EIPJqXhVn1WpIiyPFuAtS64zftOy4hlB8xAqCj4RabhWrfockv2bSrVT
         +ZzX3GOQChRm3RpPtHSLq5jxCHzWFccGITdhHtrROqnm8DXOwtirr/DfLHU80oxupS9e
         QXEXfa3O4of9SmG0gyC6qlnehsiH53m9nmJAwkw2Cd1h3U2040O6jAqoEGPn7D+Fd40/
         Cw4A==
X-Gm-Message-State: APjAAAVpgao5xRKbVjrlZdmja+7h2IcLWG7V+XKCEwUPur/jdfC7V5Ur
        1AZpo/Tlyo97Ah9p3zTUVGo=
X-Google-Smtp-Source: APXvYqwaLCRlql5xhgTnrM13tvT/qr8vUX1h+Jj5AJzgIpGqjFfKxlqRPG/MhURFuNZ16uthFe+Vzw==
X-Received: by 2002:a2e:3803:: with SMTP id f3mr18200964lja.165.1554759792252;
        Mon, 08 Apr 2019 14:43:12 -0700 (PDT)
Received: from z50.gdansk-morena.vectranet.pl (109241207190.gdansk.vectranet.pl. [109.241.207.190])
        by smtp.gmail.com with ESMTPSA id j6sm5286048ljc.0.2019.04.08.14.43.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 08 Apr 2019 14:43:11 -0700 (PDT)
From:   Janusz Krzysztofik <jmkrzyszt@gmail.com>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     Sakari Ailus <sakari.ailus@linux.intel.com>,
        Hans Verkuil <hans.verkuil@cisco.com>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org, Janusz Krzysztofik <jmkrzyszt@gmail.com>
Subject: [PATCH 05/14] media: ov6650: Fix unverified arguments accepted by .enum_mbus_code()
Date:   Mon,  8 Apr 2019 23:42:33 +0200
Message-Id: <20190408214242.9603-6-jmkrzyszt@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190408214242.9603-1-jmkrzyszt@gmail.com>
References: <20190408214242.9603-1-jmkrzyszt@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit ebcff5fce6b1 ("[media] v4l2: replace enum_mbus_fmt by
enum_mbus_code") converted a former ov6650_enum_fmt() video operation
callback to an ov6650_enum_mbus_fmt() pad operation callback.  However,
the function dees not verify correctness of code->which flag and pad
config pointer arguments.  Fix it.

Even if the function has no need to dereference the pad config pointer
argument, return -EINVAL if it is NULL on V4L2_SUBDEV_FORMAT_TRY.

Fixes: ebcff5fce6b1 ("[media] v4l2: replace enum_mbus_fmt by enum_mbus_code")
Signed-off-by: Janusz Krzysztofik <jmkrzyszt@gmail.com>
Cc: stable@vger.kernel.org
---
 drivers/media/i2c/ov6650.c | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/drivers/media/i2c/ov6650.c b/drivers/media/i2c/ov6650.c
index 5c1738c5a847..d72fcf56930a 100644
--- a/drivers/media/i2c/ov6650.c
+++ b/drivers/media/i2c/ov6650.c
@@ -737,7 +737,21 @@ static int ov6650_enum_mbus_code(struct v4l2_subdev *sd,
 		struct v4l2_subdev_pad_config *cfg,
 		struct v4l2_subdev_mbus_code_enum *code)
 {
-	if (code->pad || code->index >= ARRAY_SIZE(ov6650_codes))
+	if (code->pad)
+		return -EINVAL;
+
+	switch (code->which) {
+	case V4L2_SUBDEV_FORMAT_ACTIVE:
+		break;
+	case V4L2_SUBDEV_FORMAT_TRY:
+		if (cfg)
+			break;
+		/* fall through */
+	default:
+		return -EINVAL;
+	}
+
+	if (code->index >= ARRAY_SIZE(ov6650_codes))
 		return -EINVAL;
 
 	code->code = ov6650_codes[code->index];
-- 
2.21.0

