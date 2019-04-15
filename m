Return-Path: <SRS0=rNeM=SR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73C1FC10F0E
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 19:07:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 403CA2087C
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 19:07:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555355278;
	bh=3pfRlHGvDOfiJHSPXsEvGAxacrekbSneK81BfCV8twg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=KR0C/p4fwMzQowR/fynGoFMpAud3SMQunZ0nf+PC3fLHDab/6MgcJL4AsUfgn8H+b
	 xqbfAggTsXK6JbLrzN8MUTP8yGEjz/gKZqVYXyNgwBKYISXzqT66O+l6CnMZPRWrIW
	 kAktHh+niFMWvFoo7/GVrjHtO9tHpZzAx2igfHfM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730340AbfDOTH4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Apr 2019 15:07:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:43054 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729806AbfDOTHy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Apr 2019 15:07:54 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4AF922087C;
        Mon, 15 Apr 2019 19:07:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1555355273;
        bh=3pfRlHGvDOfiJHSPXsEvGAxacrekbSneK81BfCV8twg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=h/koQAZbd+7+CRTMCEJnOcyYKqd1zCW4eyyNQCEoUYBqo+rpoZKpjAIFFM9uqdKdY
         AjYTocQrOdEcOLzw3NQcWa5F8hptG2YJzPmjEHtIBbuOXtEOs9mVlXh4gPZZ4hroYg
         eVf5ge2WHACmhJFiI5BEN1ICENnAvVNie06eYaos=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Helge Deller <deller@gmx.de>
Subject: [PATCH 4.19 056/101] parisc: Detect QEMU earlier in boot process
Date:   Mon, 15 Apr 2019 20:58:54 +0200
Message-Id: <20190415183743.487943324@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190415183740.341577907@linuxfoundation.org>
References: <20190415183740.341577907@linuxfoundation.org>
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
@@ -399,6 +399,9 @@ void __init start_parisc(void)
 	int ret, cpunum;
 	struct pdc_coproc_cfg coproc_cfg;
 
+	/* check QEMU/SeaBIOS marker in PAGE0 */
+	running_on_qemu = (memcmp(&PAGE0->pad0, "SeaBIOS", 8) == 0);
+
 	cpunum = smp_processor_id();
 
 	init_cpu_topology();


