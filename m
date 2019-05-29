Return-Path: <SRS0=t3dz=T5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 972E6C28CC0
	for <linux-kernel@archiver.kernel.org>; Wed, 29 May 2019 15:15:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 76ADE23C12
	for <linux-kernel@archiver.kernel.org>; Wed, 29 May 2019 15:15:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727149AbfE2PPb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 May 2019 11:15:31 -0400
Received: from gateway22.websitewelcome.com ([192.185.47.206]:21860 "EHLO
        gateway22.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725914AbfE2PPb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 May 2019 11:15:31 -0400
Received: from cm11.websitewelcome.com (cm11.websitewelcome.com [100.42.49.5])
        by gateway22.websitewelcome.com (Postfix) with ESMTP id 9DBAF14D37
        for <linux-kernel@vger.kernel.org>; Wed, 29 May 2019 10:15:30 -0500 (CDT)
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with SMTP
        id W0IchQ4AZdnCeW0Ich4pwv; Wed, 29 May 2019 10:15:30 -0500
X-Authority-Reason: nr=8
Received: from [189.250.47.159] (port=47392 helo=embeddedor)
        by gator4166.hostgator.com with esmtpa (Exim 4.91)
        (envelope-from <gustavo@embeddedor.com>)
        id 1hW0Ib-001KQP-2O; Wed, 29 May 2019 10:15:29 -0500
Date:   Wed, 29 May 2019 10:15:28 -0500
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
To:     Mike Marciniszyn <mike.marciniszyn@intel.com>,
        Dennis Dalessandro <dennis.dalessandro@intel.com>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>
Cc:     linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: [PATCH][next] IB/hfi1: Use struct_size() helper
Message-ID: <20190529151528.GA24148@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 189.250.47.159
X-Source-L: No
X-Exim-ID: 1hW0Ib-001KQP-2O
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: (embeddedor) [189.250.47.159]:47392
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 18
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Make use of the struct_size() helper instead of an open-coded version
in order to avoid any potential type mistakes, in particular in the
context in which this code is being used.

So, replace the following form:

sizeof(struct opa_port_status_rsp) + num_vls * sizeof(struct _vls_pctrs)

with:

struct_size(rsp, vls, num_vls)

and so on...

Also, notice that variable size is unnecessary, hence it is removed.

This code was detected with the help of Coccinelle.

Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
---
 drivers/infiniband/hw/hfi1/mad.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/drivers/infiniband/hw/hfi1/mad.c b/drivers/infiniband/hw/hfi1/mad.c
index 4228393e6c4c..184dba3c2828 100644
--- a/drivers/infiniband/hw/hfi1/mad.c
+++ b/drivers/infiniband/hw/hfi1/mad.c
@@ -2744,8 +2744,7 @@ static int pma_get_opa_portstatus(struct opa_pma_mad *pmp,
 	u16 link_width;
 	u16 link_speed;
 
-	response_data_size = sizeof(struct opa_port_status_rsp) +
-				num_vls * sizeof(struct _vls_pctrs);
+	response_data_size = struct_size(rsp, vls, num_vls);
 	if (response_data_size > sizeof(pmp->data)) {
 		pmp->mad_hdr.status |= OPA_PM_STATUS_REQUEST_TOO_LARGE;
 		return reply((struct ib_mad_hdr *)pmp);
@@ -3014,8 +3013,7 @@ static int pma_get_opa_datacounters(struct opa_pma_mad *pmp,
 	}
 
 	/* Sanity check */
-	response_data_size = sizeof(struct opa_port_data_counters_msg) +
-				num_vls * sizeof(struct _vls_dctrs);
+	response_data_size = struct_size(req, port[0].vls, num_vls);
 
 	if (response_data_size > sizeof(pmp->data)) {
 		pmp->mad_hdr.status |= IB_SMP_INVALID_FIELD;
@@ -3232,8 +3230,7 @@ static int pma_get_opa_porterrors(struct opa_pma_mad *pmp,
 		return reply((struct ib_mad_hdr *)pmp);
 	}
 
-	response_data_size = sizeof(struct opa_port_error_counters64_msg) +
-				num_vls * sizeof(struct _vls_ectrs);
+	response_data_size = struct_size(req, port[0].vls, num_vls);
 
 	if (response_data_size > sizeof(pmp->data)) {
 		pmp->mad_hdr.status |= IB_SMP_INVALID_FIELD;
-- 
2.21.0

