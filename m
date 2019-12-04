Return-Path: <SRS0=oopU=Z2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF566C2BD09
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 18:07:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A3AE3206DF
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 18:07:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1575482830;
	bh=WbGhciv/qtk73dVy7tm29B/NrK/nbLd9KuYwwCP2gxM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=dQTm/DzP98idZYXwNClmnM8mRYAYloJ1s00qCC4k1neDvlyUGpN0XcpDRqi8nHjeW
	 GWkshRMezcpypdxpILwpJ5I4tb4tg7j/hcxQXEq5lFGHjYSYJYyx/4BZVC8O0EEF94
	 NvA9Q4Jv0nIpaQL+jo3x96F3P9wasPE0iSiIkLmg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730711AbfLDSHJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Dec 2019 13:07:09 -0500
Received: from mail.kernel.org ([198.145.29.99]:56326 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729039AbfLDSHF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Dec 2019 13:07:05 -0500
Received: from localhost (unknown [217.68.49.72])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6388D206DF;
        Wed,  4 Dec 2019 18:07:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1575482824;
        bh=WbGhciv/qtk73dVy7tm29B/NrK/nbLd9KuYwwCP2gxM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=euvaVx0ussl4iv/ZGgRkSKvNkJqSrUtodz4jsaUh/NcskhXT5RKr1H1nr0TgG3yj7
         e8Bl4bveiv4MsGT7RQXQbfifTJG8u9+a6qqxNvM1UCoU5VUvMrcVL5DWJ9kZpy7I0t
         qow1dPGOO3E4lWUzfckCdELt1Fy5pzmsypR0fbho=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Borislav Petkov <bp@suse.de>,
        James Morse <james.morse@arm.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 150/209] ACPI / APEI: Dont wait to serialise with oops messages when panic()ing
Date:   Wed,  4 Dec 2019 18:56:02 +0100
Message-Id: <20191204175333.828341942@linuxfoundation.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191204175321.609072813@linuxfoundation.org>
References: <20191204175321.609072813@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: James Morse <james.morse@arm.com>

[ Upstream commit 78b0b690f6558ed788dccafa45965325dd11ba89 ]

oops_begin() exists to group printk() messages with the oops message
printed by die(). To reach this caller we know that platform firmware
took this error first, then notified the OS via NMI with a 'panic'
severity.

Don't wait for another CPU to release the die-lock before panic()ing,
our only goal is to print this fatal error and panic().

This code is always called in_nmi(), and since commit 42a0bb3f7138
("printk/nmi: generic solution for safe printk in NMI"), it has been
safe to call printk() from this context. Messages are batched in a
per-cpu buffer and printed via irq-work, or a call back from panic().

Link: https://patchwork.kernel.org/patch/10313555/
Acked-by: Borislav Petkov <bp@suse.de>
Signed-off-by: James Morse <james.morse@arm.com>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/acpi/apei/ghes.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c
index 5889f6407fea8..9c31c7cd5cb5e 100644
--- a/drivers/acpi/apei/ghes.c
+++ b/drivers/acpi/apei/ghes.c
@@ -33,7 +33,6 @@
 #include <linux/interrupt.h>
 #include <linux/timer.h>
 #include <linux/cper.h>
-#include <linux/kdebug.h>
 #include <linux/platform_device.h>
 #include <linux/mutex.h>
 #include <linux/ratelimit.h>
@@ -936,7 +935,6 @@ static int ghes_notify_nmi(unsigned int cmd, struct pt_regs *regs)
 
 		sev = ghes_severity(ghes->estatus->error_severity);
 		if (sev >= GHES_SEV_PANIC) {
-			oops_begin();
 			ghes_print_queued_estatus();
 			__ghes_panic(ghes);
 		}
-- 
2.20.1



