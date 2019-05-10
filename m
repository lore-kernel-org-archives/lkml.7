Return-Path: <SRS0=sufd=TK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 986DDC04A6B
	for <linux-kernel@archiver.kernel.org>; Fri, 10 May 2019 06:10:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 644352182B
	for <linux-kernel@archiver.kernel.org>; Fri, 10 May 2019 06:10:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1557468656;
	bh=dNIVI5l2X20SzPqGYcEUUEt02rrptMeSMITb0ZlClcY=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=Vp1ZFA0pdmo9Q7DJxhxfIrbPskxMD+ybt0NNwTFSEKYcxwh9e19WhJhbf91zWpbVl
	 N0Dh+fprYaQPxujzCAxhDimbmLqO5GUJij8IiH9N8u0zzwegkmF1AY2xRGwvpNcwsD
	 sxkQksSxpZI7caDswGiXMc06cOefBEt0IEN8ArQY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727073AbfEJGKz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 May 2019 02:10:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:52636 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726305AbfEJGKz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 May 2019 02:10:55 -0400
Received: from localhost.localdomain (unknown [60.186.222.240])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CEBB32175B;
        Fri, 10 May 2019 06:10:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1557468654;
        bh=dNIVI5l2X20SzPqGYcEUUEt02rrptMeSMITb0ZlClcY=;
        h=From:To:Cc:Subject:Date:From;
        b=IK6yNx53vlx+I65OmEhOKTZYZzTi3iwt29T27Vb0N4hP1X8juer3FMtVySQc5XXKR
         iSIwWNWrkBD8KacpLIHvYcaSXh5FGAWbyA8mdw5o0m+sgO5R7v2bIEAfuaicx6XJMn
         /kWzF/ew4k6DW3qD61jBvypi4tCVoN+JY8RKdyDg=
From:   guoren@kernel.org
To:     arnd@arnd.de, guoren@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        ren_guo@c-sky.com
Subject: [PATCH] csky: Select intc & timer drivers
Date:   Fri, 10 May 2019 14:10:39 +0800
Message-Id: <1557468639-21021-1-git-send-email-guoren@kernel.org>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Guo Ren <ren_guo@c-sky.com>

Let arch help to select interrupt controller's and timer's drivers
instead of people using menuconfig to select. This help the mini system
boot up.

Signed-off-by: Guo Ren <ren_guo@c-sky.com>
Cc: Arnd Bergmann <arnd@arnd.de>
---
 arch/csky/Kconfig | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/csky/Kconfig b/arch/csky/Kconfig
index ce07990..5e2cfc2 100644
--- a/arch/csky/Kconfig
+++ b/arch/csky/Kconfig
@@ -9,6 +9,9 @@ config CSKY
 	select COMMON_CLK
 	select CLKSRC_MMIO
 	select CLKSRC_OF
+	select CSKY_MPINTC if CPU_CK860
+	select CSKY_MP_TIMER if CPU_CK860
+	select CSKY_APB_INTC
 	select DMA_DIRECT_REMAP
 	select IRQ_DOMAIN
 	select HANDLE_DOMAIN_IRQ
@@ -29,6 +32,7 @@ config CSKY
 	select GENERIC_IRQ_MULTI_HANDLER
 	select GENERIC_SCHED_CLOCK
 	select GENERIC_SMP_IDLE_THREAD
+	select GX6605S_TIMER if CPU_CK610
 	select HAVE_ARCH_TRACEHOOK
 	select HAVE_ARCH_AUDITSYSCALL
 	select HAVE_DYNAMIC_FTRACE
-- 
2.7.4

