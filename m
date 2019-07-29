Return-Path: <SRS0=K9bG=V2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6229C7618B
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 09:04:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8875E2070D
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 09:04:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Dpmv/JAy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727679AbfG2JEg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jul 2019 05:04:36 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:42512 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726432AbfG2JEf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jul 2019 05:04:35 -0400
Received: by mail-pg1-f195.google.com with SMTP id t132so27903157pgb.9;
        Mon, 29 Jul 2019 02:04:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=v/A21rAwjhZMNLCDz5qblCoOcY3twfiyDKBiZflQpBQ=;
        b=Dpmv/JAygDIespOi7yY+Pll4NwJss+4gHitbFUWYnGC8LgfvYn0OlweiqB9Vi4w2Ni
         XLp94Y5QJ0tSLmKin/zDMce9xpI8+S9yRgkyMEWulc+/HLE0sz8sp/Zr5IT6U7D7vpb/
         oQQz9LOW0CxOBqdDk5+ThBOMpIEFQGBW5rYceBD59U9ICIKUhQ557jYViwHNcXgAHIHc
         L1MfSwJ/WhcHlm8Bk3AWCdp+pQKJLlf/IlmQ1ruyR7m/YBgeWk1ujfJpCUTua4Qa9uJh
         m+vKcvusOHAygtUf6PA3YFx7qLs3l9T2sST9dbgkkYgk2LZch1LJSs5cLD53opL8Y3Wp
         mSlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=v/A21rAwjhZMNLCDz5qblCoOcY3twfiyDKBiZflQpBQ=;
        b=Nr028G8H4GV3f+XycgII/CsuGZlgWoaYEhZ4p2EW0nc0G1xzGU1XzxTMsx0FuiSs80
         Jmr5vAMCz0fUrVE1q43zy5HoD8YOgTRUVQkkm6S2trpjVDwcKcROIV6nC9CMO+7qLhCP
         BIauzEEvbMEsB3iqMHbWi5UbxGKfX/4g8rflJKB8JjKFRJbCWK/pe+4nz9xgSjGZuOHN
         CsllcJrc5MSl5HsH77sVC5MLB0f0idtF6cP9fQIcF0Nc7lLe94fWJ24oyV4dHAwt2eoe
         zNsjSUrJYCciOhXMCXvRr/oax8wpB5gqpm/ZSQjSKYGUynJ2M+9UjYKxpy66/LGwn0jk
         V20w==
X-Gm-Message-State: APjAAAWXsuYgx4HydQ4owV839/FuFNz0FNFeJz4bGq+rgKm9iTm/A8FP
        6eUyQjz203FNasSxUgtLd/k=
X-Google-Smtp-Source: APXvYqwpAAAlCWGA6TCIkU80kb4HRWXdT1LVGsa211XYFZoBbK1cuefj+7QZRS7MNa1z9AQPXoxOdw==
X-Received: by 2002:a63:5c07:: with SMTP id q7mr50879183pgb.436.1564391074974;
        Mon, 29 Jul 2019 02:04:34 -0700 (PDT)
Received: from oslab.tsinghua.edu.cn ([2402:f000:4:72:808::3ca])
        by smtp.gmail.com with ESMTPSA id 30sm140861632pjk.17.2019.07.29.02.04.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 29 Jul 2019 02:04:34 -0700 (PDT)
From:   Jia-Ju Bai <baijiaju1990@gmail.com>
To:     b-liu@ti.com, gregkh@linuxfoundation.org
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jia-Ju Bai <baijiaju1990@gmail.com>
Subject: [PATCH] usb: musb: Fix a possible null-pointer dereference in musb_handle_intr_connect()
Date:   Mon, 29 Jul 2019 17:04:28 +0800
Message-Id: <20190729090428.29508-1-baijiaju1990@gmail.com>
X-Mailer: git-send-email 2.17.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In musb_handle_intr_connect(), there is an if statement on line 783 to
check whether musb->hcd is NULL:
    if (musb->hcd)

When musb->hcd is NULL, it is used on line 797:
    musb_host_poke_root_hub(musb);
        if (musb->hcd->status_urb)

Thus, a possible null-pointer dereference may occur.

To fix this bug, musb->hcd is checked before calling
musb_host_poke_root_hub().

This bug is found by a static analysis tool STCheck written by us.

Signed-off-by: Jia-Ju Bai <baijiaju1990@gmail.com>
---
 drivers/usb/musb/musb_core.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/musb/musb_core.c b/drivers/usb/musb/musb_core.c
index 9f5a4819a744..329ff52f8167 100644
--- a/drivers/usb/musb/musb_core.c
+++ b/drivers/usb/musb/musb_core.c
@@ -794,7 +794,8 @@ static void musb_handle_intr_connect(struct musb *musb, u8 devctl, u8 int_usb)
 		break;
 	}
 
-	musb_host_poke_root_hub(musb);
+	if (musb->hcd)
+		musb_host_poke_root_hub(musb);
 
 	musb_dbg(musb, "CONNECT (%s) devctl %02x",
 			usb_otg_state_string(musb->xceiv->otg->state), devctl);
-- 
2.17.0

