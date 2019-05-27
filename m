Return-Path: <SRS0=8QAT=T3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F965C28CBF
	for <linux-kernel@archiver.kernel.org>; Mon, 27 May 2019 08:35:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2787C21734
	for <linux-kernel@archiver.kernel.org>; Mon, 27 May 2019 08:35:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="zqPVOvMo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726653AbfE0IfZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 May 2019 04:35:25 -0400
Received: from conuserg-10.nifty.com ([210.131.2.77]:51235 "EHLO
        conuserg-10.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726543AbfE0IfT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 May 2019 04:35:19 -0400
Received: from localhost.localdomain (p14092-ipngnfx01kyoto.kyoto.ocn.ne.jp [153.142.97.92]) (authenticated)
        by conuserg-10.nifty.com with ESMTP id x4R8Yoq3030794;
        Mon, 27 May 2019 17:34:51 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-10.nifty.com x4R8Yoq3030794
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1558946091;
        bh=uljHGbwcwma+Yj7XR85d+MU5D/JvVLcbwHSAmJZ31rU=;
        h=From:To:Cc:Subject:Date:From;
        b=zqPVOvMowzvhINtwY2QxxN5u+dR1diQPRnYA2a3M5M+kf2exzqxxTqLujOt6DnGP2
         QsZwnXgdU1DFX8JbiZ57RTbw7zer6uVU2zbmc8KVZORVipqdBlcC8/FD7CF162ibws
         A7l3HW7fp/NLvq+uKuXpXggu/FXN4avIJrKlEXEQpM/knEb+g5QTEcP0+rvtGO1H5Y
         Z4QX75CfgEH0y3qbfD9hCs5WPHzBqcrJ6L7xvyMPth/K07KXzA8/hbWXsKI5Eq1CxY
         AoJx1kd3wjdp5OM5xyxVWSa6usleyGgXM/MYlU7cR93MBPLV8avC3v62/TIkS2JCMy
         vwmid5QDw46NQ==
X-Nifty-SrcIP: [153.142.97.92]
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
To:     linux-arm-kernel@lists.infradead.org,
        Will Deacon <will.deacon@arm.com>
Cc:     linux-kernel@vger.kernel.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>
Subject: [PATCH 0/2] Allow assembly code to use BIT(), GENMASK(), etc. and clean-up arm64 header
Date:   Mon, 27 May 2019 17:34:10 +0900
Message-Id: <20190527083412.26651-1-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Some in-kernel headers use _BITUL() instead of BIT().

 arch/arm64/include/asm/sysreg.h
 arch/s390/include/asm/*.h

I think the reason is because BIT() is currently not available
in assembly. It hard-codes 1UL, which is not available in assembly.

1/2 replaced
   1UL -> UL(1)
   0UL -> UL(0)
   1ULL -> ULL(1)
   0ULL -> ULL(0)

With this, there is no more restriction that prevents assembly
code from using them.

2/2 is a clean-up as as example.

I can contribute to cleanups of arch/s390/, etc.
once this series lands in upstream.

I hope both patches can go in the arm64 tree.



Masahiro Yamada (2):
  linux/bits.h: make BIT(), GENMASK(), and friends available in assembly
  arm64: replace _BITUL() with BIT()

 arch/arm64/include/asm/sysreg.h | 82 ++++++++++++++++-----------------
 include/linux/bits.h            | 17 ++++---
 2 files changed, 51 insertions(+), 48 deletions(-)

-- 
2.17.1

