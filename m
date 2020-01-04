Return-Path: <SRS0=lTpO=2Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFBF1C2D0C2
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Jan 2020 11:29:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 823D9217F4
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Jan 2020 11:29:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TAjb8QWY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725928AbgADL3D (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 4 Jan 2020 06:29:03 -0500
Received: from mail-pj1-f65.google.com ([209.85.216.65]:37898 "EHLO
        mail-pj1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725796AbgADL3D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Jan 2020 06:29:03 -0500
Received: by mail-pj1-f65.google.com with SMTP id l35so5773853pje.3;
        Sat, 04 Jan 2020 03:29:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=Mskwu76XZBCR2SUd26CGzl4VKCD+hVwmie270qLUwio=;
        b=TAjb8QWYZANgWxy0IQRbbSlL6exyJvLS2dIr38NJFrtXZFbDhZrI76wHlD+bE3Gskr
         CshtA3jjzlnBrIRVrgu8+fOSFgvlM6IueHDrPJjVmdk1njIvn2D9KnlIboGFXpP9hL8C
         bMSXcNkXwWluQH6CzRvoEpvY9jkPsP38Rj0TRsnLNyO9C1rQRkOOfiAF6lkKEtqvbEa4
         Kd/85jS6jzVDc6d4pBuYouv+eUZlM+Iyn+OxOhiJIVTqC7eRdGV1etwX7nufra3heY7v
         /swbosj2h2TyYKhKpmpyV8MV3QBZFouJiKg8zBHC48sBcOfUlMLsSmAFcTvjfevon7ys
         h3cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=Mskwu76XZBCR2SUd26CGzl4VKCD+hVwmie270qLUwio=;
        b=i8WHuC9T1roxzLSkgbR3dM6YGVZPksypUqf/OFy5jOaZFTHIZIXA4NTKjZoGpF0Z5r
         fC2ZVRbS4fX22BEhYgjg45xKnp/EV9Ax/9uZJAzpGMLGnORw/zKi0iP5cILBEnyGIJHH
         BzfltMMf9GJnopwFZMKZjN5rNNEtVZmZlETdZ/uML/OPqQjN21XdYhsc8IdBhZUSo0le
         Gb3++4B5RQoTpzhiwB+PWmNKIHpfKAaGM39tpm7FLdAAUFa0kJVjwxBj1rAv5Xwj4L9W
         o8wKg9t0hhC2mlL2KrHJHLl9Ta10pMMPknbqjLPuOS78J7EeDjSqSmkkvG59OlhPIJoE
         ZoJg==
X-Gm-Message-State: APjAAAXP/lHg4hXqWCN5ukFxdPyzuTHRC21qKOPQz3Fim/GPkoQvrYxL
        5NGoRzQsEj/pgYb9dPA+iC4=
X-Google-Smtp-Source: APXvYqxEsNrBgTOz4tIRH8CLk+sSb/NsVioWA//S3vLGVuY6yTVTKnnqUkdqKyIKYkumz1sYXJEMUw==
X-Received: by 2002:a17:902:59d8:: with SMTP id d24mr91839751plj.318.1578137342405;
        Sat, 04 Jan 2020 03:29:02 -0800 (PST)
Received: from localhost (199.168.140.36.16clouds.com. [199.168.140.36])
        by smtp.gmail.com with ESMTPSA id x4sm71013838pff.143.2020.01.04.03.29.01
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 04 Jan 2020 03:29:01 -0800 (PST)
From:   Dejin Zheng <zhengdejin5@gmail.com>
To:     balbi@kernel.org, gregkh@linuxfoundation.org,
        stern@rowland.harvard.edu, rogerq@ti.com
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Dejin Zheng <zhengdejin5@gmail.com>
Subject: [PATCH] usb: gadget: udc: core: Warn about failed to find udc
Date:   Sat,  4 Jan 2020 19:28:36 +0800
Message-Id: <20200104112836.28036-1-zhengdejin5@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If we do not warn here, the user may not know failed to
find udc class driver because it silently fails.
Let's print a warning in that case so developers find
these problems faster.

Signed-off-by: Dejin Zheng <zhengdejin5@gmail.com>
---
 drivers/usb/gadget/udc/core.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/usb/gadget/udc/core.c b/drivers/usb/gadget/udc/core.c
index 51fa614b4079..9b11046480fe 100644
--- a/drivers/usb/gadget/udc/core.c
+++ b/drivers/usb/gadget/udc/core.c
@@ -1414,6 +1414,8 @@ int usb_gadget_probe_driver(struct usb_gadget_driver *driver)
 	}
 
 	mutex_unlock(&udc_lock);
+	if (ret)
+		pr_warn("udc-core: couldn't find an available UDC or it's busy\n");
 	return ret;
 found:
 	ret = udc_bind_to_driver(udc, driver);
-- 
2.17.1

