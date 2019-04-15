Return-Path: <SRS0=rNeM=SR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58182C10F0E
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 19:24:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 131FD20651
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 19:24:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555356256;
	bh=dyU8SptGR47wVkvvFW9x+9YPzMXuAlbY+ZRCe96alh0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=V8imd56egsE3HGo94I6SKcY8eD6mbcpZjLr+7BBvEdCk58AuV1KiND8RRIBReiDnW
	 Gre21pL9xt+aRqvwHoGvmBuVkkxBBXDrQkaH6x/P+rADDU8mV1e+A94IbohdkAJT+s
	 CCDDiPCC/ziKhw5Ih3eBWA8etfHsg4AaJjcMnL6s=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729942AbfDOTGa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Apr 2019 15:06:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:40780 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729871AbfDOTGX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Apr 2019 15:06:23 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 283FE218A1;
        Mon, 15 Apr 2019 19:06:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1555355182;
        bh=dyU8SptGR47wVkvvFW9x+9YPzMXuAlbY+ZRCe96alh0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Vgt43UEd7pHsW4Oi34eo0W/ZNlSOvsc6EnsIXfxcUGjV+cmyzTsD0pyv4RvSkooDd
         dPS4+bKtdvx3psIgZRiviqdfcAbynISSgdkxmPEQX10GLoQJ2rzAZEvv76JwJuzeW1
         4g5IiC/ramkelM2FKKc9Dh+7ZgB8fUtohIAlaRls=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        liyueyi <liyueyi@live.com>, Will Deacon <will.deacon@arm.com>,
        "Sasha Levin (Microsoft)" <sashal@kernel.org>
Subject: [PATCH 4.19 044/101] arm64: kaslr: Reserve size of ARM64_MEMSTART_ALIGN in linear region
Date:   Mon, 15 Apr 2019 20:58:42 +0200
Message-Id: <20190415183742.921241265@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190415183740.341577907@linuxfoundation.org>
References: <20190415183740.341577907@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Upstream commit c8a43c18a97845e7f94ed7d181c11f41964976a2 ]

When KASLR is enabled (CONFIG_RANDOMIZE_BASE=y), the top 4K of kernel
virtual address space may be mapped to physical addresses despite being
reserved for ERR_PTR values.

Fix the randomization of the linear region so that we avoid mapping the
last page of the virtual address space.

Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Signed-off-by: liyueyi <liyueyi@live.com>
[will: rewrote commit message; merged in suggestion from Ard]
Signed-off-by: Will Deacon <will.deacon@arm.com>
Signed-off-by: Sasha Levin (Microsoft) <sashal@kernel.org>
---
 arch/arm64/mm/init.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/mm/init.c b/arch/arm64/mm/init.c
index 787e27964ab9..774c3e17c798 100644
--- a/arch/arm64/mm/init.c
+++ b/arch/arm64/mm/init.c
@@ -450,7 +450,7 @@ void __init arm64_memblock_init(void)
 		 * memory spans, randomize the linear region as well.
 		 */
 		if (memstart_offset_seed > 0 && range >= ARM64_MEMSTART_ALIGN) {
-			range = range / ARM64_MEMSTART_ALIGN + 1;
+			range /= ARM64_MEMSTART_ALIGN;
 			memstart_addr -= ARM64_MEMSTART_ALIGN *
 					 ((range * memstart_offset_seed) >> 16);
 		}
-- 
2.19.1



