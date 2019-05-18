Return-Path: <SRS0=//ty=TS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17E5DC04AAF
	for <linux-kernel@archiver.kernel.org>; Sat, 18 May 2019 11:47:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DC8EE20882
	for <linux-kernel@archiver.kernel.org>; Sat, 18 May 2019 11:47:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NwqmbD4U"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729835AbfERLrR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 18 May 2019 07:47:17 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:34741 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729814AbfERLrR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 May 2019 07:47:17 -0400
Received: by mail-pf1-f194.google.com with SMTP id n19so4981399pfa.1;
        Sat, 18 May 2019 04:47:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=kFie4+k11yDDftzG0S10xpWYpY/RkmQCteUTvMNHkI4=;
        b=NwqmbD4UphqZRGD7W1ah35LGjZf9x50ZHnK/Cxq88FQbJLPvvuPYa4QyF273Ac3gMm
         5Qt2FDOpvwEzLzVSIZbc6utGV4k+Xq7DaT7FCVu3Qygd5BR5eJtrPNi4CkpXvh0bKMIW
         oTZzTnDyNkP8HEMMx6cdOefRrQw29EQRKKgZsvm8U/FllySRvSkerE0+mrXQ4zpEsXne
         2n3krtGE0qaCTlzPf6isc5tcEKbj7aYbUOu+yuhCnf9eD9pgbuT2JsB0hQWPXfbYD683
         Udmaf1nX8fISGTMu0YWu0fJJpSaARZyTQNVF6Qn5/ew+jgNyiZ1oftkVZjRPoPKSIuSX
         XqlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=kFie4+k11yDDftzG0S10xpWYpY/RkmQCteUTvMNHkI4=;
        b=PCtw/57GrIxXZXrWTQRzgAoLaL8QxEpeF159YHRBQhp2Ici4+lmDz7i1rE0/OonnlK
         4YDTzotAERCsR+YwjhXU3UCX/ZA2HIGQlpmXt4sknVd9oo8y2GO171DYT3Dq88e76zDF
         KU+UJ/q3tu/gjdHs4sjwow5qnerCdbklkEGlYcLtcVLNsrrOHFs8wwi/wfLfZQrfQIc/
         1fkE+D66kWgDUpHVS/xLMmkZyonZECZnrg8ZF+P6uxmaspEDuOsXwMPK26TCmoCwha7z
         fsSait+8jN7Bp9UVuMofjVg32qOb9fNhsvax7Y3wU56TTzAUnKWPyFxfLNPeGZgbZUCa
         8iVA==
X-Gm-Message-State: APjAAAU/M6FHAfcnmEP7cQ2D2tNbb2onvdYsWwUBT+7mCH3SYgT0UhNu
        XjDSVrcjfOsk6hIv9ighSGI=
X-Google-Smtp-Source: APXvYqzWqHPnlARkOMniFQKPfXN1jP4MvGD63NJdIO+pf+/V1Px6FvtbupWpIJ8NmJg3aSkt1yzo8A==
X-Received: by 2002:aa7:8096:: with SMTP id v22mr66680244pff.94.1558180036828;
        Sat, 18 May 2019 04:47:16 -0700 (PDT)
Received: from localhost ([43.224.245.181])
        by smtp.gmail.com with ESMTPSA id r77sm13869151pgr.93.2019.05.18.04.47.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 18 May 2019 04:47:16 -0700 (PDT)
From:   Weitao Hou <houweitaoo@gmail.com>
To:     balbi@kernel.org, gregkh@linuxfoundation.org, Julia.Lawall@lip6.fr,
        houweitaoo@gmail.com
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] usb: fix typos in code comments
Date:   Sat, 18 May 2019 19:46:23 +0800
Message-Id: <20190518114623.17578-1-houweitaoo@gmail.com>
X-Mailer: git-send-email 2.18.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

fix lengh to length

Signed-off-by: Weitao Hou <houweitaoo@gmail.com>
---
 drivers/usb/gadget/udc/snps_udc_core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/gadget/udc/snps_udc_core.c b/drivers/usb/gadget/udc/snps_udc_core.c
index 3fcded31405a..2e84900d0b40 100644
--- a/drivers/usb/gadget/udc/snps_udc_core.c
+++ b/drivers/usb/gadget/udc/snps_udc_core.c
@@ -2734,7 +2734,7 @@ static irqreturn_t udc_control_in_isr(struct udc *dev)
 					/* write fifo */
 					udc_txfifo_write(ep, &req->req);
 
-					/* lengh bytes transferred */
+					/* length bytes transferred */
 					len = req->req.length - req->req.actual;
 					if (len > ep->ep.maxpacket)
 						len = ep->ep.maxpacket;
-- 
2.18.0

