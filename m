Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 609EEC282CE
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 17:39:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 31F932084F
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 17:39:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556127585;
	bh=hxCBoYeLN2V35rDQG0Oo36nXLGHrRtcsYr5v02sYSeQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ha3kHQSOOnhkQlpodTd39GyUmQKQK9TINivfNi08C1AdijQYccH4RJ8RWARHNFse7
	 9nplSmfEFVouWMEuNb9AUcZgbA6WQgFooXAtDJCY5zMzg5RCjwTBv44G23Tm5uWDBW
	 Sj4IaF8dYoC/6ZF2Ddd8VCTgGj11KTQ2mX0URIHo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404019AbfDXRjo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 13:39:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:36976 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2392282AbfDXRhw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 13:37:52 -0400
Received: from localhost (62-193-50-229.as16211.net [62.193.50.229])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9DD6020675;
        Wed, 24 Apr 2019 17:37:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556127471;
        bh=hxCBoYeLN2V35rDQG0Oo36nXLGHrRtcsYr5v02sYSeQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=sRN6d0BIUNrUi8lAgrU6mILMqJXalM5p27HIcx8WKMozOdxHGwnOqut2n+/VvaP6c
         JsqLkbni1OpZYWl+B0z7hvQjF68HHXa98US9/3sZBPHISN3eeoHq8DU7DfljkDdRRc
         M1OzVDvhacttgTC2AfHQvgG5+VIEWSvZ/XNMvwAI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Krzysztof Rusocki <krzysztof.rusocki@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Toshi Kani <toshi.kani@hpe.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.0 103/115] nfit/ars: Avoid stale ARS results
Date:   Wed, 24 Apr 2019 19:10:39 +0200
Message-Id: <20190424170930.756073824@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190424170924.797924502@linuxfoundation.org>
References: <20190424170924.797924502@linuxfoundation.org>
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
index 61d3fd65fbe9..4be4dc3e8aa6 100644
--- a/drivers/acpi/nfit/core.c
+++ b/drivers/acpi/nfit/core.c
@@ -2661,7 +2661,10 @@ static int ars_start(struct acpi_nfit_desc *acpi_desc,
 
 	if (rc < 0)
 		return rc;
-	return cmd_rc;
+	if (cmd_rc < 0)
+		return cmd_rc;
+	set_bit(ARS_VALID, &acpi_desc->scrub_flags);
+	return 0;
 }
 
 static int ars_continue(struct acpi_nfit_desc *acpi_desc)
@@ -2754,6 +2757,17 @@ static int ars_status_process_records(struct acpi_nfit_desc *acpi_desc)
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
@@ -3238,6 +3252,7 @@ static int acpi_nfit_register_regions(struct acpi_nfit_desc *acpi_desc)
 	struct nfit_spa *nfit_spa;
 	int rc;
 
+	set_bit(ARS_VALID, &acpi_desc->scrub_flags);
 	list_for_each_entry(nfit_spa, &acpi_desc->spas, list) {
 		switch (nfit_spa_type(nfit_spa->spa)) {
 		case NFIT_SPA_VOLATILE:
diff --git a/drivers/acpi/nfit/nfit.h b/drivers/acpi/nfit/nfit.h
index d14bad687fb8..0cbe5009eb2c 100644
--- a/drivers/acpi/nfit/nfit.h
+++ b/drivers/acpi/nfit/nfit.h
@@ -213,6 +213,7 @@ struct nfit_mem {
 enum scrub_flags {
 	ARS_BUSY,
 	ARS_CANCEL,
+	ARS_VALID,
 	ARS_POLL,
 };
 
-- 
2.19.1



