Return-Path: <SRS0=cDsG=WK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AD36C32753
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 17:12:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D62952084D
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 17:12:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1565802736;
	bh=WxNqavY8+WLPdEEfFVrqo9hF2HEFECHIJ4G1X/i8P+0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ugE3hOGqcN9ZwUsnNBZQaZMr1wrqfHzlwXYAYLGAaWZA6C1M/R5ZvxOjsEjZ1RK6w
	 yVNhEbH2/njjw7T86WdHysH+sB/6JVZXvsxUokpRlAgYhOmAE+UbT752BlDZsa8/M3
	 g85rT4tporm0bB2jWGO/88VUV5IRBAPrs4odSSxI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728793AbfHNRMO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Aug 2019 13:12:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:35896 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730527AbfHNRML (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Aug 2019 13:12:11 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 72A1B216F4;
        Wed, 14 Aug 2019 17:12:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565802730;
        bh=WxNqavY8+WLPdEEfFVrqo9hF2HEFECHIJ4G1X/i8P+0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=YtvWxvHeMZWisQadXfyJSl4bTi79TjCXz+/Bw+5I7+E3kMQ0lmeCe9F+FsVl4m4I2
         Tv+yU5TCWhfk+EdkMGoimDOIMpGw80cxvl8D8Swejr2wd1BmoiuJ1LcpskVTG7SOvk
         ch+Cnv9+x7782vAi6CFW6zxYuqNIaUKdHe3F+GgA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Halil Pasic <pasic@linux.ibm.com>,
        Petr Tesarik <ptesarik@suse.cz>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 69/91] s390/dma: provide proper ARCH_ZONE_DMA_BITS value
Date:   Wed, 14 Aug 2019 19:01:32 +0200
Message-Id: <20190814165752.562527266@linuxfoundation.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190814165748.991235624@linuxfoundation.org>
References: <20190814165748.991235624@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Upstream commit 1a2dcff881059dedc14fafc8a442664c8dbd60f1 ]

On s390 ZONE_DMA is up to 2G, i.e. ARCH_ZONE_DMA_BITS should be 31 bits.
The current value is 24 and makes __dma_direct_alloc_pages() take a
wrong turn first (but __dma_direct_alloc_pages() recovers then).

Let's correct ARCH_ZONE_DMA_BITS value and avoid wrong turns.

Signed-off-by: Halil Pasic <pasic@linux.ibm.com>
Reported-by: Petr Tesarik <ptesarik@suse.cz>
Fixes: c61e9637340e ("dma-direct: add support for allocation from ZONE_DMA and ZONE_DMA32")
Signed-off-by: Heiko Carstens <heiko.carstens@de.ibm.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/s390/include/asm/page.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/s390/include/asm/page.h b/arch/s390/include/asm/page.h
index 41e3908b397f8..0d753291c43c0 100644
--- a/arch/s390/include/asm/page.h
+++ b/arch/s390/include/asm/page.h
@@ -176,6 +176,8 @@ static inline int devmem_is_allowed(unsigned long pfn)
 #define VM_DATA_DEFAULT_FLAGS	(VM_READ | VM_WRITE | \
 				 VM_MAYREAD | VM_MAYWRITE | VM_MAYEXEC)
 
+#define ARCH_ZONE_DMA_BITS	31
+
 #include <asm-generic/memory_model.h>
 #include <asm-generic/getorder.h>
 
-- 
2.20.1



