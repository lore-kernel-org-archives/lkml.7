Return-Path: <SRS0=2dYc=UG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59525C28CC3
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Jun 2019 07:18:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2CD30208C0
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Jun 2019 07:18:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iOMVbhtn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727495AbfFGHSR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Jun 2019 03:18:17 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:42202 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726699AbfFGHSR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jun 2019 03:18:17 -0400
Received: by mail-pg1-f196.google.com with SMTP id e6so675487pgd.9
        for <linux-kernel@vger.kernel.org>; Fri, 07 Jun 2019 00:18:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=N3m8s+2059Fu//diNFBATOjWg3fyZfQ3e6DmQTqD6d8=;
        b=iOMVbhtnqeRZvvXsdXNBoe43Jqxfa+bhlO3TY5YwqJsr/f0immkDnHSix0UdxqBtga
         4olOcewyVGr5YbODNCk/k1NHp4833YxSm6kYX2e8+yc3v/nOBj7XeVNLvdPBbdbx+vs4
         o7zG6ZlOzAlmPLX6qXi0PXe5mEHsyFZExAk3tbbZFpNe2767b2zJBYRJDvmSSD2oSZlP
         J+RIXGK1pO+srwmT40YPbCNxLPWFGZ4elNfTtmVzrWZhSGRgEnIoQvVVHBsye90IPMlD
         hj9A7yboMiuINF58nDdt/GIA+rr9wbvqxnGSqi0taB0xicmA3H0B991w4JfEiNQw39w/
         x4Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=N3m8s+2059Fu//diNFBATOjWg3fyZfQ3e6DmQTqD6d8=;
        b=tu83s9PpTy8ocHQseILrTDqCBsCYb/oWwbhLcbCcW4NyQsjXVtif43yzxOPs9YvXqJ
         FZjvH5bG4IgaA/3PutdCS6cY0JxdNXp5dr+lZbRA2w9WODEsR/gx1xb1XvTMUyyVq5UL
         0BtS/IYxx6yG2/d4VnCD+EHXMWMB66Hwk/Q3Bw7GOfcU2OvqQTmANd3xyROLE4p6Yjx2
         gSLfwRrFavgqTNRvo/vvU66OIoxGfuXiRG+kYjSWiihJK5earAbYvMFZQeIwCtNpq6Mt
         RJ3w1m4Yr5WkMnm12AFukT+iCny8VDLh6k0XA6LGYEX4OBhGe7tIqdgL26hGgRQF1hsh
         mTrA==
X-Gm-Message-State: APjAAAWXi6187Ya6o+n9nwW5FYgikSLK5l9HCQyzlHdl8TOFL1KEZLBv
        IJkXe/Nc9cgAmFr1juEStjo=
X-Google-Smtp-Source: APXvYqxpj7tRa6U0t++O/ryXNuCaMRHWHGvYKe55FI9ONfUDOjSC8O0y20Xo/7Mqp8fMYwICAjyQVw==
X-Received: by 2002:a63:5d45:: with SMTP id o5mr1564440pgm.40.1559891896267;
        Fri, 07 Jun 2019 00:18:16 -0700 (PDT)
Received: from localhost.localdomain ([110.227.95.145])
        by smtp.gmail.com with ESMTPSA id e26sm1222390pfn.94.2019.06.07.00.18.11
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 07 Jun 2019 00:18:15 -0700 (PDT)
From:   Nishka Dasgupta <nishkadg.linux@gmail.com>
To:     gregkh@linuxfoundation.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, colin.king@canonical.com,
        hdegoede@redhat.com, straube.linux@gmail.com, julia.lawall@lip6.fr,
        hardiksingh.k@gmail.com, pakki001@umn.edu,
        hariprasad.kelam@gmail.com, arnd@arndb.de
Cc:     Nishka Dasgupta <nishkadg.linux@gmail.com>
Subject: [PATCH] staging: rtl8723bs: core: Remove variable priority
Date:   Fri,  7 Jun 2019 12:48:01 +0530
Message-Id: <20190607071801.28420-1-nishkadg.linux@gmail.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove local variable change_priority, as it takes the value of the
argument priority; as both of these variables are of type u8, priority
can be modified without changing the value of its copy at the call site.
Issue found with Coccinelle.

Signed-off-by: Nishka Dasgupta <nishkadg.linux@gmail.com>
---
 drivers/staging/rtl8723bs/core/rtw_xmit.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/drivers/staging/rtl8723bs/core/rtw_xmit.c b/drivers/staging/rtl8723bs/core/rtw_xmit.c
index 53146ec62ae9..b5dcb78fb4f4 100644
--- a/drivers/staging/rtl8723bs/core/rtw_xmit.c
+++ b/drivers/staging/rtl8723bs/core/rtw_xmit.c
@@ -625,13 +625,11 @@ static s32 update_attrib_sec_info(struct adapter *padapter, struct pkt_attrib *p
 
 u8 qos_acm(u8 acm_mask, u8 priority)
 {
-	u8 change_priority = priority;
-
 	switch (priority) {
 	case 0:
 	case 3:
 		if (acm_mask & BIT(1))
-			change_priority = 1;
+			priority = 1;
 		break;
 	case 1:
 	case 2:
@@ -639,19 +637,19 @@ u8 qos_acm(u8 acm_mask, u8 priority)
 	case 4:
 	case 5:
 		if (acm_mask & BIT(2))
-			change_priority = 0;
+			priority = 0;
 		break;
 	case 6:
 	case 7:
 		if (acm_mask & BIT(3))
-			change_priority = 5;
+			priority = 5;
 		break;
 	default:
 		DBG_871X("qos_acm(): invalid pattrib->priority: %d!!!\n", priority);
 		break;
 	}
 
-	return change_priority;
+	return priority;
 }
 
 static void set_qos(struct pkt_file *ppktfile, struct pkt_attrib *pattrib)
-- 
2.19.1

