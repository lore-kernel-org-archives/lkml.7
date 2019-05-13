Return-Path: <SRS0=lMFC=TN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0621C04A6B
	for <linux-kernel@archiver.kernel.org>; Mon, 13 May 2019 02:16:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7F3C3208CB
	for <linux-kernel@archiver.kernel.org>; Mon, 13 May 2019 02:16:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="r6kk+F6u"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727305AbfEMCQB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 12 May 2019 22:16:01 -0400
Received: from conuserg-07.nifty.com ([210.131.2.74]:37608 "EHLO
        conuserg-07.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727054AbfEMCQB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 May 2019 22:16:01 -0400
Received: from localhost.localdomain (p14092-ipngnfx01kyoto.kyoto.ocn.ne.jp [153.142.97.92]) (authenticated)
        by conuserg-07.nifty.com with ESMTP id x4D2EE3v031136;
        Mon, 13 May 2019 11:14:15 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-07.nifty.com x4D2EE3v031136
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1557713655;
        bh=yt8WNEk/c0Lu9DjEl2IG91FINsXeZugKO1ysTYHMkOA=;
        h=From:To:Cc:Subject:Date:From;
        b=r6kk+F6uCUivwteO6G9WgYSMfdoPPwfH/BqDDKvNbx5AMfhf0W0nGULqDWAH22nbR
         dKAMHkzWShvXPE9Lb4uXuHxLz7rnE9reXOWD8HnTebl56KVlVcFH7g2msB5IL2RLIa
         NM8riQlijAhaMElRggAN8FlUu3ICr2bULjIv88u6K0WQZA3va+NISq5Ch7Rr7PIwlP
         FSGbs3u7E6fyxEGawjJ2vziiBOuQiKIWDFBY4dFrLpuZloFYEILOL7BNeGI9ezKTYu
         vNAEXMMveTRKDs1WLFYm6JwRjwze5S30HG4H8lmHklaH3IZaqJNazQke3oZLkUd1WZ
         77J4r6VWaYvyg==
X-Nifty-SrcIP: [153.142.97.92]
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
To:     linux-kbuild@vger.kernel.org
Cc:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        Greentime Hu <green.hu@gmail.com>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        linux-kernel@vger.kernel.org, Guo Ren <guoren@kernel.org>,
        Vincent Chen <deanbo422@gmail.com>,
        Matt Turner <mattst88@gmail.com>,
        Palmer Dabbelt <palmer@sifive.com>,
        linux-alpha@vger.kernel.org, Richard Henderson <rth@twiddle.net>,
        linux-riscv@lists.infradead.org, Albert Ou <aou@eecs.berkeley.edu>
Subject: [PATCH] alpha: move arch/alpha/defconfig to arch/alpha/configs/defconfig
Date:   Mon, 13 May 2019 11:14:05 +0900
Message-Id: <20190513021405.12428-1-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As of Linux 5.1, alpha and s390 are the last architectures that
have defconfig in arch/*/ instead of arch/*/configs/.

  $ find arch -name defconfig | sort
  arch/alpha/defconfig
  arch/arm64/configs/defconfig
  arch/csky/configs/defconfig
  arch/nds32/configs/defconfig
  arch/riscv/configs/defconfig
  arch/s390/defconfig

The arch/$(ARCH)/defconfig is the hard-coded default in Kconfig,
and I want to deprecate it after evacuating the remaining defconfig
into the standard location, arch/*/configs/.

Define KBUILD_DEFCONFIG like other architectures, and move defconfig
into the configs/ subdirectory.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 arch/alpha/Makefile                | 2 ++
 arch/alpha/{ => configs}/defconfig | 0
 2 files changed, 2 insertions(+)
 rename arch/alpha/{ => configs}/defconfig (100%)

diff --git a/arch/alpha/Makefile b/arch/alpha/Makefile
index 12dee59b011c..b3314e0dcb6f 100644
--- a/arch/alpha/Makefile
+++ b/arch/alpha/Makefile
@@ -8,6 +8,8 @@
 # Copyright (C) 1994 by Linus Torvalds
 #
 
+KBUILD_DEFCONFIG := defconfig
+
 NM := $(NM) -B
 
 LDFLAGS_vmlinux	:= -static -N #-relax
diff --git a/arch/alpha/defconfig b/arch/alpha/configs/defconfig
similarity index 100%
rename from arch/alpha/defconfig
rename to arch/alpha/configs/defconfig
-- 
2.17.1

