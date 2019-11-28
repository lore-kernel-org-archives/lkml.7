Return-Path: <SRS0=QHyQ=ZU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF396C432C0
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Nov 2019 14:59:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B57D521771
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Nov 2019 14:59:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b="V2jSMZBN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727719AbfK1O67 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Nov 2019 09:58:59 -0500
Received: from mail-lf1-f68.google.com ([209.85.167.68]:46210 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727517AbfK1O55 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Nov 2019 09:57:57 -0500
Received: by mail-lf1-f68.google.com with SMTP id a17so20228838lfi.13
        for <linux-kernel@vger.kernel.org>; Thu, 28 Nov 2019 06:57:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=izqhGk+7dYtc0qSDmqSrNzca5ES+nhNiwDVQCjT9+7A=;
        b=V2jSMZBN8uh/xpePhhzkN28hW1PU3ZPx3auFFgQEEIv24PnHG7WcUuT9Hr7TOse5Rk
         FIOhKMME0cB9iUKg1zBa4lJ8C9Vi0lSdcsXWunqNCSFJ9Nz0OrpeEQRglQhTBkE35R9e
         ejuls2cV8st5na9tOFkujKVk+QD9iuwF49KvM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=izqhGk+7dYtc0qSDmqSrNzca5ES+nhNiwDVQCjT9+7A=;
        b=lNByBew7xMeg/2Gt/y/1VewersdXJqe1u/4mv7N4uTfCOwbPUb1ua8PPY4VvBPxhzl
         Y6W9MioBhMhiGIUDk7HjTmAF13TpzCI7q1pcXm85PVSp2DomT/ic2ifibdn0Q6S0aOgu
         2K0JUcsSDPcpJz/erm0F+8FBj1rzKdY/rBe/MgcF3p+8gwp9NHRjmJnfpulEj5UXbi+n
         aI2ia5MgS54yhD3eqBrFPwKADwPznE6jKGyVB0eEIWlsc3RiCxi49m2SX0YS656xcB1P
         V1dVD7QY2eUGF4cJW86kf9oZbjC+JUWb9CLZiHiqNSNoZmqv4AUyounRJeoo8ii2Ihot
         Nz9A==
X-Gm-Message-State: APjAAAXHvvwfOWXXbHUjJG9ZC+e0PTJLBrZo9W0+/ELtp/9SmIWvfDpX
        Nntn+4dWcQSm06JOODL3LSUyKA==
X-Google-Smtp-Source: APXvYqyw4gw+pnvDh4FxsHQgDketpaq7hQlReciEcvlLDb7UG2dgMuvgna7yNQjdHNDX/gN/j/K3IQ==
X-Received: by 2002:ac2:5a08:: with SMTP id q8mr32413398lfn.106.1574953074176;
        Thu, 28 Nov 2019 06:57:54 -0800 (PST)
Received: from prevas-ravi.prevas.se ([81.216.59.226])
        by smtp.gmail.com with ESMTPSA id u2sm2456803lfl.18.2019.11.28.06.57.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Nov 2019 06:57:53 -0800 (PST)
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
To:     Qiang Zhao <qiang.zhao@nxp.com>, Li Yang <leoyang.li@nxp.com>,
        Christophe Leroy <christophe.leroy@c-s.fr>
Cc:     linuxppc-dev@lists.ozlabs.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Scott Wood <oss@buserror.net>, Timur Tabi <timur@kernel.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
Subject: [PATCH v6 37/49] soc: fsl: qe: make cpm_muram_free() ignore a negative offset
Date:   Thu, 28 Nov 2019 15:55:42 +0100
Message-Id: <20191128145554.1297-38-linux@rasmusvillemoes.dk>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191128145554.1297-1-linux@rasmusvillemoes.dk>
References: <20191128145554.1297-1-linux@rasmusvillemoes.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This allows one to simplify callers since they can store a negative
value as a sentinel to indicate "this was never allocated" (or store
the -ENOMEM from an allocation failure) and then call cpm_muram_free()
unconditionally.

Reviewed-by: Timur Tabi <timur@kernel.org>
Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
---
 drivers/soc/fsl/qe/qe_common.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/soc/fsl/qe/qe_common.c b/drivers/soc/fsl/qe/qe_common.c
index 962835488f66..48c77bb92846 100644
--- a/drivers/soc/fsl/qe/qe_common.c
+++ b/drivers/soc/fsl/qe/qe_common.c
@@ -176,6 +176,9 @@ void cpm_muram_free(s32 offset)
 	int size;
 	struct muram_block *tmp;
 
+	if (offset < 0)
+		return;
+
 	size = 0;
 	spin_lock_irqsave(&cpm_muram_lock, flags);
 	list_for_each_entry(tmp, &muram_block_list, head) {
-- 
2.23.0

