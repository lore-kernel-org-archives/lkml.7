Return-Path: <SRS0=6OEZ=YL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 363B1CA9EA9
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 15:40:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 003B421852
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 15:40:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="p3OJhjA2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406022AbfJRPkB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Oct 2019 11:40:01 -0400
Received: from mail-wm1-f74.google.com ([209.85.128.74]:58502 "EHLO
        mail-wm1-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728464AbfJRPkB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Oct 2019 11:40:01 -0400
Received: by mail-wm1-f74.google.com with SMTP id m16so2498941wmg.8
        for <linux-kernel@vger.kernel.org>; Fri, 18 Oct 2019 08:40:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=PaZjsPzR+1FQ3qkTRVScxabvx3Efz47jv0N4anko9Eg=;
        b=p3OJhjA2j7FCMdp847ipwinNOL9liOJNc4HbX6pAJPp7oFWqosCJS2/2tSKvRhe4Qt
         aA22KP/Nf4Ig1Nn8QwbOG8f7xAZ5nXT2CqS0e1nFWCVfaKSUFaKS5Te/Rj2v5MELYsnU
         m0HxvxUiPWqsEC/azbuHlmJWeJ80kFX+KGpetKOqcEGCpFOCegPRAYrUlIDUVGQb84yz
         B5qKY8bGXbV9BV06YtL+4yphuwc5VURRiKkzcnEXV4TeczjzYWA+hJF98a8QJTy1SVtC
         hkU7EVOFHR51UYe6jG0+dFPd1fO0DxCdpIqGTsWVoLcxDaxvyt/2tESLRZN11yF9zNOU
         xt+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=PaZjsPzR+1FQ3qkTRVScxabvx3Efz47jv0N4anko9Eg=;
        b=dsSGXC+Rgl5R1WuJV2zFV6yqKbwNhrAXQwpd2G0DQjDcWKrYIcLY8cowguv6nR/gyY
         62YIatIrjoRtHsOHq4fFm4oxk/x8VZrt2lVwaGl3L9DFFjGph1HctPD3GwHTf1k0Ch6r
         vbG4rKyMpZTAFbRwvWZBe9y/5ghp/F/FugGkRfN9fcsDgGRlKIGbBHjrNZEjr/D4Qw1C
         x9AUDyYDq3SqtGk+GAKOjG5UbvF5BALy2bjga2xGPRHSbqjFAKxjsCe8Egx60zQ/khx1
         Xruz7oRrrSy55H4F00vv1nEZf1K57EmSv++ghPQ4/h8MyWxsYsXoaG9LqACWX4a3F+u0
         39AA==
X-Gm-Message-State: APjAAAVPXwm3Too1UylDudQvYPNMf43Vz1nQgATH3On1bjnxIUff9ytQ
        DIsukuU4fMZcpM/n6/hOgPW3zqTJsQ==
X-Google-Smtp-Source: APXvYqzmFOB1c4YwA/6jO3dHH7qq+1M5HdZYJXGCq2REnWbY70L5/pHyVa7nuMkInVndEbmzQlh7RvKKgg==
X-Received: by 2002:adf:e441:: with SMTP id t1mr2855713wrm.395.1571413199056;
 Fri, 18 Oct 2019 08:39:59 -0700 (PDT)
Date:   Fri, 18 Oct 2019 17:39:46 +0200
Message-Id: <20191018153946.128584-1-jannh@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.23.0.866.gb869b98d4c-goog
Subject: [PATCH] binder: Remove incorrect comment about vm_insert_page() behavior
From:   Jann Horn <jannh@google.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "=?UTF-8?q?Arve=20Hj=C3=B8nnev=C3=A5g?=" <arve@android.com>,
        Todd Kjos <tkjos@android.com>,
        Martijn Coenen <maco@android.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Christian Brauner <christian@brauner.io>, jannh@google.com
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

vm_insert_page() does increment the page refcount, and just to be sure,
I've confirmed it by printing page_count(page[0].page_ptr) before and after
vm_insert_page(). It's 1 before, 2 afterwards, as expected.

Signed-off-by: Jann Horn <jannh@google.com>
---
 drivers/android/binder_alloc.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/android/binder_alloc.c b/drivers/android/binder_alloc.c
index d42a8b2f636a..2faada3e97fd 100644
--- a/drivers/android/binder_alloc.c
+++ b/drivers/android/binder_alloc.c
@@ -267,7 +267,6 @@ static int binder_update_page_range(struct binder_alloc *alloc, int allocate,
 			alloc->pages_high = index + 1;
 
 		trace_binder_alloc_page_end(alloc, index);
-		/* vm_insert_page does not seem to increment the refcount */
 	}
 	if (mm) {
 		up_read(&mm->mmap_sem);
-- 
2.23.0.866.gb869b98d4c-goog

