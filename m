Return-Path: <SRS0=RyeP=TH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	T_DKIMWL_WL_HIGH,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8417C004C9
	for <linux-kernel@archiver.kernel.org>; Tue,  7 May 2019 05:48:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 88E3F205ED
	for <linux-kernel@archiver.kernel.org>; Tue,  7 May 2019 05:48:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1557208117;
	bh=4Ruw6mUD4zBOCDiBbLvKaU1Nm+tiQj2boN6q3TPTB18=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=XrbJ0+rT9hjJuPrPPCdrZ/UQNsS+fNktpOa3KMUegDS/0gOoS8E6Ljrhz9wAkTYsH
	 RjPGawNajYh6U3EMfwSRfjplEF4nMmD7njSyqhQfWlBAl9TZsMAT3H3TT70NYcVwI9
	 GsjR/WHW+wIemSDNhFoNqkUdq38wor/x/Xk9xf1I=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729174AbfEGFko (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 May 2019 01:40:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:60104 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729142AbfEGFkj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 May 2019 01:40:39 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id ECDB5205ED;
        Tue,  7 May 2019 05:40:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1557207639;
        bh=4Ruw6mUD4zBOCDiBbLvKaU1Nm+tiQj2boN6q3TPTB18=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=LjiMBnFqwrkyL5H3KcTcobAxMWzYoiTWdC0MeV86TAsOH3OxzcGmiW7nOetBtdKF0
         7yNG25HAH6n8BjmT4OR/QapehK4qyRRIOCuvjVckGfa/LOHQJiZwpncVtBtMTPY6jB
         Mb/w8ek7oX0hNNFLv5NoW7MSMr8nTdbHMO++sPOs=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Alexey Brodkin <alexey.brodkin@synopsys.com>,
        Alexey Brodkin <abrodkin@synopsys.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        David Laight <David.Laight@ACULAB.COM>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vineet Gupta <vgupta@synopsys.com>,
        Will Deacon <will.deacon@arm.com>, Greg KH <greg@kroah.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.14 72/95] devres: Align data[] to ARCH_KMALLOC_MINALIGN
Date:   Tue,  7 May 2019 01:38:01 -0400
Message-Id: <20190507053826.31622-72-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190507053826.31622-1-sashal@kernel.org>
References: <20190507053826.31622-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alexey Brodkin <alexey.brodkin@synopsys.com>

[ Upstream commit a66d972465d15b1d89281258805eb8b47d66bd36 ]

Initially we bumped into problem with 32-bit aligned atomic64_t
on ARC, see [1]. And then during quite lengthly discussion Peter Z.
mentioned ARCH_KMALLOC_MINALIGN which IMHO makes perfect sense.
If allocation is done by plain kmalloc() obtained buffer will be
ARCH_KMALLOC_MINALIGN aligned and then why buffer obtained via
devm_kmalloc() should have any other alignment?

This way we at least get the same behavior for both types of
allocation.

[1] http://lists.infradead.org/pipermail/linux-snps-arc/2018-July/004009.html
[2] http://lists.infradead.org/pipermail/linux-snps-arc/2018-July/004036.html

Signed-off-by: Alexey Brodkin <abrodkin@synopsys.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: David Laight <David.Laight@ACULAB.COM>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Vineet Gupta <vgupta@synopsys.com>
Cc: Will Deacon <will.deacon@arm.com>
Cc: Greg KH <greg@kroah.com>
Cc: <stable@vger.kernel.org> # 4.8+
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/base/devres.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/base/devres.c b/drivers/base/devres.c
index 71d577025285..e43a04a495a3 100644
--- a/drivers/base/devres.c
+++ b/drivers/base/devres.c
@@ -25,8 +25,14 @@ struct devres_node {
 
 struct devres {
 	struct devres_node		node;
-	/* -- 3 pointers */
-	unsigned long long		data[];	/* guarantee ull alignment */
+	/*
+	 * Some archs want to perform DMA into kmalloc caches
+	 * and need a guaranteed alignment larger than
+	 * the alignment of a 64-bit integer.
+	 * Thus we use ARCH_KMALLOC_MINALIGN here and get exactly the same
+	 * buffer alignment as if it was allocated by plain kmalloc().
+	 */
+	u8 __aligned(ARCH_KMALLOC_MINALIGN) data[];
 };
 
 struct devres_group {
-- 
2.20.1

