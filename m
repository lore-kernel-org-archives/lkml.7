Return-Path: <SRS0=tMFY=W7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 652C9C3A5A7
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 14:21:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3918E22CED
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 14:21:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YAWN4s0W"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730960AbfIDOVV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Sep 2019 10:21:21 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:37145 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729993AbfIDOVU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Sep 2019 10:21:20 -0400
Received: by mail-wm1-f68.google.com with SMTP id r195so4020393wme.2;
        Wed, 04 Sep 2019 07:21:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=aVkZQqOuZnmw6j0QSgYaya0CSEyCvqv8Llmj2i2rC7o=;
        b=YAWN4s0W76Y7PAvCuk9fzZEwQho+kNNc2lnHVPIaK1fpUCKN08UfUbAQnLLotYAdrm
         CdI4ytIXTFFIlqxMjej8vpyjn4Z1t0Qp+dWz+k/eewhxkoOaWTeUWx+G+c3wIZ5WjosQ
         lDz/qiVrLoxjPvQ6mLKw0OWXul3EFhS5fVh9ln8K30I97tG+t2MrqHAoDCqP38isfxqU
         rActlDMdJr2Cjx0kjx3YEFa0ljrZolRsHagvyXta8s75mCTHogXIwQU1erqz4QHShR8X
         gWHAth2Eo/LK41XxyjJKCQn22vjGHQsVYlc0b+x5EmAkTtmC0CwDrOuITo6sOaRdk6TR
         fMIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=aVkZQqOuZnmw6j0QSgYaya0CSEyCvqv8Llmj2i2rC7o=;
        b=YWRBG6kblAcd5TGskfZ87x6h5ikJ+gQ1fu+QwhXKeynozCg6lJ+9YTkI3JPuarEVRl
         BMXn18QK63STZol1u4QOtFm/LTCxxjm4iSuVjiXlWf0dwPDw4bTK7ssfqqbTDWpE3/Fh
         CGvTs/SWs5MiGu9nh3fYvnE0X9HpNn5ISTFsOlr4xWgfEoNEmklnHL2wlieT9tXvODpR
         TUqP57B1zpBjR0XRo/3HytGzxR2Xf1u1NWp7f4c0KKo0aBJ+Zt7a77XtCFeYEEQFLRe3
         OrJWuXiJxA3s70wFqx8J39RZi4nQ4eh3klQXgGEr4l2tu8TsXYztv8CZfUC9HL3JQ5rt
         yNVg==
X-Gm-Message-State: APjAAAU3JEEXG4E9qQ05zoRR+cV2chxLk4wQD1k6y+ttFohwdacCfyg/
        b0PtKLWlC39ZXK72/XR/Nc0=
X-Google-Smtp-Source: APXvYqyzvgDjB54xrywRGdsKRfpeyKScXMU6k5GFXvDSArzUzuLnIZFXN8gCsazBi74dmbo38aFq2A==
X-Received: by 2002:a1c:3cc3:: with SMTP id j186mr4454404wma.119.1567606878094;
        Wed, 04 Sep 2019 07:21:18 -0700 (PDT)
Received: from localhost.localdomain (ip5b4096c3.dynamic.kabel-deutschland.de. [91.64.150.195])
        by smtp.gmail.com with ESMTPSA id j1sm15056618wrg.24.2019.09.04.07.21.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Sep 2019 07:21:17 -0700 (PDT)
From:   Krzysztof Wilczynski <kw@linux.com>
To:     Yisen Zhuang <yisen.zhuang@huawei.com>,
        Salil Mehta <salil.mehta@huawei.com>,
        "David S. Miller" <davem@davemloft.net>,
        Yonglong Liu <liuyonglong@huawei.com>,
        Peng Li <lipeng321@huawei.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Colin Ian King <colin.king@canonical.com>,
        Huang Zijiang <huang.zijiang@zte.com.cn>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] net: hns: Move static keyword to the front of declaration
Date:   Wed,  4 Sep 2019 16:21:16 +0200
Message-Id: <20190904142116.31884-1-kw@linux.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move the static keyword to the front of declaration of g_dsaf_mode_match,
and resolve the following compiler warning that can be seen when building
with warnings enabled (W=1):

drivers/net/ethernet/hisilicon/hns/hns_dsaf_main.c:27:1: warning:
  ‘static’ is not at beginning of declaration [-Wold-style-declaration]

Signed-off-by: Krzysztof Wilczynski <kw@linux.com>
---
Related: https://lore.kernel.org/r/20190827233017.GK9987@google.com

 drivers/net/ethernet/hisilicon/hns/hns_dsaf_main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/hisilicon/hns/hns_dsaf_main.c b/drivers/net/ethernet/hisilicon/hns/hns_dsaf_main.c
index c1eba421ba82..3a14bbc26ea2 100644
--- a/drivers/net/ethernet/hisilicon/hns/hns_dsaf_main.c
+++ b/drivers/net/ethernet/hisilicon/hns/hns_dsaf_main.c
@@ -24,7 +24,7 @@
 #include "hns_dsaf_rcb.h"
 #include "hns_dsaf_misc.h"
 
-const static char *g_dsaf_mode_match[DSAF_MODE_MAX] = {
+static const char *g_dsaf_mode_match[DSAF_MODE_MAX] = {
 	[DSAF_MODE_DISABLE_2PORT_64VM] = "2port-64vf",
 	[DSAF_MODE_DISABLE_6PORT_0VM] = "6port-16rss",
 	[DSAF_MODE_DISABLE_6PORT_16VM] = "6port-16vf",
-- 
2.22.1

