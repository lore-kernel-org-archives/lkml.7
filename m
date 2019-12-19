Return-Path: <SRS0=nnGO=2J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1917BC43603
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Dec 2019 19:08:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D4AE6222C2
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Dec 2019 19:08:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576782520;
	bh=FjQfHrnMKBL/HTRi+36OsxA3RH7s2kM7QEmwxUvZLGg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=VBOIFFf5/SkE90nZKl4lAviXTDYL3sTMr25ubT53wjdQR6Gif/fPbnsLKPlwtfzJP
	 dXffzQEr5BwJoXammEgwnqLjAVHNeuK6uoCV7cV9tbxRcpxnqE9b8s6tZeWGCpWZVt
	 qBsGqs+0GGBPQ1hE4V39RELYxT8GDv9IRHgQD/4E=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728632AbfLSTIk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Dec 2019 14:08:40 -0500
Received: from mail.kernel.org ([198.145.29.99]:60908 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728574AbfLSSlp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Dec 2019 13:41:45 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 49795206D7;
        Thu, 19 Dec 2019 18:41:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576780904;
        bh=FjQfHrnMKBL/HTRi+36OsxA3RH7s2kM7QEmwxUvZLGg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=UXyf956KqMHAxyU886pmnTIt6k1Yauwki+ueu5qxKQxVDfBx/Rcqfv1pzvsJMeWFi
         uClBCOUQL9yKAfnhCoesn5vT3py24HM4DqAYpblVTgTlyX7ptZ8UhSuM61GFF3gj6p
         60fRCZFdfU6Xh80lw5gG6ghxVbTBTnIeffkQNqQk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        Dmitry Osipenko <digetx@gmail.com>,
        Thierry Reding <treding@nvidia.com>
Subject: [PATCH 4.4 156/162] ARM: tegra: Fix FLOW_CTLR_HALT register clobbering by tegra_resume()
Date:   Thu, 19 Dec 2019 19:34:24 +0100
Message-Id: <20191219183217.267453630@linuxfoundation.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20191219183150.477687052@linuxfoundation.org>
References: <20191219183150.477687052@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dmitry Osipenko <digetx@gmail.com>

commit d70f7d31a9e2088e8a507194354d41ea10062994 upstream.

There is an unfortunate typo in the code that results in writing to
FLOW_CTLR_HALT instead of FLOW_CTLR_CSR.

Cc: <stable@vger.kernel.org>
Acked-by: Peter De Schrijver <pdeschrijver@nvidia.com>
Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
Signed-off-by: Thierry Reding <treding@nvidia.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/arm/mach-tegra/reset-handler.S |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

--- a/arch/arm/mach-tegra/reset-handler.S
+++ b/arch/arm/mach-tegra/reset-handler.S
@@ -56,16 +56,16 @@ ENTRY(tegra_resume)
 	cmp	r6, #TEGRA20
 	beq	1f				@ Yes
 	/* Clear the flow controller flags for this CPU. */
-	cpu_to_csr_reg r1, r0
+	cpu_to_csr_reg r3, r0
 	mov32	r2, TEGRA_FLOW_CTRL_BASE
-	ldr	r1, [r2, r1]
+	ldr	r1, [r2, r3]
 	/* Clear event & intr flag */
 	orr	r1, r1, \
 		#FLOW_CTRL_CSR_INTR_FLAG | FLOW_CTRL_CSR_EVENT_FLAG
 	movw	r0, #0x3FFD	@ enable, cluster_switch, immed, bitmaps
 				@ & ext flags for CPU power mgnt
 	bic	r1, r1, r0
-	str	r1, [r2]
+	str	r1, [r2, r3]
 1:
 
 	mov32	r9, 0xc09


