Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D39AC282CE
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 17:32:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E014E21903
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 17:32:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556127148;
	bh=Fs9HWQxuWQIIUThd/5mrUWFKqj8BhbLyUImYW9hSDnc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=XVGLrfP8GqP16haN3D94v+K57gMSDN6DluQTgcBtP/4a6aBYFGkpVDE3tjVv9ycBc
	 sfNcWMpn4q1v7CVNtmrFz2oL61U4PcjP/WZamSiu7kAK0RYAZXFDCUBjbgXbgpRvmG
	 lDHYxPc9YI08h2a9bPoMzqwYibw6WBcpG0KvxsFk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390916AbfDXRc0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 13:32:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:59028 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2403858AbfDXRcX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 13:32:23 -0400
Received: from localhost (62-193-50-229.as16211.net [62.193.50.229])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 178602054F;
        Wed, 24 Apr 2019 17:32:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556127142;
        bh=Fs9HWQxuWQIIUThd/5mrUWFKqj8BhbLyUImYW9hSDnc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=NX2l3+7zJyCMA2RdaGMvqZhOtv9e4gUb1sPbvUWyQUMjW+TJOWiVZIWwRvbOcQs/I
         xYaN82OPYpTFklWBPTpIg/EucFNAq2SatdPw+sfYkK8QghKe490bszHvOcgu2YW6hj
         EmPcJdFhT09IdIvbIkyAz8WEaZAowhuWwzoiAvH0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Toshi Kani <toshi.kani@hpe.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 77/96] nfit/ars: Remove ars_start_flags
Date:   Wed, 24 Apr 2019 19:10:22 +0200
Message-Id: <20190424170925.011225291@linuxfoundation.org>
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

commit 317a992ab9266b86b774b9f6b0f87eb4f59879a1 upstream.

The ars_start_flags property of 'struct acpi_nfit_desc' is no longer
used since ARS_REQ_SHORT and ARS_REQ_LONG were added.

Reviewed-by: Toshi Kani <toshi.kani@hpe.com>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/acpi/nfit/core.c | 10 +++++-----
 drivers/acpi/nfit/nfit.h |  1 -
 2 files changed, 5 insertions(+), 6 deletions(-)

diff --git a/drivers/acpi/nfit/core.c b/drivers/acpi/nfit/core.c
index df2175b1169a..b5237a506464 100644
--- a/drivers/acpi/nfit/core.c
+++ b/drivers/acpi/nfit/core.c
@@ -2539,11 +2539,11 @@ static int ars_continue(struct acpi_nfit_desc *acpi_desc)
 	struct nvdimm_bus_descriptor *nd_desc = &acpi_desc->nd_desc;
 	struct nd_cmd_ars_status *ars_status = acpi_desc->ars_status;
 
-	memset(&ars_start, 0, sizeof(ars_start));
-	ars_start.address = ars_status->restart_address;
-	ars_start.length = ars_status->restart_length;
-	ars_start.type = ars_status->type;
-	ars_start.flags = acpi_desc->ars_start_flags;
+	ars_start = (struct nd_cmd_ars_start) {
+		.address = ars_status->restart_address,
+		.length = ars_status->restart_length,
+		.type = ars_status->type,
+	};
 	rc = nd_desc->ndctl(nd_desc, NULL, ND_CMD_ARS_START, &ars_start,
 			sizeof(ars_start), &cmd_rc);
 	if (rc < 0)
diff --git a/drivers/acpi/nfit/nfit.h b/drivers/acpi/nfit/nfit.h
index 02c10de50386..df31a2721573 100644
--- a/drivers/acpi/nfit/nfit.h
+++ b/drivers/acpi/nfit/nfit.h
@@ -194,7 +194,6 @@ struct acpi_nfit_desc {
 	struct list_head idts;
 	struct nvdimm_bus *nvdimm_bus;
 	struct device *dev;
-	u8 ars_start_flags;
 	struct nd_cmd_ars_status *ars_status;
 	struct nfit_spa *scrub_spa;
 	struct delayed_work dwork;
-- 
2.19.1



