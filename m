Return-Path: <SRS0=OzJr=YZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1ED5CA9ECF
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Nov 2019 11:24:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BFB88217F9
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Nov 2019 11:24:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1572607458;
	bh=dX6IpixzVBgSCMKI4SHYthEfbtWdSHK7QsJSPXjpaTM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=v5nbABJl/5J0cKRJf9mhbUgX+frCfsUR7FC5Hu4S04T8BXPC3Gjo9ZEzwQED5ttRz
	 7SNt6h7xxPkVBjzx6tx+q6m1c54XXvRyMQ06qA2I1EbPuKlMTElXdT/TW+Lc5+HVVK
	 zI+uT3Fd3xkvdHDFyOoBSAaqcPIZJ3Dm0VpuQqMo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730443AbfKALYR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Nov 2019 07:24:17 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:39246 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730404AbfKALYK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Nov 2019 07:24:10 -0400
Received: by mail-lf1-f68.google.com with SMTP id 195so6968485lfj.6;
        Fri, 01 Nov 2019 04:24:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=sjj30/458E859XQbnjLj4WwTf4kInVK2hNYmrjy4KYE=;
        b=tuB0+GaFjZfcMtnGWjCSbTydZU/U1TvshrEipNQUfIKJuxTMqWVaFYLyIo+hH9KFEY
         9GCmUSkeCHUzZby+VumQEIoK3mLvLyKdZ6VZ2cY/8k8YkEY1ih1Bk5iSW1kc24ln5AOO
         yNWpul2gVVbzavaRgQmeSNDypglglKiZTL/FAWHp0k/mBbMZfOv2VylHtcKYPX3IspoA
         VvxICGIjlzmbNxsvntJOGjZkjUQ8Sa80K3bq3vog+P4l8TaTOH1hYI34lt6WX+5vEU2D
         bdpRDZH2OYjvxQ3Vr0upCwr85Rcj2mF6ZXOQnZutacR41FTIEwdUSzi5m7LckK9cGIAC
         nb+g==
X-Gm-Message-State: APjAAAWSZe8f3muJTs7rZ6HO40skBTFaLA7K/YASGqnN3SXltZ4oFKD0
        oof12myOO2js9s8sVe1Lfxw1vqLiNmk=
X-Google-Smtp-Source: APXvYqy95GAojfhN2ezdIMYV6qxUyV9oWwH5cwwrCtchwmsFKvYc4W1fxxmM3P5LOKCyOjU6qxUDrg==
X-Received: by 2002:ac2:46d7:: with SMTP id p23mr6959576lfo.104.1572607447848;
        Fri, 01 Nov 2019 04:24:07 -0700 (PDT)
Received: from neopili.qtec.com (cpe.xe-3-0-1-778.vbrnqe10.dk.customer.tdc.net. [80.197.57.18])
        by smtp.gmail.com with ESMTPSA id v1sm2313691lji.89.2019.11.01.04.24.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Nov 2019 04:24:06 -0700 (PDT)
From:   Ricardo Ribalda Delgado <ribalda@kernel.org>
To:     Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Ricardo Ribalda Delgado <ribalda@kernel.org>
Subject: [PATCH v3 5/5] Documentation: v42l_core: v4l2_ext_control
Date:   Fri,  1 Nov 2019 12:23:58 +0100
Message-Id: <20191101112358.29538-5-ribalda@kernel.org>
X-Mailer: git-send-email 2.24.0.rc1
In-Reply-To: <20191101112358.29538-1-ribalda@kernel.org>
References: <20191101112358.29538-1-ribalda@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Describe p_area field from v4l2_ext_ctrl

Signed-off-by: Ricardo Ribalda Delgado <ribalda@kernel.org>
---
 Documentation/media/uapi/v4l/vidioc-g-ext-ctrls.rst | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/media/uapi/v4l/vidioc-g-ext-ctrls.rst b/Documentation/media/uapi/v4l/vidioc-g-ext-ctrls.rst
index 13dc1a986249..271cac18afbb 100644
--- a/Documentation/media/uapi/v4l/vidioc-g-ext-ctrls.rst
+++ b/Documentation/media/uapi/v4l/vidioc-g-ext-ctrls.rst
@@ -198,6 +198,11 @@ still cause this situation.
       - ``p_u32``
       - A pointer to a matrix control of unsigned 32-bit values. Valid if
 	this control is of type ``V4L2_CTRL_TYPE_U32``.
+    * -
+      - :c:type:`v4l2_area` *
+      - ``p_area``
+      - A pointer to a struct :c:type:`v4l2_area`. Valid if this control is
+        of type ``V4L2_CTRL_TYPE_AREA``.
     * -
       - void *
       - ``ptr``
-- 
2.24.0.rc1

