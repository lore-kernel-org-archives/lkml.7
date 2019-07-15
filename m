Return-Path: <SRS0=zSVa=VM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2954CC7618F
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jul 2019 20:12:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F2BBE2171F
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jul 2019 20:12:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lwr/TN3g"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732372AbfGOUMy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jul 2019 16:12:54 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:39845 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732101AbfGOUMv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jul 2019 16:12:51 -0400
Received: by mail-pg1-f196.google.com with SMTP id u17so8242360pgi.6;
        Mon, 15 Jul 2019 13:12:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=gD+CSHmbXTuo7zYwij9NuKnefs9nMb0BCJwuTq+GjOE=;
        b=lwr/TN3g0mpILHpAXP2GhKXEBlNGyVTGRl0qbyiAtw+phokxusOHpSrZHt1ekrWxDw
         BwIu6fqQMuufIPA+Plq9F8X65ZQq/wsdLZxgZ89PHK4xFiTJrJV60jT7ckWMsb6xFmHH
         dK/OgTlWCT87D1BN7rPDjAx007MJ2ybgrLOQJCpU2SpCDemEBlO1Mh+n5LUndrjBuuJp
         Opvk1klUdyYM0bCZ+1Wo+QU8WBgcedKwa3P2UHf00Ryy32h5unoVISU83ihBOvH7gyok
         NSkxG437NZNPljX3h9M4Fdo8kknXqF3QlVayT6FSw2Tjz3WJjw8OZGe3PEYwnAoKyGip
         2OXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gD+CSHmbXTuo7zYwij9NuKnefs9nMb0BCJwuTq+GjOE=;
        b=Qv7rPQk+HKuoCLwM2AYMqM9pnuoELDI5yVJlktc+wgqd5Wh87bQivMzKB80GeBO39p
         sIzkK/Y2LvAjTyfNDJuVQ2mK+PlvL04tuUCmXnXzThOc1yYQ8K3ePk0ekrNYUA3s3BLC
         XsqLKBv23p9SdpckJLFKRS/DgAB6ak9QIubjXd4LZySlisjllozWLvLWYYjc3iXnJMuC
         mBdeRjYbv0aaJqUMeBXEgOJWec+W6Su1o991XWVruHGh4GYgVR81HKt7uZHIpDcRX1dM
         uEod6iAaTMwW7z62avYqYAS3ha52MqipI32e+KTDfWvj9xrEHkmysOuBkrW+I1UIerrt
         bWow==
X-Gm-Message-State: APjAAAWrIWQ6E5MgE6WgCcarr2kZS2O15SwbU/tIK8zD7Lf3uZuSco6x
        EIZuHfuREBbPFxhKCbXBZm225pqT
X-Google-Smtp-Source: APXvYqyqsEXhuac6p4IjlkMf7qEFu3xC574kbkutAh6Kf1U57ZeBwPilQN2eikLmgfB5XgTfNwX3vg==
X-Received: by 2002:a63:231c:: with SMTP id j28mr2119083pgj.430.1563221570614;
        Mon, 15 Jul 2019 13:12:50 -0700 (PDT)
Received: from localhost.lan (c-67-185-54-80.hsd1.wa.comcast.net. [67.185.54.80])
        by smtp.gmail.com with ESMTPSA id d21sm7327783pgm.75.2019.07.15.13.12.49
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 15 Jul 2019 13:12:49 -0700 (PDT)
From:   Andrey Smirnov <andrew.smirnov@gmail.com>
To:     linux-clk@vger.kernel.org
Cc:     Andrey Smirnov <andrew.smirnov@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        Chris Healy <cphealy@gmail.com>, linux-kernel@vger.kernel.org
Subject: [PATCH 4/6] clk: Sync prototypes for clk_bulk_disable()
Date:   Mon, 15 Jul 2019 13:12:32 -0700
Message-Id: <20190715201234.13556-4-andrew.smirnov@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190715201234.13556-1-andrew.smirnov@gmail.com>
References: <20190715201234.13556-1-andrew.smirnov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

No-op version of clk_bulk_disable() should have the same protoype as
the real implementation, so constify the last argument to make it so.

Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
Cc: Russell King <linux@armlinux.org.uk>
Cc: Chris Healy <cphealy@gmail.com>
Cc: linux-clk@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
---
 include/linux/clk.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/clk.h b/include/linux/clk.h
index fafa63ea06b9..2d3f2a55795a 100644
--- a/include/linux/clk.h
+++ b/include/linux/clk.h
@@ -830,7 +830,7 @@ static inline void clk_disable(struct clk *clk) {}
 
 
 static inline void clk_bulk_disable(int num_clks,
-				    struct clk_bulk_data *clks) {}
+				    const struct clk_bulk_data *clks) {}
 
 static inline unsigned long clk_get_rate(struct clk *clk)
 {
-- 
2.21.0

