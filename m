Return-Path: <SRS0=N68d=SK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B9F4C10F14
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 21:44:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 41D962148E
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 21:44:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="setoFDWk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728733AbfDHVo0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Apr 2019 17:44:26 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:40606 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726731AbfDHVnR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Apr 2019 17:43:17 -0400
Received: by mail-lf1-f66.google.com with SMTP id a28so10627473lfo.7;
        Mon, 08 Apr 2019 14:43:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=JZJX0cBW48BfmEFVskcagOwO7Nr6Cx7mLM31SY93LnA=;
        b=setoFDWkhlc33k/Jfb0WClbzs9jH7Er0bGixMeKL6L7VlVvgVqiTOu5Vcn36/VCb1q
         Qwq39P4QV49WN+vDiTsrE/hXr1gSctgQOUeMlvTJ9q19Lgh0eY5niJNBT04EKYKbXE+M
         G79Wnkzzya9nS0X1Px4lHlG7tLIxFOkodHKriIehIlQtMv8+wtIt2PSA5VGpgYgzXZbd
         YjpnfFyT5wAYrkua6kDFPyZiYK2F2EJLw6VJz2AfkwBKZH/Sv+Vrsi1ipglqL7bJe2z7
         NbdTtFpuWrFOiZQTu/TrV3A6HMJOOFsZEpTUTF1jDUjhgBU0h/Vj1Oo2I1ZE0GsxBIil
         WHTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=JZJX0cBW48BfmEFVskcagOwO7Nr6Cx7mLM31SY93LnA=;
        b=l8Ik8wNxGwMgUQvlvYphY5HnXvSa9HLX7GKMxqHuDIsygHXkJOb8qqjGyWCgHHZmGD
         lc+rXBUHno/egCo6GjFt3b4qX5FuSIP5eOOXL9VPgHPoMeoTfRGh3AVM+FE/MkJC7lSr
         jNgNxrJmLG7D/gF8qpkrdFkP00NcCkYlUuIVWGlP0rz7g6LFEsKktGAI4TelKeRjKCN3
         QUZABZuqZAs6/rbkyyxEilmJ2erdZG9UJEoAuJhDw/rlyeCC05IPc6f5lUKpA6rYCZ8E
         Zw5P5s7lnxUMmNTR+OG3t9t8QU3JE8qrE+yoaz+vupea4dT/L52F2k1wihxkGtmM6pD3
         hy2w==
X-Gm-Message-State: APjAAAXZ5qM1/IXeMQR2M0ypwhQ5TEk911GAEaX+OtmmwXoIEuSUM6yu
        4CWZaH4o2yPvRsx58KvPiPgnO9aW4n4=
X-Google-Smtp-Source: APXvYqx4OJ+CQMPT+7DgGtrZQp8tX7Y66jbzrL9XKamSwfI59Ang55K1DZoGGzUlWYmS4Wz8QMIkTQ==
X-Received: by 2002:ac2:4115:: with SMTP id b21mr17756590lfi.54.1554759794879;
        Mon, 08 Apr 2019 14:43:14 -0700 (PDT)
Received: from z50.gdansk-morena.vectranet.pl (109241207190.gdansk.vectranet.pl. [109.241.207.190])
        by smtp.gmail.com with ESMTPSA id j6sm5286048ljc.0.2019.04.08.14.43.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 08 Apr 2019 14:43:14 -0700 (PDT)
From:   Janusz Krzysztofik <jmkrzyszt@gmail.com>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     Sakari Ailus <sakari.ailus@linux.intel.com>,
        Hans Verkuil <hans.verkuil@cisco.com>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org, Janusz Krzysztofik <jmkrzyszt@gmail.com>
Subject: [PATCH 07/14] media: ov6650: Fix unverified pad IDs accepted by .g/s_frame_interval()
Date:   Mon,  8 Apr 2019 23:42:35 +0200
Message-Id: <20190408214242.9603-8-jmkrzyszt@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190408214242.9603-1-jmkrzyszt@gmail.com>
References: <20190408214242.9603-1-jmkrzyszt@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 4471109e3894 ("media: convert g/s_parm to g/s_frame_interval in
subdevs") comverted former ov6650_g/s_parm() video_operation_callbacks
to ov6650_g/s_frame_interval() pad operation callbacks.  Howeveer, the
new functions don't verify correcntess of pad IDs passed in user
arguments.  Fix it.

Even if pad ID arguments are not actually used in those functions,
assumed to be 0, always return -EINVAL if an operation on an invalid
(non-zero) pad is requested by a user.

Fixes: 4471109e3894 ("media: convert g/s_parm to g/s_frame_interval in subdevs")
Signed-off-by: Janusz Krzysztofik <jmkrzyszt@gmail.com>
Cc: stable@vger.kernel.org
---
 drivers/media/i2c/ov6650.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/media/i2c/ov6650.c b/drivers/media/i2c/ov6650.c
index 5df81dec06ae..1daef0c7ad91 100644
--- a/drivers/media/i2c/ov6650.c
+++ b/drivers/media/i2c/ov6650.c
@@ -770,6 +770,9 @@ static int ov6650_g_frame_interval(struct v4l2_subdev *sd,
 	struct i2c_client *client = v4l2_get_subdevdata(sd);
 	struct ov6650 *priv = to_ov6650(client);
 
+	if (ival->pad)
+		return -EINVAL;
+
 	ival->interval.numerator = GET_CLKRC_DIV(to_clkrc(&priv->tpf,
 			priv->pclk_limit, priv->pclk_max));
 	ival->interval.denominator = FRAME_RATE_MAX;
@@ -789,6 +792,9 @@ static int ov6650_s_frame_interval(struct v4l2_subdev *sd,
 	int div, ret;
 	u8 clkrc;
 
+	if (ival->pad)
+		return -EINVAL;
+
 	if (tpf->numerator == 0 || tpf->denominator == 0)
 		div = 1;  /* Reset to full rate */
 	else
-- 
2.21.0

