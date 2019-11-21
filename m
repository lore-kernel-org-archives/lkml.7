Return-Path: <SRS0=lLEG=ZN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FE34C432C0
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 08:15:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 458AD20898
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 08:15:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="yq3uTprM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727105AbfKUIPQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Nov 2019 03:15:16 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:43801 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727028AbfKUIPK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Nov 2019 03:15:10 -0500
Received: by mail-wr1-f68.google.com with SMTP id n1so3157646wra.10
        for <linux-kernel@vger.kernel.org>; Thu, 21 Nov 2019 00:15:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=S85Lb8WCrvzvHsXJ1JP6vJm29LDHnvv8cinVUtImNUA=;
        b=yq3uTprMfeFN489dyXFOl4m/qrdnE7eA2cjunM2zTtR4UzDnl6oQiaoS9uColT8q2h
         wSzZgoGOtmJvVG3/bcQbKvkBPwTgsAI4pbcteHAiL654TKVR8qKocXKSzfTIYt1jEUdI
         d8QWlvvR89ZJamV3huZEneoVQDB24YemVutwEGXJ/crJmSINH//i0XWOqGkOGe2gYgBU
         cOsHAD9eLTf66ifK2U3WkpLlVAPRn1erMWf6UKVoQuSgxpxbb72CERomZVM+HLZyQTff
         FX0GlPhHUyTgfuCvyXlcWO8+KKu1xx6IWRzydMZQYIvkCoviWDEpPtldm1QvSbRh1J5T
         UKLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=S85Lb8WCrvzvHsXJ1JP6vJm29LDHnvv8cinVUtImNUA=;
        b=jp55PCtoUJO90/awSI75G4LiC7hBaRnPpbIUz8dKkSxOWoawD5uDKC4SnFJJlOjpy6
         0iVPuduobqE5ikp0KAj1iLywblbAtj2rhx1XJcnFygu94LgAGI1cgxZHMHnu4iOp2NeX
         GoPE5PrmBVyGXH/R+v/oQlBwvcBzC293/RXRiLd5+m7mLK83yq6UFVFDaNylsJG4JJwX
         uNxeFNfZybLA1O/GvTLHi4Gzq9IL/gIbxfQIDy+MPxOnTDrV+9fLaXEdNa0A93oxGxkz
         4p6gEYeNMMa4qcrkkUJi/GQxn/bKx/tNVfoZQxtyMepjwUYTiq5TR1V5swIVh988xSxb
         MXoA==
X-Gm-Message-State: APjAAAUBqtIi5EKzX714d5A7IMkje9E2hEp+SiImIf8iZny9j+WbXhGT
        JUJ/RAURjmBolh/FxDD6wVsCeQ==
X-Google-Smtp-Source: APXvYqwHgkPusxSIOYywogp+NmRlVVWIOoz0RqJdPk/4zC/qUu85b4/pJcVwbAtIK3Y6U6qbm6wG8g==
X-Received: by 2002:a5d:678f:: with SMTP id v15mr8567761wru.242.1574324107777;
        Thu, 21 Nov 2019 00:15:07 -0800 (PST)
Received: from localhost.localdomain ([51.15.160.169])
        by smtp.googlemail.com with ESMTPSA id w13sm2315075wrm.8.2019.11.21.00.15.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 21 Nov 2019 00:15:07 -0800 (PST)
From:   Corentin Labbe <clabbe@baylibre.com>
To:     airlied@redhat.com, airlied@linux.ie, arnd@arndb.de,
        fenghua.yu@intel.com, gregkh@linuxfoundation.org,
        tony.luck@intel.com
Cc:     linux-ia64@vger.kernel.org, linux-kernel@vger.kernel.org,
        Corentin Labbe <clabbe@baylibre.com>
Subject: [PATCH v2 5/5] ia64: agp: Replace empty define with do while
Date:   Thu, 21 Nov 2019 08:14:45 +0000
Message-Id: <1574324085-4338-6-git-send-email-clabbe@baylibre.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1574324085-4338-1-git-send-email-clabbe@baylibre.com>
References: <1574324085-4338-1-git-send-email-clabbe@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It's dangerous to use empty code define.
Furthermore it lead to the following warning:
drivers/char/agp/generic.c: In function « agp_generic_destroy_page »:
drivers/char/agp/generic.c:1266:28: attention : suggest braces around empty body in an « if » statement [-Wempty-body]

So let's replace emptyness by "do {} while(0)"

Signed-off-by: Corentin Labbe <clabbe@baylibre.com>
---
 arch/ia64/include/asm/agp.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/ia64/include/asm/agp.h b/arch/ia64/include/asm/agp.h
index 2b451c4496da..0261507dc264 100644
--- a/arch/ia64/include/asm/agp.h
+++ b/arch/ia64/include/asm/agp.h
@@ -14,8 +14,8 @@
  * in coherent mode, which lets us map the AGP memory as normal (write-back) memory
  * (unlike x86, where it gets mapped "write-coalescing").
  */
-#define map_page_into_agp(page)		/* nothing */
-#define unmap_page_from_agp(page)	/* nothing */
+#define map_page_into_agp(page)		do { } while (0)
+#define unmap_page_from_agp(page)	do { } while (0)
 #define flush_agp_cache()		mb()
 
 /* GATT allocation. Returns/accepts GATT kernel virtual address. */
-- 
2.23.0

