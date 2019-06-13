Return-Path: <SRS0=5wok=UM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E81DC31E49
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 16:25:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1778720644
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 16:25:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1560443137;
	bh=C7tErvoAFiAYsNdkVYn7ouGMWrn3z9QR0m0KZOCj8tM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=MNueG2RTor5Ec9kpe658ybk7RjqzjykPDUNQAKom+a3W5c3s6sK+OAEjn2Eqkf/mH
	 +cSn+k+sPhFcXRDFXaQESD4BIJ3nYjTYoLI+iG60AOHog1eEd81j3LGFv4b8tK4s8R
	 Wq1cYTkdjQk3ZDVjPEiWmhbeLmCQQBUwkUBA2+6w=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392024AbfFMQZb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Jun 2019 12:25:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:54098 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730974AbfFMIgi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jun 2019 04:36:38 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3801E20851;
        Thu, 13 Jun 2019 08:36:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560414997;
        bh=C7tErvoAFiAYsNdkVYn7ouGMWrn3z9QR0m0KZOCj8tM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=WLeWXc2SbGnO5TOWCi3DLGFH5M0lPiSTG4ebnmA0RQrzkI3ml3fYXhO86GWVgooUA
         GkMEBTbRyWLeVS2xfNNz5MldDR6YMz4oqUS6f2YA3Ajej5uJQc0Yeo2aJWq9XqAGj7
         E0VW6DXFFTXOeuFgRar9cIGE004ZsrzFUyW5YA6w=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Nathan Chancellor <natechancellor@gmail.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 49/81] soc: mediatek: pwrap: Zero initialize rdata in pwrap_init_cipher
Date:   Thu, 13 Jun 2019 10:33:32 +0200
Message-Id: <20190613075652.875493360@linuxfoundation.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190613075649.074682929@linuxfoundation.org>
References: <20190613075649.074682929@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Upstream commit 89e28da82836530f1ac7a3a32fecc31f22d79b3e ]

When building with -Wsometimes-uninitialized, Clang warns:

drivers/soc/mediatek/mtk-pmic-wrap.c:1358:6: error: variable 'rdata' is
used uninitialized whenever '||' condition is true
[-Werror,-Wsometimes-uninitialized]

If pwrap_write returns non-zero, pwrap_read will not be called to
initialize rdata, meaning that we will use some random uninitialized
stack value in our print statement. Zero initialize rdata in case this
happens.

Link: https://github.com/ClangBuiltLinux/linux/issues/401
Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>
Reviewed-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Matthias Brugger <matthias.bgg@gmail.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/soc/mediatek/mtk-pmic-wrap.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/soc/mediatek/mtk-pmic-wrap.c b/drivers/soc/mediatek/mtk-pmic-wrap.c
index e3df1e96b141..d7a31bf3c9d6 100644
--- a/drivers/soc/mediatek/mtk-pmic-wrap.c
+++ b/drivers/soc/mediatek/mtk-pmic-wrap.c
@@ -778,7 +778,7 @@ static bool pwrap_is_pmic_cipher_ready(struct pmic_wrapper *wrp)
 static int pwrap_init_cipher(struct pmic_wrapper *wrp)
 {
 	int ret;
-	u32 rdata;
+	u32 rdata = 0;
 
 	pwrap_writel(wrp, 0x1, PWRAP_CIPHER_SWRST);
 	pwrap_writel(wrp, 0x0, PWRAP_CIPHER_SWRST);
-- 
2.20.1



