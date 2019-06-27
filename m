Return-Path: <SRS0=pEez=U2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-22.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 906F6C4321A
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 22:15:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 68BEF208CB
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 22:15:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="FUoTSiWG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726880AbfF0WPe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Jun 2019 18:15:34 -0400
Received: from mail-pf1-f201.google.com ([209.85.210.201]:49954 "EHLO
        mail-pf1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726563AbfF0WPd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jun 2019 18:15:33 -0400
Received: by mail-pf1-f201.google.com with SMTP id x9so2426328pfm.16
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jun 2019 15:15:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=Symvyf/Uz9S5oKdNsFmtumlityXOKZm70HtIggCwFnk=;
        b=FUoTSiWGUAtMmT6Erkt4yAeuT0+qjeYcWls6gB3JPv82xDHkgN1hirWiFjVAqnnOVq
         j3Z9Td4BjBrcCMOH4skPnJx3La72XnsWPgIHKbkYMkKrnLi/LFiskUO8f5MhH+PQ6C4e
         KObEoLRcNyNt5RjzC3mElSNiGYJYULWFrsg3bezwh3jABhgWyneK+vjFogRmjHykQlLG
         pWevR8tpcYknyHIgomouTnrqo+1ywloJhMER3s2boTItwF3cssClvvIVSZ0lh6YyFYQq
         9Ik5+4zmwGMCXlH03L6WSLUMi7or2zDUnDFVYXyfNH8gVHiYWki8yp+UMawuPW1mVK8/
         yMgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=Symvyf/Uz9S5oKdNsFmtumlityXOKZm70HtIggCwFnk=;
        b=k7Yzv72FErCSGg91VRd2UydN8ZUiuMo17/I7RuauhgB7L1dnzfGf4lXypy7YDcAzf3
         Y7H7xWbKDEMb3LToDCTXwKSBtzzCjrh5Sn/P+EVC5heIg0YkU5nEONny5TV9n72U3Xud
         /BAM1vRyE5YyOGu/BmFdUMvmmxEsXLZb7eZN+yi05uykLqxPFkMCzJ++x6JQiXmlsKGx
         fP/MdprgwNjiU8p7H+gQ3tuqCCb0uCaEdADEp7INW5NfiPmD+5yf45HJjSbn4Jc+0seH
         PMjbYEu350RcwAJ2P5ljEruIGhngiGXMoG8l/m7ITsbULx4/Ed+jHpaNi4FigYDXlpJy
         d+BQ==
X-Gm-Message-State: APjAAAVvgirfYkZ8EsnrzKZRBJ6TFZUjFijpz3V68MVkJicp8LZAE1BX
        W+t+HUZxwFv82hEQUfUTb2F2oVe0jw==
X-Google-Smtp-Source: APXvYqxUVrAymwj/ugIGi6sQXo8Sqq04CVHfX4dFLvmyXHderTB1493KLtyO4xlY6inwpt5jVs2FxtQjAQ==
X-Received: by 2002:a65:6656:: with SMTP id z22mr5733329pgv.197.1561673732735;
 Thu, 27 Jun 2019 15:15:32 -0700 (PDT)
Date:   Thu, 27 Jun 2019 15:15:07 -0700
Message-Id: <20190627221507.83942-1-nhuck@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.22.0.410.gd8fdbe21b5-goog
Subject: [PATCH] clk: mediatek: Fix -Wunused-const-variable
From:   Nathan Huckleberry <nhuck@google.com>
To:     mturquette@baylibre.com, sboyd@kernel.org, matthias.bgg@gmail.com,
        fparent@baylibre.com
Cc:     linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        Nathan Huckleberry <nhuck@google.com>,
        clang-built-linux@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Clang produces the following warning

drivers/clk/mediatek/clk-mt8516.c:234:27: warning: unused variable
'ddrphycfg_parents' [-Wunused-const-variable] static const char * const
ddrphycfg_parents[] __initconst = {

This variable has never been used. Deleting it to cleanup the warning.

Cc: clang-built-linux@googlegroups.com
Link: https://github.com/ClangBuiltLinux/linux/issues/523
Signed-off-by: Nathan Huckleberry <nhuck@google.com>
---
 drivers/clk/mediatek/clk-mt8516.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/clk/mediatek/clk-mt8516.c b/drivers/clk/mediatek/clk-mt8516.c
index 26fe43cc9ea2..9d4261ecc760 100644
--- a/drivers/clk/mediatek/clk-mt8516.c
+++ b/drivers/clk/mediatek/clk-mt8516.c
@@ -231,11 +231,6 @@ static const char * const nfi1x_pad_parents[] __initconst = {
 	"nfi1x_ck"
 };
 
-static const char * const ddrphycfg_parents[] __initconst = {
-	"clk26m_ck",
-	"mainpll_d16"
-};
-
 static const char * const usb_78m_parents[] __initconst = {
 	"clk_null",
 	"clk26m_ck",
-- 
2.22.0.410.gd8fdbe21b5-goog

