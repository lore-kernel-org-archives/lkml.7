Return-Path: <SRS0=xALZ=UQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_RED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 796BAC31E5B
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 21:29:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4426A21670
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 21:29:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1560806940;
	bh=sSkpEd/tsKtdVlynj8lDlqkdYmDE5okHyirgF3MBG4w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=N/UWZLhDabHqBIxL0iY+ncNMyEl05VMGMKCg2fS+ci/35qaHun7tKwWcnCmMHqOjo
	 rnCRdjYAfjJzuc03zgrn2EHXOXxi3bZZZ6hTAQooAq7V82c+PyGBRGSwBmLzkSquAV
	 Ax8d1/Qtj7MyW5u5F+hkpPtI9+ltgf6b/Uqf5aHk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730349AbfFQV26 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Jun 2019 17:28:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:56034 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730625AbfFQV24 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jun 2019 17:28:56 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E4C97204FD;
        Mon, 17 Jun 2019 21:28:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560806934;
        bh=sSkpEd/tsKtdVlynj8lDlqkdYmDE5okHyirgF3MBG4w=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=GRNJ9I1nDylUQJPnNHI/me2cO1szczJ41wSguqk82JVfHK5AtN5GTDnxveK3Q+cjf
         BgtzsPO611Y8xBqOwX6iNJpOGr9c1bbEfmvD5ID4mucdMeMCAQ0ydCZvLSI6z+W8RQ
         0a9mdbkBV1rTSKncQMz1quHza5VXBMMWhauA8GJs=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Sasha Levin <sashal@kernel.org>,
        Semyon Verchenko <semverchenko@factor-ts.ru>
Subject: [PATCH 4.14 33/53] platform/x86: pmc_atom: Add Lex 3I380D industrial PC to critclk_systems DMI table
Date:   Mon, 17 Jun 2019 23:10:16 +0200
Message-Id: <20190617210751.164769195@linuxfoundation.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190617210745.104187490@linuxfoundation.org>
References: <20190617210745.104187490@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Upstream commit 3d0818f5eba80fbe4c0addbfe6ddb2d19dc82cd4 ]

The Lex 3I380D industrial PC has 4 ethernet controllers on board
which need pmc_plt_clk0 - 3 to function, add it to the critclk_systems
DMI table, so that drivers/clk/x86/clk-pmc-atom.c will mark the clocks
as CLK_CRITICAL and they will not get turned off.

Fixes: 648e921888ad ("clk: x86: Stop marking clocks as CLK_IS_CRITICAL")
Reported-and-tested-by: Semyon Verchenko <semverchenko@factor-ts.ru>
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
Acked-by: Andy Shevchenko <andy.shevchenko@gmail.com>
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/platform/x86/pmc_atom.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/platform/x86/pmc_atom.c b/drivers/platform/x86/pmc_atom.c
index 50f2a125cd2c..e3e1f83a2dd7 100644
--- a/drivers/platform/x86/pmc_atom.c
+++ b/drivers/platform/x86/pmc_atom.c
@@ -428,12 +428,21 @@ static int pmc_dbgfs_register(struct pmc_dev *pmc)
  */
 static const struct dmi_system_id critclk_systems[] = {
 	{
+		/* pmc_plt_clk0 is used for an external HSIC USB HUB */
 		.ident = "MPL CEC1x",
 		.matches = {
 			DMI_MATCH(DMI_SYS_VENDOR, "MPL AG"),
 			DMI_MATCH(DMI_PRODUCT_NAME, "CEC10 Family"),
 		},
 	},
+	{
+		/* pmc_plt_clk0 - 3 are used for the 4 ethernet controllers */
+		.ident = "Lex 3I380D",
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "Lex BayTrail"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "3I380D"),
+		},
+	},
 	{ /*sentinel*/ }
 };
 
-- 
2.20.1



