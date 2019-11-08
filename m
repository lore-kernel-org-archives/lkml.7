Return-Path: <SRS0=1LW7=ZA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81838C5DF60
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 19:23:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 50FC5207FA
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 19:23:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573240993;
	bh=gY/L2MAepOxsg87cErfdhKPZBxQzNz+ZaHqFOcO4FWU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=z4i8ROmjWx4wyvMDFI2EGI5hvley6q6Tz1fBFVEH/hjDpk0DT4zYiokpseONIs9kt
	 y3ZtqTsbESYKDyt5zsSTKnWryuAQ5+TcR2cDSm2EYMJHD8rUuq4pryPLgJMZOJwAFk
	 hFrh94KcYsKsbZhFd8lGoBqW5SHRwJ+ZuEJd90RA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730555AbfKHTXM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Nov 2019 14:23:12 -0500
Received: from mail.kernel.org ([198.145.29.99]:52346 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731269AbfKHSzI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Nov 2019 13:55:08 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DCB2720865;
        Fri,  8 Nov 2019 18:55:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573239307;
        bh=gY/L2MAepOxsg87cErfdhKPZBxQzNz+ZaHqFOcO4FWU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=zMo9uXqPHd28fP+uvwmgI3a0DJ+pNu4s8ImKISC+mFCYwVfD5zxHVIQWxcnAv0uDV
         92goPHDOqJU4VtKNh0SgwLSWGtU8Go+NnC+fGhRb3ChyR0GeH1mc9Nr5S3ZMHa74tF
         BGLTppwFTE2wa0iFhTBfanUb6wmF6FpiY60BtDc4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "linus.walleij@linaro.org, rmk+kernel@armlinux.org.uk, Ard Biesheuvel" 
        <ardb@kernel.org>, Julien Thierry <julien.thierry@arm.com>,
        Russell King <rmk+kernel@armlinux.org.uk>,
        "David A. Long" <dave.long@linaro.org>,
        Sasha Levin <sashal@kernel.org>,
        Ard Biesheuvel <ardb@kernel.org>
Subject: [PATCH 4.4 69/75] ARM: clean up per-processor check_bugs method call
Date:   Fri,  8 Nov 2019 19:50:26 +0100
Message-Id: <20191108174810.309879161@linuxfoundation.org>
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

Commit 945aceb1db8885d3a35790cf2e810f681db52756 upstream.

Call the per-processor type check_bugs() method in the same way as we
do other per-processor functions - move the "processor." detail into
proc-fns.h.

Reviewed-by: Julien Thierry <julien.thierry@arm.com>
Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
Signed-off-by: David A. Long <dave.long@linaro.org>
Reviewed-by: Julien Thierry <julien.thierry@arm.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/arm/include/asm/proc-fns.h |    1 +
 arch/arm/kernel/bugs.c          |    4 ++--
 2 files changed, 3 insertions(+), 2 deletions(-)

--- a/arch/arm/include/asm/proc-fns.h
+++ b/arch/arm/include/asm/proc-fns.h
@@ -99,6 +99,7 @@ extern void cpu_do_suspend(void *);
 extern void cpu_do_resume(void *);
 #else
 #define cpu_proc_init			processor._proc_init
+#define cpu_check_bugs			processor.check_bugs
 #define cpu_proc_fin			processor._proc_fin
 #define cpu_reset			processor.reset
 #define cpu_do_idle			processor._do_idle
--- a/arch/arm/kernel/bugs.c
+++ b/arch/arm/kernel/bugs.c
@@ -6,8 +6,8 @@
 void check_other_bugs(void)
 {
 #ifdef MULTI_CPU
-	if (processor.check_bugs)
-		processor.check_bugs();
+	if (cpu_check_bugs)
+		cpu_check_bugs();
 #endif
 }
 


