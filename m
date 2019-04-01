Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DEADC43381
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 17:21:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3CBFE20856
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 17:21:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554139309;
	bh=m5izEEu7Xvml9Gb/mT+ebQQSZ1f9xWtmjQs2kYiw5LM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=uZSlqpbd4HsX60qvWOJFIRYZIxA5EmlbUG5Gx4MPJwM67A8wNA2SPeQoVepUaB2kL
	 HO+j4PwE6kyHl2N1tQ4wGxU0QXZXcEOD1Pv0034JMX087yiYXOxa4VxESSV+jHgIzB
	 NsnhBTnLYl85rHhB+0M5xnefeaXHyRyGflWzrExk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731437AbfDARVr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 13:21:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:50566 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731863AbfDARVo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 13:21:44 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4979B20856;
        Mon,  1 Apr 2019 17:21:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554139303;
        bh=m5izEEu7Xvml9Gb/mT+ebQQSZ1f9xWtmjQs2kYiw5LM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=UJJZlroZjU1g6sjaY3nV9Y5rTvUHwh1kG8vr1/6a29GygcX2KdMyah7uPowE7yClv
         +r6ezkdIrA9fOUO6Tv4173pF/l/pkXpYfnSMoAQLJBJg/2pTLATwXmm8RXlH/ptz/O
         9UC4/nckuTMwgy8LN512U5+TPJFzfGzzldlEj1iU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Diana Craciun <diana.craciun@nxp.com>,
        Michael Ellerman <mpe@ellerman.id.au>
Subject: [PATCH 4.14 035/107] powerpc/64: Make meltdown reporting Book3S 64 specific
Date:   Mon,  1 Apr 2019 19:01:50 +0200
Message-Id: <20190401170048.867662867@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190401170045.246405031@linuxfoundation.org>
References: <20190401170045.246405031@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Diana Craciun <diana.craciun@nxp.com>

commit 406d2b6ae3420f5bb2b3db6986dc6f0b6dbb637b upstream.

In a subsequent patch we will enable building security.c for Book3E.
However the NXP platforms are not vulnerable to Meltdown, so make the
Meltdown vulnerability reporting PPC_BOOK3S_64 specific.

Signed-off-by: Diana Craciun <diana.craciun@nxp.com>
[mpe: Split out of larger patch]
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/powerpc/kernel/security.c |    2 ++
 1 file changed, 2 insertions(+)

--- a/arch/powerpc/kernel/security.c
+++ b/arch/powerpc/kernel/security.c
@@ -92,6 +92,7 @@ static __init int barrier_nospec_debugfs
 device_initcall(barrier_nospec_debugfs_init);
 #endif /* CONFIG_DEBUG_FS */
 
+#ifdef CONFIG_PPC_BOOK3S_64
 ssize_t cpu_show_meltdown(struct device *dev, struct device_attribute *attr, char *buf)
 {
 	bool thread_priv;
@@ -124,6 +125,7 @@ ssize_t cpu_show_meltdown(struct device
 
 	return sprintf(buf, "Vulnerable\n");
 }
+#endif
 
 ssize_t cpu_show_spectre_v1(struct device *dev, struct device_attribute *attr, char *buf)
 {


