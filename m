Return-Path: <SRS0=zSVa=VM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC8D6C7618F
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jul 2019 20:12:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A44292171F
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jul 2019 20:12:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rq4w0oXP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732441AbfGOUMy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jul 2019 16:12:54 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:36381 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732287AbfGOUMu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jul 2019 16:12:50 -0400
Received: by mail-pf1-f195.google.com with SMTP id r7so7942640pfl.3;
        Mon, 15 Jul 2019 13:12:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0Ti3vKrPw6fMZdayISTTnJ8tLgl7jwdarVcpue/8npQ=;
        b=rq4w0oXP0yilo69hxgkjEo84Ctc6II9yrsgPI6oFG8zrG0RyFQuADTqv/H1aREK5jX
         ewXvO9Nz605E6mbqwD71eAawebV3RQ9brbNqGgmV5mEYAmJ/fEu37IAplbbtvQCxe/Tv
         Hzw4DF4HLzlK+azqHA0ICpcGPk9gONGsagDRzJLlDeoO6zp8tIQZwdZBKO/zfxaHqBvH
         /ce7tnN5Qu8YkbiMPQSZdZTjrkbrIxbGk6YqG5DjQB6+dC+bJysLYz665hHAy05ttYaR
         VSYfazR2eDsw+u3y8+sPHPPlxdw+nORfUXZM5ZlaDU3nBpnMMg14+Rm+VoDEeQ3x4zSZ
         /OcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0Ti3vKrPw6fMZdayISTTnJ8tLgl7jwdarVcpue/8npQ=;
        b=Pvdu6Ptz8SqX24ZUVwGckK4IK/srZa6GxCygcpxeHnwr5Cj3h9zzdfw0FaCaRF1iH1
         MG/aKN+pacT4tXIbitUurHH3B0JjOt/Z4mgHd5/H6kAkDI/RrolnGKzc+wp5Ub0F1mBw
         AsrD0N/a7FSSBklWUAwRWns/5nz4L1Qy+BMPfCfPyUzKPEQus13WeZP4dHDKy9Ub+kye
         U0ERGKhgj218GXXDiKPWnB6zewKytfn3vpS/UA8u7WwWKyMkczROseV+fcnkg1ER+rbU
         Mca862VxYI0sYdMCOA7x+S1pEsZKmlc3LjVUZ369lxWHrqJ3zwkODbawnDcfYN0qFanJ
         A0kA==
X-Gm-Message-State: APjAAAVip75eMSIzHWYMzP/C/dvK3MBTAXxYEQzkm2BkJ0gSJoypjMWl
        R1Pi2ppGgCTz0vKBU2Zn9MPn9a4o
X-Google-Smtp-Source: APXvYqys2P9qBCvFBDT6gKiu05SBVldEmqbzM8SpppFTMP3Kp7DqVQP4w/V3EUWFGEp/pC7ikcuKoQ==
X-Received: by 2002:a17:90a:b903:: with SMTP id p3mr30811850pjr.79.1563221569163;
        Mon, 15 Jul 2019 13:12:49 -0700 (PDT)
Received: from localhost.lan (c-67-185-54-80.hsd1.wa.comcast.net. [67.185.54.80])
        by smtp.gmail.com with ESMTPSA id d21sm7327783pgm.75.2019.07.15.13.12.47
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 15 Jul 2019 13:12:48 -0700 (PDT)
From:   Andrey Smirnov <andrew.smirnov@gmail.com>
To:     linux-clk@vger.kernel.org
Cc:     Andrey Smirnov <andrew.smirnov@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        Chris Healy <cphealy@gmail.com>, linux-kernel@vger.kernel.org
Subject: [PATCH 3/6] clk: Constify second argument of clk_bulk_prepare_enable()
Date:   Mon, 15 Jul 2019 13:12:31 -0700
Message-Id: <20190715201234.13556-3-andrew.smirnov@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190715201234.13556-1-andrew.smirnov@gmail.com>
References: <20190715201234.13556-1-andrew.smirnov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Both clk_bulk_prepare() and clk_bulk_enable() take const struct
clk_bulk_data, so change clk_bulk_prepare_enable() to do so as
well. No functional change intended.

Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
Cc: Russell King <linux@armlinux.org.uk>
Cc: Chris Healy <cphealy@gmail.com>
Cc: linux-clk@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
---
 include/linux/clk.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/linux/clk.h b/include/linux/clk.h
index 8af6b943bb9a..fafa63ea06b9 100644
--- a/include/linux/clk.h
+++ b/include/linux/clk.h
@@ -919,8 +919,8 @@ static inline void clk_disable_unprepare(struct clk *clk)
 	clk_unprepare(clk);
 }
 
-static inline int __must_check clk_bulk_prepare_enable(int num_clks,
-					struct clk_bulk_data *clks)
+static inline int __must_check
+clk_bulk_prepare_enable(int num_clks, const struct clk_bulk_data *clks)
 {
 	int ret;
 
-- 
2.21.0

