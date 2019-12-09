Return-Path: <SRS0=ag/Q=Z7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39BE4C43603
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Dec 2019 08:19:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0DAE0205ED
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Dec 2019 08:19:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aSAarSF1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727257AbfLIITd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Dec 2019 03:19:33 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:37177 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727208AbfLIIT2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Dec 2019 03:19:28 -0500
Received: by mail-pl1-f196.google.com with SMTP id c23so187901plz.4;
        Mon, 09 Dec 2019 00:19:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=q0ied9L65yH7tx4IRU87dXRq0PeDGyWkKG3sBMiryjI=;
        b=aSAarSF1Q4vngr/xtJNb7O9bLCUrJSGAd2GqdQvsBD1T81zyGrVEsgwUEdw9dqhDt9
         9u9jbJQKhvDiHXlRTwJ+rReVJNowZmDItl6cHOttpJkW3N98tCr/81W9ru5YhTx1kqon
         qNsENbK2e1W5Brygy7xyOBuZPkB0+YAbaIvmpTGfiuQPLQVlwHXb9Sp4Rb/Dfo6tqO3J
         6N3jpZqHBU+2TE2y+i7Rmd0p3gtjWuV813DX6EFyDrHSMIt9yB4Dn4rlrqq+zYB8UwN7
         5kfSDrLN69qvFZQKWwY7vOaKXFJD3oSMiLhodfiqDkq6M47Eg9EtsQxj5sKFk+uVlXvv
         PT4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=q0ied9L65yH7tx4IRU87dXRq0PeDGyWkKG3sBMiryjI=;
        b=SHy89DpIm5hHFpnoLsMfpQJHmtE7CZ+MPc/ZvtlF8zqKcv0e7AMrL0DKXT2MB49mY9
         +ZfZcCBOXZdsfmwNb6TcHiKoYv0AthPdkAGR9Z7pFas8ZBEbDAbtYv90vr701cP+glBy
         tqXtuCZTibx2unhwxLSjFjbOTTNomT+DxNkidRoZQ9OCun3bQ7dtd460diXkSSacRQyh
         3n6iq0v2dUgF7ksDNob7AEOKLRr1oRFnxHot6nI5lGIgl4VVdrm6rOZCcg4Od+PRcr0A
         +nP5qJ6GkASdqOcmu3bYTeNXhHscH/eJG8/+2lTe1QkypLY60rNEqGXT5rzo3aTt9Awc
         p3SQ==
X-Gm-Message-State: APjAAAUe/fTbbiJY8vXp/XSaNrHkBhCfYCaHg2hjq45iAmyUVYb5Z+3s
        UiNAAmvX2vix1Qr7QCLF8u3oJSlJf6jfqQ==
X-Google-Smtp-Source: APXvYqzHpZzDb88qUMIhfw94xrEO0/DNfnFkwUtAGgV3uivw2MIRAyxPWGtMOjFh9Bp8cbIR9Ghijg==
X-Received: by 2002:a17:902:12c:: with SMTP id 41mr28079801plb.224.1575879567178;
        Mon, 09 Dec 2019 00:19:27 -0800 (PST)
Received: from glados.lan ([2601:647:4c01:6541:fa16:54ff:fed1:1bd6])
        by smtp.gmail.com with ESMTPSA id u2sm23810375pgc.19.2019.12.09.00.19.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Dec 2019 00:19:26 -0800 (PST)
From:   Thomas Hebb <tommyhebb@gmail.com>
To:     linux-kernel@vger.kernel.org, linux-kbuild@vger.kernel.org
Cc:     Thomas Hebb <tommyhebb@gmail.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>
Subject: [PATCH 2/4] kconfig: don't crash on NULL expressions in expr_eq()
Date:   Mon,  9 Dec 2019 00:19:17 -0800
Message-Id: <2f42719235f9250ed10209982543f99f4fd41d61.1575879069.git.tommyhebb@gmail.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <cover.1575879069.git.tommyhebb@gmail.com>
References: <cover.1575879069.git.tommyhebb@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

NULL expressions are taken to always be true, as implemented by the
expr_is_yes() macro and by several other functions in expr.c. As such,
they ought to be valid inputs to expr_eq(), which compares two
expressions.

Signed-off-by: Thomas Hebb <tommyhebb@gmail.com>
---
 scripts/kconfig/expr.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/scripts/kconfig/expr.c b/scripts/kconfig/expr.c
index 77ffff3a053c..8284444cc3fa 100644
--- a/scripts/kconfig/expr.c
+++ b/scripts/kconfig/expr.c
@@ -254,6 +254,11 @@ static int expr_eq(struct expr *e1, struct expr *e2)
 {
 	int res, old_count;
 
+	/* A NULL expr is taken to be yes, but there's also a different way to
+	 * represent yes. expr_is_yes() checks for either representation. */
+	if (!e1 || !e2)
+		return expr_is_yes(e1) && expr_is_yes(e2);
+
 	if (e1->type != e2->type)
 		return 0;
 	switch (e1->type) {
-- 
2.24.0

