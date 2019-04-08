Return-Path: <SRS0=N68d=SK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8874FC10F13
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 21:44:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4F85B2084F
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 21:44:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jwI1amul"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726892AbfDHVnS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Apr 2019 17:43:18 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:39047 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726564AbfDHVnN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Apr 2019 17:43:13 -0400
Received: by mail-lj1-f194.google.com with SMTP id l7so12625838ljg.6;
        Mon, 08 Apr 2019 14:43:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=xnC2Q7NaDaS6u2MiZtA1HALfljD2ysiOfTyMydRHW5s=;
        b=jwI1amulwo1LNJ7let0l3PYX2sHWrU0Wk/Aa+C+fZ9at8nr+emkX5+/J+ENdx4uMnW
         XDzn106OibE71EMGOgwlbOdgM4hz9PnzZUwEJz8IP1VDIHhWIXvuKVrwR7zOyp7nhq9t
         ilbOIVFzMf7/jYUfSb5kCd7DxGZ+qN+hSBJYjIRHKYaloZobk/Yo9TD9HG7uImliYS9K
         NJ+HbW7O8aahkrFBRDm1uYAlfdS1NWECBkJPV9nWUog+J069Z+AcsqOBuvfvNxYQizO+
         bLD0fgKWnDbQTQN5aWpinFKKZCl2Ak8dEf49cI4p7D0tgxUTbxwEMJAqU+IKIh3EvnXp
         Cvog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=xnC2Q7NaDaS6u2MiZtA1HALfljD2ysiOfTyMydRHW5s=;
        b=H4+1H8WvPiyvIIhz6G604hJCJMgRrYUQrphcYZApOv5HlSwQX9Ul8i+4vAveSDdCYf
         O8C1X8rNxZjHlKuKCHtV6VWBFol4TPeEa4G3TKLDFdm2mdLq0gls+rjWXWIhCmRDtIkI
         8i2Km0AhB91SKBcMVZ9KR5TD6BsNOD/EfRDwItVKk9TocBp+Q3u2R3LaPp4Zab2fCF82
         xg0L2KXddqXbzVirpWSUI/0G/eHKDUVQAahnLhUN7P+JYXWRN+h1S3eK/naOp1Xmj29j
         8JEBAtCR4VpnUgOxmT2qLO7Xf4L6qerIEJ/kMYI3iv1mGnaYD076+kAEUWgQkb86YdYB
         iaMA==
X-Gm-Message-State: APjAAAVlbGZuQOvfGt2Ob4dji6RxBdJ8DDFYMlQS/GQ1ihDvXwvOELtT
        0NTgrWNYNoKlP118NmFQwPo=
X-Google-Smtp-Source: APXvYqxauJIfcTHs7hvjNNsT7DBEM4bIBQ3n+vkcEWHA4MvX9iX4iOn5984BYUfeQv30NsrUVEPm+Q==
X-Received: by 2002:a2e:7c02:: with SMTP id x2mr14248044ljc.176.1554759790982;
        Mon, 08 Apr 2019 14:43:10 -0700 (PDT)
Received: from z50.gdansk-morena.vectranet.pl (109241207190.gdansk.vectranet.pl. [109.241.207.190])
        by smtp.gmail.com with ESMTPSA id j6sm5286048ljc.0.2019.04.08.14.43.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 08 Apr 2019 14:43:10 -0700 (PDT)
From:   Janusz Krzysztofik <jmkrzyszt@gmail.com>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     Sakari Ailus <sakari.ailus@linux.intel.com>,
        Hans Verkuil <hans.verkuil@cisco.com>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org, Janusz Krzysztofik <jmkrzyszt@gmail.com>
Subject: [PATCH 04/14] media: ov6650: Fix unverified arguments accepted by .get_fmt()
Date:   Mon,  8 Apr 2019 23:42:32 +0200
Message-Id: <20190408214242.9603-5-jmkrzyszt@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190408214242.9603-1-jmkrzyszt@gmail.com>
References: <20190408214242.9603-1-jmkrzyszt@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit da298c6d98d5 ("[media] v4l2: replace video op g_mbus_fmt by pad
op get_fmt") converted a former ov6650_g_fmt() video operation callback
to an ov6650_get_fmt() pad operation callback.  However, the function
does not verify correctness of user provided format->which flag and pad
config pointer arguments.  Fix it.

Even if the function never dereferences the pad config pointer argument,
return -EINVAL if it is NULL on V4L2_SUBDEV_FORMAT_TRY.

Fixes: da298c6d98d5 ("[media] v4l2: replace video op g_mbus_fmt by pad op get_fmt")
Signed-off-by: Janusz Krzysztofik <jmkrzyszt@gmail.com>
Cc: stable@vger.kernel.org
---
 drivers/media/i2c/ov6650.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/media/i2c/ov6650.c b/drivers/media/i2c/ov6650.c
index 3062c9a6c57b..5c1738c5a847 100644
--- a/drivers/media/i2c/ov6650.c
+++ b/drivers/media/i2c/ov6650.c
@@ -515,6 +515,17 @@ static int ov6650_get_fmt(struct v4l2_subdev *sd,
 	if (format->pad)
 		return -EINVAL;
 
+	switch (format->which) {
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
 	mf->width	= priv->rect.width >> priv->half_scale;
 	mf->height	= priv->rect.height >> priv->half_scale;
 	mf->code	= priv->code;
-- 
2.21.0

