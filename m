Return-Path: <SRS0=t3dz=T5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FEA2C28CC2
	for <linux-kernel@archiver.kernel.org>; Wed, 29 May 2019 11:33:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 06C6D21721
	for <linux-kernel@archiver.kernel.org>; Wed, 29 May 2019 11:33:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="L+C/lE+F"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726863AbfE2LdB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 May 2019 07:33:01 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:55127 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725894AbfE2LdA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 May 2019 07:33:00 -0400
Received: by mail-wm1-f66.google.com with SMTP id i3so1424341wml.4
        for <linux-kernel@vger.kernel.org>; Wed, 29 May 2019 04:32:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=fghY+BZG9jzLH9CkfdGMJemIUFdCRHcuHHhTEZX8sh0=;
        b=L+C/lE+FoHWyOoKPusjaa84mUfC5vwra665gmIPOHxtpeKaROW6pH6HWhk7bB99zDx
         0pTtMvF4Ey0i4wH88VMwcD5bz3bSDGlMesqI/bW7UJzVjpAFV1XpvVPkW+F5baqsncXe
         A5RkrHuYBJxrWlfomO4FDAIFqItODvK2WIgYe5B0+Fj/y9ITA1Gw5GJxEZ/dQ7YPOzXG
         htCeZbJhccM4fT+tdo6xXN/McOmQVTH8rrOLHGNVYpWiAxKxcxp9leWir5f9rt3M6o8Y
         AeFALuV7F022LnFUNFCIEWx7RgXkGBgVIMg3jXEawHzIhAed8IvmrYGoxD/0Cw+2Eqry
         pPHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=fghY+BZG9jzLH9CkfdGMJemIUFdCRHcuHHhTEZX8sh0=;
        b=SDZHhjDuks8gA3nULN3H9Ia+UWnVXqmWaGc2a5u0akWLuwWzb50cxw072LVreNM97k
         pedCF9UavPi21+a/1m3Jm5bKmhWMrb3/gGNH3VPafdEEwPP3R5VlUfpjbjkF/13Jlefg
         XDJ1BpBXfezSUfJsZPDl1JsAdC/z6+ovOro7a1seI22rLKRkLB6+xogJIyHhLwfmQ/1D
         kC/3yZWpLXc7+CtVXHwtuDzb7U5DfycXwUhs02Y4J4ruhcbtisGD0Db5jpXwQgu4Iohm
         RxAx62Jo26jWStf7psuIskk9hD/liVy28xBkyKjtdNT3whs4L7D2rAcLlWXwbl6bjyXG
         g+xw==
X-Gm-Message-State: APjAAAUh9mAlRhl8rG+/BGtvpWURucfPvA76DvXu9uBpdH1gsCC3hwmS
        vT4JHLA29lsb9T6i0z8hH/Y4/w==
X-Google-Smtp-Source: APXvYqxjNj2+u5xGz/WmE+sFhfaNSVZwlhC/y4svXXUWEjG6Pe2nusU5fvTjI8ygUg0gNdTV1HYmSw==
X-Received: by 2002:a1c:cb49:: with SMTP id b70mr7029966wmg.80.1559129578915;
        Wed, 29 May 2019 04:32:58 -0700 (PDT)
Received: from hackbox2.linaro.org ([81.128.185.34])
        by smtp.gmail.com with ESMTPSA id t6sm12253565wmt.34.2019.05.29.04.32.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 29 May 2019 04:32:58 -0700 (PDT)
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
To:     stable@vger.kernel.org
Cc:     linux-media@vger.kernel.org, hverkuil-cisco@xs4all.nl,
        linux-kernel@vger.kernel.org,
        Hans Verkuil <hans.verkuil@cisco.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Subject: [PATCH] media: v4l2-ioctl: clear fields in s_parm
Date:   Wed, 29 May 2019 12:32:47 +0100
Message-Id: <20190529113247.21188-1-naresh.kamboju@linaro.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Hans Verkuil <hans.verkuil@cisco.com>

commit 8a7c5594c02022ca5fa7fb603e11b3e1feb76ed5 upstream.

Zero the reserved capture/output array.

Zero the extendedmode (it is never used in drivers).

Clear all flags in capture/outputmode except for V4L2_MODE_HIGHQUALITY,
as that is the only valid flag.

Cc: <stable@vger.kernel.org> # v4.9 v4.14
Signed-off-by: Hans Verkuil <hans.verkuil@cisco.com>
Reviewed-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
---
 drivers/media/v4l2-core/v4l2-ioctl.c | 17 ++++++++++++++++-
 1 file changed, 16 insertions(+), 1 deletion(-)

diff --git a/drivers/media/v4l2-core/v4l2-ioctl.c b/drivers/media/v4l2-core/v4l2-ioctl.c
index 4510e8a37244..699e5f8e0a71 100644
--- a/drivers/media/v4l2-core/v4l2-ioctl.c
+++ b/drivers/media/v4l2-core/v4l2-ioctl.c
@@ -1959,7 +1959,22 @@ static int v4l_s_parm(const struct v4l2_ioctl_ops *ops,
 	struct v4l2_streamparm *p = arg;
 	int ret = check_fmt(file, p->type);
 
-	return ret ? ret : ops->vidioc_s_parm(file, fh, p);
+	if (ret)
+		return ret;
+
+	/* Note: extendedmode is never used in drivers */
+	if (V4L2_TYPE_IS_OUTPUT(p->type)) {
+		memset(p->parm.output.reserved, 0,
+		       sizeof(p->parm.output.reserved));
+		p->parm.output.extendedmode = 0;
+		p->parm.output.outputmode &= V4L2_MODE_HIGHQUALITY;
+	} else {
+		memset(p->parm.capture.reserved, 0,
+		       sizeof(p->parm.capture.reserved));
+		p->parm.capture.extendedmode = 0;
+		p->parm.capture.capturemode &= V4L2_MODE_HIGHQUALITY;
+	}
+	return ops->vidioc_s_parm(file, fh, p);
 }
 
 static int v4l_queryctrl(const struct v4l2_ioctl_ops *ops,
-- 
2.17.1

