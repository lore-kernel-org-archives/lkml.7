Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDE1AC10F12
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 03:00:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 94BF62075B
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 03:00:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555383610;
	bh=qPtlq9ofbOUH5iqKEir63lG1/aTdeQco7Py1xp6GROA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=uf8TxAXrQE2ARXWp7dsn22AERwZo5BUQtiOeLLweIBxhWt+7U+x9ka4uKHodPTf1D
	 UwMd1Fum1fAb4Vf8yqEUq6USwKnr2BSk95zzdl5Uqe/DZmTpC9qVvYkhkScSJnfPBl
	 yYqG7CCsjM5gE+wikT4ScOo0Zf5Y5c/tKG5yx8Rg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728459AbfDPDAJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Apr 2019 23:00:09 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:44332 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726827AbfDPC4d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Apr 2019 22:56:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Sender:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=nGs5gkOE+bnvarrQ0OR5mRuVe5KnlhEDeZqfsm3VpwE=; b=omx/Ot+cpvJ2JgTZBYJlDtB0UJ
        OZ9EeWqMsJQr+xaO4vGqJHPmy+INAKB7pzNzByzTF0u4DiDsjv84psY6AhmoZBtpeVcQVHwLTITq3
        zy/xv4loIAZIX7+xMJQnJGCADchSQiXiA4FLF4UgnvPU1m7kohs5CXqbQ9LhyiH32BPqEGbZvFFp4
        kAj7BUGIarW4K0Jp3AekyJ/Z2a53XWA5EZ1vFZXIbxFT9velu6Ic07djK/Ayr53vyq6dxjZiprmee
        nVYd1sUwBqP/oxCXp0NReDGW8GAtuE+3JdZBZfBRJOq68U2ht59pu/s0v/5gL2vaFaAcvrpSTd7gC
        rCeuuL+g==;
Received: from 177.205.118.176.dynamic.adsl.gvt.net.br ([177.205.118.176] helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hGEGu-0007aj-Q6; Tue, 16 Apr 2019 02:56:32 +0000
Received: from mchehab by bombadil.infradead.org with local (Exim 4.92)
        (envelope-from <mchehab@bombadil.infradead.org>)
        id 1hGEGn-0001o1-LG; Mon, 15 Apr 2019 23:56:25 -0300
From:   Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Mauro Carvalho Chehab <mchehab@infradead.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>
Subject: [PATCH 28/57] docs: ptp.txt: convert to ReST and move to driver-api
Date:   Mon, 15 Apr 2019 23:55:53 -0300
Message-Id: <a886dcad78d130f7fa77b0f57a3642501fcc4b3d.1555382110.git.mchehab+samsung@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1555382110.git.mchehab+samsung@kernel.org>
References: <cover.1555382110.git.mchehab+samsung@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The conversion is trivial: just adjust title markups.

Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
---
 Documentation/ptp/ptp.txt | 26 +++++++++++++++++---------
 1 file changed, 17 insertions(+), 9 deletions(-)

diff --git a/Documentation/ptp/ptp.txt b/Documentation/ptp/ptp.txt
index 11e904ee073f..65c84a72e9fc 100644
--- a/Documentation/ptp/ptp.txt
+++ b/Documentation/ptp/ptp.txt
@@ -1,5 +1,6 @@
-
-* PTP hardware clock infrastructure for Linux
+===========================================
+PTP hardware clock infrastructure for Linux
+===========================================
 
   This patch set introduces support for IEEE 1588 PTP clocks in
   Linux. Together with the SO_TIMESTAMPING socket options, this
@@ -22,7 +23,8 @@
     - Period output signals configurable from user space
     - Synchronization of the Linux system time via the PPS subsystem
 
-** PTP hardware clock kernel API
+PTP hardware clock kernel API
+=============================
 
    A PTP clock driver registers itself with the class driver. The
    class driver handles all of the dealings with user space. The
@@ -36,7 +38,8 @@
    development, it can be useful to have more than one clock in a
    single system, in order to allow performance comparisons.
 
-** PTP hardware clock user space API
+PTP hardware clock user space API
+=================================
 
    The class driver also creates a character device for each
    registered clock. User space can use an open file descriptor from
@@ -49,7 +52,8 @@
    ancillary clock features. User space can receive time stamped
    events via blocking read() and poll().
 
-** Writing clock drivers
+Writing clock drivers
+=====================
 
    Clock drivers include include/linux/ptp_clock_kernel.h and register
    themselves by presenting a 'struct ptp_clock_info' to the
@@ -66,14 +70,17 @@
    class driver, since the lock may also be needed by the clock
    driver's interrupt service routine.
 
-** Supported hardware
+Supported hardware
+==================
+
+   * Freescale eTSEC gianfar
 
-   + Freescale eTSEC gianfar
      - 2 Time stamp external triggers, programmable polarity (opt. interrupt)
      - 2 Alarm registers (optional interrupt)
      - 3 Periodic signals (optional interrupt)
 
-   + National DP83640
+   * National DP83640
+
      - 6 GPIOs programmable as inputs or outputs
      - 6 GPIOs with dedicated functions (LED/JTAG/clock) can also be
        used as general inputs or outputs
@@ -81,6 +88,7 @@
      - GPIO outputs can produce periodic signals
      - 1 interrupt pin
 
-   + Intel IXP465
+   * Intel IXP465
+
      - Auxiliary Slave/Master Mode Snapshot (optional interrupt)
      - Target Time (optional interrupt)
-- 
2.20.1

