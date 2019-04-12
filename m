Return-Path: <SRS0=nVcb=SO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3FE6C10F13
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 01:44:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6AB9E2084D
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 01:44:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555033445;
	bh=s2o9JDOCnesBuFb9IrnDW1tnaBA2g4Htst0Zzr7K3ys=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=uh64ObGFyFAshRWsvJfk27mlAAP/KILRHanmWpTHTQm6OX9/qn7z+R6DtzHwOsl4G
	 e+b91cpOK0X/g1liNuYxJPvvNwkkM5O8nG8793v8xMaSwP8l3IRJ4RKnUD0QRwDmcL
	 tLuFHR2tXeOaAih8i24gXUaBfg2wnuykmCJNTg9o=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726812AbfDLBoE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Apr 2019 21:44:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:54542 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726677AbfDLBoD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Apr 2019 21:44:03 -0400
Received: from sinanubuntu1604.mkjiurmyylmellclgttazegk5f.bx.internal.cloudapp.net (unknown [52.191.113.170])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C6F9C20674;
        Fri, 12 Apr 2019 01:44:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1555033443;
        bh=s2o9JDOCnesBuFb9IrnDW1tnaBA2g4Htst0Zzr7K3ys=;
        h=From:To:Cc:Subject:Date:From;
        b=IqBwCwKn4Zo9ebb82nqHKE36yRuiZ6ZYLet+zjUcWvL/RMTkrekGwRk1h3vJ+iB8L
         Xr93DX7VWURGghArLT/1aNFweBQu151pLt6b9bp1MSQu14vLu+ghqhzT4ea4/5oXeA
         vqiTI8DdYusB2an5Rfg951upsrtQIghJYa4+anqI=
From:   Sinan Kaya <okaya@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     josh@joshtriplett.org, keescook@chromium.org,
        Sinan Kaya <okaya@kernel.org>
Subject: [PATCH v4 0/5] init: Do not select DEBUG_KERNEL by default
Date:   Fri, 12 Apr 2019 01:43:50 +0000
Message-Id: <20190412014355.25307-1-okaya@kernel.org>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

CONFIG_DEBUG_KERNEL has been designed to just enable Kconfig options.
Kernel code generatoin should not depend on CONFIG_DEBUG_KERNEL.

Proposed alternative plan: let's add a new symbol, something like
DEBUG_MISC ("Miscellaneous debug code that should be under a more
specific debug option but isn't"), make it depend on DEBUG_KERNEL and be
"default DEBUG_KERNEL" but allow itself to be turned off, and then
mechanically change the small handful of "#ifdef CONFIG_DEBUG_KERNEL" to
"#ifdef CONFIG_DEBUG_MISC".

Sinan Kaya (5):
  init: Introduce DEBUG_MISC option
  powerpc: Replace CONFIG_DEBUG_KERNEL with CONFIG_DEBUG_MISC
  mips: Replace CONFIG_DEBUG_KERNEL with CONFIG_DEBUG_MISC
  xtensa: Replace CONFIG_DEBUG_KERNEL with CONFIG_DEBUG_MISC
  net: Replace CONFIG_DEBUG_KERNEL with CONFIG_DEBUG_MISC

 arch/mips/kernel/setup.c           | 2 +-
 arch/powerpc/kernel/sysfs.c        | 8 ++++----
 arch/xtensa/include/asm/irqflags.h | 2 +-
 arch/xtensa/kernel/smp.c           | 2 +-
 lib/Kconfig.debug                  | 9 +++++++++
 net/netfilter/core.c               | 2 +-
 6 files changed, 17 insertions(+), 8 deletions(-)

-- 
2.21.0

