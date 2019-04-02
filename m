Return-Path: <SRS0=bo2+=SE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C8DCC10F00
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 09:08:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F1B3720882
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 09:08:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=c-s.fr header.i=@c-s.fr header.b="bXSCWwiI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729818AbfDBJIh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Apr 2019 05:08:37 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:25450 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726790AbfDBJIg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Apr 2019 05:08:36 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 44YNfp2KQZz9v0ZZ;
        Tue,  2 Apr 2019 11:08:34 +0200 (CEST)
Authentication-Results: localhost; dkim=pass
        reason="1024-bit key; insecure key"
        header.d=c-s.fr header.i=@c-s.fr header.b=bXSCWwiI; dkim-adsp=pass;
        dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id xeYOJjuk7SOh; Tue,  2 Apr 2019 11:08:34 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 44YNfp14F7z9v0ZY;
        Tue,  2 Apr 2019 11:08:34 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
        t=1554196114; bh=j2Z/SxIguK6XhWdiwmCM8+0HPRCiMDEgAkEU3q/M5VE=;
        h=From:Subject:To:Cc:Date:From;
        b=bXSCWwiIJHjdAHDBhPvgzHs2eHvcV9mejxrVn7RwWHdIeQ5afkXG3rW4E5USpm/vu
         YP85+NTGWJUV66BDq8dwmti5iatQAsCcKpu5gt0AKzh72Q2edE96UfUGlG1tbgFk81
         4W9Y+4GGTqadZLbNN6XN+/M6vtmbtJNeXrUa4WCw=
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 3FDE88B8C3;
        Tue,  2 Apr 2019 11:08:35 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id YyTggLTXWqzu; Tue,  2 Apr 2019 11:08:35 +0200 (CEST)
Received: from po16846vm.idsi0.si.c-s.fr (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 15D998B8C0;
        Tue,  2 Apr 2019 11:08:35 +0200 (CEST)
Received: by po16846vm.idsi0.si.c-s.fr (Postfix, from userid 0)
        id C138E661D9; Tue,  2 Apr 2019 09:08:34 +0000 (UTC)
Message-Id: <cover.1554195798.git.christophe.leroy@c-s.fr>
From:   Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH 0/9] Improve boot command line handling
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>, danielwa@cisco.com
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-arch@vger.kernel.org
Date:   Tue,  2 Apr 2019 09:08:34 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The purpose of this series is to improve and enhance the
handling of kernel boot arguments.

It is first focussed on powerpc but also extends the capability
for other arches.

This is based on suggestion from Daniel Walker <danielwa@cisco.com>

Christophe Leroy (9):
  powerpc: enable appending of CONFIG_CMDLINE to bootloader's cmdline.
  Add generic function to build command line.
  drivers: of: use cmdline building function
  powerpc/prom_init: get rid of PROM_SCRATCH_SIZE
  powerpc: convert to generic builtin command line
  Add capability to prepend the command line
  powerpc: add capability to prepend default command line
  Gives arches opportunity to use generically defined boot cmdline
    manipulation
  powerpc: use generic CMDLINE manipulations

 arch/powerpc/Kconfig                   | 23 ++------------
 arch/powerpc/kernel/prom_init.c        | 38 ++++++++++-------------
 arch/powerpc/kernel/prom_init_check.sh |  2 +-
 drivers/of/fdt.c                       | 23 +++-----------
 include/linux/cmdline.h                | 37 ++++++++++++++++++++++
 init/Kconfig                           | 56 ++++++++++++++++++++++++++++++++++
 6 files changed, 117 insertions(+), 62 deletions(-)
 create mode 100644 include/linux/cmdline.h

-- 
2.13.3

