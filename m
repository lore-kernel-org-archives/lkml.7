Return-Path: <SRS0=FxTY=RO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12963C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 19:57:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DA09321738
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 19:57:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552334221;
	bh=QpNv7KP6bJQnFVr1D6Hsiz7PwXAQRehVv7/X7tYeYRs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=cKeL3TMpRd6/yGJc8Qo+ZT42J5wuuzLtz0h6d781uRSqbFfkoCUV4UovV9OY1+ozF
	 kdyuO2w7M5/pxGk28HVVCIEoVHrWFw9cun9/aONCJSkQUD3F26zZp632I5sXHTUAhF
	 VJi3Ekxj2yUpZXwz1n2r1JHQAhha9WwCHOaPlXPU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728932AbfCKT5A (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 15:57:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:34332 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728920AbfCKT46 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 15:56:58 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E69C52087C;
        Mon, 11 Mar 2019 19:56:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552334217;
        bh=QpNv7KP6bJQnFVr1D6Hsiz7PwXAQRehVv7/X7tYeYRs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=uku49mMDocgUaOQfp2EbyM+hRV6/p+g82MVNqFWNzrR0xYHvKgypZuTfy0Y5U7g3C
         xCHVFuZGaROnSu3KRVknijq58LToGQ7FqAaqGrzXRDDTO4pAKxo4iykVrWFCdy8CWz
         aN5eP1UoiSuBxlMoh5C11Lsc9rwcia37M1PyqrE0=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.20 51/52] lib/crc32.c: mark crc32_le_base/__crc32c_le_base aliases as __pure
Date:   Mon, 11 Mar 2019 15:55:15 -0400
Message-Id: <20190311195516.137772-51-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190311195516.137772-1-sashal@kernel.org>
References: <20190311195516.137772-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>

[ Upstream commit ff98e20ef2081b8620dada28fc2d4fb24ca0abf2 ]

The upcoming GCC 9 release extends the -Wmissing-attributes warnings
(enabled by -Wall) to C and aliases: it warns when particular function
attributes are missing in the aliases but not in their target.

In particular, it triggers here because crc32_le_base/__crc32c_le_base
aren't __pure while their target crc32_le/__crc32c_le are.

These aliases are used by architectures as a fallback in accelerated
versions of CRC32. See commit 9784d82db3eb ("lib/crc32: make core crc32()
routines weak so they can be overridden").

Therefore, being fallbacks, it is likely that even if the aliases
were called from C, there wouldn't be any optimizations possible.
Currently, the only user is arm64, which calls this from asm.

Still, marking the aliases as __pure makes sense and is a good idea
for documentation purposes and possible future optimizations,
which also silences the warning.

Acked-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Tested-by: Laura Abbott <labbott@redhat.com>
Signed-off-by: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 lib/crc32.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/lib/crc32.c b/lib/crc32.c
index 45b1d67a1767..4a20455d1f61 100644
--- a/lib/crc32.c
+++ b/lib/crc32.c
@@ -206,8 +206,8 @@ u32 __pure __weak __crc32c_le(u32 crc, unsigned char const *p, size_t len)
 EXPORT_SYMBOL(crc32_le);
 EXPORT_SYMBOL(__crc32c_le);
 
-u32 crc32_le_base(u32, unsigned char const *, size_t) __alias(crc32_le);
-u32 __crc32c_le_base(u32, unsigned char const *, size_t) __alias(__crc32c_le);
+u32 __pure crc32_le_base(u32, unsigned char const *, size_t) __alias(crc32_le);
+u32 __pure __crc32c_le_base(u32, unsigned char const *, size_t) __alias(__crc32c_le);
 
 /*
  * This multiplies the polynomials x and y modulo the given modulus.
-- 
2.19.1

