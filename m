Return-Path: <SRS0=yZjE=R4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3A0DC4360F
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 21:07:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A2FF820811
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 21:07:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y/L7fBIy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730332AbfCYVHz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Mar 2019 17:07:55 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:39617 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729283AbfCYVHz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Mar 2019 17:07:55 -0400
Received: by mail-pl1-f195.google.com with SMTP id b65so533146plb.6
        for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2019 14:07:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=tBj//QOlOyjUJzu3wlOuk95ckvdPlbdm8RVV0pjJRDw=;
        b=Y/L7fBIyCvQVXA2Gh8cfgQKCSNKy8V5VYDvwr9S2ZdcA2mKRtO1DvozM7pcKG2Yt4B
         rL3ozkYN7QofFFTQ+BZTxphMZRrl5tYk2ZHzv9WfyM19HxmjEHwwWvaPYVFy/zahYKh8
         Na9oFPFfF2wGuWpliwYujMWUI9Gi4f7x3HVATi02A6p3N3PbxoNOVyuImUKEP91uWwxI
         7/z/NAILmUAVcH6mJf+yVpHMCHqI8xQ5893fSkB4gB1K1J01pC0Ftrbh3swNrSzcCjlH
         vrXdUkUsEkQfOGctzl15AI9PfNLpuSg00eHOxaqg/LdlwH7Qes//fFAWLO1OP2e7G9+x
         /6CQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=tBj//QOlOyjUJzu3wlOuk95ckvdPlbdm8RVV0pjJRDw=;
        b=tS5r+9IvgbuqPTp8Z0cQi/RRqn1YSmTPi4YEzBNBFJLHkMrujnrl2YiNrO0omlYqnu
         Uqla3QUUQ0HOC90R7dNie6lKJPxNMvKcCDY9TAizLTxuerNIlJv9p9I64LdeNRh/SOvw
         8/z7HdvOAvLaxpayj3d2Fp1UEB2xyb2ZjznNaLtX0a07VrOxj5ElIiUU10IEZ64QEOX3
         uoHIuRBVtDRltiEG5tAMbb4Q1j7g6ds+PfwW+bjC7jfolMasoEdHZhGoRbJ/l9ZffMAB
         /1bPChaLdfu/7sr71vlNUwIWzkvSTP5okVHxLeJKO+aHeVKbcqcQBKcueORDSt4Wh7K3
         42rw==
X-Gm-Message-State: APjAAAX53Vz66leKdR90g/4i7bVlkL/Cfnn/qpWrZ3tnJLvdRGnO1hU7
        G7yzmX9B0ATl2+z3Kmm42Jc=
X-Google-Smtp-Source: APXvYqz6OgSZoEUt7zAWvbwwhjBSzNWfRK9QY5qAA5wG6I/YQ8iQ7aRKYIQaTpvSGugoiLZ1KKHDDQ==
X-Received: by 2002:a17:902:2702:: with SMTP id c2mr27140927plb.239.1553548074313;
        Mon, 25 Mar 2019 14:07:54 -0700 (PDT)
Received: from localhost ([169.229.22.206])
        by smtp.gmail.com with ESMTPSA id h184sm35239882pfc.78.2019.03.25.14.07.53
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 25 Mar 2019 14:07:53 -0700 (PDT)
From:   Yury Norov <yury.norov@gmail.com>
X-Google-Original-From: Yury Norov <ynorov@marvell.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Arnd Bergmann <arnd@arndb.de>,
        Kees Cook <keescook@chromium.org>,
        Matthew Wilcox <willy@infradead.org>,
        Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Cc:     Yury Norov <ynorov@marvell.com>, Yury Norov <yury.norov@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/6] bitmap_parselist: don't calculate length of the input string
Date:   Tue, 26 Mar 2019 00:07:43 +0300
Message-Id: <20190325210748.6571-2-ynorov@marvell.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190325210748.6571-1-ynorov@marvell.com>
References: <20190325210748.6571-1-ynorov@marvell.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

bitmap_parselist() calculates length of the input string before passing
it to the __bitmap_parselist(). But the end-of-line condition is checked
for every character in __bitmap_parselist() anyway. So doing it in wrapper
is a simple waste of time.

Signed-off-by: Yury Norov <ynorov@marvell.com>
---
 lib/bitmap.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/lib/bitmap.c b/lib/bitmap.c
index 98872e9025da..ad1fb7e6ad0e 100644
--- a/lib/bitmap.c
+++ b/lib/bitmap.c
@@ -614,10 +614,7 @@ static int __bitmap_parselist(const char *buf, unsigned int buflen,
 
 int bitmap_parselist(const char *bp, unsigned long *maskp, int nmaskbits)
 {
-	char *nl  = strchrnul(bp, '\n');
-	int len = nl - bp;
-
-	return __bitmap_parselist(bp, len, 0, maskp, nmaskbits);
+	return __bitmap_parselist(bp, UINT_MAX, 0, maskp, nmaskbits);
 }
 EXPORT_SYMBOL(bitmap_parselist);
 
-- 
2.17.1

