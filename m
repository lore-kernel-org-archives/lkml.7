Return-Path: <SRS0=CEgE=VT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B8FEC76188
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 07:14:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D184022305
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 07:14:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PP0eSpGL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727594AbfGVHO1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jul 2019 03:14:27 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:43668 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725773AbfGVHO1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jul 2019 03:14:27 -0400
Received: by mail-pf1-f194.google.com with SMTP id i189so16933516pfg.10
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jul 2019 00:14:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=rKKwPKQ9nSH1uCbjpYY0QdQfAXfR9yy6okm4F8X7Kfk=;
        b=PP0eSpGL9fJvYulXJ4voZq4Jh7vxlXxo8EL8ugM+R/prryBtWxNwVsTCyjZLqnSAgQ
         /yyZ7O8UA5ScPZgjwDejQ/Yi0WSW6DkAl9fJLgeDXEBOCV0skgYrmsI0WmduD2xClwVw
         krvoRSVZXy975cfdfS7S7STa/dD6nk4tUg0QSqA0ejwJ+mSVTARL+BwLWadmie6HaUKR
         I7kBAxl70FYkvuwxVHT69BbMGtRgFiAFoVB2uNnGZkcA7yB5Li8kobWOj2HD9Plb5uT0
         TKHUCDqEvI1WNiBAwiGTrO5mMhKs7bYFdb/f0Vjq3ytn16P6AVk4+Ox7fruON+gvujrZ
         h8nA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=rKKwPKQ9nSH1uCbjpYY0QdQfAXfR9yy6okm4F8X7Kfk=;
        b=rd5yepKoIU64pB3CZ1RH4fBHtem9QepzksY+aGa08m3bFYXCfPHmLSHGa6RZ0WnEhi
         6+1fu1A8pq//+DQBOEXCOYgTG1WmHcxoTsIUOUzuKJwM2S6kzpSajlUIz8IrvBZaSoIu
         HtdfUUJtEMhqpH69XJ+GQAqDiEaNRuFabWZJUKjpNbXjsVnX9TdeAFWl2iJr3K650xKc
         NKmm1VB8yNM8bSBQyds/uQg7/rYPPhLDzsNhYER6j1Gl16/80CWNsYuuGXpEqL92otgQ
         BCkwNtrsPafeo9UAqu/7idAX3H/p7a/x3bnhw2Q1gDB2YSieR+zCp6YjUP6m4xCEC7aM
         aSqA==
X-Gm-Message-State: APjAAAVMyWETW/NkDwxz+5/y1zFhm10y5oswOU8JtaF48UFKeRTfa5zQ
        pMKJSKHSc2tXALtt2fHrKNo=
X-Google-Smtp-Source: APXvYqxR6M9vTipkk84zlF3VH62Hs3fFypm9ayC0zj9LFqagpkrYFOqMSV+EYgBVLAjN5A6aykTdBQ==
X-Received: by 2002:a63:5d45:: with SMTP id o5mr70953105pgm.40.1563779666597;
        Mon, 22 Jul 2019 00:14:26 -0700 (PDT)
Received: from ubt.spreadtrum.com ([117.18.48.82])
        by smtp.gmail.com with ESMTPSA id 195sm61983642pfu.75.2019.07.22.00.14.23
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 22 Jul 2019 00:14:25 -0700 (PDT)
From:   Chunyan Zhang <zhang.lyra@gmail.com>
To:     Russell King <linux@armlinux.org.uk>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Chunyan Zhang <zhang.lyra@gmail.com>,
        Lvqiang Huang <lvqiang.huang@unisoc.com>
Subject: [PATCH] ARM: check stmfd instruction using right shift
Date:   Mon, 22 Jul 2019 15:14:19 +0800
Message-Id: <20190722071419.22535-1-zhang.lyra@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190722071122.22434-1-zhang.lyra@gmail.com>
References: <20190722071122.22434-1-zhang.lyra@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lvqiang Huang <Lvqiang.Huang@unisoc.com>

In the commit ef41b5c92498 ("ARM: make kernel oops easier to read"),
-               .word   0xe92d0000 >> 10        @ stmfd sp!, {}
+               .word   0xe92d0000 >> 11        @ stmfd sp!, {}
then the shift need to change to 11.

Fixes: ef41b5c92498 ("ARM: make kernel oops easier to read")
Signed-off-by: Lvqiang Huang <Lvqiang.Huang@unisoc.com>
Signed-off-by: Chunyan Zhang <zhang.lyra@gmail.com>
---
 arch/arm/lib/backtrace.S |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/lib/backtrace.S b/arch/arm/lib/backtrace.S
index 7d7952e..926851b 100644
--- a/arch/arm/lib/backtrace.S
+++ b/arch/arm/lib/backtrace.S
@@ -70,7 +70,7 @@ for_each_frame:	tst	frame, mask		@ Check for address exceptions
 
 1003:		ldr	r2, [sv_pc, #-4]	@ if stmfd sp!, {args} exists,
 		ldr	r3, .Ldsi+4		@ adjust saved 'pc' back one
-		teq	r3, r2, lsr #10		@ instruction
+		teq	r3, r2, lsr #11		@ instruction
 		subne	r0, sv_pc, #4		@ allow for mov
 		subeq	r0, sv_pc, #8		@ allow for mov + stmia
 
-- 
1.7.9.5

