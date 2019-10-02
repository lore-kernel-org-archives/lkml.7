Return-Path: <SRS0=zem1=X3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B411DC35280
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Oct 2019 14:45:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8744221920
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Oct 2019 14:45:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="chddndZZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728424AbfJBOpR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Oct 2019 10:45:17 -0400
Received: from mout.gmx.net ([212.227.15.18]:59825 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726016AbfJBOpQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Oct 2019 10:45:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1570027504;
        bh=tIKm3JH2YEZf0hbvxB9mUtKzkT5iw+SjZ/d8uy0OaMU=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
        b=chddndZZd4lqM0AMbi7QVtkCVtykPG1kz6hDLTOWLNKkjxmLEJH1DBoULsskyYV7g
         CWdewsBE+mCO29PPdrVSuWHzbqggt9BGxqMjjA3OpWUHM0Ggc7YAhm6TrfDL+m9pkg
         88j3NJLc1bawA0rtD3VhCk1AmWzoClcgK6u2TbRQ=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from longitude ([109.90.233.87]) by mail.gmx.com (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1N3KPg-1i7Jp42OyA-010LJH; Wed, 02
 Oct 2019 16:45:04 +0200
From:   =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
To:     linux-kernel@vger.kernel.org
Cc:     Christoph Hellwig <hch@lst.de>,
        =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <maz@kernel.org>
Subject: [PATCH] irqchip: Place CONFIG_SIFIVE_PLIC into the menu
Date:   Wed,  2 Oct 2019 16:44:52 +0200
Message-Id: <20191002144452.10178-1-j.neuschaefer@gmx.net>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:gwZGHxXzFG/CGaR/95835hjG3xnUCzmvJPA6sqvj7GW7Vvdls8D
 +9rr2jFU8k5tjGMb3IN9eFxlCpW2uQ8bzWk+/ZMRFeX/A7eqgoW9xVQ8ASv6TWC2BiUkkiR
 t0AbCl7qzLtEyerr2/6kDwK9bqy7SYmsLYEUJHqpGrV4RJWKSKepZLfesT0+hCE0c9LaXtq
 F2jb4BXpl9i222e9c6jAg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:kI60wKvB05Y=:ES2DaDY/KMch7LHb+3uSCh
 /ha23/l21PgYKrMc9YLncXReV8OaDTfBcrF+T2npn43BWTIm7ZY6qf9SDCRYvryLNYtHUG6gG
 CsZrdz5ULtczdVUA4rJOSrgWp8I86q5YE7JWB6pcejQAqPkSwi0ZvS/89BcL1OWNvpUHg0wy4
 7Q9CLIFKAocmIP1Di0cbRgd9BzoQA2Ahhr4mBHu2oBXX9xIeoeXfa9W2zc0ZBmG2xrdAnvuTp
 Bx+q9h4yU+YlfSUFHu7ckPlvKmp+ZMnEsO5QHlDQRCrhTO3uWHx0xWOqIkHMVkTwHHesvPp/u
 VCYeujNnTnbU63OjQhlacR2ri3ITGUudEzEmTeM8E6pf8XK73srYDkKS5pftURmV/tzsKHuTj
 FCBeeMGmfWULkFi4euiku4rsWi2dhP4UZs13xR5JZ5o04FPuK47kVwnkWb/ANRC/NCpANRHnO
 F8opRfWeCQEUFZ5okaGtHviqrGL0VS4nMfM5wGS0dUFm73jKnefu8iJALbQrbuMHk36xa36IA
 tyoQ9L2CtzvK6MM2hLVxRDQr5/naXGtLltr+JeaT02PMoah8vG96OkhakTmvUasLZAWEPHIkm
 ujLpNnvWt42ThMUc9tfc/k7TbuAY9S6Nmj48yaDtAvKi99UQaURdJtYWvv0Mq5yD9rF+K+KTu
 HIAbasBm92tLiAldIsyvPDqLPxpEdBIM4jSqWT1nKbPjwwEeRN8HRUefd9I8oBLkrUXHdLNsx
 E0nVHrfKI7zC1J4c7e9ZttnwJ8oUMaAVO+rTdnXkJ9SwSKG3JQtxKdlG3yTYxUO8B/5dRvUxG
 JWKTdMhT0hNSDtYnwDkm7fkjvJZJDgZ5L6yTwckJrnwuZrg1B/jKi4Q7Zjdf06UjgwDcqNPqp
 hgFnsdRE5lXvHeNr6NIFNxbdHaEhs5/njIBtlruyV23XZ2S9WoERWKSh/BdCQ18cncvyQcPaI
 wZN1ubJ+6rY09UZ6zCzSmxbdgE3fPAuSFPJjWcIHtchuCHdXeQZ8mTQq7Mz4rr2BVcdua9jPq
 DKpmsqa9jAJB5obGQz+CHN3m1plBqVvO7mc1vUXb95Ni72apA2K1gmhvJP3sSaojM32Pq/naU
 PBE7SqTJD3Rmp/JUJ+7Q5J0pqY8ieyYMkhASVsu3qrm4j3cwnNm8sJzArlilEaDwYZpOpRLCA
 SjEkyIIhIuc6ImrPmm2R+FMidahhPwlXnN1Dzjx8PDFs1B8twBZalRRfwKFOJzRC5WTJ37yWg
 3E2o18GFps6z2n0vsU4u2al9tlDvs/xUc+reZ8vyVmpTabof9WcR1xYk3FTc=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Somehow CONFIG_SIFIVE_PLIC ended up outside of the "IRQ chip support"
menu.

Fixes: 8237f8bc4f6e ("irqchip: add a SiFive PLIC driver")
Signed-off-by: Jonathan Neusch=C3=A4fer <j.neuschaefer@gmx.net>
=2D--
 drivers/irqchip/Kconfig | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/irqchip/Kconfig b/drivers/irqchip/Kconfig
index ccbb8973a324..97f9c001d8ff 100644
=2D-- a/drivers/irqchip/Kconfig
+++ b/drivers/irqchip/Kconfig
@@ -483,8 +483,6 @@ config TI_SCI_INTA_IRQCHIP
 	  If you wish to use interrupt aggregator irq resources managed by the
 	  TI System Controller, say Y here. Otherwise, say N.

-endmenu
-
 config SIFIVE_PLIC
 	bool "SiFive Platform-Level Interrupt Controller"
 	depends on RISCV
@@ -496,3 +494,5 @@ config SIFIVE_PLIC
 	   interrupt sources are subordinate to the PLIC.

 	   If you don't know what to do here, say Y.
+
+endmenu
=2D-
2.20.1

