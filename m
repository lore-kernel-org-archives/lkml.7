Return-Path: <SRS0=PjNn=RI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48DB7C43381
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 23:47:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E0EF120661
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 23:47:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W2I8qOdn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728804AbfCEXrZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Mar 2019 18:47:25 -0500
Received: from mail-oi1-f193.google.com ([209.85.167.193]:33343 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727305AbfCEXrY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Mar 2019 18:47:24 -0500
Received: by mail-oi1-f193.google.com with SMTP id z14so8361772oid.0
        for <linux-kernel@vger.kernel.org>; Tue, 05 Mar 2019 15:47:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+SkSIRW3zOrn65GNA9YO2IQDd4Zm6pq2szsb//Le7L8=;
        b=W2I8qOdnorXQRFaHJgWclrCcQHzAE3uH0matgS4StaiLoadWSXKQgwqiRFcHQIfXLr
         V9V6IhBlAQyUVI4eclIhLX/IxNkVIAo0MOBeyJH2WPQp0hoJJ4sZJmkmP82V9zaUtyNw
         27gbsOeqQXJmmxCpIuHK0FyX8Fxhbl7XNmlXU4fTVssqRpdx4kyhORCrzM5tvwptqZB0
         Jwu0cMpuKmUTdkDtAxK7PrcohFdilWknnHFZAijnUK6WPZsXvRnbREs4xx21+Eh95Q7H
         MtH8LhEZuto3KLX25FK6dAhwXUy9/2wMraL7tq9jkEv/6y7N76oKlejKyoTpkBLmLQb0
         ZgvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+SkSIRW3zOrn65GNA9YO2IQDd4Zm6pq2szsb//Le7L8=;
        b=uQdeiG/Het9d9Os7Kh7H/mbgd4xX73Js8kmN/7wnLUxPZS5rnr8qNvdagC5B787Bqw
         b6Ocjp7BEluCuPCwequGKcxgZ7QKSmCrlvsAgcG7ts8yObN74TfB7blIcB6ccHSSKzL6
         mKCD/pfJnRC5Nt/Cegb3VWii3tv4iQZPkdaZG7ytBoKD6fHgJ/P+Z0WypWzbztEaTYDc
         MQt64Tr6nhFXwsLH2z8RXFOLcISK7NA6wDFrlIlpHlAj9qYVt38CyeffbKYP7sq/ivgI
         fMaiPXvZm+RfKb4wqA6iKbPETQMZX5qjZrrWKPeAXvqo1mvnLje0Iawg34fail7oCAyF
         30UA==
X-Gm-Message-State: APjAAAUFd+Y/mHOtxfvI4EjseJH9OWd6I4z1eAChkWwmPJ1tFZIJI6to
        MZzA77xCnA2weArJmi9k/Sc=
X-Google-Smtp-Source: APXvYqyGLZhx4Nl9gqpNTidMrECHOdnBO5S6nbvUTLWQjv3i/DPxg/aYqnxQMJfAUxli6PFyz/QQxQ==
X-Received: by 2002:aca:3081:: with SMTP id w123mr2212oiw.141.1551829643273;
        Tue, 05 Mar 2019 15:47:23 -0800 (PST)
Received: from griffin.server111.com ([177.234.13.170])
        by smtp.gmail.com with ESMTPSA id f43sm23204otf.23.2019.03.05.15.47.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 05 Mar 2019 15:47:22 -0800 (PST)
From:   =?UTF-8?q?Jes=C3=BAs=20Castro?= <x51v4n@gmail.com>
To:     kys@microsoft.com, haiyangz@microsoft.com, sthemmin@microsoft.com,
        sashal@kernel.org
Cc:     miguel.bernal@zapopan.tecmm.edu.mx, devel@linuxdriverproject.org,
        linux-kernel@vger.kernel.org,
        =?UTF-8?q?Jes=C3=BAs=20Castro?= <x51v4n@gmail.com>
Subject: [PATCH] hv: utils: fix coding style
Date:   Tue,  5 Mar 2019 17:45:42 -0600
Message-Id: <20190305234542.5243-1-x51v4n@gmail.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Checkpatch script is showing a coding style error and is showing:

ERROR: else should follow close brace '}'
+	}
+	else if (hvt->mode == HVUTIL_TRANSPORT_NETLINK) {

This commit fixes the coding style, not a functional change.

Signed-off-by: Jesús Castro <x51v4n@gmail.com>
---
 drivers/hv/hv_utils_transport.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/hv/hv_utils_transport.c b/drivers/hv/hv_utils_transport.c
index 832777527936..eff5419b7b35 100644
--- a/drivers/hv/hv_utils_transport.c
+++ b/drivers/hv/hv_utils_transport.c
@@ -139,8 +139,7 @@ static int hvt_op_open(struct inode *inode, struct file *file)
 		 * device gets released.
 		 */
 		hvt->mode = HVUTIL_TRANSPORT_CHARDEV;
-	}
-	else if (hvt->mode == HVUTIL_TRANSPORT_NETLINK) {
+	} else if (hvt->mode == HVUTIL_TRANSPORT_NETLINK) {
 		/*
 		 * We're switching from netlink communication to using char
 		 * device. Issue the reset first.
-- 
2.21.0

