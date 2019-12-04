Return-Path: <SRS0=oopU=Z2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B2E5C2BC73
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 18:00:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EC2B02073B
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 18:00:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1575482445;
	bh=oFBGn2tRryc9oldibQQBIAoEL8LAFhJYgr1PYw8bf88=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=vTan4pspyV4tUUI6mES+++eal/R59AtrzS/42EFbVpooKKE2AWYZ5rGC2MSO7ChSY
	 eWqpKQ/IMWOS+v3Gm2r8/AfLmRNeWq+HG5j4nro6qb/L7ArlX9ebmGewGvLTBElLIU
	 vNXK9V+8CLEcx62ZaRTFQ2eWqSP9YfCXk/8mdars=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728338AbfLDSAo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Dec 2019 13:00:44 -0500
Received: from mail.kernel.org ([198.145.29.99]:39692 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729021AbfLDSAl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Dec 2019 13:00:41 -0500
Received: from localhost (unknown [217.68.49.72])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 141072084B;
        Wed,  4 Dec 2019 18:00:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1575482440;
        bh=oFBGn2tRryc9oldibQQBIAoEL8LAFhJYgr1PYw8bf88=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=k79xScKUVxvJxL/Sriyelq/n5bnEbhLCHYiCUFCDLYJN6wFv9MA92N3M6z72hl+EF
         WCSPhq+pxq5EZg2wCyScxneNO+ThkZenZRhixHVE/aQUuukYkhK9uaSHhwotuG2K8z
         zTbPO5Yjku83hAu4wf0CvDVTnKRZ9i7KsoAMGcFA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Christophe Leroy <christophe.leroy@c-s.fr>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.4 48/92] powerpc/prom: fix early DEBUG messages
Date:   Wed,  4 Dec 2019 18:49:48 +0100
Message-Id: <20191204174333.370705613@linuxfoundation.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191204174327.215426506@linuxfoundation.org>
References: <20191204174327.215426506@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Christophe Leroy <christophe.leroy@c-s.fr>

[ Upstream commit b18f0ae92b0a1db565c3e505fa87b6971ad3b641 ]

This patch fixes early DEBUG messages in prom.c:
- Use %px instead of %p to see the addresses
- Cast memblock_phys_mem_size() with (unsigned long long) to
avoid build failure when phys_addr_t is not 64 bits.

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/powerpc/kernel/prom.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/kernel/prom.c b/arch/powerpc/kernel/prom.c
index a15fe1d4e84ae..04a27307a2c4d 100644
--- a/arch/powerpc/kernel/prom.c
+++ b/arch/powerpc/kernel/prom.c
@@ -125,7 +125,7 @@ static void __init move_device_tree(void)
 		p = __va(memblock_alloc(size, PAGE_SIZE));
 		memcpy(p, initial_boot_params, size);
 		initial_boot_params = p;
-		DBG("Moved device tree to 0x%p\n", p);
+		DBG("Moved device tree to 0x%px\n", p);
 	}
 
 	DBG("<- move_device_tree\n");
@@ -647,7 +647,7 @@ void __init early_init_devtree(void *params)
 {
 	phys_addr_t limit;
 
-	DBG(" -> early_init_devtree(%p)\n", params);
+	DBG(" -> early_init_devtree(%px)\n", params);
 
 	/* Too early to BUG_ON(), do it by hand */
 	if (!early_init_dt_verify(params))
@@ -707,7 +707,7 @@ void __init early_init_devtree(void *params)
 	memblock_allow_resize();
 	memblock_dump_all();
 
-	DBG("Phys. mem: %llx\n", memblock_phys_mem_size());
+	DBG("Phys. mem: %llx\n", (unsigned long long)memblock_phys_mem_size());
 
 	/* We may need to relocate the flat tree, do it now.
 	 * FIXME .. and the initrd too? */
-- 
2.20.1



