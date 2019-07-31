Return-Path: <SRS0=cgli=V4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2693DC433FF
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 18:19:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ED751206A2
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 18:19:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DORqV2Tw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729432AbfGaST0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Jul 2019 14:19:26 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:38866 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726118AbfGaST0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jul 2019 14:19:26 -0400
Received: by mail-wm1-f68.google.com with SMTP id s15so39334620wmj.3;
        Wed, 31 Jul 2019 11:19:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=gIhR1rFWYPyrLTsaj4himG3yGapZVhC0thy8Gdfepg8=;
        b=DORqV2TwG88my+ccXBU+Hnzftcjv03/kwCkah17l13sB3nibFPHKVNwkXvPdUtpHrM
         joJtludO2I1oYBDEVkkS0Wf4jjJumoXjKNJPHCu4NDfICwaXddTtixhqmu7IOrYsT7LA
         SsBzqG6DVJ/NjIg6DkUdMlLkfKoimFFgchsrz1pRObfxDUkV1FtgsasqBCWQzIcVP8L0
         CXtZqsXGhWYUUSsSn1puICNRV4QNNbXFpJ657gm/UiTD0yK3+5FMKOtgo08jpyiG6XCd
         cGXz0o5D59dm2lDGUqTsNCXZOkCm31Ez56wvRszsDECqx1M00t9AT7tpCre6BH43I7JB
         cUlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gIhR1rFWYPyrLTsaj4himG3yGapZVhC0thy8Gdfepg8=;
        b=ZMM0tmGTOqgUiodJ+cQcVfwFP2IkdHJVEuGIupWs1EmubutfRq3nJPWZlgBqWtitW8
         uG75P5RWhZKU8w2y+101uq0L6Dzbok24Z5bT02P7jgHP2+PDc05oXTFI8naQp6lmbXIi
         O1u13IC4M+vfN909acBqbPiTbfNLrMm04aEOZgsRf52BUd8756n+FEgNtgb7qXZjkVIp
         ghtW0dM6uaTDt7hBnVge+qlBCOoiV15940RBJbWQ8G9FqtTcS1GVAfvB7aXsNzBSkXrA
         3EhPl4Xl5F61dBaR3odtDxSws60MEb7OW8W2eT+AA/P171TnaeDdfOCI3n0Q4nUQ5Hkj
         SIpA==
X-Gm-Message-State: APjAAAUFoMpnzGJn/4SNfRqI5ynEQ6R+V98LyJ09RLQanByIzoEl09nS
        laD69QdM0RI08x99Gzq5pE8=
X-Google-Smtp-Source: APXvYqwrgMUC5y/0PalEibAJGNjglLfiIcusQrOyF+huLD7r0zhD6uZeGnFiXHUBTgo73QD+T/HG7g==
X-Received: by 2002:a1c:f914:: with SMTP id x20mr34597086wmh.142.1564597164070;
        Wed, 31 Jul 2019 11:19:24 -0700 (PDT)
Received: from localhost.localdomain ([2a01:4f8:222:2f1b::2])
        by smtp.gmail.com with ESMTPSA id n2sm46680908wmi.38.2019.07.31.11.19.23
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 31 Jul 2019 11:19:23 -0700 (PDT)
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     saravanak@google.com
Cc:     collinsd@codeaurora.org, corbet@lwn.net,
        devicetree@vger.kernel.org, frowand.list@gmail.com,
        gregkh@linuxfoundation.org, kernel-team@android.com,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        mark.rutland@arm.com, rafael@kernel.org, robh+dt@kernel.org,
        Nathan Chancellor <natechancellor@gmail.com>,
        kbuild test robot <lkp@intel.com>
Subject: [PATCH] of/platform: Add missing const qualifier in of_link_property
Date:   Wed, 31 Jul 2019 11:17:34 -0700
Message-Id: <20190731181733.60422-1-natechancellor@gmail.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190729221101.228240-4-saravanak@google.com>
References: <20190729221101.228240-4-saravanak@google.com>
MIME-Version: 1.0
X-Patchwork-Bot: notify
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Clang errors:

drivers/of/platform.c:632:28: error: initializing 'struct
supplier_bindings *' with an expression of type 'const struct
supplier_bindings [4]' discards qualifiers
[-Werror,-Wincompatible-pointer-types-discards-qualifiers]
        struct supplier_bindings *s = bindings;
                                  ^   ~~~~~~~~
1 error generated.

Fixes: 05f812549f53 ("of/platform: Add functional dependency link from DT bindings")
Reported-by: kbuild test robot <lkp@intel.com>
Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
---

Given this is still in the driver-core-testing branch, I am fine with
this being squashed in if desired.

 drivers/of/platform.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/of/platform.c b/drivers/of/platform.c
index e2da90e53edb..21838226d68a 100644
--- a/drivers/of/platform.c
+++ b/drivers/of/platform.c
@@ -629,7 +629,7 @@ static bool of_link_property(struct device *dev, struct device_node *con_np,
 			     const char *prop)
 {
 	struct device_node *phandle;
-	struct supplier_bindings *s = bindings;
+	const struct supplier_bindings *s = bindings;
 	unsigned int i = 0;
 	bool done = true, matched = false;
 
-- 
2.22.0

