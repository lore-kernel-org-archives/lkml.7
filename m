Return-Path: <SRS0=y5Xy=UI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26E5BC28EBD
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Jun 2019 16:45:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F1C8220840
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Jun 2019 16:45:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1560098718;
	bh=F8mVEECUDWVAl2J0GvhC9Qkc1zHUdiM9elyggL2b6Jk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=i2vl3jo96QwmEyDNUGqSEtnoW0+wGisEi2TpJY73FMduRf4gdig7X5VOdLa9VZm58
	 KjVuwd96WXd5yGS0oSN6fIADCPFN7QawD5J5CayMqzgnTu4nU/8c4D65eUjp95Hf/c
	 4cU6QOEiT8NKVAVPf8jzbhvCXW0y2k33Thj28v+c=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729755AbfFIQpR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Jun 2019 12:45:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:42856 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729717AbfFIQpO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Jun 2019 12:45:14 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C1DCE2145D;
        Sun,  9 Jun 2019 16:45:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560098714;
        bh=F8mVEECUDWVAl2J0GvhC9Qkc1zHUdiM9elyggL2b6Jk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=pdfoaqZPby3ngSIcgq5Uo5TCSijmO+iw2t17WwVQXaE/TdqesCQ+FI5tX8wDusUjc
         FZD2D1De8Lgv8h7eSFP1fWL4zQTqouHeycbgz6T0OTrFLMFEpi7KSckDi626cghoMY
         u6E9ujzYHlwVmbZjGa2MIuCfBBjO07AL+wMo2abA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Pi-Hsun Shih <pihsun@chromium.org>,
        Kees Cook <keescook@chromium.org>
Subject: [PATCH 5.1 33/70] pstore: Set tfm to NULL on free_buf_for_compression
Date:   Sun,  9 Jun 2019 18:41:44 +0200
Message-Id: <20190609164129.877736227@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190609164127.541128197@linuxfoundation.org>
References: <20190609164127.541128197@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Pi-Hsun Shih <pihsun@chromium.org>

commit a9fb94a99bb515d8720ba8440ce3aba84aec80f8 upstream.

Set tfm to NULL on free_buf_for_compression() after crypto_free_comp().

This avoid a use-after-free when allocate_buf_for_compression()
and free_buf_for_compression() are called twice. Although
free_buf_for_compression() freed the tfm, allocate_buf_for_compression()
won't reinitialize the tfm since the tfm pointer is not NULL.

Fixes: 95047b0519c1 ("pstore: Refactor compression initialization")
Signed-off-by: Pi-Hsun Shih <pihsun@chromium.org>
Cc: stable@vger.kernel.org
Signed-off-by: Kees Cook <keescook@chromium.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/pstore/platform.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

--- a/fs/pstore/platform.c
+++ b/fs/pstore/platform.c
@@ -347,8 +347,10 @@ static void allocate_buf_for_compression
 
 static void free_buf_for_compression(void)
 {
-	if (IS_ENABLED(CONFIG_PSTORE_COMPRESS) && tfm)
+	if (IS_ENABLED(CONFIG_PSTORE_COMPRESS) && tfm) {
 		crypto_free_comp(tfm);
+		tfm = NULL;
+	}
 	kfree(big_oops_buf);
 	big_oops_buf = NULL;
 	big_oops_buf_sz = 0;


