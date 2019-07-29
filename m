Return-Path: <SRS0=K9bG=V2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56774C76186
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 19:55:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 268272054F
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 19:55:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1564430139;
	bh=rB73xvJpdEcFSjH9TyP6peeD9RRA82j1t5fr13TMwFM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=b1JRbHE/B+WaB6q/N8Cyf9IQIzcp4vBLAtJlH5Tr8l1JMsPBf1Z5n6eYWR7D3yAKi
	 hn4MIRy9ltg7jtrxTOM4nm2C9qor3gXqYkCUutg5E5k131Qr12hncq+S6JHxpNEN3H
	 tvBgENpuWAfibFrHJ85PNMkgN0hWAltqBikLW/hI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391045AbfG2Tzh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jul 2019 15:55:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:48370 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404223AbfG2Tzc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jul 2019 15:55:32 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9FE9C204EC;
        Mon, 29 Jul 2019 19:55:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564430131;
        bh=rB73xvJpdEcFSjH9TyP6peeD9RRA82j1t5fr13TMwFM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=tQpjcGXRh1oudxNHtUJ+Xhkyq7ZmIthIJjEiQ54wwygnp83kDqo/Ajn/rIwjchDBt
         Wy/vQUw4nQwaquRoBb1Uzu9jqHIzMdWaL9MMeJuaAqYGG+RNmwFx5xkUThfx4QItik
         EtCEbhGuBCCH5Jw5uMK1H4wOFwh8nfN80EucBuks=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Vishal Verma <vishal.l.verma@intel.com>,
        Dan Williams <dan.j.williams@intel.com>
Subject: [PATCH 5.2 207/215] libnvdimm/region: Register badblocks before namespaces
Date:   Mon, 29 Jul 2019 21:23:23 +0200
Message-Id: <20190729190815.879490144@linuxfoundation.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190729190739.971253303@linuxfoundation.org>
References: <20190729190739.971253303@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dan Williams <dan.j.williams@intel.com>

commit 700cd033a82d466ad8f9615f9985525e45f8960a upstream.

Namespace activation expects to be able to reference region badblocks.
The following warning sometimes triggers when asynchronous namespace
activation races in front of the completion of namespace probing. Move
all possible namespace probing after region badblocks initialization.

Otherwise, lockdep sometimes catches the uninitialized state of the
badblocks seqlock with stack trace signatures like:

    INFO: trying to register non-static key.
    pmem2: detected capacity change from 0 to 136365211648
    the code is fine but needs lockdep annotation.
    turning off the locking correctness validator.
    CPU: 9 PID: 358 Comm: kworker/u80:5 Tainted: G           OE     5.2.0-rc4+ #3382
    Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 0.0.0 02/06/2015
    Workqueue: events_unbound async_run_entry_fn
    Call Trace:
     dump_stack+0x85/0xc0
    pmem1.12: detected capacity change from 0 to 8589934592
     register_lock_class+0x56a/0x570
     ? check_object+0x140/0x270
     __lock_acquire+0x80/0x1710
     ? __mutex_lock+0x39d/0x910
     lock_acquire+0x9e/0x180
     ? nd_pfn_validate+0x28f/0x440 [libnvdimm]
     badblocks_check+0x93/0x1f0
     ? nd_pfn_validate+0x28f/0x440 [libnvdimm]
     nd_pfn_validate+0x28f/0x440 [libnvdimm]
     ? lockdep_hardirqs_on+0xf0/0x180
     nd_dax_probe+0x9a/0x120 [libnvdimm]
     nd_pmem_probe+0x6d/0x180 [nd_pmem]
     nvdimm_bus_probe+0x90/0x2c0 [libnvdimm]

Fixes: 48af2f7e52f4 ("libnvdimm, pfn: during init, clear errors...")
Cc: <stable@vger.kernel.org>
Cc: Vishal Verma <vishal.l.verma@intel.com>
Reviewed-by: Vishal Verma <vishal.l.verma@intel.com>
Link: https://lore.kernel.org/r/156341208365.292348.1547528796026249120.stgit@dwillia2-desk3.amr.corp.intel.com
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/nvdimm/region.c |   22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

--- a/drivers/nvdimm/region.c
+++ b/drivers/nvdimm/region.c
@@ -34,17 +34,6 @@ static int nd_region_probe(struct device
 	if (rc)
 		return rc;
 
-	rc = nd_region_register_namespaces(nd_region, &err);
-	if (rc < 0)
-		return rc;
-
-	ndrd = dev_get_drvdata(dev);
-	ndrd->ns_active = rc;
-	ndrd->ns_count = rc + err;
-
-	if (rc && err && rc == err)
-		return -ENODEV;
-
 	if (is_nd_pmem(&nd_region->dev)) {
 		struct resource ndr_res;
 
@@ -60,6 +49,17 @@ static int nd_region_probe(struct device
 		nvdimm_badblocks_populate(nd_region, &nd_region->bb, &ndr_res);
 	}
 
+	rc = nd_region_register_namespaces(nd_region, &err);
+	if (rc < 0)
+		return rc;
+
+	ndrd = dev_get_drvdata(dev);
+	ndrd->ns_active = rc;
+	ndrd->ns_count = rc + err;
+
+	if (rc && err && rc == err)
+		return -ENODEV;
+
 	nd_region->btt_seed = nd_btt_create(nd_region);
 	nd_region->pfn_seed = nd_pfn_create(nd_region);
 	nd_region->dax_seed = nd_dax_create(nd_region);


