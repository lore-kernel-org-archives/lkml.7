Return-Path: <SRS0=yQuH=Z3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CAC8C43603
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Dec 2019 15:29:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 62CF420707
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Dec 2019 15:29:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729827AbfLEP3S (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Dec 2019 10:29:18 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:39695 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726028AbfLEP3S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Dec 2019 10:29:18 -0500
Received: from mail-wr1-f70.google.com ([209.85.221.70])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <andrea.righi@canonical.com>)
        id 1ict48-0005VA-1Z
        for linux-kernel@vger.kernel.org; Thu, 05 Dec 2019 15:29:16 +0000
Received: by mail-wr1-f70.google.com with SMTP id l20so1691069wrc.13
        for <linux-kernel@vger.kernel.org>; Thu, 05 Dec 2019 07:29:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=LC6DDS7dzR3mgMabSVrO4Lfc9Ry73+/2Egm44NEkV5Y=;
        b=PVmHzoTZv3sB8f072jDZCsNlhWa0tciFZXr/NX/oVhWX4HHrV/evlx9GqFNP5XK+G4
         35ax2Fy6VpStqwixcMwbQOml2RMmHY2wTnd5Z3n5VPxvHKHzjyANybNsROtSDepskuqC
         ocNvBsQwergOf3ZXmlGx2wvlgaB6nbD4k8jD4PARAz/lxACXOy8NMOSkTl+s7sbqpBjU
         XjELi/kfPS7ERt9AyZkMMAdsDWnzj+GFhtRo+KhNIRdrkvUA3VJY5/YlIonuhpK3LMJk
         MVseV8ezc3OBfUHluImBL+s9emBHXs9L1uVbwLO0+GVEyjgIIai5yp2U0tb1JYxqjB3C
         bsCA==
X-Gm-Message-State: APjAAAWA8i3kimNzatQSp8/q7f/D9GTVXq6hwLbx7enFuqvq4MXxyYEJ
        vypaszDBQ+TjmVu/jJljdkfgeC0MqKKInxkBhJwQ2iXBiLzmcHDU/+3zEaE6wzPM6OZAmx/yko7
        kOXVmeF8Og+wjzrkS44H1NcHmifH/AXqM11CsBFizCQ==
X-Received: by 2002:a5d:4281:: with SMTP id k1mr11236638wrq.72.1575559755763;
        Thu, 05 Dec 2019 07:29:15 -0800 (PST)
X-Google-Smtp-Source: APXvYqww3fLVvHw4i2+mxqUfxSNjvtsmae9g98lTbmDUho19nYRX5yQGivaJ4A4RPXoES4jgYCTINg==
X-Received: by 2002:a5d:4281:: with SMTP id k1mr11236599wrq.72.1575559755411;
        Thu, 05 Dec 2019 07:29:15 -0800 (PST)
Received: from localhost (host40-61-dynamic.57-82-r.retail.telecomitalia.it. [82.57.61.40])
        by smtp.gmail.com with ESMTPSA id g74sm179791wme.5.2019.12.05.07.29.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Dec 2019 07:29:14 -0800 (PST)
Date:   Thu, 5 Dec 2019 16:29:13 +0100
From:   Andrea Righi <andrea.righi@canonical.com>
To:     Valdis Kletnieks <valdis.kletnieks@vt.edu>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-fsdevel@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] staging: exfat: properly support discard in
 clr_alloc_bitmap()
Message-ID: <20191205152913.GJ3276@xps-13>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently the discard code in clr_alloc_bitmap() is just dead code.
Move code around so that the discard operation is properly attempted
when enabled.

Signed-off-by: Andrea Righi <andrea.righi@canonical.com>
---
 drivers/staging/exfat/exfat_core.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/exfat/exfat_core.c b/drivers/staging/exfat/exfat_core.c
index d2d3447083c7..463eb89c676a 100644
--- a/drivers/staging/exfat/exfat_core.c
+++ b/drivers/staging/exfat/exfat_core.c
@@ -192,8 +192,6 @@ static s32 clr_alloc_bitmap(struct super_block *sb, u32 clu)
 
 	exfat_bitmap_clear((u8 *)p_fs->vol_amap[i]->b_data, b);
 
-	return sector_write(sb, sector, p_fs->vol_amap[i], 0);
-
 #ifdef CONFIG_EXFAT_DISCARD
 	if (opts->discard) {
 		ret = sb_issue_discard(sb, START_SECTOR(clu),
@@ -202,9 +200,13 @@ static s32 clr_alloc_bitmap(struct super_block *sb, u32 clu)
 		if (ret == -EOPNOTSUPP) {
 			pr_warn("discard not supported by device, disabling");
 			opts->discard = 0;
+		} else {
+			return ret;
 		}
 	}
 #endif /* CONFIG_EXFAT_DISCARD */
+
+	return sector_write(sb, sector, p_fs->vol_amap[i], 0);
 }
 
 static u32 test_alloc_bitmap(struct super_block *sb, u32 clu)
-- 
2.20.1

