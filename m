Return-Path: <SRS0=bmbz=XS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BEAFC04EBF
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Sep 2019 13:59:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D519420835
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Sep 2019 13:59:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hXTzopcI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2439820AbfIWN7c (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Sep 2019 09:59:32 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:42699 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2439806AbfIWN7a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Sep 2019 09:59:30 -0400
Received: by mail-io1-f65.google.com with SMTP id n197so33597639iod.9;
        Mon, 23 Sep 2019 06:59:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=TWgZDntOMYE0pJNm4v4MgMyLm0itzJK9E74UOUCbCFE=;
        b=hXTzopcIeEtU3YQpZSBp5dvZTJ34eZGS9dDGpC4OHcG4AN7Of7TFkRelLOlS+lhrLR
         3ZW3djNcy8+CEc54FtuvZDppefcCC9PzwHoSkao3l8AJXAYZuM+I99a4gD9sZ1Fzs5Py
         Ky+2zPa6AvZerjOwsQrGfVTidMxj6GzNTi6bymKP/GCLJb1E07XA21Nypo3yQ2Wwblvx
         QfUaiG4dSphMnE468ZYfz9RPGxxuYo5Mp7s+IOxnx0e4sCae3SKiWYRWTfNbgThh/4Vj
         aa0RGz8bwrcSZ0A93/5GTdZiqpsuqz4EfD1alE4pE8CvUg0gO7xMkABA7PB2ClNDTtnX
         oqPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=TWgZDntOMYE0pJNm4v4MgMyLm0itzJK9E74UOUCbCFE=;
        b=bZ8Wac3fnn4gZeqCl1v/OPKUHbaYfBaZgN5dYHnrRhxBR1H7+XQZHemFbVeTsKTOiE
         zj3AQFfotcPUZVgRyUTbkbGFTrDBXTvUAgcF/BijLx6zNLw+Vr1TXwtzQu/gjxzLszEN
         Up8C6tmZo2+SbgfoeePJhrUwY97BcUgdOKHV1JQPBUNMs7dZVCefKZfeGL112tVXtfba
         W94y8w+82Q43AVbvj3CKT9pXgwNrDaJEsbH6VuS5p5qhLxF/KgSyO8EDoNwoLdOBKP+7
         qJ50WRYxucTjkOmDUBXe3Es/WvEy39dcBvVplfL8yAsc9n8HpvhmysVVDxlcZIJhh9Ss
         qidQ==
X-Gm-Message-State: APjAAAVI3pGnftJpjxxQly1R5mQLfQ7+rh3bKa8a8oOnuviCkH1onwih
        cEGy2i4FJ3aWSoc2k7QEYuOFTsYRcIk=
X-Google-Smtp-Source: APXvYqzKXJ14ZJ19fJit1ABq++SlGZCf+1o9nIpifnXKaLyS326hNX5guZLcZi6nHehygWI9jbHqKg==
X-Received: by 2002:a6b:6117:: with SMTP id v23mr527829iob.95.1569247168654;
        Mon, 23 Sep 2019 06:59:28 -0700 (PDT)
Received: from aford-OptiPlex-7050.logicpd.com ([174.46.170.158])
        by smtp.gmail.com with ESMTPSA id j11sm7917262ioa.55.2019.09.23.06.59.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Sep 2019 06:59:26 -0700 (PDT)
From:   Adam Ford <aford173@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-omap@vger.kernel.org, Adam Ford <aford173@gmail.com>
Subject: [PATCH] MAINTAINERS: Add logicpd-som-lv and logicpd-torpedo to OMAP TREE
Date:   Mon, 23 Sep 2019 08:59:07 -0500
Message-Id: <20190923135908.23080-2-aford173@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190923135908.23080-1-aford173@gmail.com>
References: <20190923135908.23080-1-aford173@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The OMAP DEVICE TREE SUPPORT lists a bunch of device tree files
with wildcard names using am3*, am4*, am5*, dra7*, and *omap*.
Unfortunately, the LogicPD boards do not follow this convention
so changes to these boards don't get automatically flagged to
route to the omap mailing list.  After consulting with Tony
Lindgren, he agreed it made sense to add these boards to the
list.

This patch adds the omap based boards to the omap device tree
maintainer list.

Signed-off-by: Adam Ford <aford173@gmail.com>

diff --git a/MAINTAINERS b/MAINTAINERS
index a50e97a63bc8..0ee89575699c 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -11645,6 +11645,8 @@ F:	arch/arm/boot/dts/*am3*
 F:	arch/arm/boot/dts/*am4*
 F:	arch/arm/boot/dts/*am5*
 F:	arch/arm/boot/dts/*dra7*
+F:	arch/arm/boot/dts/logicpd-som-lv*
+F:	arch/arm/boot/dts/logicpd-torpedo*
 
 OMAP DISPLAY SUBSYSTEM and FRAMEBUFFER SUPPORT (DSS2)
 L:	linux-omap@vger.kernel.org
-- 
2.17.1

