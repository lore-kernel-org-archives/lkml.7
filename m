Return-Path: <SRS0=K9bG=V2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9B15C76186
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 19:49:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9D71321655
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 19:49:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1564429777;
	bh=/6BT4lrHx6h+19CBgVzQ1g8yCgOr7XrC7Iko3b39SZM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=rkuEhjbx1iaYaaX6+jUfa2apCnH627SNeC8ll9N6lkuaEuqlz1X2ayevvE+Qx4our
	 rMpdNeksPpGMc1LHoEzazWOJQ5OriyaaR9lQxwGNPqD3vvPLLS2G89SMpycq2eZ+EA
	 BxoliAyIsq+Ang1NcFpNwdzbsZKYMWI0GnE3ei9g=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390558AbfG2Ttg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jul 2019 15:49:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:40058 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390299AbfG2Ttb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jul 2019 15:49:31 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4BE15205F4;
        Mon, 29 Jul 2019 19:49:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564429770;
        bh=/6BT4lrHx6h+19CBgVzQ1g8yCgOr7XrC7Iko3b39SZM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=R+pRipdfgz1e3lUZ6ykCmBOts9tKfdWg5M5pTR2Drdx21+Wpqyzi4v69uOz6R5i3X
         OpgCSxPMyPNB9o/hdw+tIRSjn7JrtuWBijsUMn8Gr/2OrifiQSwKV4fmiqfHoyXV98
         rfLwP7rL7qm0I2Rn4HWaIUvevQ2aBHtXARu1PqkY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.2 091/215] powerpc/xmon: Fix disabling tracing while in xmon
Date:   Mon, 29 Jul 2019 21:21:27 +0200
Message-Id: <20190729190755.141054869@linuxfoundation.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190729190739.971253303@linuxfoundation.org>
References: <20190729190739.971253303@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Upstream commit aaf06665f7ea3ee9f9754e16c1a507a89f1de5b1 ]

Commit ed49f7fd6438d ("powerpc/xmon: Disable tracing when entering
xmon") added code to disable recording trace entries while in xmon. The
commit introduced a variable 'tracing_enabled' to record if tracing was
enabled on xmon entry, and used this to conditionally enable tracing
during exit from xmon.

However, we are not checking the value of 'fromipi' variable in
xmon_core() when setting 'tracing_enabled'. Due to this, when secondary
cpus enter xmon, they will see tracing as being disabled already and
tracing won't be re-enabled on exit. Fix the same.

Fixes: ed49f7fd6438d ("powerpc/xmon: Disable tracing when entering xmon")
Signed-off-by: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/powerpc/xmon/xmon.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/xmon/xmon.c b/arch/powerpc/xmon/xmon.c
index d0620d762a5a..4a721fd62406 100644
--- a/arch/powerpc/xmon/xmon.c
+++ b/arch/powerpc/xmon/xmon.c
@@ -465,8 +465,10 @@ static int xmon_core(struct pt_regs *regs, int fromipi)
 	local_irq_save(flags);
 	hard_irq_disable();
 
-	tracing_enabled = tracing_is_on();
-	tracing_off();
+	if (!fromipi) {
+		tracing_enabled = tracing_is_on();
+		tracing_off();
+	}
 
 	bp = in_breakpoint_table(regs->nip, &offset);
 	if (bp != NULL) {
-- 
2.20.1



