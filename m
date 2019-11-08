Return-Path: <SRS0=1LW7=ZA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3CFCFA372C
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 18:55:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ADA9E21D7B
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 18:55:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573239312;
	bh=ujPc1fIhvRd5erak0GQgPSowVKTT2kQickvsRoK/fVc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=AcVk+X2h1o9jo2ZkIMiIABmDnsPMeDDd7HVoqEmLcryTsv85ZiI3eKN4yrJTOz/Qr
	 1zxsdvv7zhct5yB/zK4wQeOOd+PB3uk4l4pRcjoBTpzyVHZLF2NsYyAeRqPmZwxYwZ
	 CSNUKszqy8mZ0s1Yi+oxyMiTqrFYZrMDi/jec9w8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733243AbfKHSzK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Nov 2019 13:55:10 -0500
Received: from mail.kernel.org ([198.145.29.99]:52212 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731278AbfKHSzG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Nov 2019 13:55:06 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1904920865;
        Fri,  8 Nov 2019 18:55:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573239301;
        bh=ujPc1fIhvRd5erak0GQgPSowVKTT2kQickvsRoK/fVc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=t+L0pGSoOxjsvo6SIPBAT3xDkX8fIClzZnG6E221xjdnWc9E/eVjnlxPhuDJBNf32
         RH2/jigcUgXruCiCL53NHqdKGZljKv6/kgTHy5kotwqm/fAf18m2ebfM2H21yzAchP
         KQH6Mlav6guq8BZ3F6zqzsyQX7n5gk5MI+SVNWHI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "linus.walleij@linaro.org, rmk+kernel@armlinux.org.uk, Ard Biesheuvel" 
        <ardb@kernel.org>, Julien Thierry <julien.thierry@arm.com>,
        Russell King <rmk+kernel@armlinux.org.uk>,
        "David A. Long" <dave.long@linaro.org>,
        Sasha Levin <sashal@kernel.org>,
        Ard Biesheuvel <ardb@kernel.org>
Subject: [PATCH 4.4 67/75] ARM: make lookup_processor_type() non-__init
Date:   Fri,  8 Nov 2019 19:50:24 +0100
Message-Id: <20191108174809.058667447@linuxfoundation.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191108174708.135680837@linuxfoundation.org>
References: <20191108174708.135680837@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Russell King <rmk+kernel@armlinux.org.uk>

Commit 899a42f836678a595f7d2bc36a5a0c2b03d08cbc upstream.

Move lookup_processor_type() out of the __init section so it is callable
from (eg) the secondary startup code during hotplug.

Reviewed-by: Julien Thierry <julien.thierry@arm.com>
Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
Signed-off-by: David A. Long <dave.long@linaro.org>
Reviewed-by: Julien Thierry <julien.thierry@arm.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/arm/kernel/head-common.S |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

--- a/arch/arm/kernel/head-common.S
+++ b/arch/arm/kernel/head-common.S
@@ -122,6 +122,9 @@ __mmap_switched_data:
 	.long	init_thread_union + THREAD_START_SP @ sp
 	.size	__mmap_switched_data, . - __mmap_switched_data
 
+	__FINIT
+	.text
+
 /*
  * This provides a C-API version of __lookup_processor_type
  */
@@ -133,9 +136,6 @@ ENTRY(lookup_processor_type)
 	ldmfd	sp!, {r4 - r6, r9, pc}
 ENDPROC(lookup_processor_type)
 
-	__FINIT
-	.text
-
 /*
  * Read processor ID register (CP#15, CR0), and look up in the linker-built
  * supported processor list.  Note that we can't use the absolute addresses


