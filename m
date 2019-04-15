Return-Path: <SRS0=rNeM=SR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 151CEC10F12
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 18:46:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D172C218D3
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 18:46:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555353988;
	bh=Eb4rEwUZ6RXNtzNjbG+XVZsj6T3Gm4TRFGCWKXhEZf4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=GWrU5WmcTZz1VqTJFm4MbaR0ZQch39iexgeLKpEvlr7M04ZPIc+jww3C6O68pKsHh
	 DTYLZeyS7wptqm0TZVMukPn061kYCz+Ep/6qkKBUB4ZRgt3OTGtKY/Ka5T9txxbmAa
	 3AOHi//MBjj1OOvupsxJwoZeYEoTD+g7EK2IUI20=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728614AbfDOSq2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Apr 2019 14:46:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:49144 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728589AbfDOSqZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Apr 2019 14:46:25 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7179D2073F;
        Mon, 15 Apr 2019 18:46:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1555353985;
        bh=Eb4rEwUZ6RXNtzNjbG+XVZsj6T3Gm4TRFGCWKXhEZf4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=x3aHBzkdIUyN5Qem/mhT780VhJAHNzBPpsMK+kFSq+G5RJcCy6pUU+w0DyfpXrRYU
         tn0qlpyE12fPz4LpqOorxsdRIzbFrpaIPe/wn8emiiVgW8zeDxQP0J9fqZja1/MREh
         fZvb+VlAVEPuhmd1Fgl4WdOZw7KVK7pOPaUu4Pqc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Michael Ellerman <mpe@ellerman.id.au>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.9 28/76] powerpc/64s: Add new security feature flags for count cache flush
Date:   Mon, 15 Apr 2019 20:43:52 +0200
Message-Id: <20190415183715.164988720@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190415183707.712011689@linuxfoundation.org>
References: <20190415183707.712011689@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

commit dc8c6cce9a26a51fc19961accb978217a3ba8c75 upstream.

Add security feature flags to indicate the need for software to flush
the count cache on context switch, and for the presence of a hardware
assisted count cache flush.

Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/powerpc/include/asm/security_features.h | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/powerpc/include/asm/security_features.h b/arch/powerpc/include/asm/security_features.h
index 44989b22383c..a0d47bc18a5c 100644
--- a/arch/powerpc/include/asm/security_features.h
+++ b/arch/powerpc/include/asm/security_features.h
@@ -59,6 +59,9 @@ static inline bool security_ftr_enabled(unsigned long feature)
 // Indirect branch prediction cache disabled
 #define SEC_FTR_COUNT_CACHE_DISABLED	0x0000000000000020ull
 
+// bcctr 2,0,0 triggers a hardware assisted count cache flush
+#define SEC_FTR_BCCTR_FLUSH_ASSIST	0x0000000000000800ull
+
 
 // Features indicating need for Spectre/Meltdown mitigations
 
@@ -74,6 +77,9 @@ static inline bool security_ftr_enabled(unsigned long feature)
 // Firmware configuration indicates user favours security over performance
 #define SEC_FTR_FAVOUR_SECURITY		0x0000000000000200ull
 
+// Software required to flush count cache on context switch
+#define SEC_FTR_FLUSH_COUNT_CACHE	0x0000000000000400ull
+
 
 // Features enabled by default
 #define SEC_FTR_DEFAULT \
-- 
2.19.1



