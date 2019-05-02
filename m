Return-Path: <SRS0=c+yg=TC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 577F9C46470
	for <linux-kernel@archiver.kernel.org>; Thu,  2 May 2019 16:31:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1D78920675
	for <linux-kernel@archiver.kernel.org>; Thu,  2 May 2019 16:31:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qw6j5mpw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726608AbfEBQbm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 May 2019 12:31:42 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:39919 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726303AbfEBQbl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 May 2019 12:31:41 -0400
Received: by mail-ed1-f65.google.com with SMTP id e24so2671944edq.6
        for <linux-kernel@vger.kernel.org>; Thu, 02 May 2019 09:31:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=7Oy1RG3BUKEsx4VUlFgLOKgTT7HGDm6BmTdCPYEVHzI=;
        b=qw6j5mpwSwKYxN/oL4IAsK/zH1v/EkIn+dDLKuZam7yyhsQTM8KB9cL677/5Oz7MVy
         IexCjBqxB23TohGwbBNWIteLggib7PQ3HCSGF844ugqO8ODk5dxWwnXEZg9sKL1DIzyR
         J/+ASLTaOgJswbMKQq8KaHH3d5PttebWx1MBEpVqQ93t2Os4ETMG7fcecg0n18fINZuk
         fWyvoeQsc12VsByCTBs3lt6WG9FvJ9kaNvf+e8CIKjw4G35upmxBIcv//uweMZ6jFNL8
         D79gY0owa3HXwk0qwp26NVPUdg9mRp/hYXIhEdDJ1ZNlad7IQv9ewy6AszUJc2gWsEip
         EYWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7Oy1RG3BUKEsx4VUlFgLOKgTT7HGDm6BmTdCPYEVHzI=;
        b=MmKlwzpW32bSSfIKQn8e07ShcxKgCk1Twbw/gIK6FCaFSQNQwtSF3sp3DAFHIs3IfK
         OBk7zFRcdyVRM/7sV2tU7oJcbPSRxABG59QRRzr2SMo/uKRpdnMApgAnrxFBsj9hIpqC
         30cAREs5HB8tGTQoUfTb4XiQmqoRjEwP8knZbgD8NtTyyV0J/POCpJH/oj+YlTCNJR5c
         XCmURCye6LIFioZ8MILwnNlYdZ6/QQ3vmB18Fj4lf1o8jRYh281BuODoLFjP96RmyJoL
         AMAa7Wintw11fx2h4tPp3hUK8vOos8Q/d6ekD0m2NLjRiwrwUQgcSsD0b49IBdJjkvfO
         AxGQ==
X-Gm-Message-State: APjAAAUbGtWcLeyJPWh9SWloDtKO7JkxJmDlkutUesd6B8RIhUnpac3E
        z8L2zkyGnprgQwETugytzOQ=
X-Google-Smtp-Source: APXvYqz4jS4aZzqlMk96rIVkIK1ahQvD2cBXh7geHSHkh6Ve3klRmskSiNbCIGL6V2kmJmVabxVeIg==
X-Received: by 2002:a17:906:5fd7:: with SMTP id k23mr2318906ejv.201.1556814699691;
        Thu, 02 May 2019 09:31:39 -0700 (PDT)
Received: from localhost.localdomain ([2a01:4f9:2b:2b84::2])
        by smtp.gmail.com with ESMTPSA id oq25sm7460093ejb.46.2019.05.02.09.31.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 02 May 2019 09:31:38 -0700 (PDT)
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>
Cc:     kasan-dev@googlegroups.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Nick Desaulniers <ndesaulniers@google.com>,
        clang-built-linux@googlegroups.com,
        Nathan Chancellor <natechancellor@gmail.com>
Subject: [PATCH v2] kasan: Initialize tag to 0xff in __kasan_kmalloc
Date:   Thu,  2 May 2019 09:30:58 -0700
Message-Id: <20190502163057.6603-1-natechancellor@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190502153538.2326-1-natechancellor@gmail.com>
References: <20190502153538.2326-1-natechancellor@gmail.com>
MIME-Version: 1.0
X-Patchwork-Bot: notify
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When building with -Wuninitialized and CONFIG_KASAN_SW_TAGS unset, Clang
warns:

mm/kasan/common.c:484:40: warning: variable 'tag' is uninitialized when
used here [-Wuninitialized]
        kasan_unpoison_shadow(set_tag(object, tag), size);
                                              ^~~

set_tag ignores tag in this configuration but clang doesn't realize it
at this point in its pipeline, as it points to arch_kasan_set_tag as
being the point where it is used, which will later be expanded to
(void *)(object) without a use of tag. Initialize tag to 0xff, as it
removes this warning and doesn't change the meaning of the code.

Link: https://github.com/ClangBuiltLinux/linux/issues/465
Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
---

v1 -> v2:

* Initialize tag to 0xff at Andrey's request

 mm/kasan/common.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/kasan/common.c b/mm/kasan/common.c
index 36afcf64e016..242fdc01aaa9 100644
--- a/mm/kasan/common.c
+++ b/mm/kasan/common.c
@@ -464,7 +464,7 @@ static void *__kasan_kmalloc(struct kmem_cache *cache, const void *object,
 {
 	unsigned long redzone_start;
 	unsigned long redzone_end;
-	u8 tag;
+	u8 tag = 0xff;
 
 	if (gfpflags_allow_blocking(flags))
 		quarantine_reduce();
-- 
2.21.0

