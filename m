Return-Path: <SRS0=2Nly=TJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E9B5C04AB1
	for <linux-kernel@archiver.kernel.org>; Thu,  9 May 2019 18:46:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 75D012186A
	for <linux-kernel@archiver.kernel.org>; Thu,  9 May 2019 18:46:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1557427568;
	bh=yC0K1TXT1Dg+h2IWUIu97lPsdjlyrA3kg/UjzugIvig=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=APmutJGs6AMZ30m4mTQhChRyNg5YEK7gO+w6wsjKeYqLTIz09s4i0jxIrU1zS69VL
	 oy0ffXpJbM7bbz/Hcb/dowGVHyCFVb/wpgBz2++zuQBgE4elYDY3QGD5zn1alBIffy
	 XrPf4bLFcqEIoKH5x5PM+dVMEG14H7E6EvboWa7A=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727504AbfEISqH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 May 2019 14:46:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:38246 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727488AbfEISqD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 May 2019 14:46:03 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9DC192184C;
        Thu,  9 May 2019 18:46:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1557427563;
        bh=yC0K1TXT1Dg+h2IWUIu97lPsdjlyrA3kg/UjzugIvig=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=EYQzVxxRnUGQMX9Jmpzkc5t1m7W58TuZnV+wGlHBuRiI6whGZ20UxN0w1AwPZeknh
         8Yb6NqjgekjSE0BLRuu+l2rIm9RZbKw7ycRoN/zqM4i3QsUt9fg7LldLi5HLi72lo1
         0NkoDu+wrICR0T2QftXmN45UnJp7kbo3wQfn7zNo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, kbuild test robot <lkp@intel.com>,
        =?UTF-8?q?David=20M=C3=BCller?= <dave.mueller@gmx.ch>,
        Hans de Goede <hdegoede@redhat.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 28/42] platform/x86: pmc_atom: Drop __initconst on dmi table
Date:   Thu,  9 May 2019 20:42:17 +0200
Message-Id: <20190509181258.306404372@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190509181252.616018683@linuxfoundation.org>
References: <20190509181252.616018683@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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
index 75f69cf0d45fa..50f2a125cd2c8 100644
--- a/drivers/platform/x86/pmc_atom.c
+++ b/drivers/platform/x86/pmc_atom.c
@@ -426,7 +426,7 @@ static int pmc_dbgfs_register(struct pmc_dev *pmc)
  * Some systems need one or more of their pmc_plt_clks to be
  * marked as critical.
  */
-static const struct dmi_system_id critclk_systems[] __initconst = {
+static const struct dmi_system_id critclk_systems[] = {
 	{
 		.ident = "MPL CEC1x",
 		.matches = {
-- 
2.20.1



