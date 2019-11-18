Return-Path: <SRS0=CA45=ZK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C560C432C0
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Nov 2019 11:25:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E4DAB20748
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Nov 2019 11:25:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b="Db6euGnE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727588AbfKRLZI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Nov 2019 06:25:08 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:34252 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727417AbfKRLY2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Nov 2019 06:24:28 -0500
Received: by mail-wm1-f67.google.com with SMTP id j18so15697128wmk.1
        for <linux-kernel@vger.kernel.org>; Mon, 18 Nov 2019 03:24:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=zHMD7aDRcAnceTlZ0tE45j1n7viMV+uwJbkB9Il7bT8=;
        b=Db6euGnEfzB5H/iTyUNURmUloFyq903uV0BYdRSFgVz4amYzVi2dv+0jshKv7P41xb
         sruMTYeeiVwmh+JE265ApF9BX20HrI+c2BUx1ZXojrl449QK2WGXQKWVagHUYulZg9sa
         l2hwnnX+fMO9v0MEfaKICTs+9LISR/3kZZSdE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=zHMD7aDRcAnceTlZ0tE45j1n7viMV+uwJbkB9Il7bT8=;
        b=W1gyfWJdAhI9h3GnSTlVFfmohEAHULAfG4Z4RIqz/cxkzMxRzwSE8wfqxOC2b3ZqP2
         Nc5tOoJCkAwv21n43LwUGsDpjtGfgXHANgF+hZc3JgcYHnubS3y4B5dlkpvYj50kv3ja
         koNffPLVgL+A58m2quOzYOh+GmPRKDH/5N7KQYpWoOO8/KzXPJ3cRDWmSPic9lglX3iY
         3mmqACsi/xG6KSdiTDxZRzuxvg5tq6XSmQJVNj3C1cygv6iw79MOgCp8H+LkTzCbMuVa
         xBZghZL54BkO1pR8AOVeZi7jY5RfiPA0lZaWSIGry8sIYFrQVW230uG7qJbXV3cv7qrb
         9Tfw==
X-Gm-Message-State: APjAAAVyfFL9KvC91vZhvnpg/iPwDjOJkTEGujbTBExdJDwMkfimcsnH
        EHeHNIX4OYlPrOJwtDc2qGOC5w==
X-Google-Smtp-Source: APXvYqwMMHzUUPCd/OFuPAlEujB+DVFL+n+r5M7zPZa0exErgxvPNfo7S9ywHMDhP1IpheD/ml6g+Q==
X-Received: by 2002:a7b:c768:: with SMTP id x8mr29729945wmk.26.1574076266012;
        Mon, 18 Nov 2019 03:24:26 -0800 (PST)
Received: from prevas-ravi.prevas.se (ip-5-186-115-54.cgn.fibianet.dk. [5.186.115.54])
        by smtp.gmail.com with ESMTPSA id y2sm21140815wmy.2.2019.11.18.03.24.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Nov 2019 03:24:25 -0800 (PST)
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
To:     Qiang Zhao <qiang.zhao@nxp.com>, Li Yang <leoyang.li@nxp.com>,
        Christophe Leroy <christophe.leroy@c-s.fr>
Cc:     linuxppc-dev@lists.ozlabs.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Scott Wood <oss@buserror.net>, Timur Tabi <timur@kernel.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
Subject: [PATCH v5 41/48] soc: fsl: qe: drop use of IS_ERR_VALUE in qe_sdma_init()
Date:   Mon, 18 Nov 2019 12:23:17 +0100
Message-Id: <20191118112324.22725-42-linux@rasmusvillemoes.dk>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191118112324.22725-1-linux@rasmusvillemoes.dk>
References: <20191118112324.22725-1-linux@rasmusvillemoes.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that qe_muram_alloc() returns s32, adapt qe_sdma_init() and avoid
another few IS_ERR_VALUE() uses.

Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
---
 drivers/soc/fsl/qe/qe.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/soc/fsl/qe/qe.c b/drivers/soc/fsl/qe/qe.c
index ec511840db3c..5bf279c679ef 100644
--- a/drivers/soc/fsl/qe/qe.c
+++ b/drivers/soc/fsl/qe/qe.c
@@ -365,16 +365,16 @@ EXPORT_SYMBOL(qe_put_snum);
 static int qe_sdma_init(void)
 {
 	struct sdma __iomem *sdma = &qe_immr->sdma;
-	static unsigned long sdma_buf_offset = (unsigned long)-ENOMEM;
+	static s32 sdma_buf_offset = -ENOMEM;
 
 	if (!sdma)
 		return -ENODEV;
 
 	/* allocate 2 internal temporary buffers (512 bytes size each) for
 	 * the SDMA */
-	if (IS_ERR_VALUE(sdma_buf_offset)) {
+	if (sdma_buf_offset < 0) {
 		sdma_buf_offset = qe_muram_alloc(512 * 2, 4096);
-		if (IS_ERR_VALUE(sdma_buf_offset))
+		if (sdma_buf_offset < 0)
 			return -ENOMEM;
 	}
 
-- 
2.23.0

