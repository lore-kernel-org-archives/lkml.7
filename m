Return-Path: <SRS0=G/Om=ZT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F001C432C0
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 20:49:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0552C21843
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 20:49:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574887789;
	bh=DjyCqwt1ga+lwVJAsjsS0ynYp2uQ2lXOueGsNp5OE3Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ocLhmPNHEyv/66ISsaqpVIpSGstAM0t5/EgRy2on0Re4Kq2AS2SFhU4fPGpyg6OGv
	 qunwSSW2B/ZMB/MzHG44lEQmsPPG5gvSQGfJL8raOb0L8wDboa6a4YvTiWN1wgZ/01
	 n9LH0Xo1k+LpHA18GfvsQitv86PEacBIgEWlM4KY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727906AbfK0Utr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Nov 2019 15:49:47 -0500
Received: from mail.kernel.org ([198.145.29.99]:35438 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730263AbfK0Uto (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Nov 2019 15:49:44 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E316921843;
        Wed, 27 Nov 2019 20:49:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574887784;
        bh=DjyCqwt1ga+lwVJAsjsS0ynYp2uQ2lXOueGsNp5OE3Q=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=YQFCQ0MpYqqhxE/kTNGmKy+f9jg3mkr7doufcY+42CDUI1f3gV4PGyCV4z7DdALPf
         qgRCJ+eRZbxxR0uthoL4DooVOEU9ehFt9CA6WmmQeL13NGg2HHn4IfdzjDbU48aZgE
         BWnFOqMkmxBtxN7EL/59R/AppbWfQx2bRrzpgFiI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 091/211] sparc64: Rework xchg() definition to avoid warnings.
Date:   Wed, 27 Nov 2019 21:30:24 +0100
Message-Id: <20191127203102.337052008@linuxfoundation.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191127203049.431810767@linuxfoundation.org>
References: <20191127203049.431810767@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: David S. Miller <davem@davemloft.net>

[ Upstream commit 6c2fc9cddc1ffdef8ada1dc8404e5affae849953 ]

Such as:

fs/ocfs2/file.c: In function ‘ocfs2_file_write_iter’:
./arch/sparc/include/asm/cmpxchg_64.h:55:22: warning: value computed is not used [-Wunused-value]
 #define xchg(ptr,x) ((__typeof__(*(ptr)))__xchg((unsigned long)(x),(ptr),sizeof(*(ptr))))

and

drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c: In function ‘ixgbevf_xdp_setup’:
./arch/sparc/include/asm/cmpxchg_64.h:55:22: warning: value computed is not used [-Wunused-value]
 #define xchg(ptr,x) ((__typeof__(*(ptr)))__xchg((unsigned long)(x),(ptr),sizeof(*(ptr))))

Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/sparc/include/asm/cmpxchg_64.h | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/arch/sparc/include/asm/cmpxchg_64.h b/arch/sparc/include/asm/cmpxchg_64.h
index f71ef3729888f..316faa0130bab 100644
--- a/arch/sparc/include/asm/cmpxchg_64.h
+++ b/arch/sparc/include/asm/cmpxchg_64.h
@@ -52,7 +52,12 @@ static inline unsigned long xchg64(__volatile__ unsigned long *m, unsigned long
 	return val;
 }
 
-#define xchg(ptr,x) ((__typeof__(*(ptr)))__xchg((unsigned long)(x),(ptr),sizeof(*(ptr))))
+#define xchg(ptr,x)							\
+({	__typeof__(*(ptr)) __ret;					\
+	__ret = (__typeof__(*(ptr)))					\
+		__xchg((unsigned long)(x), (ptr), sizeof(*(ptr)));	\
+	__ret;								\
+})
 
 void __xchg_called_with_bad_pointer(void);
 
-- 
2.20.1



