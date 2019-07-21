Return-Path: <SRS0=KmSF=VS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 285BCC76191
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Jul 2019 21:29:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F124F21743
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Jul 2019 21:28:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LNxv8NfT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727233AbfGUV26 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 21 Jul 2019 17:28:58 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:37719 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726981AbfGUV2m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Jul 2019 17:28:42 -0400
Received: by mail-pg1-f196.google.com with SMTP id i70so5920980pgd.4
        for <linux-kernel@vger.kernel.org>; Sun, 21 Jul 2019 14:28:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=h1lAoIGMEmg1SmYdgcH8enSteTGZOeyVaONxBQc1srM=;
        b=LNxv8NfTQ9tJ2P/+uvOb3saxettugiprX3jM1F2J5ZFenuS2Hz7skylNDmsldI3ETI
         451udWxKEpha6SlayOZum3TGQ/PXgmSRgZ2KpEtwISkwO0YjhEzGYnd61k8+oKO9i3b3
         fuPAQNgTZswpLzFEE5Vlt6cu/ulq3l6tTwKikm6US+MqniNONDmn22fBi6iALxO/DnmP
         tsj/Hs4sOnpJJteSvgB2uNm6o2Vgc19Whz3tQCmmG0CdMDAuceMwnIaShBWPwYJFEkeg
         nJr8IQglYr/QBHXMq1QsvL30GUGiNN40l80yWKgkP+8uFZgv9/yX19gGQpRgx8NHlvNY
         8o7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=h1lAoIGMEmg1SmYdgcH8enSteTGZOeyVaONxBQc1srM=;
        b=ZWrwU4E+owb4hZawMpQIz6HkfOFXUgSj/wtpxGLoIDwo8FfeEFj6FXORZSidAT/gaU
         46cOm7P8xl54bVV5d4sK/v+ratvKw+u5tPvQx2TVzv/9JqRudr5YErmBpL5XgJPxgsPJ
         dIrBb88QiFlPSpmgMxbXLg125g2YJ9r4Ogi+e2zeIFVAnTdl1iBeiC6tUSaDlmgQ0FwI
         Xj8gijg7VLyYSPS1RH+0Qfcek2Ct5ON9xYQgBmuX7Kf3n+ZYLqFEn/5Q3Omy+lZuMH3L
         1osK24FMegtrgZfZoJhRrd3YlZAbngsVptPN+rVZ66ifujnmyZayw0Oww49H8LKGLmYU
         GZbA==
X-Gm-Message-State: APjAAAX/Oieb9RA7iuNVFCkkOzBcHv0dDEkmLJSFVd1nApERRbzg/LtE
        knzmo05GeQcQTSL/5K6ruV8=
X-Google-Smtp-Source: APXvYqxadyXLONMT5MqN95a3X4wtEGwDb5OA/CmTRZVv6gCdzmLEtOHYK+F2yDF/ylAhcp0hIAc1qA==
X-Received: by 2002:a65:4189:: with SMTP id a9mr41904923pgq.399.1563744521934;
        Sun, 21 Jul 2019 14:28:41 -0700 (PDT)
Received: from localhost.localdomain ([2601:640:105:2ef8:a909:5e8d:6363:7009])
        by smtp.gmail.com with ESMTPSA id t9sm37970510pji.18.2019.07.21.14.28.40
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Sun, 21 Jul 2019 14:28:41 -0700 (PDT)
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
Cc:     Yury Norov <yury.norov@gmail.com>, Yury Norov <ynorov@marvell.com>,
        Jens Axboe <axboe@kernel.dk>,
        Steffen Klassert <steffen.klassert@secunet.com>
Subject: [PATCH 6/7] lib: new testcases for bitmap_parse{_user}
Date:   Sun, 21 Jul 2019 14:27:52 -0700
Message-Id: <20190721212753.3287-7-yury.norov@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190721212753.3287-1-yury.norov@gmail.com>
References: <20190721212753.3287-1-yury.norov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From Yury Norov <ynorov@marvell.com>

New version of bitmap_parse() is unified with bitmap_parse_list(),
and therefore:
 - weakens rules on whitespaces and commas between hex chunks;
 - in addition to \0 allows using \n as the line ending symbol;
 - allows passing UINT_MAX or any other big number as the length
   of input string instead of actual string length.

The patch covers the cases.

Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Yury Norov <ynorov@marvell.com>
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

