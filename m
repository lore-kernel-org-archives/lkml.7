Return-Path: <SRS0=GGWy=XB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 496C4C43331
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Sep 2019 06:56:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1506720842
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Sep 2019 06:56:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=hardenedlinux.org header.i=@hardenedlinux.org header.b="XfrsGKJA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392474AbfIFG40 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Sep 2019 02:56:26 -0400
Received: from mail2.protonmail.ch ([185.70.40.22]:47756 "EHLO
        mail2.protonmail.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732161AbfIFG4Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Sep 2019 02:56:25 -0400
Date:   Fri, 06 Sep 2019 06:56:20 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hardenedlinux.org;
        s=protonmail; t=1567752983;
        bh=tnjEQHsjLTOwlXpsM+jIBd9kUJcYGN4t3QPxOXWDZXg=;
        h=Date:To:From:Cc:Reply-To:Subject:Feedback-ID:From;
        b=XfrsGKJAJrPo4xO99677ifuwvEb6/N4sg/bLFpox2BYBgnyajpCyTUP5pNywekQuh
         fUloulGna6+oMTCTSCvnclVj3heLf04JYo0pVKGDMIsquM6Y53GQv5st+xArh1Qqp4
         zMYvDAlY+xu8EjJ2Do84Lb0gHmymoWVNsYM6lRv8=
To:     "paul.walmsley@sifive.com" <paul.walmsley@sifive.com>,
        "palmer@sifive.com" <palmer@sifive.com>,
        "aou@eecs.berkeley.edu" <aou@eecs.berkeley.edu>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
From:   Xiang Wang <merle@hardenedlinux.org>
Cc:     "citypw@hardenedlinux.org" <citypw@hardenedlinux.org>
Reply-To: Xiang Wang <merle@hardenedlinux.org>
Subject: [PATCH] arch/riscv: disable too many harts before pick main boot hart
Message-ID: <AMJe39pHTcb4gsI-_Dv-wmR8_x9EbCCN9LKI47j34_8vBKRqzFxPrjmZvBtwV5OU_HcOiRkKUG66xVaNQ8VAXw7Ws0CCK74gpA8pKaYN5wM=@hardenedlinux.org>
Feedback-ID: BRRa7Rf7LqOlikZR00e5gSr_IsihWq0drDTak4NnawY-ONQTW87vpTHz90bkJTl_rn8r4L6gc-nP1pm37CQtxw==:Ext:ProtonMail
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From 12300865d1103618c9d4c375f7d7fbe601b6618c Mon Sep 17 00:00:00 2001
From: Xiang Wang <merle@hardenedlinux.org>
Date: Fri, 6 Sep 2019 11:56:09 +0800
Subject: [PATCH] arch/riscv: disable too many harts before pick main boot h=
art

These harts with id greater than or equal to CONFIG_NR_CPUS need to be disa=
bled.
But pick the main Hart can choose any one. So, before pick the main hart, y=
ou
need to disable the hart with id greater than or equal to CONFIG_NR_CPUS.

Signed-off-by: Xiang Wang <merle@hardenedlinux.org>
---
 arch/riscv/kernel/head.S | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/arch/riscv/kernel/head.S b/arch/riscv/kernel/head.S
index 0f1ba17e476f..cfffea38eb17 100644
--- a/arch/riscv/kernel/head.S
+++ b/arch/riscv/kernel/head.S
@@ -63,6 +63,11 @@ _start_kernel:
 =09li t0, SR_FS
 =09csrc sstatus, t0

+#ifdef CONFIG_SMP
+=09li t0, CONFIG_NR_CPUS
+=09bgeu a0, t0, .Lsecondary_park
+#endif
+
 =09/* Pick one hart to run the main boot sequence */
 =09la a3, hart_lottery
 =09li a2, 1
@@ -154,9 +159,6 @@ relocate:

 .Lsecondary_start:
 #ifdef CONFIG_SMP
-=09li a1, CONFIG_NR_CPUS
-=09bgeu a0, a1, .Lsecondary_park
-
 =09/* Set trap vector to spin forever to help debug */
 =09la a3, .Lsecondary_park
 =09csrw CSR_STVEC, a3
--
2.20.1







