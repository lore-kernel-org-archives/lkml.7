Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A189C10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 10:00:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6828F2089F
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 10:00:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lz4zOKh3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727996AbfDXKAT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 06:00:19 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:36369 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726167AbfDXKAS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 06:00:18 -0400
Received: by mail-pg1-f193.google.com with SMTP id 85so9151374pgc.3
        for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2019 03:00:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=bVBtXiY60o/H/a2If5QKEKolQPhttzstTTkizfwe+UU=;
        b=lz4zOKh3fv/H4zqfVpvpymcbwBC/Zg7xYRrCtl/sCEHu+6FBjXRzwak85Yw3OJ11KN
         6KWrDYYKu25CtoXE50m61F06FNZnG4YMoazAsSYC6YsHtoGDC3huPM7vWMvK09baRCbI
         m32mzJ9zjzlX7ICUJet0WxXGohxSNrlcE335icyITzbysyoI/q/7D28BZOzBJuDUc+DE
         cjFPQJe3W7Q3f6T2/VcbQw4sSeNFhaGQrJcewtMx2CzSSOFISgtuE/hqCIqxhl5qtA3x
         pm1hTFe1DN3w72hNSQth0IAQEUBJu9zQ4M3rOHRqnhGkjuvo3b4xOoeOkRIR4NvxrarB
         R41g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=bVBtXiY60o/H/a2If5QKEKolQPhttzstTTkizfwe+UU=;
        b=OJjhOZHRkNNayDY78srAnrWPXDvq3ijJP6XLs+M3mi7W1XpzkaNVH7p8cB1lahJ9AF
         yCEn3JGEWbzaebLy70B1U5RZNjjyfdwQvTp1kwcIE8JCXlozw7I9LS3HsQIDoHpWiipK
         Hg35r1GFBDTO3HJtudh2o3UcHbM0qWbeuyfb9qEHbdWZSCFLGG0zsTMP7ww82ZBkqOsU
         aB0oJsPdeg45Y6f3UJGoe3M3mIEKzT6j4NJm2lFmVzN32bLEKUFxqtL5MHVlai64Evio
         NuTVCBXHSughi7jxdZTlRnfHszbMPMBUOJDymlufUEib+zxJrG5HPP86jvpYSrlJMm/i
         NUug==
X-Gm-Message-State: APjAAAVmvA/cXg/wSLxcCpVSlg/h1fp8a3yfYNO1FJfLH90NjEyanutY
        FVIMXo5eFc5V0uP6otvZB9A=
X-Google-Smtp-Source: APXvYqzFa8F7O+FZuAw7lN0hGGyxrTUL/vEAr9hSOBZ367qEz2L1TIIxyvlGd2rKnSDmnB6gjBOofQ==
X-Received: by 2002:aa7:928b:: with SMTP id j11mr32630545pfa.200.1556100018091;
        Wed, 24 Apr 2019 03:00:18 -0700 (PDT)
Received: from localhost.localdomain (ch.ptr162.ptrcloud.net. [153.122.97.60])
        by smtp.gmail.com with ESMTPSA id q5sm27411660pff.97.2019.04.24.03.00.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 24 Apr 2019 03:00:16 -0700 (PDT)
From:   Weikang shi <swkhack@gmail.com>
To:     keescook@chromium.org
Cc:     arnd@arndb.de, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org, swkhack <swkhack@gmail.com>
Subject: [PATCH] lkdtm: fix potential use after free
Date:   Wed, 24 Apr 2019 17:59:52 +0800
Message-Id: <20190424095952.10990-1-swkhack@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: swkhack <swkhack@gmail.com>

The function lkdtm_READ_AFTER_FREE calls kfree(base) to free the memory
of base. However, following kfree(base),
it access the memory which base point to via base[offset]. This may result in a
use-after-free bug. This patch moves kfree(base) after the dereference.

Signed-off-by: swkhack <swkhack@gmail.com>
---
 drivers/misc/lkdtm/heap.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/misc/lkdtm/heap.c b/drivers/misc/lkdtm/heap.c
index 65026d7de..3e2f1580a 100644
--- a/drivers/misc/lkdtm/heap.c
+++ b/drivers/misc/lkdtm/heap.c
@@ -77,7 +77,6 @@ void lkdtm_READ_AFTER_FREE(void)
 	base[offset] = *val;
 	pr_info("Value in memory before free: %x\n", base[offset]);
 
-	kfree(base);
 
 	pr_info("Attempting bad read from freed memory\n");
 	saw = base[offset];
@@ -88,6 +87,7 @@ void lkdtm_READ_AFTER_FREE(void)
 	}
 	pr_info("Memory was not poisoned\n");
 
+	kfree(base);
 	kfree(val);
 }
 
-- 
2.17.1

