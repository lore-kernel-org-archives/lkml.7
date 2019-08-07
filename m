Return-Path: <SRS0=/Haq=WD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42BF8C31E40
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Aug 2019 00:32:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 194D1214C6
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Aug 2019 00:32:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="az+UmsXm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728172AbfHGAcH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Aug 2019 20:32:07 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:34353 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726381AbfHGAcG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Aug 2019 20:32:06 -0400
Received: by mail-wr1-f68.google.com with SMTP id 31so89615216wrm.1;
        Tue, 06 Aug 2019 17:32:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=GGs8MT6FGlCkbNNH7TTlHmnRq/ZZmT2kM4HCkC2iAKw=;
        b=az+UmsXmDuq0cUhWJaho5IgfxSfXKToHUabQ1qKX5d/vT3zH87nkJ2i5gDs/K+jCy1
         DQefVcwEeK7GXtQWtwnU8isjUoMThDEhn5YvyURbVwRC1ppp23CPg+idSb4c2+qqZABJ
         vI5QmFWHBrhwxE1ebD2Ahhi/8ItA4cw8m7cWaYspTCRxUwI8yEbX6XN7SFoQFZz+Pv+2
         +owVGTu2fr3Rt4XaTdrV9JScsafyA9POwGXWsmRNVDCqDiNsSLuDlc/zPwusE/2JERCZ
         9oWK3+0Aoz1yhxW5n58r5gNe3ZPPJfE8XXIAwnRzZjNnwy4nAg8osT246qbwoYnNP3Z9
         yKNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=GGs8MT6FGlCkbNNH7TTlHmnRq/ZZmT2kM4HCkC2iAKw=;
        b=hRwF8Bmw7WDcf2ZKwKmZXQuJqEAHhza3jZZK7mRymz3z/8wTZaaEA+iY53SKTn7VU2
         MQIKBdXaCVCUOiOSUMqQXsvpPWYPg8Ls7PbLu3QQMBvIiwFhsBFyk6ho8DDkUQ0xEaBB
         nRE4Ts4ek8ufyMiUNvdUKZM+MrkwjdLYDKBJcEuYMXt5IU5KMdXGoAqT0SR6wDmdHGCv
         c8XTw66NooRA4mj4+uqyXZClTOxzXxT5JZC+klWlOrKD4gdYq7NHWQA5bITVxhIcoEuE
         UA6k6K8PRB0rlh69GVO8erPQi96jL3P4r2VUbj6Rr2CMg7h8OkHv6IkiHqoXJlXKp2vB
         1mAQ==
X-Gm-Message-State: APjAAAXxHsxQv96MLj843IwQ2dU0QWqPcEOF20mUV9TW0G0RMQvDkX1+
        bmo//fUkrgNCa3qq+B7yY9k=
X-Google-Smtp-Source: APXvYqynFI9yVSwY6UqnrCwxba4J2DyfeETuCPqf8QdPoeXnlnppBxsfHbIvGeLFeGUQTKIz3twsdA==
X-Received: by 2002:adf:f646:: with SMTP id x6mr7256533wrp.18.1565137923815;
        Tue, 06 Aug 2019 17:32:03 -0700 (PDT)
Received: from localhost.localdomain ([2a01:4f8:222:2f1b::2])
        by smtp.gmail.com with ESMTPSA id 91sm183684963wrp.3.2019.08.06.17.32.02
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 06 Aug 2019 17:32:03 -0700 (PDT)
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Andrew Jeffery <andrew@aj.id.au>,
        Linus Walleij <linus.walleij@linaro.org>
Cc:     Joel Stanley <joel@jms.id.au>, linux-aspeed@lists.ozlabs.org,
        openbmc@lists.ozlabs.org, linux-gpio@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        clang-built-linux@googlegroups.com,
        Nathan Chancellor <natechancellor@gmail.com>
Subject: [PATCH] pinctrl: aspeed: g6: Remove const specifier from aspeed_g6_sig_expr_set's ctx parameter
Date:   Tue,  6 Aug 2019 17:30:37 -0700
Message-Id: <20190807003037.48457-1-natechancellor@gmail.com>
X-Mailer: git-send-email 2.23.0.rc1
MIME-Version: 1.0
X-Patchwork-Bot: notify
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

clang errors:

drivers/pinctrl/aspeed/pinctrl-aspeed-g6.c:2325:9: error: incompatible
pointer types initializing 'int (*)(struct aspeed_pinmux_data *, const
struct aspeed_sig_expr *, bool)' with an expression of type 'int (const
struct aspeed_pinmux_data *, const struct aspeed_sig_expr *, bool)'
[-Werror,-Wincompatible-pointer-types]
        .set = aspeed_g6_sig_expr_set,
               ^~~~~~~~~~~~~~~~~~~~~~
1 error generated.

Commit 674fa8daa8c9 ("pinctrl: aspeed-g5: Delay acquisition of regmaps")
changed the set function pointer declaration and the g6 one wasn't
updated (I assume because it wasn't merged yet).

Fixes: 2eda1cdec49f ("pinctrl: aspeed: Add AST2600 pinmux support")
Link: https://github.com/ClangBuiltLinux/linux/issues/632
Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
---
 drivers/pinctrl/aspeed/pinctrl-aspeed-g6.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pinctrl/aspeed/pinctrl-aspeed-g6.c b/drivers/pinctrl/aspeed/pinctrl-aspeed-g6.c
index 6012d7d4a22a..648ddb7f038a 100644
--- a/drivers/pinctrl/aspeed/pinctrl-aspeed-g6.c
+++ b/drivers/pinctrl/aspeed/pinctrl-aspeed-g6.c
@@ -2267,7 +2267,7 @@ static const struct aspeed_pin_function aspeed_g6_functions[] = {
  * Return: 0 if the expression is configured as requested and a negative error
  * code otherwise
  */
-static int aspeed_g6_sig_expr_set(const struct aspeed_pinmux_data *ctx,
+static int aspeed_g6_sig_expr_set(struct aspeed_pinmux_data *ctx,
 				  const struct aspeed_sig_expr *expr,
 				  bool enable)
 {
-- 
2.23.0.rc1

