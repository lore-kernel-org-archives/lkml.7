Return-Path: <SRS0=SjSX=S5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 477DFC43219
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 01:52:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0E8C62064A
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 01:52:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556329955;
	bh=rhGKgLoAIN+SA/unJSFJ4JRNXXqT4RR7W2XucRBKwj8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=sQWgJFpgEZZWN69+ZkqoVRpApDEN5Odi1M6602tRGEofxkE+o1ZNfn/nTxHrsXwnM
	 IyuuJtM7YYsLyxDueoNuh/BBDqkACH65QnBDULfh+ZB/vzH5d+GrZj0SAHM8OwhRMZ
	 oE3PgNq/YwdRI5tfqqplKBUqVJPEc25BUwnZXB04=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728364AbfD0Bwe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Apr 2019 21:52:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:44194 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728012AbfD0Bke (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Apr 2019 21:40:34 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 28FCC214AE;
        Sat, 27 Apr 2019 01:40:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556329234;
        bh=rhGKgLoAIN+SA/unJSFJ4JRNXXqT4RR7W2XucRBKwj8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=UZ73YsYPdw/lCjb4oByq3QmBEJ+StKYS88R0ZiJTZhV8tgzee2ZpiFWGNlXYwzOKJ
         m+nan0q1Eyzkm+bsBo68EEkRhCPG/g/gkHx06r1PjVADjyj9ZWMXaJsnYO2KoO2x+G
         1xmv08VjiebdGTxR7cVrhXSmXnMRvVNX5TlH8lb0=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Stephen Boyd <sboyd@kernel.org>,
        =?UTF-8?q?David=20M=C3=BCller?= <dave.mueller@gmx.ch>,
        Hans de Goede <hdegoede@redhat.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Sasha Levin <sashal@kernel.org>,
        platform-driver-x86@vger.kernel.org
Subject: [PATCH AUTOSEL 5.0 71/79] platform/x86: pmc_atom: Drop __initconst on dmi table
Date:   Fri, 26 Apr 2019 21:38:30 -0400
Message-Id: <20190427013838.6596-71-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190427013838.6596-1-sashal@kernel.org>
References: <20190427013838.6596-1-sashal@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Stephen Boyd <sboyd@kernel.org>

[ Upstream commit b995dcca7cf12f208cfd95fd9d5768dca7cccec7 ]

It's used by probe and that isn't an init function. Drop this so that we
don't get a section mismatch.

Reported-by: kbuild test robot <lkp@intel.com>
Cc: David Müller <dave.mueller@gmx.ch>
Cc: Hans de Goede <hdegoede@redhat.com>
Cc: Andy Shevchenko <andy.shevchenko@gmail.com>
Fixes: 7c2e07130090 ("clk: x86: Add system specific quirk to mark clocks as critical")
Signed-off-by: Stephen Boyd <sboyd@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/platform/x86/pmc_atom.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/platform/x86/pmc_atom.c b/drivers/platform/x86/pmc_atom.c
index eaec2d306481..c7039f52ad51 100644
--- a/drivers/platform/x86/pmc_atom.c
+++ b/drivers/platform/x86/pmc_atom.c
@@ -396,7 +396,7 @@ static int pmc_dbgfs_register(struct pmc_dev *pmc)
  * Some systems need one or more of their pmc_plt_clks to be
  * marked as critical.
  */
-static const struct dmi_system_id critclk_systems[] __initconst = {
+static const struct dmi_system_id critclk_systems[] = {
 	{
 		.ident = "MPL CEC1x",
 		.matches = {
-- 
2.19.1

