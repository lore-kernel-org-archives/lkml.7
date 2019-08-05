Return-Path: <SRS0=v0Gj=WB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEBCEC433FF
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Aug 2019 13:08:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8426B2067D
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Aug 2019 13:08:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1565010506;
	bh=fx+ROdbaiTOj4K4MiEjLJht8kft5nXZPivT5yEKqB6E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=hxsH/sL0cdg02u/T/8mLi5aDUGEnb0gvCFYwZ5LIBb1v9LHEHRWuLU0YgAlrXy4gz
	 lO/HS+6CiEP7PPWHBHgWYNXGMXHyL3cgmibf9iqR6f3OiIHJkqhqdphoQyFf9MxNy2
	 Le+Bp+EZ9rtVM6F6PsKCDyPxMDOy72U99Kw5A9Hg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730027AbfHENIZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Aug 2019 09:08:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:46420 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730017AbfHENIX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Aug 2019 09:08:23 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CBC3F2067D;
        Mon,  5 Aug 2019 13:08:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565010502;
        bh=fx+ROdbaiTOj4K4MiEjLJht8kft5nXZPivT5yEKqB6E=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=w5zky6sQqFUTYCri3GT+mtd7tyJYNVvbNYIsGny7Xfg2HfD/2bF8PB25XyvYmEdLb
         xhn0uCrDBC0hbxpSaSpjix7TpBNA17d1ZC5LT6cmy/st/qOnG7K8L7XjvF0/IjW2W7
         EhsIDTfmbdb9DEdUsGyqyIu8jMInssKOtAUWRBlE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Mike Marciniszyn <mike.marciniszyn@intel.com>,
        John Fleck <john.fleck@intel.com>,
        Jason Gunthorpe <jgg@mellanox.com>
Subject: [PATCH 4.14 49/53] IB/hfi1: Check for error on call to alloc_rsm_map_table
Date:   Mon,  5 Aug 2019 15:03:14 +0200
Message-Id: <20190805124933.338612472@linuxfoundation.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190805124927.973499541@linuxfoundation.org>
References: <20190805124927.973499541@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: John Fleck <john.fleck@intel.com>

commit cd48a82087231fdba0e77521102386c6ed0168d6 upstream.

The call to alloc_rsm_map_table does not check if the kmalloc fails.
Check for a NULL on alloc, and bail if it fails.

Fixes: 372cc85a13c9 ("IB/hfi1: Extract RSM map table init from QOS")
Link: https://lore.kernel.org/r/20190715164521.74174.27047.stgit@awfm-01.aw.intel.com
Cc: <stable@vger.kernel.org>
Reviewed-by: Mike Marciniszyn <mike.marciniszyn@intel.com>
Signed-off-by: John Fleck <john.fleck@intel.com>
Signed-off-by: Mike Marciniszyn <mike.marciniszyn@intel.com>
Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/infiniband/hw/hfi1/chip.c |   11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

--- a/drivers/infiniband/hw/hfi1/chip.c
+++ b/drivers/infiniband/hw/hfi1/chip.c
@@ -14566,7 +14566,7 @@ void hfi1_deinit_vnic_rsm(struct hfi1_de
 		clear_rcvctrl(dd, RCV_CTRL_RCV_RSM_ENABLE_SMASK);
 }
 
-static void init_rxe(struct hfi1_devdata *dd)
+static int init_rxe(struct hfi1_devdata *dd)
 {
 	struct rsm_map_table *rmt;
 	u64 val;
@@ -14575,6 +14575,9 @@ static void init_rxe(struct hfi1_devdata
 	write_csr(dd, RCV_ERR_MASK, ~0ull);
 
 	rmt = alloc_rsm_map_table(dd);
+	if (!rmt)
+		return -ENOMEM;
+
 	/* set up QOS, including the QPN map table */
 	init_qos(dd, rmt);
 	init_user_fecn_handling(dd, rmt);
@@ -14599,6 +14602,7 @@ static void init_rxe(struct hfi1_devdata
 	val = read_csr(dd, RCV_BYPASS);
 	val |= (4ull << 16);
 	write_csr(dd, RCV_BYPASS, val);
+	return 0;
 }
 
 static void init_other(struct hfi1_devdata *dd)
@@ -15154,7 +15158,10 @@ struct hfi1_devdata *hfi1_init_dd(struct
 		goto bail_cleanup;
 
 	/* set initial RXE CSRs */
-	init_rxe(dd);
+	ret = init_rxe(dd);
+	if (ret)
+		goto bail_cleanup;
+
 	/* set initial TXE CSRs */
 	init_txe(dd);
 	/* set initial non-RXE, non-TXE CSRs */


