Return-Path: <SRS0=WmnE=2X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6401AC2D0C2
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jan 2020 18:27:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 31C1021655
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jan 2020 18:27:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KpLh9CYV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728153AbgABS1I (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Jan 2020 13:27:08 -0500
Received: from mail-qk1-f196.google.com ([209.85.222.196]:45846 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727829AbgABS1I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jan 2020 13:27:08 -0500
Received: by mail-qk1-f196.google.com with SMTP id x1so31973428qkl.12
        for <linux-kernel@vger.kernel.org>; Thu, 02 Jan 2020 10:27:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=xoZom4dvPhH0lSN9HoTINswBq8kGqxa7WqVa6AF9rc4=;
        b=KpLh9CYV3aLwPiZGakdC6gcd8MaoEEi/hyfaAQ8kkWAbuweRKOk0kPst+5NHzmAFNM
         r/Ebn33C9oVfRODRGangLinbPEVQPT1XAOINxn1+zaTazPXGw9M8JS0zP99hVZCg+HAW
         Ojl1UC1ajse1xHp49VEKiq5nVVxTRaPi2Ur0aILgzvyOyQ4iqxgWeZu5XguvUDyXON/g
         yvFurGwNLNp7Xk/qQ13OO4nwBQe2bEkAeOP1dv9MgGSRr0Wsp56NNj+5mn7Q/8l4paqv
         obNvb20FDcvaS/mGciSy1NujN1Mi8kheZRcTszxzBG1aTe7BSftUNqKpBAuyL3jkdWon
         x/pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=xoZom4dvPhH0lSN9HoTINswBq8kGqxa7WqVa6AF9rc4=;
        b=aD8QIyLYgQKBO8JC8JOVSEqxIv/LZp6Pw7Y7Vsq47jyhgRMoc4bs+ObaNAVxjtG4Sc
         u3sBbOwkozVN+BOHMgRnNZnhr6Djazovic6eCuQsaOh2AVuM0OJqio5hI0OJDOslpMk0
         tibK9XvmdHtmDkxCmxIvGc1cx1H1atXE6RnEAc7gUuWfSy5BisCPgNuEO/hapdm7Xv+u
         qy28dCjV29xOF/ohGYg8ZJd1ILEwoKVARcW9PgWCHoZUuq4cg0z5AaRUR8V4kJpyfnlx
         5gv0cMtVKjmbz/vewekunb4FvTPlkBo8FSHI+Ch0TacM4SdRNT0+osX9Mcn0n41oa/L5
         vRNg==
X-Gm-Message-State: APjAAAVf+ixqaOqbJ5Z79WrRDyj10LsGL1w48Tvl+t2WXdTBI1pAe8iV
        XW3hTk4hw9BG9XbgEmOgsyY=
X-Google-Smtp-Source: APXvYqzeEdh9okhXzsiguZ0jeG9Cdo35/ie5OfwW/KBQmtCBqcG2zWICghWKPNSzu6o54qFD1tZWbQ==
X-Received: by 2002:ae9:e649:: with SMTP id x9mr64197782qkl.405.1577989627137;
        Thu, 02 Jan 2020 10:27:07 -0800 (PST)
Received: from yury-thinkpad.dhcp.amer.jpmchase.net ([2604:2000:4185:2300:b196:4884:e960:2cb8])
        by smtp.gmail.com with ESMTPSA id 184sm15312599qke.73.2020.01.02.10.27.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Jan 2020 10:27:06 -0800 (PST)
From:   Yury Norov <yury.norov@gmail.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        "David S . Miller" <davem@davemloft.net>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Amritha Nambiar <amritha.nambiar@intel.com>,
        Willem de Bruijn <willemb@google.com>,
        Kees Cook <keescook@chromium.org>,
        Matthew Wilcox <willy@infradead.org>,
        "Tobin C . Harding" <tobin@kernel.org>,
        Will Deacon <will.deacon@arm.com>,
        Miklos Szeredi <mszeredi@redhat.com>,
        Vineet Gupta <vineet.gupta1@synopsys.com>,
        Chris Wilson <chris@chris-wilson.co.uk>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        linux-kernel@vger.kernel.org
Cc:     Yury Norov <yury.norov@gmail.com>, Jens Axboe <axboe@kernel.dk>,
        Steffen Klassert <steffen.klassert@secunet.com>
Subject: [PATCH] fix rebase issue
Date:   Thu,  2 Jan 2020 10:26:59 -0800
Message-Id: <20200102182659.6685-1-yury.norov@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200102043031.30357-4-yury.norov@gmail.com>
References: 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Yury Norov <yury.norov@gmail.com>
---
 lib/test_bitmap.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/test_bitmap.c b/lib/test_bitmap.c
index 830c9b195e405..a4ecf6f04a5be 100644
--- a/lib/test_bitmap.c
+++ b/lib/test_bitmap.c
@@ -349,7 +349,6 @@ static const struct test_bitmap_parselist parselist_tests[] __initconst = {
 	{-EINVAL, "0-31:a/1", NULL, 8, 0},
 	{-EINVAL, "0-\n", NULL, 8, 0},
 
-#undef step
 };
 
 static void __init __test_bitmap_parselist(int is_user)
@@ -430,6 +429,7 @@ static const struct test_bitmap_parselist parse_tests[] __initconst = {
 	{-EOVERFLOW, "badf00d,deadbeef,1,0",	NULL, 90, 0},
 	{-EOVERFLOW, "fbadf00d,deadbeef,1,0",	NULL, 95, 0},
 	{-EOVERFLOW, "badf00d,deadbeef,1,0",	NULL, 100, 0},
+#undef step
 };
 
 static void __init __test_bitmap_parse(int is_user)
-- 
2.20.1

