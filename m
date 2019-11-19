Return-Path: <SRS0=UImc=ZL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9D68C432C0
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 05:51:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BBEE8214D9
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 05:51:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574142698;
	bh=UI1J+tDPK+dDqNQkuwW+1DwMI88CGJiKXEB/ID8jN98=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=dq3Msv8SU+Sc6rqjJ3xCMHGivvFr15OlJAYCqB661MgnvVLAvvtM5iVTwtU5ILnZC
	 A2BVn2iheYWmv4iSX7vIqfmQCBJYHpss+o7krHePNsTS/udmC4b66M184RiO9CD0hK
	 cYMk2CUOYKnN2lYlSB+4UbRfHof4gGrxYGgH67eM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729128AbfKSFvh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Nov 2019 00:51:37 -0500
Received: from mail.kernel.org ([198.145.29.99]:49022 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730803AbfKSFve (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Nov 2019 00:51:34 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 44157208C3;
        Tue, 19 Nov 2019 05:51:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574142693;
        bh=UI1J+tDPK+dDqNQkuwW+1DwMI88CGJiKXEB/ID8jN98=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=TvgzpNdKjWvdy/LXnp3FiTSL6iyBHNnTYCkwce0xmnLXXDbMCsfU3Jf1s7d19sM+J
         Q9oXcILBnhmxCL3v8c3n4NTOKc6aerjHKebznnWJl0Fo95SjEMeCbPB6beUfc2tLwh
         GoJqNPYkBxktf+4/dy0GzVLvLdmjBBN7vVjRUwyk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Stefan Agner <stefan@agner.ch>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 166/239] crypto: arm/crc32 - avoid warning when compiling with Clang
Date:   Tue, 19 Nov 2019 06:19:26 +0100
Message-Id: <20191119051333.678289239@linuxfoundation.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191119051255.850204959@linuxfoundation.org>
References: <20191119051255.850204959@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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



