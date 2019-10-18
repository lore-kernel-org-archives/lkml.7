Return-Path: <SRS0=6OEZ=YL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32961CA9EA0
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 12:53:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0A218222C3
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 12:53:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b="I8XtwIaY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2410122AbfJRMxJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Oct 2019 08:53:09 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:36777 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2410020AbfJRMwx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Oct 2019 08:52:53 -0400
Received: by mail-lj1-f195.google.com with SMTP id v24so6130605ljj.3
        for <linux-kernel@vger.kernel.org>; Fri, 18 Oct 2019 05:52:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=zynimEHSa2z793BfmzBbQkfkisgqCtAkV6BR9OsqlmE=;
        b=I8XtwIaYLYlfxg9NNy6ELtflmn8AM1cj4JKiG746px15j1nQkF152ypbwtndZWIK6U
         fpsGGyBDxtjg7QmbR17VQAv77y3IUubgjwsdpncHc0qga1+kFg35E3D1g6NMY/X4MLte
         gBtvKk3S2nRNRmpwOlubL7lPWAZnrDp9bGpmU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=zynimEHSa2z793BfmzBbQkfkisgqCtAkV6BR9OsqlmE=;
        b=Jg1ypp2vEzSKeWrigdc+RvAby3OseJZhMNRlYEwj86LwsQamseZPd1ydeBNEe+G2Cc
         7i5nvOPQ+IE5SyLK/Y5Ki2M3s6JTgdUd4GlzwYsOQyrOxwB74XNvu+1r+Y8g1Bkle+Rm
         sWhxEoxiGJS/yRYL8dZpZQuxUbghPj6ZQ17RFI2elyz6lypMSSWG0SqNIal0808eI+AN
         I8o7mfHBEwRsZ3B4WFOxu0SS3Czxa4qpGbNm5xlYO8mcjAREixQ0rpgucbmYiDWubIEl
         7wmYrpz6z2KeB9/FEwV3pD3KzCZhyoIaTTK6s05KVsWPKFGOeK3Rxqnys0W3OoohP76K
         4z/A==
X-Gm-Message-State: APjAAAX10B8sjCcelekDQ5AXsgavqB6oXtA0QEkoB5Vxplh8XlQnGAz+
        b5JJtHkdK1c8+TOvu45bI8jaMQ==
X-Google-Smtp-Source: APXvYqzL15xzNiCg30fEr7XFvHwNNnUijyABeFrBXYL+96A0QzVaeXNN1l+/dWTNB2mw6SlvUo0HFQ==
X-Received: by 2002:a2e:584b:: with SMTP id x11mr6266881ljd.36.1571403171701;
        Fri, 18 Oct 2019 05:52:51 -0700 (PDT)
Received: from prevas-ravi.prevas.se ([81.216.59.226])
        by smtp.gmail.com with ESMTPSA id m17sm7454792lje.0.2019.10.18.05.52.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Oct 2019 05:52:50 -0700 (PDT)
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
To:     Qiang Zhao <qiang.zhao@nxp.com>, Li Yang <leoyang.li@nxp.com>,
        Timur Tabi <timur@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>
Cc:     Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        linuxppc-dev@lists.ozlabs.org, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 6/7] serial: ucc_uart.c: explicitly include asm/cpm.h
Date:   Fri, 18 Oct 2019 14:52:33 +0200
Message-Id: <20191018125234.21825-7-linux@rasmusvillemoes.dk>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191018125234.21825-1-linux@rasmusvillemoes.dk>
References: <20191018125234.21825-1-linux@rasmusvillemoes.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This driver uses #defines from asm/cpm.h, so instead of relying on
some other header pulling that in, do that explicitly.

Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
---
 drivers/tty/serial/ucc_uart.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/tty/serial/ucc_uart.c b/drivers/tty/serial/ucc_uart.c
index a0555ae2b1ef..e2c998badf81 100644
--- a/drivers/tty/serial/ucc_uart.c
+++ b/drivers/tty/serial/ucc_uart.c
@@ -33,6 +33,7 @@
 
 #include <linux/firmware.h>
 #include <asm/reg.h>
+#include <asm/cpm.h>
 
 /*
  * The GUMR flag for Soft UART.  This would normally be defined in qe.h,
-- 
2.20.1

