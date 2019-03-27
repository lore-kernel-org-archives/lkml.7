Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A128C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 18:18:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1E5882087C
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 18:18:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553710688;
	bh=49Ws3vm9DBCDEHNtlMsKfC4OwoNUPa7uOurx/0g4ZXI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=QqnY0UiIwWzT5qFKwzqdjdZ68QKdiWukPCpFprOg83jGlyrWKp6+lqw8tPyDn5Tvq
	 hAEF5ymPkn/Mt/xonGygQLGcQYgvetUjW2PM8g9Ve5UbKawNQ0dZZ8cNL42rbylZMJ
	 E7i1teW7ZYyT+uCVT54Y4hubgJqLUlMRgCjhNNBM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390440AbfC0SSG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 14:18:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:34672 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390418AbfC0SSB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 14:18:01 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4893221850;
        Wed, 27 Mar 2019 18:18:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553710681;
        bh=49Ws3vm9DBCDEHNtlMsKfC4OwoNUPa7uOurx/0g4ZXI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ZaGuEhmUl6l1d9KQiFkLn4oT2DZxv/Dj5dIPcL3hp5EJF8YY10pSRQd4GEN5T6lcy
         cfkW/MeUAZFUHyOZZmyzJNXK4EVmG2ReleNr+9e0W67ImL6vZkNYUvcuDROm1g3JO8
         CbPgM0GKtq6Me/bHJid+5GIFVUl0xpQzkDkpkzC4=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Ross Lagerwall <ross.lagerwall@citrix.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Sasha Levin <sashal@kernel.org>, linux-efi@vger.kernel.org
Subject: [PATCH AUTOSEL 4.14 051/123] efi: cper: Fix possible out-of-bounds access
Date:   Wed, 27 Mar 2019 14:15:15 -0400
Message-Id: <20190327181628.15899-51-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190327181628.15899-1-sashal@kernel.org>
References: <20190327181628.15899-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ross Lagerwall <ross.lagerwall@citrix.com>

[ Upstream commit 45b14a4ffcc1e0b5caa246638f942cbe7eaea7ad ]

When checking a generic status block, we iterate over all the generic
data blocks. The loop condition only checks that the start of the
generic data block is valid (within estatus->data_length) but not the
whole block. Because the size of data blocks (excluding error data) may
vary depending on the revision and the revision is contained within the
data block, ensure that enough of the current data block is valid before
dereferencing any members otherwise an out-of-bounds access may occur if
estatus->data_length is invalid.

This relies on the fact that struct acpi_hest_generic_data_v300 is a
superset of the earlier version.  Also rework the other checks to avoid
potential underflow.

Signed-off-by: Ross Lagerwall <ross.lagerwall@citrix.com>
Acked-by: Borislav Petkov <bp@suse.de>
Tested-by: Tyler Baicar <baicar.tyler@gmail.com>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/firmware/efi/cper.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/drivers/firmware/efi/cper.c b/drivers/firmware/efi/cper.c
index d2fcafcea07e..ce23d5402bd6 100644
--- a/drivers/firmware/efi/cper.c
+++ b/drivers/firmware/efi/cper.c
@@ -641,19 +641,24 @@ EXPORT_SYMBOL_GPL(cper_estatus_check_header);
 int cper_estatus_check(const struct acpi_hest_generic_status *estatus)
 {
 	struct acpi_hest_generic_data *gdata;
-	unsigned int data_len, gedata_len;
+	unsigned int data_len, record_size;
 	int rc;
 
 	rc = cper_estatus_check_header(estatus);
 	if (rc)
 		return rc;
+
 	data_len = estatus->data_length;
 
 	apei_estatus_for_each_section(estatus, gdata) {
-		gedata_len = acpi_hest_get_error_length(gdata);
-		if (gedata_len > data_len - acpi_hest_get_size(gdata))
+		if (sizeof(struct acpi_hest_generic_data) > data_len)
+			return -EINVAL;
+
+		record_size = acpi_hest_get_record_size(gdata);
+		if (record_size > data_len)
 			return -EINVAL;
-		data_len -= acpi_hest_get_record_size(gdata);
+
+		data_len -= record_size;
 	}
 	if (data_len)
 		return -EINVAL;
-- 
2.19.1

