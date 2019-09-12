Return-Path: <SRS0=nCuq=XH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25478C4CEC6
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Sep 2019 13:49:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ECE2220856
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Sep 2019 13:49:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=c-s.fr header.i=@c-s.fr header.b="PpkVSY9G"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732249AbfILNtm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Sep 2019 09:49:42 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:43914 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731209AbfILNtl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Sep 2019 09:49:41 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 46Tg9v0znqz9tyn4;
        Thu, 12 Sep 2019 15:49:39 +0200 (CEST)
Authentication-Results: localhost; dkim=pass
        reason="1024-bit key; insecure key"
        header.d=c-s.fr header.i=@c-s.fr header.b=PpkVSY9G; dkim-adsp=pass;
        dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id Wf5kk3MVvHvj; Thu, 12 Sep 2019 15:49:39 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 46Tg9t71PYz9tyn0;
        Thu, 12 Sep 2019 15:49:38 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
        t=1568296179; bh=d2QKZgIsoKBN+peITw+555bks/d8W8e+DijVX+dp8BY=;
        h=From:Subject:To:Cc:Date:From;
        b=PpkVSY9Gqb+knPHWbIUSQD/D+v2EuU1ilWPUrwsA+RereHq+2h/jUGl30Iy9zmRT4
         ppHWVyM4vJ4rew4cLuCqRz9v4MUL537VXiPBCd74DegYXJqC0rJmI03VgEE/u/0N5F
         pW8LIAgMlAA0JP4k5ML0pTaonfnUW3WkZaGz3oSg=
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 872498B93B;
        Thu, 12 Sep 2019 15:49:40 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id 4UtH4FD05xBO; Thu, 12 Sep 2019 15:49:40 +0200 (CEST)
Received: from pc16032vm.idsi0.si.c-s.fr (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 525488B933;
        Thu, 12 Sep 2019 15:49:40 +0200 (CEST)
Received: by pc16032vm.idsi0.si.c-s.fr (Postfix, from userid 0)
        id 31A5D6B736; Thu, 12 Sep 2019 13:49:40 +0000 (UTC)
Message-Id: <cover.1568295907.git.christophe.leroy@c-s.fr>
From:   Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH v1 0/4] powerpc: Add support for GENERIC_EARLY_IOREMAP
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>, npiggin@gmail.com,
        hch@infradead.org
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date:   Thu, 12 Sep 2019 13:49:40 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series adds support for GENERIC_EARLY_IOREMAP on powerpc.

It also adds a warning in the standard ioremap() when it's called
before vmalloc is available in order to help locate those users.

Next step will be to incrementaly migrate all early users of
ioremap() to using early_ioremap() or other method.

Once they are all converted we can drop all the logic
behind ioremap_bot.

Christophe Leroy (4):
  powerpc/fixmap: don't clear fixmap area in paging_init()
  powerpc/fixmap: Use __fix_to_virt() instead of fix_to_virt()
  powerpc: Add support for GENERIC_EARLY_IOREMAP
  powerpc/ioremap: warn on early use of ioremap()

 arch/powerpc/Kconfig              |  1 +
 arch/powerpc/include/asm/Kbuild   |  1 +
 arch/powerpc/include/asm/fixmap.h | 19 ++++++++++++++++++-
 arch/powerpc/kernel/setup_32.c    |  3 +++
 arch/powerpc/kernel/setup_64.c    |  3 +++
 arch/powerpc/mm/ioremap_32.c      |  1 +
 arch/powerpc/mm/ioremap_64.c      |  2 ++
 arch/powerpc/mm/mem.c             |  8 --------
 8 files changed, 29 insertions(+), 9 deletions(-)

-- 
2.13.3

