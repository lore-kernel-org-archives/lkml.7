Return-Path: <SRS0=CA45=ZK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9AFEC432C0
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Nov 2019 11:24:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9FD7A20895
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Nov 2019 11:24:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b="E4AHDjvC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727500AbfKRLYe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Nov 2019 06:24:34 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:43294 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727420AbfKRLY3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Nov 2019 06:24:29 -0500
Received: by mail-wr1-f67.google.com with SMTP id n1so18956804wra.10
        for <linux-kernel@vger.kernel.org>; Mon, 18 Nov 2019 03:24:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=FL4wefDICHo32h9247H9jmqyY6zv5MUtAqMoiveQx9g=;
        b=E4AHDjvC6aXMNQjRveC5f6E2vzA0LBGQPU4cVhU95XHEvW4ndN2XtxJT8GKavd70F2
         jC9tRDlotOojTjdz6tbnx1hk+e6LRNypVnQPbIF4Bep2+cKjOdMAyk5VimxdRAI1phcT
         lwP/3vwBXv7QrZtV8x00tERfMHg5v1yR1r5Os=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=FL4wefDICHo32h9247H9jmqyY6zv5MUtAqMoiveQx9g=;
        b=tl62ZPTBY4EUChhNaIp/FtlRXx0caW3hJ6BLM3gkFCTIc0vrQMuotbV+GH6i216DBi
         zmsKPzfJ/KZdnn6ztdlMNaWMuU3v8DdCnyfHqKgC9Dr1hecq9vIQNJdEqUHz4aUWlXQz
         7P9ewfP2TpnPkWWtJA5CvSy1ICDTJYQHkXAshWnUlEBOOEDGfjVkaGDoPDbCvX057efw
         EzJ1YbS/Pqn5Ua72FO4zZC++JSwe2niVqLEXNyv/cNfTuBea8fmktIXhnXoRF/Nw0+cS
         wF5TLMOnngZOjYmHr2+03DAubIbWQVlPWF59cJQJpqU1vLjFxlsJ+0YKfOGfZ2fMEG+n
         GV4Q==
X-Gm-Message-State: APjAAAUsdRilY1Tq3EjHATkuWqiQVC1HmHD3eiBZLhvEHereypXzecZS
        VuumvdCdyxYLTcSmwXmnlEUs6A==
X-Google-Smtp-Source: APXvYqwHH2szYVNaS4MG6r2NeMu4AnUDfPLgQecmFMGcPhOZDZXQ80z3njZwNa52cVw6dP6X8ZlqQA==
X-Received: by 2002:a5d:448a:: with SMTP id j10mr21126896wrq.79.1574076267155;
        Mon, 18 Nov 2019 03:24:27 -0800 (PST)
Received: from prevas-ravi.prevas.se (ip-5-186-115-54.cgn.fibianet.dk. [5.186.115.54])
        by smtp.gmail.com with ESMTPSA id y2sm21140815wmy.2.2019.11.18.03.24.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Nov 2019 03:24:26 -0800 (PST)
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
To:     Qiang Zhao <qiang.zhao@nxp.com>, Li Yang <leoyang.li@nxp.com>,
        Christophe Leroy <christophe.leroy@c-s.fr>
Cc:     linuxppc-dev@lists.ozlabs.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Scott Wood <oss@buserror.net>, Timur Tabi <timur@kernel.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
Subject: [PATCH v5 42/48] soc: fsl: qe: drop pointless check in qe_sdma_init()
Date:   Mon, 18 Nov 2019 12:23:18 +0100
Message-Id: <20191118112324.22725-43-linux@rasmusvillemoes.dk>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191118112324.22725-1-linux@rasmusvillemoes.dk>
References: <20191118112324.22725-1-linux@rasmusvillemoes.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The sdma member of struct qe_immap is not at offset zero, so even if
qe_immr wasn't initialized yet (i.e. NULL), &qe_immr->sdma would not
be NULL.

Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
---
 drivers/soc/fsl/qe/qe.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/soc/fsl/qe/qe.c b/drivers/soc/fsl/qe/qe.c
index 5bf279c679ef..96c2057d8d8e 100644
--- a/drivers/soc/fsl/qe/qe.c
+++ b/drivers/soc/fsl/qe/qe.c
@@ -367,9 +367,6 @@ static int qe_sdma_init(void)
 	struct sdma __iomem *sdma = &qe_immr->sdma;
 	static s32 sdma_buf_offset = -ENOMEM;
 
-	if (!sdma)
-		return -ENODEV;
-
 	/* allocate 2 internal temporary buffers (512 bytes size each) for
 	 * the SDMA */
 	if (sdma_buf_offset < 0) {
-- 
2.23.0

