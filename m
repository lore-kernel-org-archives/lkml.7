Return-Path: <SRS0=nCuq=XH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEB70ECDE20
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Sep 2019 00:29:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E63A2089F
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Sep 2019 00:29:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tp+vOykV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728521AbfILA3k (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Sep 2019 20:29:40 -0400
Received: from mail-qt1-f201.google.com ([209.85.160.201]:34181 "EHLO
        mail-qt1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728073AbfILA3j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Sep 2019 20:29:39 -0400
Received: by mail-qt1-f201.google.com with SMTP id f19so25836729qtq.1
        for <linux-kernel@vger.kernel.org>; Wed, 11 Sep 2019 17:29:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=aQObBnsoF37hTK58s3QRsq2XDnpF8nVsAPwHxvDTqp4=;
        b=tp+vOykVFb6wUsjvQv2rrq40mey4jC2MVuUOo62FVit7XzEuaaCrt0Aliep49jaMiY
         XbUwG8uuq24QHYFR1pJXCGLPlk8YErtCXtbkDMHqwebZu9qAnRnSI/g0XfTBOt0PWM5z
         +I1bY29tI3TZKsWz3SvhpAV9F6AiGL9n/hfy/Px34sAcEY7+oQGL2CAHQLWdf+tIglJe
         W3yG6rm1gP6NFBf3dIxi5GmhqJaznQb/QPwy8hRpuMgN4CeDrRfdsP0q/N+e/Gt9Y2Hh
         YepnosVfNG9Kn5Z5M9n1US8q6U8NgabAvnJug85mkUCVYj4mLlaILu8iJr55zzhPg34s
         hzIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=aQObBnsoF37hTK58s3QRsq2XDnpF8nVsAPwHxvDTqp4=;
        b=ei8DD7jL+vi7EYRvWNDGQizpxjkyjor/meab3+0jVVSrYTxVZ3rcA7w8cWhgbzwW7P
         vKuN/pI81FvNOcUUvrlD8nLpMbURbziIY88IKkZKoMBba4u/bsKQ65Xd/xVqpIN6jLWD
         SBZkHxIRo7WoSYypdlsk5CB3HkB5NBUw3A4eRmNPofJaf9mAdb4N06CmFbyo37G4GhE+
         P2xDU1aX19zC3itXKJQnwQq9DgynLdc9M9p1lwFmWoRadbqFwDIneX0o/LBA3ha7FNYL
         Za3zMCYu6QRu14IKgKNTbmP2aouwRFpgKelRaxevgXrTgBCOugoiDkyjecbNS3mMkMC4
         VLIQ==
X-Gm-Message-State: APjAAAULvts3u9xQmnrtbxV8qQhdQLKXgc8Ph1wEEiLn1rPQTWxsIIsF
        tNR8fMbiHRZ3nLCutlWDzduATmKH9Bg=
X-Google-Smtp-Source: APXvYqzK80GPgtRHqvxLYSknsuTpGxTEnT/qyaOOSlta3kEOoLG8zvl4/XdyIzaKcqVWNpZnMQh96oPAaU8=
X-Received: by 2002:ac8:678f:: with SMTP id b15mr37229590qtp.293.1568248177173;
 Wed, 11 Sep 2019 17:29:37 -0700 (PDT)
Date:   Wed, 11 Sep 2019 18:29:29 -0600
In-Reply-To: <20190912002929.78873-1-yuzhao@google.com>
Message-Id: <20190912002929.78873-3-yuzhao@google.com>
Mime-Version: 1.0
References: <20190911071331.770ecddff6a085330bf2b5f2@linux-foundation.org> <20190912002929.78873-1-yuzhao@google.com>
X-Mailer: git-send-email 2.23.0.162.g0b9fbb3734-goog
Subject: [PATCH 3/3] mm: lock slub page when listing objects
From:   Yu Zhao <yuzhao@google.com>
To:     Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Yu Zhao <yuzhao@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Though I have no idea what the side effect of a race would be,
apparently we want to prevent the free list from being changed
while debugging objects in general.

Signed-off-by: Yu Zhao <yuzhao@google.com>
---
 mm/slub.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/mm/slub.c b/mm/slub.c
index f28072c9f2ce..2734a092bbff 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -4594,10 +4594,14 @@ static void process_slab(struct loc_track *t, struct kmem_cache *s,
 	void *addr = page_address(page);
 	void *p;
 
+	slab_lock(page);
+
 	get_map(s, page, map);
 	for_each_object(p, s, addr, page->objects)
 		if (!test_bit(slab_index(p, s, addr), map))
 			add_location(t, s, get_track(s, p, alloc));
+
+	slab_unlock(page);
 }
 
 static int list_locations(struct kmem_cache *s, char *buf,
-- 
2.23.0.162.g0b9fbb3734-goog

