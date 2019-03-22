Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C704C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 12:02:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0A88E2192D
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 12:02:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553256130;
	bh=1PGIS+gx5ORucqsr9XmOysTbU0pU6ljmz1B/+nBVndI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=XfDALvJrGehq8gWSs25k1ahUwHPKpKMBYjVQNnSamyiLtYbPsyEYR9usz82Ofv93O
	 mGGrrJa9GAAA8SsymM9WnbKAw6wlQ+fYvnUYFDfJJWkbjwY6gJDox/mGhhNESmHFgP
	 dk78zk7PTHNAyHNU1qnOxPbbavOnExXtfqr2nVn8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388312AbfCVMCJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 08:02:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:40056 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388305AbfCVMCF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 08:02:05 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 979CA204FD;
        Fri, 22 Mar 2019 12:02:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553256125;
        bh=1PGIS+gx5ORucqsr9XmOysTbU0pU6ljmz1B/+nBVndI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=1zeMpr57GFPBvCl98Ndb/7HNVsnv0WFX852f0QvVqo8uhHVghXLDFC7Iibt9wHuO0
         IWsyxwatuJJlpemjpnJesNJOKT3+24LD2Ay8HWEPfvC005Dsw16J0G7sywsX9EtVAL
         4k6QRie5e6vDkXllU4RBSVcNKbOPZoRtr2zs3bP4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Erwin Tsaur <erwin.tsaur@oracle.com>,
        Toshi Kani <toshi.kani@hpe.com>,
        Dan Williams <dan.j.williams@intel.com>
Subject: [PATCH 4.19 116/280] nfit/ars: Attempt short-ARS even in the no_init_ars case
Date:   Fri, 22 Mar 2019 12:14:29 +0100
Message-Id: <20190322111314.337064741@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190322111306.356185024@linuxfoundation.org>
References: <20190322111306.356185024@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Dan Williams <dan.j.williams@intel.com>

commit fa3ed4d981b1fc19acdd07fcb152a4bd3706892b upstream.

The no_init_ars option is meant to prevent long-ARS, but short-ARS
should be allowed to grab any immediate results.

Fixes: bc6ba8085842 ("nfit, address-range-scrub: rework and simplify ARS...")
Cc: <stable@vger.kernel.org>
Reported-by: Erwin Tsaur <erwin.tsaur@oracle.com>
Reviewed-by: Toshi Kani <toshi.kani@hpe.com>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/acpi/nfit/core.c |    5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

--- a/drivers/acpi/nfit/core.c
+++ b/drivers/acpi/nfit/core.c
@@ -2892,11 +2892,12 @@ static int ars_register(struct acpi_nfit
 {
 	int rc;
 
-	if (no_init_ars || test_bit(ARS_FAILED, &nfit_spa->ars_state))
+	if (test_bit(ARS_FAILED, &nfit_spa->ars_state))
 		return acpi_nfit_register_region(acpi_desc, nfit_spa);
 
 	set_bit(ARS_REQ_SHORT, &nfit_spa->ars_state);
-	set_bit(ARS_REQ_LONG, &nfit_spa->ars_state);
+	if (!no_init_ars)
+		set_bit(ARS_REQ_LONG, &nfit_spa->ars_state);
 
 	switch (acpi_nfit_query_poison(acpi_desc)) {
 	case 0:


