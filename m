Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D9F1C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 17:32:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2AC8E20856
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 17:32:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554139979;
	bh=7Q6pRAPO4EI8nm8ujH190EuPFC4jnsj0UAGCrmv2a7s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=xuFgKaDQxR6uO4ZIzchMYjc8KZpICZvn8+ZHdBFX3ei+fsU15Ts/JoNazOIBiMiOI
	 W7lWyCNQPaCEPiDYXFZtH+9oNQ7NwSmplLSlIqXxLAm340384ErqfUMRqXMeQ9teRh
	 5UH/iB3TCRxRQopGOT13tMU2aD9aS+NfesEfD3sE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387562AbfDARc6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 13:32:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:41388 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729057AbfDARc4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 13:32:56 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D284D20880;
        Mon,  1 Apr 2019 17:32:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554139975;
        bh=7Q6pRAPO4EI8nm8ujH190EuPFC4jnsj0UAGCrmv2a7s=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=SkGMA9qUtlCgx15kTixlVcofnzCwwVFQ9zO7S5F+riruJYa2dJqePwyYi7gfrKQVH
         rvEDpN4nRLA6nj8ZMNB9b2hP/QQ96XLqL0sp3sK9wOjwubUgh+NvqAotcQ6+Ja1GST
         43JYVKJipBbAmr/ajF1RjAQMt93Qe8HKr6jPUcGQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Yury Norov <ynorov@caviumnetworks.com>,
        Will Deacon <will.deacon@arm.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.4 042/131] arm64: fix COMPAT_SHMLBA definition for large pages
Date:   Mon,  1 Apr 2019 19:01:52 +0200
Message-Id: <20190401170055.830039642@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190401170051.645954551@linuxfoundation.org>
References: <20190401170051.645954551@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

[ Upstream commit b9b7aebb42d1b1392f3111de61136bb6cf3aae3f ]

ARM glibc uses (4 * __getpagesize()) for SHMLBA, which is correct for
4KB pages and works fine for 64KB pages, but the kernel uses a hardcoded
16KB that is too small for 64KB page based kernels. This changes the
definition to what user space sees when using 64KB pages.

Acked-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Yury Norov <ynorov@caviumnetworks.com>
Signed-off-by: Will Deacon <will.deacon@arm.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm64/include/asm/shmparam.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/include/asm/shmparam.h b/arch/arm64/include/asm/shmparam.h
index 4df608a8459e..e368a55ebd22 100644
--- a/arch/arm64/include/asm/shmparam.h
+++ b/arch/arm64/include/asm/shmparam.h
@@ -21,7 +21,7 @@
  * alignment value. Since we don't have aliasing D-caches, the rest of
  * the time we can safely use PAGE_SIZE.
  */
-#define COMPAT_SHMLBA	0x4000
+#define COMPAT_SHMLBA	(4 * PAGE_SIZE)
 
 #include <asm-generic/shmparam.h>
 
-- 
2.19.1



