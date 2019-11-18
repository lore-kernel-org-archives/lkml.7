Return-Path: <SRS0=CA45=ZK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCF4FC432C3
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Nov 2019 11:24:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B6C9D2084D
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Nov 2019 11:24:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b="ZyUJ5WMn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727441AbfKRLY3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Nov 2019 06:24:29 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:55855 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727405AbfKRLY0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Nov 2019 06:24:26 -0500
Received: by mail-wm1-f66.google.com with SMTP id b11so16953359wmb.5
        for <linux-kernel@vger.kernel.org>; Mon, 18 Nov 2019 03:24:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=u67M6iMnQRPeWGbUjU6/8zjKJ8MPzlxCYb6wzRlTUzI=;
        b=ZyUJ5WMnth3SU48aYvS4fzK8hUXIaPpYljpdKoErKfrhzAmKvOTIG8Lv0aPWgk2RxT
         ZP67+R3KRm5OJwrOYPHHE3tk4Y//im0p1QB5M0gz5HuEGSCuTRoUZobX2Y3BeyIr8Osj
         7vaYJIjKqRt2NVkR9YYnzVUZAb3xO9OfGiUJw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=u67M6iMnQRPeWGbUjU6/8zjKJ8MPzlxCYb6wzRlTUzI=;
        b=RiUndGlbOEkP3TlMPe7FiF20+KzHxnQA2xw6SiaPOz17pxfnkkexAG9rgrtGmHCxJV
         wRCQALZbxzowioKMa/xDv+I33Yrj2CHWFOYs4vNaVrsUjWtNXHjQpnxJul3eiC1VBcX3
         BRO7ZWaFOTX9mcWtxfEdBDKcTSrXZcCt+30ofh+W7tD/gYybJF0raEUXC+LypHkvRXgV
         aBrshGB17fPEMoaBXRXXlzVkeC5gwjolAfAMC7HkQxXTCr6Vvg5q8DB/lM93JflgSKdC
         82IkBqn2wYAfUoVfafpm73/EhleTNoHl4ywtoChtNH6KF/yduP32Mw8XOriQzOZVlL0O
         qxZA==
X-Gm-Message-State: APjAAAXNzZYL7dwA43Za3akcNw1GNdmHnx+zS1kM/ECoNrc8m8cIXT+N
        EwG/SFJ+C+verYhyfhymJEXAEQ==
X-Google-Smtp-Source: APXvYqyvwQK7ZNvJAAcJjBPFCHxzOq/iR38P0uIeZFJ2nKarTxjyW1A/whUUJQYA2dtQxAXwNIZrhQ==
X-Received: by 2002:a1c:3cc4:: with SMTP id j187mr29379317wma.95.1574076261570;
        Mon, 18 Nov 2019 03:24:21 -0800 (PST)
Received: from prevas-ravi.prevas.se (ip-5-186-115-54.cgn.fibianet.dk. [5.186.115.54])
        by smtp.gmail.com with ESMTPSA id y2sm21140815wmy.2.2019.11.18.03.24.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Nov 2019 03:24:21 -0800 (PST)
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
To:     Qiang Zhao <qiang.zhao@nxp.com>, Li Yang <leoyang.li@nxp.com>,
        Christophe Leroy <christophe.leroy@c-s.fr>
Cc:     linuxppc-dev@lists.ozlabs.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Scott Wood <oss@buserror.net>, Timur Tabi <timur@kernel.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
Subject: [PATCH v5 38/48] soc: fsl: qe: drop broken lazy call of cpm_muram_init()
Date:   Mon, 18 Nov 2019 12:23:14 +0100
Message-Id: <20191118112324.22725-39-linux@rasmusvillemoes.dk>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191118112324.22725-1-linux@rasmusvillemoes.dk>
References: <20191118112324.22725-1-linux@rasmusvillemoes.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

cpm_muram_alloc_common() tries to support a kind of lazy
initialization - if the muram_pool has not been created yet, it calls
cpm_muram_init(). Now, cpm_muram_alloc_common() is always called under

	spin_lock_irqsave(&cpm_muram_lock, flags);

and cpm_muram_init() does gen_pool_create() (which implies a
GFP_KERNEL allocation) and ioremap(), not to mention the fun that
ensues from cpm_muram_init() doing

	spin_lock_init(&cpm_muram_lock);

In other words, this has never worked, so nobody can have been relying
on it.

cpm_muram_init() is called from a subsys_initcall (either from
cpm_init() in arch/powerpc/sysdev/cpm_common.c or, via qe_reset(),
from qe_init() in drivers/soc/fsl/qe/qe.c).

Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
---
 drivers/soc/fsl/qe/qe_common.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/soc/fsl/qe/qe_common.c b/drivers/soc/fsl/qe/qe_common.c
index 48c77bb92846..dcb267567d76 100644
--- a/drivers/soc/fsl/qe/qe_common.c
+++ b/drivers/soc/fsl/qe/qe_common.c
@@ -119,9 +119,6 @@ static s32 cpm_muram_alloc_common(unsigned long size,
 	struct muram_block *entry;
 	s32 start;
 
-	if (!muram_pool && cpm_muram_init())
-		goto out2;
-
 	start = gen_pool_alloc_algo(muram_pool, size, algo, data);
 	if (!start)
 		goto out2;
-- 
2.23.0

