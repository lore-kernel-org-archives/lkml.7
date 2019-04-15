Return-Path: <SRS0=rNeM=SR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E07EC10F0E
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 18:51:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3C79B218A1
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 18:51:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555354300;
	bh=wNvJE6k0AIawkS5DgbDO1EqRHCKq447heZQrFXOAEVc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=sjBRwm0nUgiEt5MnSoFhaV7Gwfev+Psp8D/8KwuNCnOEj4DwrM1OKjoV9MWtPFwpL
	 IPAPc4yGXKKD2u/EpaztdlLi9/SMvV2mQhIfPJOLr8kKNCOYvhTq/aALYK2sj+ZKhD
	 XyqX+1fG7Ja/+Fe2ZrHZfxgTbv+L5gLqtTaYIZaI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728381AbfDOSp3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Apr 2019 14:45:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:47832 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728358AbfDOSp0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Apr 2019 14:45:26 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 278FE2073F;
        Mon, 15 Apr 2019 18:45:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1555353925;
        bh=wNvJE6k0AIawkS5DgbDO1EqRHCKq447heZQrFXOAEVc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=DoUI4Y9ByPU+PGoYX6Iulf908MFvaX/uu2Sz7/OpAPRbLj5oFUSIDQMMcIyaPeQHa
         k5nWI8kvHmM5Zo9HyeoUXv0xFXMSt5QLsabLm/T+BDVqryo7GmZOIxPEURAD8U9/fc
         f6lZQWns1JIXlaHc/BNJw6vLltXdJrO/TKE4d13c=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Diana Craciun <diana.craciun@nxp.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.9 21/76] powerpc/64: Make stf barrier PPC_BOOK3S_64 specific.
Date:   Mon, 15 Apr 2019 20:43:45 +0200
Message-Id: <20190415183713.307439867@linuxfoundation.org>
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

commit 6453b532f2c8856a80381e6b9a1f5ea2f12294df upstream.

NXP Book3E platforms are not vulnerable to speculative store
bypass, so make the mitigations PPC_BOOK3S_64 specific.

Signed-off-by: Diana Craciun <diana.craciun@nxp.com>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/powerpc/kernel/security.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/powerpc/kernel/security.c b/arch/powerpc/kernel/security.c
index 813e38ff81ce..926ed3c38741 100644
--- a/arch/powerpc/kernel/security.c
+++ b/arch/powerpc/kernel/security.c
@@ -177,6 +177,7 @@ ssize_t cpu_show_spectre_v2(struct device *dev, struct device_attribute *attr, c
 	return s.len;
 }
 
+#ifdef CONFIG_PPC_BOOK3S_64
 /*
  * Store-forwarding barrier support.
  */
@@ -324,3 +325,4 @@ static __init int stf_barrier_debugfs_init(void)
 }
 device_initcall(stf_barrier_debugfs_init);
 #endif /* CONFIG_DEBUG_FS */
+#endif /* CONFIG_PPC_BOOK3S_64 */
-- 
2.19.1



