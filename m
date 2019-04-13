Return-Path: <SRS0=NhyN=SP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B193C10F11
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Apr 2019 22:44:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EBD30218C3
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Apr 2019 22:44:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555195490;
	bh=VhO3hJkEHA/k1EYeU8ERxFLcTP4nzuN8R7Jz7kRTTOE=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=EOp1qoYJ6xXYPoTUyOWVP9rgCA1srOLGJwx+d5KcGKCNAMtratMkbowCWGXNa8BHe
	 lqBpaW0+7OJx0QDxu8uJEEEI3Hh4HB1KgxzkOCpFII52gq1Z5InLVxw8uexXzxzAKF
	 9c3k6cpgTVxyfmHYaZemqcaVE25iGgcG4nzrw4SM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727185AbfDMWol (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 13 Apr 2019 18:44:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:57276 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727048AbfDMWol (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Apr 2019 18:44:41 -0400
Received: from sinanubuntu1604.mkjiurmyylmellclgttazegk5f.bx.internal.cloudapp.net (unknown [40.117.159.179])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 69F1A2147A;
        Sat, 13 Apr 2019 22:44:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1555195480;
        bh=VhO3hJkEHA/k1EYeU8ERxFLcTP4nzuN8R7Jz7kRTTOE=;
        h=From:To:Cc:Subject:Date:From;
        b=Sdc/1OqbqAMrBnItfh5P1yHqP0wAyLL6Iftmw76D1G18AIyBMd68ZDV+pX1JnEC+n
         o9AXOqotapEfoI/VEkuqO+XCEzn5i9Qg22LepULVs/YENs2eh8dTYT9TrZqjZ1RgJy
         lf8fZircagObRS7BJeHnmhKX2dCpDbjtoSglHuJw=
From:   Sinan Kaya <okaya@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     josh@joshtriplett.org, keescook@chromium.org,
        Sinan Kaya <okaya@kernel.org>
Subject: [PATCH v5 0/5] init: Do not select DEBUG_KERNEL by default
Date:   Sat, 13 Apr 2019 22:44:33 +0000
Message-Id: <20190413224438.10802-1-okaya@kernel.org>
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

Diff from v4:
- collect reviewed-by
- collect acked-by
- fix nit on 1/5

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

