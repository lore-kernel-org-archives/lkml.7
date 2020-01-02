Return-Path: <SRS0=WmnE=2X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00B05C2D0DD
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jan 2020 04:31:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C964621734
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jan 2020 04:31:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rX61RXPG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727674AbgABEb1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Jan 2020 23:31:27 -0500
Received: from mail-qk1-f195.google.com ([209.85.222.195]:45302 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727741AbgABEbU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jan 2020 23:31:20 -0500
Received: by mail-qk1-f195.google.com with SMTP id x1so30577588qkl.12
        for <linux-kernel@vger.kernel.org>; Wed, 01 Jan 2020 20:31:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=8yle5SGT2LD8EPGS4O93IAzsD2MIvygf12/flk+DQCQ=;
        b=rX61RXPGBTCZxmJLV+CXp5tMUXb/AB3GBIjTf7InZxDZaQsofQO2fCvJ9YBjUmQYKu
         JldBaF/DW0IIXCt9+ViHWvoNams5n755ziWMXGxJ46sU8xF9VVTHROTGGX65efHV345y
         Z93pPyqSXAaBK/sSdIbkZJNGQ33snj7vyFcAHP/uGvRN7aGNqkFpefXTMI5CUrlhP6od
         C8t86dxLViFbjbDdR+RJ7gFp4fbDRgwvau7eH7DV/SoAjbD5O4/KG94f8YWsJZVBB2Qk
         EgOD4LBTlwvDAI+zPF/N2Wg3JX4w6HnNvWH/lDqBi9eXM8QtHW+z0olyS4Vu7qN7+ib3
         LIZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8yle5SGT2LD8EPGS4O93IAzsD2MIvygf12/flk+DQCQ=;
        b=asDyKpary3gNibNg7wuCAAdnv8lyEn0xjYDu3sc7CbKmw3YP06ZdYfhLF3A9OPstU3
         CsWjlZxRWQSNfQMBhvvbopUBjq0goqt/uoKJbSulszBZ0q/d47xTo2gbZ3RmN0Xvxlvs
         SFUN0+AbW8PqChm9nAywqDckKiSarkAkUMDwnQBEZFhhJgjj+CEONbsHY53RiuCtV3XB
         jGGWpW28qIL++wYTe5gUygwa2/BIPRtclDRDEH1vGow4Wrz8ZDVNexeMl7brG2sM9bLx
         KivOD347jDPuKLyxmtjd1Kp53/r3a1S+hgR8qulD2VGaZXzjyGleqolbNP/OUT1s29f+
         nFtg==
X-Gm-Message-State: APjAAAUfWSoPElalHaOzIxVVyoQ2Qh1LIoXaLF49F13SLFjbQtExRMFs
        W6Drc1LBL0wgeGGyu8wku3c=
X-Google-Smtp-Source: APXvYqy9lFMtn+6Qy59YIGby0n7GWWHxTBTmNYV4w/XsS3+y2SQ6Bj+mnign1qI1MSncAjI9A3dNyg==
X-Received: by 2002:a05:620a:b04:: with SMTP id t4mr66854077qkg.7.1577939479179;
        Wed, 01 Jan 2020 20:31:19 -0800 (PST)
Received: from yury-thinkpad.dhcp.amer.jpmchase.net ([2604:2000:4185:2300:b196:4884:e960:2cb8])
        by smtp.gmail.com with ESMTPSA id 16sm14876857qkj.77.2020.01.01.20.31.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Jan 2020 20:31:18 -0800 (PST)
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
Date:   Wed,  1 Jan 2020 20:30:30 -0800
Message-Id: <20200102043031.30357-7-yury.norov@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200102043031.30357-1-yury.norov@gmail.com>
References: <20200102043031.30357-1-yury.norov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From Yury Norov <yury.norov@gmail.com>

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
index 830c9b195e405..fb4ffb88a8160 100644
--- a/lib/test_bitmap.c
+++ b/lib/test_bitmap.c
@@ -415,14 +415,22 @@ static const unsigned long parse_test2[] __initconst = {
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

