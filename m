Return-Path: <SRS0=7x1k=SF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E548C4360F
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 00:35:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 125762146E
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 00:35:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BgDAfYu8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726633AbfDCAfQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Apr 2019 20:35:16 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:39041 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725912AbfDCAfQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Apr 2019 20:35:16 -0400
Received: by mail-qt1-f195.google.com with SMTP id t28so17553818qte.6;
        Tue, 02 Apr 2019 17:35:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id;
        bh=8O/UaAr9QkMj1OHDicJnvmpXgq5UwL1SvD9pZq0SF2A=;
        b=BgDAfYu8zCD8o2xo9nBi4tnF0k3bYICZGIoNOQU6uX2zrIMKh9U0e06yKp9FdSqTho
         UEC4vbEYhfjuc8944LbVAZT6u4mZx3FAtottSqkf+SUtN+zszj4sqGbtgSQo7OsHF5Rz
         ZwR1X659gV2VH+/1HcKbNlmdesnls7DyEhswiwDZxEg2K+Wh8Dn1h5ER1hWqbm2B8QFo
         r3kQp/cvMUOYP6Z7+2G4YaB6OZ0xP2EoLk/ve1eFfrz+iGsfoU0I5FwgR3Cut1kxUR0p
         CcGa3eo+67ZfeI10C1kKGC3BpnRZjfTKYcVN3Iow1FT3NhxHy8deRWVmoMvJngp/2Wnv
         e4/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id;
        bh=8O/UaAr9QkMj1OHDicJnvmpXgq5UwL1SvD9pZq0SF2A=;
        b=Ra3aDABeWiJ/Dls14x3cgiNit3yZNnEEdmYFsntKE92VtW+8lLA0dQauRY7R9TiYqE
         /WBduqQjYuKTUCc2MmZBtHcDqaUh8rCzrpXQL2Jb34R0JZMbKTyzGHVy61gcb/G0+1Io
         AGvk1xNzCHtPKmM5iOJKMGOAzzQZiYRotSeYXjmo3ymE9tVulJ+eVsT28ntigCYWtnyV
         zwNmKOztXIXvI4VKMbwlrrFt2IqFvNLeCFmtsPTRhBjOJylKKh6u9rS6LmvFIgDIGqXL
         iLHO7xIN48BRHDBoy+AHzzJqYaqsXpn7QYmDNMyUdu83qwUEaYciC10h2buGQUJRXsTO
         glBw==
X-Gm-Message-State: APjAAAV66FpV/1dKmpLiDLvFuMCcskb17EEa30p8swpj7EtaOsf3xxe2
        UqO7FPCFBxAjJ+Dlh7+GZDU=
X-Google-Smtp-Source: APXvYqwEYX9QDYOs6hOj6oE7kuF9Dne8lzECGTbjEi1b65Km+I6EfbBIdlG1XEfDYDew7t/J6sjcNg==
X-Received: by 2002:ac8:2f10:: with SMTP id j16mr62702224qta.29.1554251715441;
        Tue, 02 Apr 2019 17:35:15 -0700 (PDT)
Received: from localhost.localdomain ([179.94.76.49])
        by smtp.gmail.com with ESMTPSA id c21sm7378776qkm.8.2019.04.02.17.35.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 02 Apr 2019 17:35:14 -0700 (PDT)
From:   Gilberto Martinez Jr <gil.engcomp@gmail.com>
To:     mchehab@kernel.org, gregkh@linuxfoundation.org,
        hverkuil-cisco@xs4all.nl, sakari.ailus@linux.intel.com,
        mjpeg-users@lists.sourceforge.net, linux-media@vger.kernel.org,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: [PATCH] media: zoran: remove unnecessary space
Date:   Tue,  2 Apr 2019 21:34:53 -0300
Message-Id: <20190403003453.32228-1-gil.engcomp@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

fix the following errors from checkpath:

WARNING: Unnecessary space before function pointer arguments
+	void (*init) (struct zoran *zr);

Signed-off-by: Gilberto Martinez Jr <gil.engcomp@gmail.com>
---
 drivers/staging/media/zoran/zoran.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/media/zoran/zoran.h b/drivers/staging/media/zoran/zoran.h
index 35f74ce53eeb..dc91e5196b12 100644
--- a/drivers/staging/media/zoran/zoran.h
+++ b/drivers/staging/media/zoran/zoran.h
@@ -262,7 +262,7 @@ struct card_info {
 	/* avs6eyes mux setting */
 	u8 input_mux;
 
-	void (*init) (struct zoran *zr);
+	void (*init)(struct zoran *zr);
 };
 
 struct zoran {
-- 
2.17.1

