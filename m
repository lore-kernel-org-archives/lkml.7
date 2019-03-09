Return-Path: <SRS0=x0+x=RM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12169C43381
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Mar 2019 18:31:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D670D207E0
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Mar 2019 18:31:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fla19zIt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726575AbfCISbd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 9 Mar 2019 13:31:33 -0500
Received: from mail-qt1-f195.google.com ([209.85.160.195]:37735 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726400AbfCISbU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Mar 2019 13:31:20 -0500
Received: by mail-qt1-f195.google.com with SMTP id z17so867876qtn.4
        for <linux-kernel@vger.kernel.org>; Sat, 09 Mar 2019 10:31:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ag25KiQTY1FVAqTfM/8d5N/iuytix/eDd7Dz7lVbk7c=;
        b=fla19zIt03pKGA2jIckEfER1BPLVC09vGz87VAbhxGMqfA/EpgMJa67eW8jimeSDCQ
         6myBoAois0bSen92W/AhY0xikCai7JVRkEqcZuACJF6S17i2lDc6Anxs1yuU2k/3Yds3
         Jck35B3kjOBAhCXjNWkcej9zZI3AsHggev3wPOd8apWk8fuALTUTrU2UF9cefLuWqVBy
         VjIoMRoHF1Z8PISXKzOP7E7CPsRT3Plze7Ko+GwWhuxHg0BsICk5ErgiNXgVmiYTf59U
         3oPDbQYBTcAjz22xzgr8onmuxPGWNyuXRLdnJpYduDay4FSvt/EPqyOM8TMik2h6rVI9
         9qjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ag25KiQTY1FVAqTfM/8d5N/iuytix/eDd7Dz7lVbk7c=;
        b=aP2OS1JWsCuTO6IjZuXZ5ccFJxv3piFvuceKqVZE8sDiEbKQYELmvLFK6yserghEWP
         89J4FoSyHnXg5GiHGZ7ibxjqc+mejoQpVTUQu2Nwb1oCShma7i1aNFkzmoEFwfTo1KDq
         uvmwUQbYc2qDgbdZ01fEONOg0PF2cwSKxxYKKJ4ved/JW9vmYzxmoVDXgEwQtfrDyoaj
         5foFmvQiQdghFz4zPuWgJPndlpMG6S2KK/AHm0YfEtw37WOA9RxM0IyoM7pPbVE0pXic
         C0abg8IZs1WNvCLncPnVBxjBGeyMlT/abnGl4TwEx9hZTYJn7k95QiQUKDJ4fuBpVqPi
         rO9g==
X-Gm-Message-State: APjAAAWgC78fDzPR7MuuY60OElzPyKvxxKotwHZLrvGgU8WSvE7TadmJ
        mAyYL9020GK1myWhRzlKv+Y=
X-Google-Smtp-Source: APXvYqxmGyp/4zHd7ZAQrtSerWO7HMA0lgMLrLylPO8coeteLotT0HvNmc5plFa9IsWZkuljrLGDeQ==
X-Received: by 2002:a0c:b6d1:: with SMTP id h17mr20246069qve.135.1552156279247;
        Sat, 09 Mar 2019 10:31:19 -0800 (PST)
Received: from localhost.localdomain ([191.8.88.159])
        by smtp.gmail.com with ESMTPSA id f8sm558824qkl.11.2019.03.09.10.31.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 09 Mar 2019 10:31:18 -0800 (PST)
From:   Guilherme Tadashi Maeoka <gui.maeoka@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Guilherme Tadashi Maeoka <gui.maeoka@gmail.com>
Subject: [PATCH 4/5] Staging: rtl8723bs: os_dep: Fix space in pointer definition
Date:   Sat,  9 Mar 2019 15:30:46 -0300
Message-Id: <20190309183047.10781-5-gui.maeoka@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190309183047.10781-1-gui.maeoka@gmail.com>
References: <20190309183047.10781-1-gui.maeoka@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Pointer definition "foo * bar" should be "foo *bar".

Signed-off-by: Guilherme Tadashi Maeoka <gui.maeoka@gmail.com>
---
 drivers/staging/rtl8723bs/os_dep/osdep_service.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/rtl8723bs/os_dep/osdep_service.c b/drivers/staging/rtl8723bs/os_dep/osdep_service.c
index 65921b946ff7..262b70e88e67 100644
--- a/drivers/staging/rtl8723bs/os_dep/osdep_service.c
+++ b/drivers/staging/rtl8723bs/os_dep/osdep_service.c
@@ -248,7 +248,7 @@ struct net_device *rtw_alloc_etherdev(int sizeof_priv)
 	return pnetdev;
 }
 
-void rtw_free_netdev(struct net_device * netdev)
+void rtw_free_netdev(struct net_device *netdev)
 {
 	struct rtw_netdev_priv_indicator *pnpi;
 
-- 
2.17.1

