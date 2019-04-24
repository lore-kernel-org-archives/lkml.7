Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB81AC282E1
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 17:32:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ACD9421904
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 17:32:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556127160;
	bh=kYcIESNYkto34xuZ8siGTJFwUNiKpoCnkz7pwPJXC7w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=sJL6+MAxtQCfUCF7Tjsj0pevlJXAb6wvdTVvqw4Etr8bwdZELJZUHjXmuPVOzVt6V
	 ngrgoXujbCHo0pUs1vdO85GZjYSyxIFD83IeYBSE34P+OkxaV79oN1TV6pdcE8bhcU
	 TrmrZRIYj/wZEy8T8buLjn5+PdyZ3r+JgxoZR7Ks=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391364AbfDXRcj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 13:32:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:59216 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391349AbfDXRcb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 13:32:31 -0400
Received: from localhost (62-193-50-229.as16211.net [62.193.50.229])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EC97C2077C;
        Wed, 24 Apr 2019 17:32:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556127150;
        bh=kYcIESNYkto34xuZ8siGTJFwUNiKpoCnkz7pwPJXC7w=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=tNRboOMvCdQ3kblEKsI3nTrsiYi+VVHV3KDs1ArKlSuNOn1BDYjtUyxpdx2ORmm0C
         5XPK6GGSMJLWXi8fsSTPJSXrEK74wsIH4eu6uPqm9123i5f/kE1zoIUxk3xsmHlnkI
         FrNqj1UbhCHEG/wR7iLNcEOC0CMrwn0EUFxU4uEM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Krzysztof Rusocki <krzysztof.rusocki@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Toshi Kani <toshi.kani@hpe.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 80/96] nfit/ars: Avoid stale ARS results
Date:   Wed, 24 Apr 2019 19:10:25 +0200
Message-Id: <20190424170925.219653429@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190424170919.829037226@linuxfoundation.org>
References: <20190424170919.829037226@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

commit 78153dd45e7e0596ba32b15d02bda08e1513111e upstream.

Gate ARS result consumption on whether the OS issued start-ARS since the
previous consumption. The BIOS may only clear its result buffers after a
successful start-ARS.

Fixes: 0caeef63e6d2 ("libnvdimm: Add a poison list and export badblocks")
Cc: <stable@vger.kernel.org>
Reported-by: Krzysztof Rusocki <krzysztof.rusocki@intel.com>
Reported-by: Vishal Verma <vishal.l.verma@intel.com>
Reviewed-by: Toshi Kani <toshi.kani@hpe.com>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/acpi/nfit/core.c | 17 ++++++++++++++++-
 drivers/acpi/nfit/nfit.h |  1 +
 2 files changed, 17 insertions(+), 1 deletion(-)

diff --git a/drivers/acpi/nfit/core.c b/drivers/acpi/nfit/core.c
index 4b489d14a680..925dbc751322 100644
--- a/drivers/acpi/nfit/core.c
+++ b/drivers/acpi/nfit/core.c
@@ -2540,7 +2540,10 @@ static int ars_start(struct acpi_nfit_desc *acpi_desc,
 
 	if (rc < 0)
 		return rc;
-	return cmd_rc;
+	if (cmd_rc < 0)
+		return cmd_rc;
+	set_bit(ARS_VALID, &acpi_desc->scrub_flags);
+	return 0;
 }
 
 static int ars_continue(struct acpi_nfit_desc *acpi_desc)
@@ -2633,6 +2636,17 @@ static int ars_status_process_records(struct acpi_nfit_desc *acpi_desc)
 	 */
 	if (ars_status->out_length < 44)
 		return 0;
+
+	/*
+	 * Ignore potentially stale results that are only refreshed
+	 * after a start-ARS event.
+	 */
+	if (!test_and_clear_bit(ARS_VALID, &acpi_desc->scrub_flags)) {
+		dev_dbg(acpi_desc->dev, "skip %d stale records\n",
+				ars_status->num_records);
+		return 0;
+	}
+
 	for (i = 0; i < ars_status->num_records; i++) {
 		/* only process full records */
 		if (ars_status->out_length
@@ -3117,6 +3131,7 @@ static int acpi_nfit_register_regions(struct acpi_nfit_desc *acpi_desc)
 	struct nfit_spa *nfit_spa;
 	int rc;
 
+	set_bit(ARS_VALID, &acpi_desc->scrub_flags);
 	list_for_each_entry(nfit_spa, &acpi_desc->spas, list) {
 		switch (nfit_spa_type(nfit_spa->spa)) {
 		case NFIT_SPA_VOLATILE:
diff --git a/drivers/acpi/nfit/nfit.h b/drivers/acpi/nfit/nfit.h
index b5fd3522abc7..68848fc4b7c9 100644
--- a/drivers/acpi/nfit/nfit.h
+++ b/drivers/acpi/nfit/nfit.h
@@ -184,6 +184,7 @@ struct nfit_mem {
 enum scrub_flags {
 	ARS_BUSY,
 	ARS_CANCEL,
+	ARS_VALID,
 	ARS_POLL,
 };
 
-- 
2.19.1



