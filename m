Return-Path: <SRS0=WcLH=XI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D487C4CEC5
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Sep 2019 14:50:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 22C1F20693
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Sep 2019 14:50:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1568386249;
	bh=3O2EFyMvl4FydsIhvt/igmGTAWUXY533WsMeM5QFj0w=;
	h=From:Cc:Subject:Date:In-Reply-To:References:To:List-ID:From;
	b=x0ewfB1r4lH7W456cnjqj76rhZTHlNvAQPd0B92LVJEudetZluQjXxnyCERHzwM9D
	 yB86jvV2GOTw3+OqmP4D7p33/PMVE5pDSL2iX8x+R/2XYUnR2J96954rCNMzkLv6Y9
	 6si1+ppxL0cSbgfuaywmvK5zm8Q6BwKL2ZGb2x5M=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389580AbfIMOum (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Sep 2019 10:50:42 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:40792 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388997AbfIMOuh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Sep 2019 10:50:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Sender:Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:
        To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=WHvF2CG3hSL6Apn9kwopSnBjSdtlbe1zgSHAEIpSxc8=; b=q6l1RWGrXGSXR5d/aXatJKo44b
        goPcIt2gp4yQEBUgERRBuc6sNqqBSSFqK+aUbJpTTAGxleKKkj1n+OhDCTP7MVIgvdaBr1cbfBReo
        hqqj4nxCaMeEkopchd0J3W17ukwLpNnVaq38VxEWryNhh/JWDQxDfE9/udqlUe3NRbGhx8iMwoc1d
        ky9GVS6orXqkZMiTaVQp8y340QswvVepLcrJmhg2YUSGNXtTRVbehrY42n4fw6k2a22ng/fi/m0xZ
        ed20VIe41AFaGWfsVryggFPlK3ZuIqHzQYTp8KlE5EjQuGwtyEuM65lkDhU1CILuyMM0d5xpnaapK
        7N311Bhg==;
Received: from 177.96.232.144.dynamic.adsl.gvt.net.br ([177.96.232.144] helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.2 #3 (Red Hat Linux))
        id 1i8muC-0002Mt-5b; Fri, 13 Sep 2019 14:50:36 +0000
Received: from mchehab by bombadil.infradead.org with local (Exim 4.92.2)
        (envelope-from <mchehab@bombadil.infradead.org>)
        id 1i8mu9-000432-Gl; Fri, 13 Sep 2019 11:50:33 -0300
From:   Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Linux Edac Mailing List <linux-edac@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        Tony Luck <tony.luck@intel.com>,
        James Morse <james.morse@arm.com>,
        Robert Richter <rrichter@marvell.com>
Subject: [PATCH 4/7] EDAC: i5400_edac: print type at debug message
Date:   Fri, 13 Sep 2019 11:50:29 -0300
Message-Id: <426c979d7ed44f23eeeda69bcdbc91609d2d3bb7.1568385816.git.mchehab+samsung@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <cover.1568385816.git.mchehab+samsung@kernel.org>
References: <cover.1568385816.git.mchehab+samsung@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are 3 types of non-recoverable errors that the MC reports:

	- Fatal;
	- Non-fatal uncorrected
	- Non-fatal correctable

While we don't add it to the log itself, it could be useful to
have this at least for debug messages.

This shuts up this warning:

	drivers/edac/i5400_edac.c: In function ‘i5400_proccess_non_recoverable_info’:
	drivers/edac/i5400_edac.c:524:8: warning: variable ‘type’ set but not used [-Wunused-but-set-variable]
	  524 |  char *type = NULL;
	      |        ^~~~

Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
---
 drivers/edac/i5400_edac.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/edac/i5400_edac.c b/drivers/edac/i5400_edac.c
index 6f8bcdb9256a..52783b9bd0df 100644
--- a/drivers/edac/i5400_edac.c
+++ b/drivers/edac/i5400_edac.c
@@ -548,8 +548,8 @@ static void i5400_proccess_non_recoverable_info(struct mem_ctl_info *mci,
 	ras = nrec_ras(info);
 	cas = nrec_cas(info);
 
-	edac_dbg(0, "\t\tDIMM= %d  Channels= %d,%d  (Branch= %d DRAM Bank= %d Buffer ID = %d rdwr= %s ras= %d cas= %d)\n",
-		 rank, channel, channel + 1, branch >> 1, bank,
+	edac_dbg(0, "\t\t%s DIMM= %d  Channels= %d,%d  (Branch= %d DRAM Bank= %d Buffer ID = %d rdwr= %s ras= %d cas= %d)\n",
+		 type, rank, channel, channel + 1, branch >> 1, bank,
 		 buf_id, rdwr_str(rdwr), ras, cas);
 
 	/* Only 1 bit will be on */
-- 
2.21.0

