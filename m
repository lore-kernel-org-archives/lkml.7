Return-Path: <SRS0=KBKa=UT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39197C43613
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Jun 2019 18:21:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 13A372089C
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Jun 2019 18:21:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1561054874;
	bh=xwCTgva9OI67grSH5Oh2hITs1mJLqZptYrYyn964VaQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=BD0RF3PtfnR4p59y4XEm6sU665P/coBGb8kghn/l6BxNFRv8cmQrHzhb9D7imf5h4
	 JXIfoVomJ/kQ/Rw4AqTSkYRHC+xB3tLEaa1BY7sf7C340KCO0fb5sfLcafHomu+q0t
	 bz9MiL2rNY6S8L2t4fhVikKTbRS10gZ0jOE2M1Kg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729094AbfFTSMs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Jun 2019 14:12:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:40636 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728841AbfFTSMp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jun 2019 14:12:45 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 005232089C;
        Thu, 20 Jun 2019 18:12:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1561054364;
        bh=xwCTgva9OI67grSH5Oh2hITs1mJLqZptYrYyn964VaQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=uRU7a2EiWJmvq7e/rR1cMvx6ie9TyRnTtFIDXkFXOQ0MAMwtmwi7EXMydgLxHJRQK
         1+gEd1cnf8dNx3QZLixp6X6n8hHltBgFUGffko9wmx8ZeyKWpemoVUqZnGn8H2v8/f
         T9clsK2fL0v+mesil05W+3hKcvKxWHDKO++MS5zE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, kbuild test robot <lkp@intel.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Tony Luck <tony.luck@intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>, linux-ia64@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 43/61] ia64: fix build errors by exporting paddr_to_nid()
Date:   Thu, 20 Jun 2019 19:57:38 +0200
Message-Id: <20190620174344.741589952@linuxfoundation.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190620174336.357373754@linuxfoundation.org>
References: <20190620174336.357373754@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Upstream commit 9a626c4a6326da4433a0d4d4a8a7d1571caf1ed3 ]

Fix build errors on ia64 when DISCONTIGMEM=y and NUMA=y by
exporting paddr_to_nid().

Fixes these build errors:

ERROR: "paddr_to_nid" [sound/core/snd-pcm.ko] undefined!
ERROR: "paddr_to_nid" [net/sunrpc/sunrpc.ko] undefined!
ERROR: "paddr_to_nid" [fs/cifs/cifs.ko] undefined!
ERROR: "paddr_to_nid" [drivers/video/fbdev/core/fb.ko] undefined!
ERROR: "paddr_to_nid" [drivers/usb/mon/usbmon.ko] undefined!
ERROR: "paddr_to_nid" [drivers/usb/core/usbcore.ko] undefined!
ERROR: "paddr_to_nid" [drivers/md/raid1.ko] undefined!
ERROR: "paddr_to_nid" [drivers/md/dm-mod.ko] undefined!
ERROR: "paddr_to_nid" [drivers/md/dm-crypt.ko] undefined!
ERROR: "paddr_to_nid" [drivers/md/dm-bufio.ko] undefined!
ERROR: "paddr_to_nid" [drivers/ide/ide-core.ko] undefined!
ERROR: "paddr_to_nid" [drivers/ide/ide-cd_mod.ko] undefined!
ERROR: "paddr_to_nid" [drivers/gpu/drm/drm.ko] undefined!
ERROR: "paddr_to_nid" [drivers/char/agp/agpgart.ko] undefined!
ERROR: "paddr_to_nid" [drivers/block/nbd.ko] undefined!
ERROR: "paddr_to_nid" [drivers/block/loop.ko] undefined!
ERROR: "paddr_to_nid" [drivers/block/brd.ko] undefined!
ERROR: "paddr_to_nid" [crypto/ccm.ko] undefined!

Reported-by: kbuild test robot <lkp@intel.com>
Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Tony Luck <tony.luck@intel.com>
Cc: Fenghua Yu <fenghua.yu@intel.com>
Cc: linux-ia64@vger.kernel.org
Signed-off-by: Tony Luck <tony.luck@intel.com>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/ia64/mm/numa.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/ia64/mm/numa.c b/arch/ia64/mm/numa.c
index aa19b7ac8222..476c7b4be378 100644
--- a/arch/ia64/mm/numa.c
+++ b/arch/ia64/mm/numa.c
@@ -49,6 +49,7 @@ paddr_to_nid(unsigned long paddr)
 
 	return (i < num_node_memblks) ? node_memblk[i].nid : (num_node_memblks ? -1 : 0);
 }
+EXPORT_SYMBOL(paddr_to_nid);
 
 #if defined(CONFIG_SPARSEMEM) && defined(CONFIG_NUMA)
 /*
-- 
2.20.1



