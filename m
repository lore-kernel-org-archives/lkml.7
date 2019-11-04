Return-Path: <SRS0=xa+R=Y4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5FBACA9EB5
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Nov 2019 16:14:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 954772084D
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Nov 2019 16:14:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lk3pSZUe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728996AbfKDQOf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Nov 2019 11:14:35 -0500
Received: from mail-qt1-f193.google.com ([209.85.160.193]:38172 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727838AbfKDQOe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Nov 2019 11:14:34 -0500
Received: by mail-qt1-f193.google.com with SMTP id p20so6445362qtq.5
        for <linux-kernel@vger.kernel.org>; Mon, 04 Nov 2019 08:14:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=YuYmhVgbA+Fo02o2Xskyfo4EJXaoEt0MjkOscYAQ/Uo=;
        b=lk3pSZUeGzM6eLoD0AFnbQccwwlgtIKUkLeSdLj3GhQupKaxo6Id4ox0PyEy3wCDLr
         4ByyYWvGBZnwKdeIC5Kw+orC0Nd/kvDnlGA88gdx89Jpzf5NNdmS6Q9f+6QiYkCbkA36
         J5pOGly8HGnGdiproFp6tMWg8flyHzkDsTU2alek36m+MrplTzYfebhQOIYPQUa40IoG
         RcPWOoWKKGeoN5NlpybTy8lQ5aKt48pzS/APUf59A2uYApLauBAbLH6PzCa8uHnfNWTf
         mRvPBwxJGXOnwCTg/CT15c19mz94l00yu3DGS6MH9KlaM/FNJ4W5r5BS9cGAnKgcCJzt
         i9Xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=YuYmhVgbA+Fo02o2Xskyfo4EJXaoEt0MjkOscYAQ/Uo=;
        b=DpRF9/Cd18407w4iP0sPk3m2gaELnh3Axu6iljelOehUdLHz9LJLPY01Jz+dPjalpt
         6hYMKxm7EHYEiesSoKJtXlGskMjh3JvFFZMmsZRjDRWXDREfcd4RGBSdY48LHHumWzyw
         kp4l1mES7Ryh4ATw4RF/j7Z5uZ4504lcQJ75b1ms1/uglFr8qKfSMq1+x7CVD5U7f3KX
         UEgAC52DXCFX2uiquigUdzyBdVdyFEJBKOoH9wK909pBC1FTZQ+ClHIewZKnX7b3i4fD
         TdQA9uJbrf7LcoSlmDQRcr1lR4CFSdfS4iCvg2r2DwuO49Eol+UcCLRNN2esqnifS2ev
         IMtQ==
X-Gm-Message-State: APjAAAWSlq6/zojK47NHNAa052uuX9Z5cIScRt3hdNa/ZrB23ZJ4z1GQ
        GUkJ700i9xY4zek7XeDktT4=
X-Google-Smtp-Source: APXvYqyC4InZzB7PWnIa0uKyq5kaRUwDOfqSGs+aND0mj4RP874zaM9/bIQsy+BQ6rn7DzPAtWXh7Q==
X-Received: by 2002:ac8:d6:: with SMTP id d22mr13033168qtg.290.1572884072383;
        Mon, 04 Nov 2019 08:14:32 -0800 (PST)
Received: from localhost.localdomain ([187.106.44.83])
        by smtp.gmail.com with ESMTPSA id d76sm8515020qkb.57.2019.11.04.08.14.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Nov 2019 08:14:31 -0800 (PST)
From:   Gabriela Bittencourt <gabrielabittencourt00@gmail.com>
To:     outreachy-kernel@googlegroups.com, manasi.d.navare@intel.com,
        rodrigosiqueiramelo@gmail.com, hamohammed.sa@gmail.com,
        daniel@ffwll.ch, airlied@linux.ie, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, lkcamp@lists.libreplanetbr.org
Cc:     Gabriela Bittencourt <gabrielabittencourt00@gmail.com>
Subject: [PATCH VKMS v3] drm/vkms: Fix typo and preposion in function documentation
Date:   Mon,  4 Nov 2019 13:14:24 -0300
Message-Id: <20191104161424.18105-1-gabrielabittencourt00@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix typo in word 'blend' and in the word 'destination' and change
preposition 'at' to 'of' in function 'blend' documentation.
And change the task introduction word 'Todo' for the word all in uppercase
- 'TODO'. With the TODO word all in uppercase (as it's the standard) it's
easier to find the tasks that have to be done throughout the code.

Changes since V3:
 Rodrigo:
 - Merge the patch series into a single patch since it contains one single
 logical change

Changes since V2:
 - Add fix typo in  word 'destination'
 - Add change of the preposition
 - Fix the name of the function in log message
 - Add the change in word 'Todo'

Signed-off-by: Gabriela Bittencourt <gabrielabittencourt00@gmail.com>

---

I've tested the patch using kernel-doc
---
 drivers/gpu/drm/vkms/vkms_composer.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/vkms/vkms_composer.c b/drivers/gpu/drm/vkms/vkms_composer.c
index d5585695c64d..4af2f19480f4 100644
--- a/drivers/gpu/drm/vkms/vkms_composer.c
+++ b/drivers/gpu/drm/vkms/vkms_composer.c
@@ -43,18 +43,18 @@ static uint32_t compute_crc(void *vaddr_out, struct vkms_composer *composer)
 }
 
 /**
- * blend - belnd value at vaddr_src with value at vaddr_dst
+ * blend - blend value at vaddr_src with value at vaddr_dst
  * @vaddr_dst: destination address
  * @vaddr_src: source address
  * @dest_composer: destination framebuffer's metadata
  * @src_composer: source framebuffer's metadata
  *
  * Blend value at vaddr_src with value at vaddr_dst.
- * Currently, this function write value at vaddr_src on value
+ * Currently, this function write value of vaddr_src on value
  * at vaddr_dst using buffer's metadata to locate the new values
- * from vaddr_src and their distenation at vaddr_dst.
+ * from vaddr_src and their destination at vaddr_dst.
  *
- * Todo: Use the alpha value to blend vaddr_src with vaddr_dst
+ * TODO: Use the alpha value to blend vaddr_src with vaddr_dst
  *	 instead of overwriting it.
  */
 static void blend(void *vaddr_dst, void *vaddr_src,
-- 
2.20.1

