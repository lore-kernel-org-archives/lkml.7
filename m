Return-Path: <SRS0=GVTe=2R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF2B0C2D0CE
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Dec 2019 18:04:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 808EC206F4
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Dec 2019 18:04:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="HYgNBWuj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727807AbfL0SEB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Dec 2019 13:04:01 -0500
Received: from us03-smtprelay2.synopsys.com ([149.117.87.133]:40748 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726924AbfL0SD7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Dec 2019 13:03:59 -0500
Received: from mailhost.synopsys.com (mdc-mailhost2.synopsys.com [10.225.0.210])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 05D27C09A8;
        Fri, 27 Dec 2019 18:03:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1577469838; bh=gracVR8grdfKa4Mu3uHEMLQb3guva6KDpPC9UDLgqHs=;
        h=From:To:Cc:Subject:Date:From;
        b=HYgNBWujgmoxrs3Z3IaqKCE2LThkjEjOTPjbLrpLlzdRXN1MdODUxYHkBUqVaDFJC
         7+3u+Sus10E6pyHoz5djN9kJX4ms6k8XdM6x1uoeh9V6jJv7WuTGF16SuZrKHdyc0z
         ODjLODi6Ikfe21Qz/B2xWrIT55kmSDBZsD+7n+HZDr2qu2D1HrA1YsnCkLNONOqEiG
         pGMB9Qq3GvSTl91m3VVBdydHYV42MCyTd1Ce0JH3ZDqsO538x/Oz4Cnus80i7iVMRH
         hVzL7oDVdoU0zUp92DnUS8TdFc3ywnQi6FT1R+HFCeBG++I4pl50IcU8/QOx6oHdnK
         RlledONAiWvXw==
Received: from paltsev-e7480.internal.synopsys.com (unknown [10.121.8.65])
        by mailhost.synopsys.com (Postfix) with ESMTP id 51207A005D;
        Fri, 27 Dec 2019 18:03:54 +0000 (UTC)
From:   Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
To:     linux-snps-arc@lists.infradead.org,
        Vineet Gupta <Vineet.Gupta1@synopsys.com>
Cc:     linux-kernel@vger.kernel.org,
        Alexey Brodkin <Alexey.Brodkin@synopsys.com>,
        Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
Subject: [RFC 0/5] ARC: handle DSP presence in HW
Date:   Fri, 27 Dec 2019 21:03:42 +0300
Message-Id: <20191227180347.3579-1-Eugeniy.Paltsev@synopsys.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Arc processors may have DSP extension which is optional.
In this patch series we:
* Handle issues caused by DSP extension presence in HW
* Add optional support for DSP-enabled applications in
  userspace (with optional AGU extension support)
* Do minor cleanups

Eugeniy Paltsev (5):
  ARC: pt_regs: remove hardcoded registers offset
  ARC: add helpers to sanitize config options
  ARC: handle DSP presence in HW
  ARC: add support for DSP-enabled userspace applications
  ARC: allow userspace DSP applications to use AGU extensions

 arch/arc/Kconfig                   |  39 +++++++-
 arch/arc/include/asm/arcregs.h     |  26 ++++++
 arch/arc/include/asm/dsp-impl.h    | 141 +++++++++++++++++++++++++++++
 arch/arc/include/asm/dsp.h         |  50 ++++++++++
 arch/arc/include/asm/entry-arcv2.h |  14 ++-
 arch/arc/include/asm/processor.h   |   4 +
 arch/arc/include/asm/ptrace.h      |   4 +
 arch/arc/include/asm/switch_to.h   |   2 +
 arch/arc/kernel/asm-offsets.c      |  16 ++++
 arch/arc/kernel/head.S             |   4 +
 arch/arc/kernel/setup.c            |  47 +++++++---
 11 files changed, 329 insertions(+), 18 deletions(-)
 create mode 100644 arch/arc/include/asm/dsp-impl.h
 create mode 100644 arch/arc/include/asm/dsp.h

-- 
2.21.0

