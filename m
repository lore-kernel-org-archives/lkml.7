Return-Path: <SRS0=uyI7=RK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D634C43381
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 23:29:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 158E420675
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 23:29:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Lg29vWxH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726319AbfCGX34 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Mar 2019 18:29:56 -0500
Received: from mail-ed1-f67.google.com ([209.85.208.67]:35095 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726172AbfCGX34 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Mar 2019 18:29:56 -0500
Received: by mail-ed1-f67.google.com with SMTP id g19so14967250edp.2;
        Thu, 07 Mar 2019 15:29:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Lxtpsb5rNAxIRu0CeS4lU0y2ypAPl6ve3vBB/cyDKe4=;
        b=Lg29vWxHtNGjTGDGVHhhRgl0fJEYKkiopChL12PvdCQfmC7H+qgJ7k36hTi1IERarq
         qG74bDDZPasBqdkLxNdx0+RQA6FjpjClCPcTrAbuufjidEMq1Cobju7CAueKQdv7/OBC
         SmYORWGHrv2m9TcSqlvBdKWyg9vD4m90QcQLmEaYzqSxHxnTqHSa6LOLixAuoDuweTWC
         XHCanH2lssqVbia9EQeC5DUhW+b0t0dUrAtEu68st9dgiAIok+URzjRf+KpqgmYajjcs
         ZRsZ6WVh1CFX83I5xS+J5b86kMr9Pa62p9nGQCTljzwlxVwxP/wV0oLB3BVUUhdpjTgl
         46rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Lxtpsb5rNAxIRu0CeS4lU0y2ypAPl6ve3vBB/cyDKe4=;
        b=MnR3gS/AKUjApb6arW6IEFbIs3i/1WXHJdXXFzu1aGY6lt0BfE5ArGKOsGDuQ+Lg0Q
         2IxhU/GhRkeVrBOnb+YXJaEM76uDQyLR6a9nyenOxwXKuugK4KTvjiEvTod5693yeIIt
         u6MjKOV3aWZGK8jfyH/2tvgYnRjcBvQbWHYwFHg+bm3MmSlJBDIop/Of+iRfLd8a16bP
         Dkj9v4mMXGIF+2WiQEdG87T1uDxMYIgn2PDvzgR3Tg6nl6po+iRR3+oVCY2x8x4HyMAN
         awazWVAmjNNrgx82cdRUzZ9CTcFcIEJFYtZAMES4lheYYhpkZrVwemSlHvSvoYToR9Mw
         jakw==
X-Gm-Message-State: APjAAAU4Mbr9GiYSp+tlkf6VWPB2sh+6EDRx8l8q0v5EZ5a03Ur4Z2vy
        Hv6+Iulz2DuSFweYPDzfQKMXxduXTepQWA==
X-Google-Smtp-Source: APXvYqxSdUlakZdbvxHUS5qFQC7PPKbExMQZQMC0NJCwnZBJ/pwLCx8gINMK3DGQw7b4l4nFy48WIw==
X-Received: by 2002:a17:906:190f:: with SMTP id a15mr9466177eje.231.1552001394124;
        Thu, 07 Mar 2019 15:29:54 -0800 (PST)
Received: from localhost.localdomain ([2a01:4f9:2a:1fae::2])
        by smtp.gmail.com with ESMTPSA id f40sm1684856eda.25.2019.03.07.15.29.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 07 Mar 2019 15:29:53 -0800 (PST)
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     "David S. Miller" <davem@davemloft.net>
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        clang-built-linux@googlegroups.com,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nathan Chancellor <natechancellor@gmail.com>
Subject: [PATCH] net: ethernet: sun: Zero initialize class in default case in niu_add_ethtool_tcam_entry
Date:   Thu,  7 Mar 2019 16:29:33 -0700
Message-Id: <20190307232933.10145-1-natechancellor@gmail.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
X-Patchwork-Bot: notify
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When building with -Wsometimes-uninitialized, Clang warns:

drivers/net/ethernet/sun/niu.c:7466:5: warning: variable 'class' is used
uninitialized whenever switch default is taken
[-Wsometimes-uninitialized]

The default case can never happen because i can only be 0 to 3
(NIU_L3_PROG_CLS is defined as 4). To make this clear to Clang,
just zero initialize class in the default case (use the macro
CLASS_CODE_UNRECOG to make it clear this shouldn't happen).

Link: https://github.com/ClangBuiltLinux/linux/issues/403
Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
---
 drivers/net/ethernet/sun/niu.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ethernet/sun/niu.c b/drivers/net/ethernet/sun/niu.c
index d84501441edd..6f99437a6962 100644
--- a/drivers/net/ethernet/sun/niu.c
+++ b/drivers/net/ethernet/sun/niu.c
@@ -7464,6 +7464,7 @@ static int niu_add_ethtool_tcam_entry(struct niu *np,
 					class = CLASS_CODE_USER_PROG4;
 					break;
 				default:
+					class = CLASS_CODE_UNRECOG;
 					break;
 				}
 				ret = tcam_user_ip_class_set(np, class, 0,
-- 
2.21.0

