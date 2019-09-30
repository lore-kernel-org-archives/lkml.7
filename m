Return-Path: <SRS0=rUXN=XZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1578CC32792
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Sep 2019 20:45:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D8E6822500
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Sep 2019 20:45:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="aKjqbywH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730827AbfI3UpB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Sep 2019 16:45:01 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:41035 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727508AbfI3UpA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Sep 2019 16:45:00 -0400
Received: by mail-qt1-f195.google.com with SMTP id n1so18799490qtp.8
        for <linux-kernel@vger.kernel.org>; Mon, 30 Sep 2019 13:45:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=1dwBvieRM+vKXZ4KLxwbvrNPVV9nPlESTVr4TgXHT9c=;
        b=aKjqbywHKeBLuug1dtqF0XkdHMigPjUAxw3BlPnJjAjdAx5lkTdY7/HB6DEFlEzwpg
         AhdjS/kmkFWrj8YIGf/HcC3mSsAsOSf/Qn0ZfQzBhgZr3BzVaxd6bu1VuiA1PM8LTOHH
         FqNNFeJmYKO2QIZMxewOPXGVvgW2vbRcZZXn8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=1dwBvieRM+vKXZ4KLxwbvrNPVV9nPlESTVr4TgXHT9c=;
        b=iu/BNvOGq+bOmBFfkayLq6/tNVdM2UGBEwfJE6vaYzt7p5RIID7q1rr6PyxUzyCK9A
         x834xoXYlS2GLQLc0xJA0qDc0CBCpEXmy7anEsH106RlPpA6XzoVg9XIh6UjNC+cjpwG
         C0NW9AfIBaaOGUWA14b/20AIKGRAKSgTxk4Ggavm34T5nw78CCBvccIOarnTHEwsa+yx
         BvE6nQt9BJEsu7VzQY/19XHAtrbcnK1YVvyqBe6xqXnFcbVtFS+iwiTz6IHB8jY4bsgS
         uj95ZPnIqWx3ffRYNBgF2IXIwyEabAhfv5/eu0q9jOGgiQiHivEs4c85Lzq6M3HpWiVO
         vNag==
X-Gm-Message-State: APjAAAWzs9HGNaZm3ozdCRzXJigur2WoirbAzD28d0DTzaviptzVAa9b
        0QI7Y/nhp40mg1uTICY9P4G8dGH+qBk=
X-Google-Smtp-Source: APXvYqxk3NZEibZ7+/VO5i5PFtNsFhkXGQFI0W+IiPDN0q29fCBgPUPrtv8hutsjM4/XczJf2Xdn9w==
X-Received: by 2002:a63:c148:: with SMTP id p8mr26335812pgi.282.1569874374266;
        Mon, 30 Sep 2019 13:12:54 -0700 (PDT)
Received: from joelaf.cam.corp.google.com ([2620:15c:6:12:9c46:e0da:efbf:69cc])
        by smtp.gmail.com with ESMTPSA id t125sm12921894pfc.80.2019.09.30.13.12.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Sep 2019 13:12:53 -0700 (PDT)
From:   "Joel Fernandes (Google)" <joel@joelfernandes.org>
To:     linux-kernel@vger.kernel.org
Cc:     "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        =?UTF-8?q?Arve=20Hj=C3=B8nnev=C3=A5g?= <arve@android.com>,
        Christian Brauner <christian@brauner.io>,
        devel@driverdev.osuosl.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Martijn Coenen <maco@android.com>,
        Todd Kjos <tkjos@android.com>
Subject: [PATCH] binder: Fix comment headers on binder_alloc_prepare_to_free()
Date:   Mon, 30 Sep 2019 16:12:50 -0400
Message-Id: <20190930201250.139554-1-joel@joelfernandes.org>
X-Mailer: git-send-email 2.23.0.444.g18eeb5a265-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

binder_alloc_buffer_lookup() doesn't exist and is named
"binder_alloc_prepare_to_free()". Correct the code comments to reflect
this.

Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>

---
 drivers/android/binder_alloc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/android/binder_alloc.c b/drivers/android/binder_alloc.c
index 6d79a1b0d446..d42a8b2f636a 100644
--- a/drivers/android/binder_alloc.c
+++ b/drivers/android/binder_alloc.c
@@ -156,7 +156,7 @@ static struct binder_buffer *binder_alloc_prepare_to_free_locked(
 }
 
 /**
- * binder_alloc_buffer_lookup() - get buffer given user ptr
+ * binder_alloc_prepare_to_free() - get buffer given user ptr
  * @alloc:	binder_alloc for this proc
  * @user_ptr:	User pointer to buffer data
  *
-- 
2.23.0.444.g18eeb5a265-goog

