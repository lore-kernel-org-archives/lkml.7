Return-Path: <SRS0=N68d=SK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 758B9C10F13
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 21:43:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 42C4B20833
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 21:43:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iA9bWOQu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728698AbfDHVnw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Apr 2019 17:43:52 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:40612 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727197AbfDHVnX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Apr 2019 17:43:23 -0400
Received: by mail-lf1-f68.google.com with SMTP id a28so10627648lfo.7;
        Mon, 08 Apr 2019 14:43:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=jt3SeGFqkjvpf0KDzystQKves66Jxmw/RGatgrGKn4Y=;
        b=iA9bWOQuNvDMWOdo2jgDFys0mxYtOymkJEjF1UN9A6cO4mGbPzJ+alLYUwmeo99WGG
         kb07/WnBPfSHDR6CepfnVesd45dlxYLqL6g+9THwb01CB50MVo9/pphyy3zjYF6NPoc1
         TAF8KZifqgNavKnrSHHFqn3iRoLqKLv62UkDhtPN+bAzqkUlnxmH2UjkwFPSiQWASaIC
         Q31jLWQwvZ7NjeUD5M/nk2l27/ZoqKK44Hq5cCKOjmYvYGTs29Fl2zH9krKbVE3OLKBo
         /aUL8oKAbvxI6dp41gWG96FetC+jzxTKt9QNCEd2CSdnXyAhDYR756+jGqJzHzecbsTu
         JSGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=jt3SeGFqkjvpf0KDzystQKves66Jxmw/RGatgrGKn4Y=;
        b=MZiJDmBr1UXiB43X34Zc1Ur3gwC0XOScmf6XA2e3nuSrWMRFkTe39kRTa+j4pHI0zL
         dGLjvYu5BfHNIfuOruXm/CnyQ7Mm/P8zm5x+dmljA9SdEHpAuWGbXjd1tqCgpDX/SLOl
         FFobBV1S5l3usGZ1nlld6v0tCEWqbzavfCZjbVoMJ1R0DlxE5T3hSIz3t0qqD3rV8SjT
         rFupqEMpGy+owf1Fy3vFINUmEKDgiCmKXkJHd9GPKyGUg54apWXf4CH9GKN7VpUTqO3h
         SUELx1j0OiLrakEwwsLaApHj/IJk3UHQLHZ7gHjphX+z56dqdDjDg/T9DreEO9vmy2fk
         5ECg==
X-Gm-Message-State: APjAAAWAZsGN6v0ZXjAPSzsBSD4pHwu/cVg8wxjq2BSVv3UU6dqP0gt4
        eWi4poey3DEJAcIMu6rq18I=
X-Google-Smtp-Source: APXvYqwN8ZILNOKD9i12z9cPOVTFvP0prVi+KBGVdRaMyM3gFv+qwUKPrkjio6nY9f8twjnEkMDEUQ==
X-Received: by 2002:ac2:495c:: with SMTP id o28mr17749542lfi.16.1554759801505;
        Mon, 08 Apr 2019 14:43:21 -0700 (PDT)
Received: from z50.gdansk-morena.vectranet.pl (109241207190.gdansk.vectranet.pl. [109.241.207.190])
        by smtp.gmail.com with ESMTPSA id j6sm5286048ljc.0.2019.04.08.14.43.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 08 Apr 2019 14:43:20 -0700 (PDT)
From:   Janusz Krzysztofik <jmkrzyszt@gmail.com>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     Sakari Ailus <sakari.ailus@linux.intel.com>,
        Hans Verkuil <hans.verkuil@cisco.com>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org, Janusz Krzysztofik <jmkrzyszt@gmail.com>
Subject: [PATCH 12/14] media: ov6650: Fix default format not applied on device probe
Date:   Mon,  8 Apr 2019 23:42:40 +0200
Message-Id: <20190408214242.9603-13-jmkrzyszt@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190408214242.9603-1-jmkrzyszt@gmail.com>
References: <20190408214242.9603-1-jmkrzyszt@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It is not clear what pixel format is actually configured in hardware on
reset.  MEDIA_BUS_FMT_YUYV8_2X8, assumed on device probe since the
driver was intiially submitted, is for sure not the one.

Fix it by explicitly applying a known, driver default frame format just
after initial device reset.

Fixes: 2f6e2404799a ("[media] SoC Camera: add driver for OV6650 sensor")
Signed-off-by: Janusz Krzysztofik <jmkrzyszt@gmail.com>
Cc: stable@vger.kernel.org
---
 drivers/media/i2c/ov6650.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/media/i2c/ov6650.c b/drivers/media/i2c/ov6650.c
index e72210653f55..8013afea0c02 100644
--- a/drivers/media/i2c/ov6650.c
+++ b/drivers/media/i2c/ov6650.c
@@ -920,6 +920,11 @@ static int ov6650_video_probe(struct v4l2_subdev *sd)
 	ret = ov6650_reset(client);
 	if (!ret)
 		ret = ov6650_prog_dflt(client);
+	if (!ret) {
+		struct v4l2_mbus_framefmt mf = ov6650_def_fmt;
+
+		ret = ov6650_s_fmt(sd, &mf);
+	}
 	if (!ret)
 		ret = v4l2_ctrl_handler_setup(&priv->hdl);
 
@@ -1074,8 +1079,6 @@ static int ov6650_probe(struct i2c_client *client,
 	priv->rect.top	  = DEF_VSTRT << 1;
 	priv->rect.width  = W_CIF;
 	priv->rect.height = H_CIF;
-	priv->half_scale  = false;
-	priv->code	  = MEDIA_BUS_FMT_YUYV8_2X8;
 
 	priv->subdev.internal_ops = &ov6650_internal_ops;
 	priv->subdev.flags |= V4L2_SUBDEV_FL_HAS_DEVNODE;
-- 
2.21.0

