Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C964C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 12:55:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1C5AD21873
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 12:55:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553259355;
	bh=fpXFYQyx+ktbuWhA9nOn0/MNPySyjASKdvry0CHsKRA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=qlUATdxRX5mfQ0sw21jsZe1vxFSihM+X+3JuDSxoaYJ+uBDlwo3oZtFwoYcWzM1np
	 fN+uudD1Kpa//dFXUGDG9syc9QEM5j598wRk9Ko+J+2Y51xpLr9xKyW3LqdUwq9Nac
	 z59P70axiGqodggxoP+j6NwnZBc9DE3+piz66YPI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732554AbfCVMzx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 08:55:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:53240 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732119AbfCVLtc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 07:49:32 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1CFF620693;
        Fri, 22 Mar 2019 11:49:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553255371;
        bh=fpXFYQyx+ktbuWhA9nOn0/MNPySyjASKdvry0CHsKRA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=CffXz6v+k6OKuS1Govm1jh4oIFOT/v380X81kWyEVhInjcuqsUQsIXEAh5FXv/atL
         pIWeosLa/hyMkkUOLA59ZxXIEBqavMTrM4cP38k+XOJQAtGkYXg19KOPnGW22ppulf
         qXnMdy7PdjW2ASybQfsG/3kHiTfNaC4po34nNI5U=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Dan Williams <dan.j.williams@intel.com>
Subject: [PATCH 4.14 070/183] libnvdimm/pmem: Honor force_raw for legacy pmem regions
Date:   Fri, 22 Mar 2019 12:14:58 +0100
Message-Id: <20190322111246.772333506@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190322111241.819468003@linuxfoundation.org>
References: <20190322111241.819468003@linuxfoundation.org>
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

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Dan Williams <dan.j.williams@intel.com>

commit fa7d2e639cd90442d868dfc6ca1d4cc9d8bf206e upstream.

For recovery, where non-dax access is needed to a given physical address
range, and testing, allow the 'force_raw' attribute to override the
default establishment of a dev_pagemap.

Otherwise without this capability it is possible to end up with a
namespace that can not be activated due to corrupted info-block, and one
that can not be repaired due to a section collision.

Cc: <stable@vger.kernel.org>
Fixes: 004f1afbe199 ("libnvdimm, pmem: direct map legacy pmem by default")
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/nvdimm/namespace_devs.c |    4 ++++
 1 file changed, 4 insertions(+)

--- a/drivers/nvdimm/namespace_devs.c
+++ b/drivers/nvdimm/namespace_devs.c
@@ -138,6 +138,7 @@ bool nd_is_uuid_unique(struct device *de
 bool pmem_should_map_pages(struct device *dev)
 {
 	struct nd_region *nd_region = to_nd_region(dev->parent);
+	struct nd_namespace_common *ndns = to_ndns(dev);
 	struct nd_namespace_io *nsio;
 
 	if (!IS_ENABLED(CONFIG_ZONE_DEVICE))
@@ -149,6 +150,9 @@ bool pmem_should_map_pages(struct device
 	if (is_nd_pfn(dev) || is_nd_btt(dev))
 		return false;
 
+	if (ndns->force_raw)
+		return false;
+
 	nsio = to_nd_namespace_io(dev);
 	if (region_intersects(nsio->res.start, resource_size(&nsio->res),
 				IORESOURCE_SYSTEM_RAM,


