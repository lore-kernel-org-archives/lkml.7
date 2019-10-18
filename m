Return-Path: <SRS0=6OEZ=YL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DE71CA9EAB
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 22:03:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2906D20679
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 22:03:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1571436237;
	bh=D+XWnP6P7RE1EroeO5z0WNCnBr45lOJWqiXuBzTjnXA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=1RSKziGGmzUJYFCJaEaSauBNHSAyULR8SyeJn3kuHxIhSZYh+SsPqO993VFo9smWO
	 ypuBEi5aa3bhAgRzJgaE5EgkvShqZYnW+qJYNpxlgHtS8KE3pOEP/Aw89px6S1aenr
	 Ms2TB+dDAbgoPDLy4WVekt4ywMHedb/OOH5Yw3ZU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727497AbfJRWD4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Oct 2019 18:03:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:35406 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727398AbfJRWDu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Oct 2019 18:03:50 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AF58F20679;
        Fri, 18 Oct 2019 22:03:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1571436230;
        bh=D+XWnP6P7RE1EroeO5z0WNCnBr45lOJWqiXuBzTjnXA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=GPwRADkTly51PRmkrkab1thq41H2Mhybfv951nP3+OkPB8AnOBSiv3+gm0lBETp6X
         gskrD2/aUXZ+IJQFVOpuAnFaJwc+XNPHTnUQRlxlb22YABvc+rFZKbyW4YYGkjYBMO
         g8nJWLP/6RaqJ6gaxGKdR628Fvsi1rS4O7YUEjEo=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Sasha Levin <sashal@kernel.org>, linux-crypto@vger.kernel.org
Subject: [PATCH AUTOSEL 5.3 16/89] crypto: arm/aes-ce - add dependency on AES library
Date:   Fri, 18 Oct 2019 18:02:11 -0400
Message-Id: <20191018220324.8165-16-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191018220324.8165-1-sashal@kernel.org>
References: <20191018220324.8165-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ard Biesheuvel <ard.biesheuvel@linaro.org>

[ Upstream commit f703964fc66804e6049f2670fc11045aa8359b1a ]

The ARM accelerated AES driver depends on the new AES library for
its non-SIMD fallback so express this in its Kconfig declaration.

Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm/crypto/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/crypto/Kconfig b/arch/arm/crypto/Kconfig
index a95322b59799f..8ecbca3e0c787 100644
--- a/arch/arm/crypto/Kconfig
+++ b/arch/arm/crypto/Kconfig
@@ -98,6 +98,7 @@ config CRYPTO_AES_ARM_CE
 	tristate "Accelerated AES using ARMv8 Crypto Extensions"
 	depends on KERNEL_MODE_NEON
 	select CRYPTO_BLKCIPHER
+	select CRYPTO_LIB_AES
 	select CRYPTO_SIMD
 	help
 	  Use an implementation of AES in CBC, CTR and XTS modes that uses
-- 
2.20.1

