Return-Path: <SRS0=PPSE=ZM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCE31C43215
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 19:00:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B5F3F21823
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 19:00:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574276443;
	bh=mrDAvCusJ7RjzcAQOztGK0ooNaLrN91ho3jdV+DQ7h0=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=Xpi2hBjhlDg2pfRVert8QF2IjKw7OKTLNTyCI6kKbkG72fRiNFIw/tjby8Yv90Zu1
	 2XJ+zVuxdj+JrSd0kDNpBjVocJE0Y9RiczCoUTsJWFJy+1YpsbbCtdSODdNSss0QOW
	 uIWciYpHyFMGyXMEGcc1zGnKbm3AvKTAOgUmOQ/I=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727545AbfKTTAm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Nov 2019 14:00:42 -0500
Received: from mail.kernel.org ([198.145.29.99]:50762 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726523AbfKTTAm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Nov 2019 14:00:42 -0500
Received: from localhost.localdomain (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2A87C2068D;
        Wed, 20 Nov 2019 19:00:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574276441;
        bh=mrDAvCusJ7RjzcAQOztGK0ooNaLrN91ho3jdV+DQ7h0=;
        h=From:To:Cc:Subject:Date:From;
        b=UeCqc0Wph0UiKuGQ1wqj0IpYkFA9zpDP2ilB3qagqYRCib5rZ+yPnKuhSgqm4NUSL
         dyePP7n0zyhUjHgbD6xQgaw1m1FyTX/zR6LG9pLUd666YIXn3Ojuyc5SzT2A0OP3Os
         m0AAUe6Da+1bNZ3s2LQpE3/53/s3gIfbgg5bZIsA=
From:   Will Deacon <will@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     devicetree@vger.kernel.org, iommu@lists.linuxfoundation.org,
        Will Deacon <will@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh@kernel.org>,
        Saravana Kannan <saravanak@google.com>,
        Robin Murphy <robin.murphy@arm.com>
Subject: [PATCH] of: property: Add device link support for "iommu-map"
Date:   Wed, 20 Nov 2019 19:00:28 +0000
Message-Id: <20191120190028.4722-1-will@kernel.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 8e12257dead7 ("of: property: Add device link support for iommus,
mboxes and io-channels") added device link support for IOMMU linkages
described using the "iommus" property. For PCI devices, this property
is not present and instead the "iommu-map" property is used on the host
bridge node to map the endpoint RequesterIDs to their corresponding
IOMMU instance.

Add support for "iommu-map" to the device link supplier bindings so that
probing of PCI devices can be deferred until after the IOMMU is
available.

Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Rob Herring <robh@kernel.org>
Cc: Saravana Kannan <saravanak@google.com>
Cc: Robin Murphy <robin.murphy@arm.com>
Signed-off-by: Will Deacon <will@kernel.org>
---

Applies against driver-core/driver-core-next.
Tested on AMD Seattle (arm64).

 drivers/of/property.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/of/property.c b/drivers/of/property.c
index 0fa04692e3cc..37e0d408430d 100644
--- a/drivers/of/property.c
+++ b/drivers/of/property.c
@@ -1190,10 +1190,20 @@ DEFINE_SIMPLE_PROP(mboxes, "mboxes", "#mbox-cells")
 DEFINE_SIMPLE_PROP(io_channels, "io-channel", "#io-channel-cells")
 DEFINE_SUFFIX_PROP(regulators, "-supply", NULL)
 
+static struct device_node *parse_iommu_maps(struct device_node *np,
+					    const char *prop_name, int index)
+{
+	if (strcmp(prop_name, "iommu-map"))
+		return NULL;
+
+	return of_parse_phandle(np, prop_name, (index * 4) + 1);
+}
+
 static const struct supplier_bindings of_supplier_bindings[] = {
 	{ .parse_prop = parse_clocks, },
 	{ .parse_prop = parse_interconnects, },
 	{ .parse_prop = parse_iommus, },
+	{ .parse_prop = parse_iommu_maps, },
 	{ .parse_prop = parse_mboxes, },
 	{ .parse_prop = parse_io_channels, },
 	{ .parse_prop = parse_regulators, },
-- 
2.17.1

