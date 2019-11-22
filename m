Return-Path: <SRS0=i7el=ZO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC64CC432C0
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 05:58:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BB83C2068F
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 05:58:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574402318;
	bh=WbGhciv/qtk73dVy7tm29B/NrK/nbLd9KuYwwCP2gxM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=SGSQ5gBQ5Jf6Aj92rCBXke2vCqTo2dPAQEQNwV8lqQj8lZOvBW49hschZ9xGojrqk
	 y3htsXhcoFRT7zqQj7afTv9z14WPpxlGm4jQaRNaSeLVMRsac2pNsjH51xEORaDkrn
	 HAo3Yl4A4zx1H1zNucs1mamTHQw2QhYMEsUGepyU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727205AbfKVF6T (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Nov 2019 00:58:19 -0500
Received: from mail.kernel.org ([198.145.29.99]:36718 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727080AbfKVF6E (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Nov 2019 00:58:04 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 94C5F207FA;
        Fri, 22 Nov 2019 05:58:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574402283;
        bh=WbGhciv/qtk73dVy7tm29B/NrK/nbLd9KuYwwCP2gxM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ZwoQAQNM7z00DeVzArDXAKIdDraTNFjk7S31c5/4zHDaBQ8mT5wmnYSVoJ4biekai
         IeHYENbLIoHFByDG8Wf6AdYGTT5m0FfH16nCA+EDK6va0ylxqbmL6FftB2tOP1sp4P
         kM5Jab33oycRmsLNrulXaPSA+OxjCzGburysgl7c=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     James Morse <james.morse@arm.com>, Borislav Petkov <bp@suse.de>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Sasha Levin <sashal@kernel.org>, linux-acpi@vger.kernel.org
Subject: [PATCH AUTOSEL 4.14 122/127] ACPI / APEI: Don't wait to serialise with oops messages when panic()ing
Date:   Fri, 22 Nov 2019 00:55:39 -0500
Message-Id: <20191122055544.3299-120-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191122055544.3299-1-sashal@kernel.org>
References: <20191122055544.3299-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
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

