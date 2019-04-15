Return-Path: <SRS0=rNeM=SR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E04DEC10F12
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 19:17:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E3672073F
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 19:17:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555355840;
	bh=RqMzeHO0/nO2zE2+lwmErEH+ewxaUdTxcNW4FEtKBpk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=1O1Xom1hJhtlTqaoVzuWp86hyspS1YoomD7Zde9tO+PI5N1h+ReD94q60aW1wA65a
	 jLexCnE6rc+1l6qdj02EEgREBUsAvEMd6x3p7C+Wi5stu5Yam/2Z7p75xXkZB0/Q0G
	 c7SnmwtCHsCUh158fs0AxhQTVw2Wo+bp7KvN+ct0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731685AbfDOTRT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Apr 2019 15:17:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:49908 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731405AbfDOTMa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Apr 2019 15:12:30 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 521B9218DA;
        Mon, 15 Apr 2019 19:12:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1555355549;
        bh=RqMzeHO0/nO2zE2+lwmErEH+ewxaUdTxcNW4FEtKBpk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=CtMHv3wi8z20mn6+XPYbB5iVrh6FOhKH3fYPAn7rQeIIVXo0ejbYbxryhLsFNZUcv
         cGwkUanXYJj2KyGa2xDIUfn3+MuAlLW88pvaNsVCXBnnz261BZ0Ibj+D/osJK2PJoe
         24blENi3/6yEkPz3c0D4RHL0uPAOJMdcJrgitlIk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Helge Deller <deller@gmx.de>
Subject: [PATCH 5.0 062/117] parisc: Detect QEMU earlier in boot process
Date:   Mon, 15 Apr 2019 21:00:32 +0200
Message-Id: <20190415183748.087422732@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190415183744.887851196@linuxfoundation.org>
References: <20190415183744.887851196@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Helge Deller <deller@gmx.de>

commit d006e95b5561f708d0385e9677ffe2c46f2ae345 upstream.

While adding LASI support to QEMU, I noticed that the QEMU detection in
the kernel happens much too late. For example, when a LASI chip is found
by the kernel, it registers the LASI LED driver as well.  But when we
run on QEMU it makes sense to avoid spending unnecessary CPU cycles, so
we need to access the running_on_QEMU flag earlier than before.

This patch now makes the QEMU detection the fist task of the Linux
kernel by moving it to where the kernel enters the C-coding.

Fixes: 310d82784fb4 ("parisc: qemu idle sleep support")
Signed-off-by: Helge Deller <deller@gmx.de>
Cc: stable@vger.kernel.org # v4.14+
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/parisc/kernel/process.c |    6 ------
 arch/parisc/kernel/setup.c   |    3 +++
 2 files changed, 3 insertions(+), 6 deletions(-)

--- a/arch/parisc/kernel/process.c
+++ b/arch/parisc/kernel/process.c
@@ -210,12 +210,6 @@ void __cpuidle arch_cpu_idle(void)
 
 static int __init parisc_idle_init(void)
 {
-	const char *marker;
-
-	/* check QEMU/SeaBIOS marker in PAGE0 */
-	marker = (char *) &PAGE0->pad0;
-	running_on_qemu = (memcmp(marker, "SeaBIOS", 8) == 0);
-
 	if (!running_on_qemu)
 		cpu_idle_poll_ctrl(1);
 
--- a/arch/parisc/kernel/setup.c
+++ b/arch/parisc/kernel/setup.c
@@ -396,6 +396,9 @@ void __init start_parisc(void)
 	int ret, cpunum;
 	struct pdc_coproc_cfg coproc_cfg;
 
+	/* check QEMU/SeaBIOS marker in PAGE0 */
+	running_on_qemu = (memcmp(&PAGE0->pad0, "SeaBIOS", 8) == 0);
+
 	cpunum = smp_processor_id();
 
 	init_cpu_topology();


