Return-Path: <SRS0=0OOB=TB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9337C43219
	for <linux-kernel@archiver.kernel.org>; Wed,  1 May 2019 01:07:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 791FA21743
	for <linux-kernel@archiver.kernel.org>; Wed,  1 May 2019 01:07:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZXTk/v/E"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727651AbfEABHH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Apr 2019 21:07:07 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:33840 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727546AbfEABGz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Apr 2019 21:06:55 -0400
Received: by mail-pg1-f193.google.com with SMTP id c13so6688108pgt.1
        for <linux-kernel@vger.kernel.org>; Tue, 30 Apr 2019 18:06:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=wExpGLZKhNx1VZ7ZHIX8KvYhTnTsNmRUJIKjaZd8NgY=;
        b=ZXTk/v/EIJcWUtjDjiyZR515Mh7HvC4u30UhGbmvZFNlhaawH9vafqkDOs6D+Fenf0
         7h4Xm+RH9dBrEcwqeDiSzTpAA5/N8NwBTCrzCxxwHS85PcbRMT270XsX9MkOHokjcD4g
         EsUqTQ7KueXKEHPNZBlHvpSedfVxbgjSgi6SH7zZfwMQfEwbGYwfSV60fcs9S2hva69F
         h7/nbAty7yPUfaO7jI9n2/NFWZ8E09fFda7Ug0C9lfADVrwufF9r83ud8hzmU2cDHuh4
         /B20eOhAXU84HvIYLWfUUHCuNQ1WofhM7PbQEHcZrm1Nx7qLuoAvXH24HWhxZeCCadFe
         cY9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=wExpGLZKhNx1VZ7ZHIX8KvYhTnTsNmRUJIKjaZd8NgY=;
        b=muQhbw92FgibajkfWjLFMln9u9yFGxLAzf7ka41CgOf7Vf8TYzNxXKhCHjSx1ABtDZ
         LQ6Ly894g86IvubNXmn55T3DHXpv26T9Nl2xoY6f5IX/KFSmbziFsz/cSX+fhi0nIpvf
         n4+fzqlVfvAi/opimWG6NqUdwYpsDw15+VC2kgny9JqybDCWmWV0kmcBe0aSSO8RXCS4
         VGPdiT2ah+fxDwAZ9FfOkxWiEB0H4DttwG1cXw8OKj6KjU6ZC98MuscUNkjlfqhXDbsW
         FAcNhiXq0IdCTCeGjL2voFNK6WzaG1KToTujMkSG2pYv+SufXkZnwQWDGyC/B5VBbmoR
         GElg==
X-Gm-Message-State: APjAAAVh+OJUzhPL4WMdtNZtwS2Bta/J43LJfI9voSJUmhX8ntIv0DOj
        EmF/xCf9171jHVzs5y0SFN8=
X-Google-Smtp-Source: APXvYqydtY+NEielE5bVNgrQGXpnejzDqwg3eqMik0zPFkU8p2EumiUX5157oUH8xqsSL1l0W4CMQw==
X-Received: by 2002:a65:62c3:: with SMTP id m3mr44211937pgv.159.1556672814554;
        Tue, 30 Apr 2019 18:06:54 -0700 (PDT)
Received: from localhost ([2601:640:7:332f:bc53:6e04:b584:e900])
        by smtp.gmail.com with ESMTPSA id y8sm46334731pgk.20.2019.04.30.18.06.53
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 30 Apr 2019 18:06:54 -0700 (PDT)
From:   Yury Norov <yury.norov@gmail.com>
X-Google-Original-From: Yury Norov <ynorov@marvell.com>
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
Cc:     Yury Norov <ynorov@marvell.com>, Yury Norov <yury.norov@gmail.com>,
        Jens Axboe <axboe@kernel.dk>,
        Steffen Klassert <steffen.klassert@secunet.com>
Subject: [PATCH 6/7] lib: new testcases for bitmap_parse{_user}
Date:   Tue, 30 Apr 2019 18:06:35 -0700
Message-Id: <20190501010636.30595-7-ynorov@marvell.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190501010636.30595-1-ynorov@marvell.com>
References: <20190501010636.30595-1-ynorov@marvell.com>
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

Signed-off-by: Yury Norov <ynorov@marvell.com>
---
 lib/test_bitmap.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/lib/test_bitmap.c b/lib/test_bitmap.c
index 731e107d811a..9e6b87895108 100644
--- a/lib/test_bitmap.c
+++ b/lib/test_bitmap.c
@@ -343,14 +343,22 @@ static const unsigned long parse_test2[] __initconst = {
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
2.17.1

