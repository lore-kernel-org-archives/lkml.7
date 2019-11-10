Return-Path: <SRS0=U1ji=ZC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7871AC43331
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Nov 2019 03:04:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 44C35208C3
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Nov 2019 03:04:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573355059;
	bh=UI1J+tDPK+dDqNQkuwW+1DwMI88CGJiKXEB/ID8jN98=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=knZXYSXKfHHqM23FGd6CA7hAlF6VPurDKgzDO2xTpS6e5LEQyZVKB6Ngs0UKVhVuV
	 IVL/fgNrvTDPThxjQbIMPE50cSFpAaF6wK0vGhCgRG2hSkpHTOh6qwFDJBfFYHx4P8
	 QCEdVPzZALC0DMUWoxXh/f4IxtZ0ownz6BbSY16E=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729192AbfKJCq5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 9 Nov 2019 21:46:57 -0500
Received: from mail.kernel.org ([198.145.29.99]:51376 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729151AbfKJCqx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Nov 2019 21:46:53 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A25EE21D82;
        Sun, 10 Nov 2019 02:46:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573354012;
        bh=UI1J+tDPK+dDqNQkuwW+1DwMI88CGJiKXEB/ID8jN98=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jz+NMqZSaLR5hrem+7Ms85c46pi4jMQiP5BRidGDR2FGu9RXiYVLQ6pHDKYWCErSn
         F++khQuZc7v/NmE/4kEeNbx0N3HPdd4OgEZje2sKrSf8oDSjJ5dqO0qjGWW6jAlq0X
         YosFLqKfGW4jstg0BngLmxcVUwWo+poWaFI52psE=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Stefan Agner <stefan@agner.ch>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Sasha Levin <sashal@kernel.org>, linux-crypto@vger.kernel.org,
        clang-built-linux@googlegroups.com
Subject: [PATCH AUTOSEL 4.14 037/109] crypto: arm/crc32 - avoid warning when compiling with Clang
Date:   Sat,  9 Nov 2019 21:44:29 -0500
Message-Id: <20191110024541.31567-37-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191110024541.31567-1-sashal@kernel.org>
References: <20191110024541.31567-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Stefan Agner <stefan@agner.ch>

[ Upstream commit cd560235d8f9ddd94aa51e1c4dabdf3212b9b241 ]

The table id (second) argument to MODULE_DEVICE_TABLE is often
referenced otherwise. This is not the case for CPU features. This
leads to a warning when building the kernel with Clang:
  arch/arm/crypto/crc32-ce-glue.c:239:33: warning: variable
    'crc32_cpu_feature' is not needed and will not be emitted
    [-Wunneeded-internal-declaration]
  static const struct cpu_feature crc32_cpu_feature[] = {
                                  ^

Avoid warnings by using __maybe_unused, similar to commit 1f318a8bafcf
("modules: mark __inittest/__exittest as __maybe_unused").

Fixes: 2a9faf8b7e43 ("crypto: arm/crc32 - enable module autoloading based on CPU feature bits")
Signed-off-by: Stefan Agner <stefan@agner.ch>
Acked-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm/crypto/crc32-ce-glue.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/crypto/crc32-ce-glue.c b/arch/arm/crypto/crc32-ce-glue.c
index 96e62ec105d06..cd9e93b46c2dd 100644
--- a/arch/arm/crypto/crc32-ce-glue.c
+++ b/arch/arm/crypto/crc32-ce-glue.c
@@ -236,7 +236,7 @@ static void __exit crc32_pmull_mod_exit(void)
 				  ARRAY_SIZE(crc32_pmull_algs));
 }
 
-static const struct cpu_feature crc32_cpu_feature[] = {
+static const struct cpu_feature __maybe_unused crc32_cpu_feature[] = {
 	{ cpu_feature(CRC32) }, { cpu_feature(PMULL) }, { }
 };
 MODULE_DEVICE_TABLE(cpu, crc32_cpu_feature);
-- 
2.20.1

