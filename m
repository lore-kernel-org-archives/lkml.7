Return-Path: <SRS0=Dm7n=X7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC883C4360C
	for <linux-kernel@archiver.kernel.org>; Sun,  6 Oct 2019 22:20:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9C8932077B
	for <linux-kernel@archiver.kernel.org>; Sun,  6 Oct 2019 22:20:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g+KWz7a8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726474AbfJFWUY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 6 Oct 2019 18:20:24 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:40090 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726030AbfJFWUX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Oct 2019 18:20:23 -0400
Received: by mail-qt1-f194.google.com with SMTP id m61so5507914qte.7
        for <linux-kernel@vger.kernel.org>; Sun, 06 Oct 2019 15:20:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=QzFy/qe/W6+KNTUy6cPF6kcqmu24zi4GEoWy9Ld7gCI=;
        b=g+KWz7a8v+RDS/wWotdD0ZdmKAGZP/xA1B6YyHFsjbwCPk0laQRqc8e45bHuOMLVmy
         qsvoAuhX7RhHg+jwP5emR2LQdXBmgW0xAk+Tt3QEJLNOmsCjD94jHem92cY5pJUrW3LO
         wx48yLjHOp9SOXrqVstEnJeJ0lopVENiz/ZR3eWyO3NnulTzAMeLJG4ketEXUzI8mXF2
         nJRzb/LXftVtMWSMzFgUepx2Nnw9TRRvavPH8nem3LpxfY4QqgxV3jcxvkMjHCx3oaMk
         /AccPJW6gkvUW2WdQLjc3EnIq8UYT0g1FnClm0CGuNzw3DXbLr0uBSX2vRZ6/SSQQtPT
         aGGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=QzFy/qe/W6+KNTUy6cPF6kcqmu24zi4GEoWy9Ld7gCI=;
        b=deDCYonLbZ+QFmxX1euNWKIqzVdj7EjQzVfGIBKWtfBN/w9T8i3aazJUoCajo3cdI9
         fEuSUazEGt4IrNSzYO1y+Pke4qXlCuvfvjM01Y+0HZZZkv7UgobIMY+qpnEL+BI9hYRn
         N0ctwZQsC86/D+t705zxtwaAEPrwwgeU9YyONj6FAf8WiEWTqC/Lrzgcqzq8IPHHVT3b
         LJrBZbUnDg8DigkFZdAC7U4WMi0M5eYuxVOFF2cht3YuWwlcIDh2pK9Ghu+P3gaox9xs
         tmEtc4OQ29F61PNyvvTXEa4jw1AGirkx6UmPTvTpO4UQfUT4JR/xVHlqN5PdzEDZX4Ik
         /1fQ==
X-Gm-Message-State: APjAAAXa7u28tcynPaisOTfPr7OSSUHif0CsteoWBAXv8vlEkRg7tJ11
        I7uONVrYD8y9otow4bo2eMo=
X-Google-Smtp-Source: APXvYqwxKSLO+U+Sk5n+LcwBwktVVJnlgZtIZNnqSVWa7n1c4lpuB/fsdRhfRSIMWZ8BeREziax7pw==
X-Received: by 2002:ac8:2b82:: with SMTP id m2mr27648660qtm.35.1570400422628;
        Sun, 06 Oct 2019 15:20:22 -0700 (PDT)
Received: from GBdebian.terracota.local ([177.103.155.130])
        by smtp.gmail.com with ESMTPSA id u123sm6585124qkh.120.2019.10.06.15.20.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Oct 2019 15:20:21 -0700 (PDT)
From:   Gabriela Bittencourt <gabrielabittencourt00@gmail.com>
To:     outreachy-kernel@googlegroups.com, Larry.Finger@lwfinger.net,
        florian.c.schilhabel@googlemail.com, gregkh@linuxfoundation.org,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        lkcamp@lists.libreplanetbr.org, trivial@kernel.org
Cc:     Gabriela Bittencourt <gabrielabittencourt00@gmail.com>
Subject: [PATCH] staging: rtl8712: align arguments with open parenthesis
Date:   Sun,  6 Oct 2019 19:20:15 -0300
Message-Id: <20191006222015.15937-1-gabrielabittencourt00@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Cleans up checks of: "Alignment should match open parenthesis"

Signed-off-by: Gabriela Bittencourt <gabrielabittencourt00@gmail.com>
---
 drivers/staging/rtl8712/osdep_service.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/rtl8712/osdep_service.h b/drivers/staging/rtl8712/osdep_service.h
index e939c4a954b3..d33ddffb7ad9 100644
--- a/drivers/staging/rtl8712/osdep_service.h
+++ b/drivers/staging/rtl8712/osdep_service.h
@@ -46,7 +46,7 @@ struct	__queue	{
 	} while (0)
 
 static inline u32 end_of_queue_search(struct list_head *head,
-		struct list_head *plist)
+				      struct list_head *plist)
 {
 	return (head == plist);
 }
-- 
2.20.1

