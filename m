Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6954C4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 09:12:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7680121734
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 09:12:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554369157;
	bh=OM+XS2an9UAEaPoTZbPTtTV5/9kG6w8fwJYo2wfoXEY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=GYHqUeUPyKYcZkCYqSiDkJ2RWJPshAXV9969p2T5M4oDEuJs7krXbUWkEIQz/Ke+J
	 TEhiVcpsd9eHrIpnidY+pJ0rmgnkcRtMyszlO/YeL9DbmP7Kyz+ocgEx3K8JC03gvL
	 ziIoXw2OVV1qHcXuBjX3oHSpyt4c41sY4k2vBFf4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387426AbfDDJMg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 05:12:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:52610 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387414AbfDDJMc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 05:12:32 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9A0F82054F;
        Thu,  4 Apr 2019 09:12:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554369152;
        bh=OM+XS2an9UAEaPoTZbPTtTV5/9kG6w8fwJYo2wfoXEY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=EAiJ5RRWWfC0ccs93Z0vXuxVLUAvY9vliFMoJdPaC6fWVZg+MKS9PoZsL8SJa8Y44
         lYKjBP4FySJ0LrDFUD752hTXIOKxn8Hz/T0WLBso5cZGRL/s2I/EihUk6amyZWENWq
         LKRzv9QrSGIbl7Mf83AhVDPST6xDmwFDWGmUm6I0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Ross Lagerwall <ross.lagerwall@citrix.com>,
        Borislav Petkov <bp@suse.de>,
        Tyler Baicar <baicar.tyler@gmail.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.0 103/246] efi: cper: Fix possible out-of-bounds access
Date:   Thu,  4 Apr 2019 10:46:43 +0200
Message-Id: <20190404084622.751720965@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190404084619.236418459@linuxfoundation.org>
References: <20190404084619.236418459@linuxfoundation.org>
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

5.0-stable review patch.  If anyone has any objections, please let me know.

------------------

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
index a7902fccdcfa..6090d25dce85 100644
--- a/drivers/firmware/efi/cper.c
+++ b/drivers/firmware/efi/cper.c
@@ -546,19 +546,24 @@ EXPORT_SYMBOL_GPL(cper_estatus_check_header);
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



