Return-Path: <SRS0=FrXW=TP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B9E7C04E53
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 12:16:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 049FF20675
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 12:16:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1557922598;
	bh=t84knI770UIPOC1bJAb0sh7vtZjL/RRH6KawfuiUgGI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=OMPRd2e/IyG4ZrnoPLxfKlfofaJ5zL9wl6ytMJUtVC4B/KpNhfnpJYQzNZJazMvqj
	 a07wBSCvUv7GyQBfsPtTYdehTAetp+1ecIKy+knSrQ+n6//fmJdaMftQatuTtF5OL1
	 /Dp/A5Mk6A1bm5HjP3IVq3GkxCaya3qGmk9Yc80k=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728466AbfEOMQg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 May 2019 08:16:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:59672 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727929AbfEOLCZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 May 2019 07:02:25 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 760EC20644;
        Wed, 15 May 2019 11:02:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1557918145;
        bh=t84knI770UIPOC1bJAb0sh7vtZjL/RRH6KawfuiUgGI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=n7t6tsa17/PIsxNJADG/uMcMSOXfSsrV/5JZySKHGEfMMvetrTMBczxAxky7g95/6
         qQv6C3FbGLzMnRMtUyggYQu7CvQy5FdlySVg7XQ42SpRSzLdaN2q7ErG+HELamhOqJ
         6hZja3xyeOBDLKlfirocQ61eePKPsTNqRL5bADPM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Michael Ellerman <mpe@ellerman.id.au>,
        Mauricio Faria de Oliveira <mauricfo@linux.vnet.ibm.com>
Subject: [PATCH 4.4 022/266] powerpc/rfi-flush: Call setup_rfi_flush() after LPM migration
Date:   Wed, 15 May 2019 12:52:09 +0200
Message-Id: <20190515090723.339061118@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190515090722.696531131@linuxfoundation.org>
References: <20190515090722.696531131@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Michael Ellerman <mpe@ellerman.id.au>

commit 921bc6cf807ceb2ab8005319cf39f33494d6b100 upstream.

We might have migrated to a machine that uses a different flush type,
or doesn't need flushing at all.

Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Signed-off-by: Mauricio Faria de Oliveira <mauricfo@linux.vnet.ibm.com>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/powerpc/platforms/pseries/mobility.c |    3 +++
 arch/powerpc/platforms/pseries/pseries.h  |    2 ++
 arch/powerpc/platforms/pseries/setup.c    |    2 +-
 3 files changed, 6 insertions(+), 1 deletion(-)

--- a/arch/powerpc/platforms/pseries/mobility.c
+++ b/arch/powerpc/platforms/pseries/mobility.c
@@ -314,6 +314,9 @@ void post_mobility_fixup(void)
 		printk(KERN_ERR "Post-mobility device tree update "
 			"failed: %d\n", rc);
 
+	/* Possibly switch to a new RFI flush type */
+	pseries_setup_rfi_flush();
+
 	return;
 }
 
--- a/arch/powerpc/platforms/pseries/pseries.h
+++ b/arch/powerpc/platforms/pseries/pseries.h
@@ -81,4 +81,6 @@ extern struct pci_controller_ops pseries
 
 unsigned long pseries_memory_block_size(void);
 
+void pseries_setup_rfi_flush(void);
+
 #endif /* _PSERIES_PSERIES_H */
--- a/arch/powerpc/platforms/pseries/setup.c
+++ b/arch/powerpc/platforms/pseries/setup.c
@@ -499,7 +499,7 @@ static void __init find_and_init_phbs(vo
 	of_pci_check_probe_only();
 }
 
-static void pseries_setup_rfi_flush(void)
+void pseries_setup_rfi_flush(void)
 {
 	struct h_cpu_char_result result;
 	enum l1d_flush_type types;


