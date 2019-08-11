Return-Path: <SRS0=XJun=WH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3335EC0650F
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Aug 2019 18:50:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0B1942085A
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Aug 2019 18:50:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kooF8enJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726516AbfHKSuE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 11 Aug 2019 14:50:04 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:42203 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726307AbfHKSuE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Aug 2019 14:50:04 -0400
Received: by mail-lj1-f194.google.com with SMTP id 15so4676500ljr.9
        for <linux-kernel@vger.kernel.org>; Sun, 11 Aug 2019 11:50:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=HWRJ8Pcye0IhTFR2bXm/cIQMe1eta7Og2Pu/IVHaA48=;
        b=kooF8enJAKY0dsAeYmSPELaQoJY4fmZHApmLcbQwxpk5KJvF28qI87zJfPq4Hki8Wy
         nLzaurYBRhJdtgxa/iLgk8OZKgQJuOZygZ3Bjo4ooma/SwQeTxnXqZXIUfyJb6Tr49J3
         5tbN+Qx8xU2QIIxOJJgxhIW9NcwhTylS+fQuO4j52AQZ29CZ17aSWqjkFMY8qXHhOUep
         h6Z/e6Zsk60/NpC/JF78KuiVdfiaR+8v92JVZ197b2slRNm4soDHd8KCS3cG4A4xessN
         2876r9Env227t1sX0AkDDJESeAO4ONy2Hw7c1BnZS/iVC9HAZ8GZP7j4p2WHvHfFSB7e
         cf0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=HWRJ8Pcye0IhTFR2bXm/cIQMe1eta7Og2Pu/IVHaA48=;
        b=Ub/glLtazrLpSQZrnZw6B4pwCS0eJ9zkM+lTnbRBSK/a24+OjARypVsaUNTckgEGAE
         lAIN2fMxl+GCmE3g9dJqHDJhYmGxmhz2wjoTx6mMnWlQORTQff8KTviE6hsA+WTUHyI0
         L1Ru8M+6Q77EaPpsigkj72XN4x1ZvfSf7+/PGf/WXP52gEPXg6yYVSCHDF2rmqhfA5lJ
         QIO7P7nNYtdFP1FrRVbGbwXXASj2qQINiJMhDU8JhxRXhL+dJsZOnAB0G8Qjt9igwW9U
         +fsh6atxwnlVm7ZfPK1exnLAma9AEpJwMQf0EHhKq6WXQ+bU44S3nEhHUrdIuVu3JoLq
         06ZA==
X-Gm-Message-State: APjAAAUxYvTe2D0aXXpEAH7P7DiaUNUkY9gkG7tteLzWqwpMIBB0cmaW
        +YyfdqsOFvZU5YdRgK4V4aY=
X-Google-Smtp-Source: APXvYqzFpKeaF5n/WtVauP75lTQCqp01OjfuC+U5ImR2oKeYBCWh02S47toSKzxO/jmk3YBilcRbkA==
X-Received: by 2002:a2e:b1c1:: with SMTP id e1mr6522365lja.228.1565549402383;
        Sun, 11 Aug 2019 11:50:02 -0700 (PDT)
Received: from localhost.localdomain (h-158-174-186-115.NA.cust.bahnhof.se. [158.174.186.115])
        by smtp.gmail.com with ESMTPSA id r21sm5250117lfi.32.2019.08.11.11.50.01
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Sun, 11 Aug 2019 11:50:01 -0700 (PDT)
From:   Rikard Falkeborn <rikard.falkeborn@gmail.com>
To:     rikard.falkeborn@gmail.com
Cc:     akpm@linux-foundation.org, joe@perches.com,
        johannes@sipsolutions.net, linux-kernel@vger.kernel.org,
        yamada.masahiro@socionext.com,
        Nick Desaulniers <ndesaulniers@google.com>,
        Kees Cook <keescook@chromium.org>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
Subject: [PATCH v3 2/3] linux/build_bug.h: Change type to int
Date:   Sun, 11 Aug 2019 20:49:37 +0200
Message-Id: <20190811184938.1796-3-rikard.falkeborn@gmail.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190811184938.1796-1-rikard.falkeborn@gmail.com>
References: <20190801230358.4193-1-rikard.falkeborn@gmail.com>
 <20190811184938.1796-1-rikard.falkeborn@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Having BUILD_BUG_ON_ZERO produce a value of type size_t leads to awkward
casts in cases where the result needs to be signed, or of smaller type
than size_t. To avoid this, cast the value to int instead and rely on
implicit type conversions when a larger or unsigned type is needed.

Suggested-by: Masahiro Yamada <yamada.masahiro@socionext.com>
Signed-off-by: Rikard Falkeborn <rikard.falkeborn@gmail.com>
---
Changes in v3:
  - This patch is new in v3

 include/linux/build_bug.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/linux/build_bug.h b/include/linux/build_bug.h
index 0fe5426f2bdc..e3a0be2c90ad 100644
--- a/include/linux/build_bug.h
+++ b/include/linux/build_bug.h
@@ -9,11 +9,11 @@
 #else /* __CHECKER__ */
 /*
  * Force a compilation error if condition is true, but also produce a
- * result (of value 0 and type size_t), so the expression can be used
+ * result (of value 0 and type int), so the expression can be used
  * e.g. in a structure initializer (or where-ever else comma expressions
  * aren't permitted).
  */
-#define BUILD_BUG_ON_ZERO(e) (sizeof(struct { int:(-!!(e)); }))
+#define BUILD_BUG_ON_ZERO(e) ((int)(sizeof(struct { int:(-!!(e)); })))
 #endif /* __CHECKER__ */
 
 /* Force a compilation error if a constant expression is not a power of 2 */
-- 
2.22.0

