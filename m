Return-Path: <SRS0=x0+x=RM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D214EC43381
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Mar 2019 18:31:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A7A622081B
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Mar 2019 18:31:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b6lFHS+2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726488AbfCISbR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 9 Mar 2019 13:31:17 -0500
Received: from mail-qt1-f193.google.com ([209.85.160.193]:39880 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726313AbfCISbO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Mar 2019 13:31:14 -0500
Received: by mail-qt1-f193.google.com with SMTP id i14so861368qtp.6
        for <linux-kernel@vger.kernel.org>; Sat, 09 Mar 2019 10:31:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=DWItStIEQp+mIgBFwa8gJQscbOamVyjok4ZBQHYapCM=;
        b=b6lFHS+2MOzGN6DZXXjKIqOi0tpPQRs9EynikjYKtfyf7nr95k1xsPwYnf343CbQ9p
         SBqzoXQbLjeiLhvxMyCLs4JMUogRDiGWUCb/ej+B1Vvl5WA292XBR8L1jVYiFZR5Au6w
         oyfHcBvm0Ny0H9MXyK2G7iARHcL/BCCiNekfmGKSlQ86KxjuuzgAAFk42X6iX36FRKxv
         m9ekJ/fuMNJMxxYltODHPbTsmyPr19aolSnwgFKGA6bJ28kdPHWzsPTBxXUNE710XXvQ
         gnd/+wL+Gy4qwophCyO5Q4ZYV2bIhei0wW3gRqwSmuaq7K0HMbew2DxAPO+w1uAJ6caK
         L/ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=DWItStIEQp+mIgBFwa8gJQscbOamVyjok4ZBQHYapCM=;
        b=rkEH5cEwizSkVaSP2n5YY6n4aiyKZ9HZEQAWuNEDVqdJ5ooj+N6HjueFvsaSoq//X/
         ymkcPLYB55WmcXh7S8Ls6GjGFXf4E/iPk1Q2Bjvr6oDK3ee3gIf7Im9dyPqC+3Dr68RE
         AjskhzJ+Z9Hc+r+6vgz3dWv9MEvC0JDxUtQDjFVOMyaoafQQtJNbSd4Pw+smsz7ZpeBm
         e535pbUvZyOUwwhREzOsWwteAkfBmr5+Ca1Dkc/ywX0KAWNouZN87eRd0mVQkVq1+8+Z
         B282+I4K/6qkZD9c0jGo/B93OZVI+bJcUO4bwkRyBu8CdMPIfpH94SdoJOc424xsaM4n
         a0TQ==
X-Gm-Message-State: APjAAAWuYdtONMLxw2YbLYEzuNdArXdD2Fi/mAzgdh0rl9FMj01kJ9dg
        0Eh9oyUpQykq3n2+tdbdkvc=
X-Google-Smtp-Source: APXvYqxfdtAltTZ9TPqMwU7DUQUleWIrUyOXEn1cNBxmk3/77h65McZVdA9qfc6jnPwfYGXaa6kfOA==
X-Received: by 2002:ac8:2d0b:: with SMTP id n11mr19247789qta.143.1552156273702;
        Sat, 09 Mar 2019 10:31:13 -0800 (PST)
Received: from localhost.localdomain ([191.8.88.159])
        by smtp.gmail.com with ESMTPSA id f8sm558824qkl.11.2019.03.09.10.31.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 09 Mar 2019 10:31:13 -0800 (PST)
From:   Guilherme Tadashi Maeoka <gui.maeoka@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Guilherme Tadashi Maeoka <gui.maeoka@gmail.com>
Subject: [PATCH 1/5] Staging: rtl8723bs: os_dep: Fix assignment in if condition
Date:   Sat,  9 Mar 2019 15:30:43 -0300
Message-Id: <20190309183047.10781-2-gui.maeoka@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190309183047.10781-1-gui.maeoka@gmail.com>
References: <20190309183047.10781-1-gui.maeoka@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix an assignment in if condition.

Signed-off-by: Guilherme Tadashi Maeoka <gui.maeoka@gmail.com>
---
 drivers/staging/rtl8723bs/os_dep/osdep_service.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/staging/rtl8723bs/os_dep/osdep_service.c b/drivers/staging/rtl8723bs/os_dep/osdep_service.c
index 73b87da15eb2..c7fdcc6bbae3 100644
--- a/drivers/staging/rtl8723bs/os_dep/osdep_service.c
+++ b/drivers/staging/rtl8723bs/os_dep/osdep_service.c
@@ -162,7 +162,9 @@ static int retriveFromFile(char *path, u8 *buf, u32 sz)
 	struct file *fp;
 
 	if (path && buf) {
-		if (0 == (ret =openFile(&fp, path, O_RDONLY, 0))) {
+		ret = openFile(&fp, path, O_RDONLY, 0);
+
+		if (ret == 0) {
 			DBG_871X("%s openFile path:%s fp =%p\n", __func__, path , fp);
 
 			oldfs = get_fs(); set_fs(KERNEL_DS);
-- 
2.17.1

