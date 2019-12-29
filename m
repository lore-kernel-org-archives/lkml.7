Return-Path: <SRS0=vISB=2T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D58FC2D0DB
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Dec 2019 17:59:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3DBCB222C4
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Dec 2019 17:59:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1577642366;
	bh=WykSmhYdnsgPQhUMrZIU+I+RjGPaVkLcpYFOzRu3ne4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=uUyzNLGO1rvFvAfwUbQfBB4MDicgZiYeIrWP/OJI2sC4SUfV8MK2wEwLOUA6DYZ6V
	 LO5biPxLubL9vhds6Qtw41RkkR7dqwyLHrT9esuXITCSdNxO3F9i+W+yDpIEfYeluL
	 Tk/G4FeV8CDmawO2iDhM+Hr/gYMKPn1ncyM/Ztko=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387614AbfL2R6t (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 29 Dec 2019 12:58:49 -0500
Received: from mail.kernel.org ([198.145.29.99]:50000 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733057AbfL2R6q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Dec 2019 12:58:46 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 76AAB208C4;
        Sun, 29 Dec 2019 17:58:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1577642325;
        bh=WykSmhYdnsgPQhUMrZIU+I+RjGPaVkLcpYFOzRu3ne4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=XT+fLv6I81kAmNVJsW+wU73noWH5yZUwQSwEJv4Eg2X59CDsR2q12PZ4Zym+HAwKE
         uv3SajrcB3msOJb7jQyRyDjNI8kvakWzC1PECUCxaQlAJPANrOBkqQHwsPM6xQyxPt
         dt0uDF43nHiIZvq77tzclxz7GDI6OsCAMwke1tqQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>, bp@alien8.de,
        feng.tang@intel.com, harry.pan@intel.com, hpa@zytor.com,
        Ingo Molnar <mingo@kernel.org>
Subject: [PATCH 5.4 420/434] x86/intel: Disable HPET on Intel Coffee Lake H platforms
Date:   Sun, 29 Dec 2019 18:27:53 +0100
Message-Id: <20191229172730.961529008@linuxfoundation.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20191229172702.393141737@linuxfoundation.org>
References: <20191229172702.393141737@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kai-Heng Feng <kai.heng.feng@canonical.com>

commit f8edbde885bbcab6a2b4a1b5ca614e6ccb807577 upstream.

Coffee Lake H SoC has similar behavior as Coffee Lake, skewed HPET timer
once the SoCs entered PC10.

So let's disable HPET on CFL-H platforms.

Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: bp@alien8.de
Cc: feng.tang@intel.com
Cc: harry.pan@intel.com
Cc: hpa@zytor.com
Link: https://lkml.kernel.org/r/20191129062303.18982-1-kai.heng.feng@canonical.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/x86/kernel/early-quirks.c |    2 ++
 1 file changed, 2 insertions(+)

--- a/arch/x86/kernel/early-quirks.c
+++ b/arch/x86/kernel/early-quirks.c
@@ -710,6 +710,8 @@ static struct chipset early_qrk[] __init
 	 */
 	{ PCI_VENDOR_ID_INTEL, 0x0f00,
 		PCI_CLASS_BRIDGE_HOST, PCI_ANY_ID, 0, force_disable_hpet},
+	{ PCI_VENDOR_ID_INTEL, 0x3e20,
+		PCI_CLASS_BRIDGE_HOST, PCI_ANY_ID, 0, force_disable_hpet},
 	{ PCI_VENDOR_ID_INTEL, 0x3ec4,
 		PCI_CLASS_BRIDGE_HOST, PCI_ANY_ID, 0, force_disable_hpet},
 	{ PCI_VENDOR_ID_BROADCOM, 0x4331,


