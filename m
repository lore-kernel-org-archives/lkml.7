Return-Path: <SRS0=hqT0=XE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4FC0C00307
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Sep 2019 03:33:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B937B2196F
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Sep 2019 03:33:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WerlIcoX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387763AbfIIDdY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 8 Sep 2019 23:33:24 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:47035 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387699AbfIIDdU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Sep 2019 23:33:20 -0400
Received: by mail-lj1-f196.google.com with SMTP id e17so11170777ljf.13
        for <linux-kernel@vger.kernel.org>; Sun, 08 Sep 2019 20:33:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=tqN3jUke6BGW8jpzgHpCXDgGvZkNIQQ47RvUhyDeqZY=;
        b=WerlIcoXbLVbvsb5D8VM2jlKo1HM2rn8A2/46xONEGXPnbSY80ANTwLKr4ON0amdRm
         c8GH1mwUV0acNZyH1//T3IxViADZAtSioNEtsho701+/rRtSJSkLFoogWhJsRW8398R+
         /r3qDoj3h9t6s/pzGwSnxqDqYmrrgLEWqubB2fhW93Lu/KqmkWt2T8ogyR6EsPHguWaA
         PY9xv/+d1lt+K9CMywfQyaK3hT9AuzW4N6iz9pJhCk1zdKY4ZRzEXRTQpFoHwq8otp1e
         YamHpbfaFBi+UMxxOYXacajvD95D0XSQCgWzYcWkyAVQv0qG2emU0AZoY4ZtGzxRQkl4
         yBkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=tqN3jUke6BGW8jpzgHpCXDgGvZkNIQQ47RvUhyDeqZY=;
        b=sdmxFpSB0KJWNMnrwscgNiQA6ih37FsAwTRrsVh3x6ACXBfqylEbj3AwArE8PAlQ0l
         Xl1TJgHEFuyK8xtqYb84r8T/85ezcIHxoNERvmWhQ2jHWqz88D172h/XYtQx7Bi9Km5V
         RAN6MX3zLX0ppTfA1ggn8VpzTsXp5lH41gXuxlRbW3ejPihPG2k/GPR/sxMUt6nzk9R9
         PRv15zcvC1nyvoNqrNT26A7p0jCTaH0eO+sd6uSLASC726a+74V0MF+vun+2nPusmARL
         C2WqDtpTP3mvS9oz6M/dmj+DmBa+3wx1u4b456OeP/05uArRvGDXZgS9iWbcaYgC5frQ
         2f2g==
X-Gm-Message-State: APjAAAXqBM2xoBD2DGNUcFZP0zDpfQvV3tRKK1tYRGMZMf0gGkLigf5E
        7iRY4wXlJrPLYFCzqVh5ojA=
X-Google-Smtp-Source: APXvYqw3YAW92AjXskirId4rAdX1DpgPVc76C1uDheEq3Mtb2Yt4skrPpROjyT5Mxgl4G7nBfV8Slg==
X-Received: by 2002:a05:651c:282:: with SMTP id b2mr13777080ljo.50.1567999998696;
        Sun, 08 Sep 2019 20:33:18 -0700 (PDT)
Received: from localhost.localdomain (128-73-37-85.broadband.corbina.ru. [128.73.37.85])
        by smtp.gmail.com with ESMTPSA id f22sm2783605lfk.56.2019.09.08.20.33.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Sep 2019 20:33:18 -0700 (PDT)
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
Subject: [PATCH 6/7] lib: new testcases for bitmap_parse{_user}
Date:   Sun,  8 Sep 2019 20:30:20 -0700
Message-Id: <20190909033021.11600-7-yury.norov@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190909033021.11600-1-yury.norov@gmail.com>
References: <20190909033021.11600-1-yury.norov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

New version of bitmap_parse() is unified with bitmap_parse_list(),
and therefore:
 - weakens rules on whitespaces and commas between hex chunks;
 - in addition to \0 allows using \n as the line ending symbol;
 - allows passing UINT_MAX or any other big number as the length
   of input string instead of actual string length.

The patch covers the cases.

Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Yury Norov <yury.norov@gmail.com>
---
 lib/test_bitmap.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/lib/test_bitmap.c b/lib/test_bitmap.c
index e306d3da12019..d9fe7c89e6a94 100644
--- a/lib/test_bitmap.c
+++ b/lib/test_bitmap.c
@@ -344,14 +344,22 @@ static const unsigned long parse_test2[] __initconst = {
 };
 
 static const struct test_bitmap_parselist parse_tests[] __initconst = {
+	{0, "",				&parse_test[0 * step], 32, 0},
+	{0, " ",			&parse_test[0 * step], 32, 0},
 	{0, "0",			&parse_test[0 * step], 32, 0},
+	{0, "0\n",			&parse_test[0 * step], 32, 0},
 	{0, "1",			&parse_test[1 * step], 32, 0},
 	{0, "deadbeef",			&parse_test[2 * step], 32, 0},
 	{0, "1,0",			&parse_test[3 * step], 33, 0},
+	{0, "deadbeef,\n,0,1",		&parse_test[2 * step], 96, 0},
 
 	{0, "deadbeef,1,0",		&parse_test2[0 * 2 * step], 96, 0},
 	{0, "baadf00d,deadbeef,1,0",	&parse_test2[1 * 2 * step], 128, 0},
 	{0, "badf00d,deadbeef,1,0",	&parse_test2[2 * 2 * step], 124, 0},
+	{0, "badf00d,deadbeef,1,0",	&parse_test2[2 * 2 * step], 124, NO_LEN},
+	{0, "  badf00d,deadbeef,1,0  ",	&parse_test2[2 * 2 * step], 124, 0},
+	{0, " , badf00d,deadbeef,1,0 , ",	&parse_test2[2 * 2 * step], 124, 0},
+	{0, " , badf00d, ,, ,,deadbeef,1,0 , ",	&parse_test2[2 * 2 * step], 124, 0},
 
 	{-EINVAL,    "goodfood,deadbeef,1,0",	NULL, 128, 0},
 	{-EOVERFLOW, "3,0",			NULL, 33, 0},
-- 
2.20.1

