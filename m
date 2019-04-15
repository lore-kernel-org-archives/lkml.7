Return-Path: <SRS0=rNeM=SR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 909A6C10F0E
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 18:48:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6120F2073F
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 18:48:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555354128;
	bh=N+dgDDTqEw5QpKuBMDdqa1VfsSreoCDzGvfAmuF627Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=2gtEJolbucAEPhIg1N5xjtrau5+F9aU4Fg8U5ZHVdca6JGjfZHPQVp6E3E23JFSK9
	 IPN21aAbiwxaeOn5mSyzmktZqdWGNOo1ERMfDqtk49kMhFdmoZi9mSaadmrBedFgCd
	 drpP3nKq0/0o0BqaMa2jKNpqg9fJICRwuGcfONso=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728691AbfDOSsq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Apr 2019 14:48:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:51652 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729022AbfDOSr6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Apr 2019 14:47:58 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id ACBDD2087C;
        Mon, 15 Apr 2019 18:47:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1555354077;
        bh=N+dgDDTqEw5QpKuBMDdqa1VfsSreoCDzGvfAmuF627Y=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=QoFbHU7MsFkalDhX5Nzs/qJJm0SxOdJRox3vb6NT6Hghk4S0rtShdL/yTgXNHeXFk
         6SSJPkmiZnFsoXBJTT0E8huLEy/aba2ZpWXJC+7jzkTPvvfxwppTjtaTgQOB1IM9Zj
         yDTAq0Nlbt1ZruSSPwq+7wcpIZqq5GPbWqTlXMj4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Helge Deller <deller@gmx.de>
Subject: [PATCH 4.9 64/76] parisc: Detect QEMU earlier in boot process
Date:   Mon, 15 Apr 2019 20:44:28 +0200
Message-Id: <20190415183726.478117691@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190415183707.712011689@linuxfoundation.org>
References: <20190415183707.712011689@linuxfoundation.org>
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
@@ -206,12 +206,6 @@ void __cpuidle arch_cpu_idle(void)
 
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
@@ -403,6 +403,9 @@ void start_parisc(void)
 	int ret, cpunum;
 	struct pdc_coproc_cfg coproc_cfg;
 
+	/* check QEMU/SeaBIOS marker in PAGE0 */
+	running_on_qemu = (memcmp(&PAGE0->pad0, "SeaBIOS", 8) == 0);
+
 	cpunum = smp_processor_id();
 
 	set_firmware_width_unlocked();


