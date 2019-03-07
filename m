Return-Path: <SRS0=uyI7=RK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72C79C43381
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 23:56:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4C5FD20840
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 23:56:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726323AbfCGX4i (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Mar 2019 18:56:38 -0500
Received: from smtprelay0043.hostedemail.com ([216.40.44.43]:46279 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726279AbfCGX4i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Mar 2019 18:56:38 -0500
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay07.hostedemail.com (Postfix) with ESMTP id 5521A181D341C;
        Thu,  7 Mar 2019 23:56:37 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: women44_9105590a9ce0c
X-Filterd-Recvd-Size: 1457
Received: from XPS-9350 (unknown [149.142.244.224])
        (Authenticated sender: joe@perches.com)
        by omf10.hostedemail.com (Postfix) with ESMTPA;
        Thu,  7 Mar 2019 23:56:36 +0000 (UTC)
Message-ID: <66af3908ab0a63a6768f3d75a87abf4056a9f8cf.camel@perches.com>
Subject: [PATCH] RISC-V: Use IS_ENABLED(CONFIG_CMODEL_MEDLOW)
From:   Joe Perches <joe@perches.com>
To:     Palmer Dabbelt <palmer@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>
Cc:     linux-riscv@lists.infradead.org,
        LKML <linux-kernel@vger.kernel.org>
Date:   Thu, 07 Mar 2019 15:56:34 -0800
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.30.1-1build1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

IS_ENABLED should generally use CONFIG_ prefaced symbols and
it doesn't appear as if there is a CMODEL_MEDLOW define.

Signed-off-by: Joe Perches <joe@perches.com>
---
 arch/riscv/kernel/module.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/riscv/kernel/module.c b/arch/riscv/kernel/module.c
index 7dd308129b40..2872edce894d 100644
--- a/arch/riscv/kernel/module.c
+++ b/arch/riscv/kernel/module.c
@@ -141,7 +141,7 @@ static int apply_r_riscv_hi20_rela(struct module *me, u32 *location,
 {
 	s32 hi20;
 
-	if (IS_ENABLED(CMODEL_MEDLOW)) {
+	if (IS_ENABLED(CONFIG_CMODEL_MEDLOW)) {
 		pr_err(
 		  "%s: target %016llx can not be addressed by the 32-bit offset from PC = %p\n",
 		  me->name, (long long)v, location);


