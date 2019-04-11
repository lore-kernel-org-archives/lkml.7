Return-Path: <SRS0=BPXs=SN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB62CC10F14
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 10:30:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9A8312184E
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 10:30:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=codeweavers.com header.i=@codeweavers.com header.b="qk1Q4L40"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726772AbfDKKaz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Apr 2019 06:30:55 -0400
Received: from mail.codeweavers.com ([173.240.25.211]:55710 "EHLO
        mail.codeweavers.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726711AbfDKKav (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Apr 2019 06:30:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=codeweavers.com; s=6377696661; h=Message-Id:Date:Subject:Cc:To:From:Sender:
        Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=NaJFx3V0PFAfo1+my5pcCmF+ykxLUO2wGcBLGrk3uhc=; b=qk1Q4L40exJkB3p+Ce/hQ72n8M
        ple1hI8QBniJUM8m/Kva8PdmVbiw3/QoUhf9LmxJ8VYzs/klvzDFFjKMRA3dqF3B4mdaZPrfVkWNN
        C/DblkDdUyeD+4FXbTV6ZzFiUhD6NkMGrkv+MxftRoKHK/XP69HROjo+vt3R9dAfcYDU=;
Received: from vpn42.vpn.mn.codeweavers.com ([10.69.139.42] helo=merlot)
        by mail.codeweavers.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <huw@codeweavers.com>)
        id 1hEWgg-0000mx-7N; Thu, 11 Apr 2019 05:12:07 -0500
Received: from daviesh by merlot with local (Exim 4.90_1)
        (envelope-from <huw@codeweavers.com>)
        id 1hEWgf-0002cm-5x; Thu, 11 Apr 2019 11:12:05 +0100
From:   Huw Davies <huw@codeweavers.com>
To:     linux kernel <linux-kernel@vger.kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Andy Lutomirski <luto@kernel.org>
Subject: [PATCH 0/3] x86/vdso: Add support for CLOCK_MONOTONIC_RAW in the vDSO
Date:   Thu, 11 Apr 2019 11:12:02 +0100
Message-Id: <20190411101205.10006-1-huw@codeweavers.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series adds support for the CLOCK_MONOTONIC_RAW clock in the x86
vDSO, thus decreasing its readout cost.  This is particularly useful
for Wine which needs to implement Win32 API clock functions whose
value does not get adjusted with adjtimex().

Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Andy Lutomirski <luto@kernel.org>

Huw Davies (3):
  x86/vdso: Remove unused 'mask' member
  x86/vdso: Allow clock specific mult and shift values
  x86/vdso: Add support for CLOCK_MONOTONIC_RAW in the vDSO

 arch/x86/entry/vdso/vclock_gettime.c    |  4 ++--
 arch/x86/entry/vsyscall/vsyscall_gtod.c | 15 ++++++++++++---
 arch/x86/include/asm/vgtod.h            | 10 +++++-----
 3 files changed, 19 insertions(+), 10 deletions(-)

-- 
2.17.1

