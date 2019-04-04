Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52588C4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 10:04:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2773A2075E
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 10:04:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729071AbfDDKEx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 06:04:53 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:52024 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727053AbfDDKEp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 06:04:45 -0400
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.0:RSA_AES_256_CBC_SHA1:32)
        (Exim 4.76)
        (envelope-from <colin.king@canonical.com>)
        id 1hBzEd-0001jT-DO; Thu, 04 Apr 2019 10:04:39 +0000
From:   Colin King <colin.king@canonical.com>
To:     Dennis Dalessandro <dennis.dalessandro@intel.com>,
        Niranjana Vishwanathapura <niranjana.vishwanathapura@intel.com>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>, linux-rdma@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH][next] opa_vnic: fix check on record->event, incorrect operator used
Date:   Thu,  4 Apr 2019 11:04:39 +0100
Message-Id: <20190404100439.19696-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

The check on record->event is always true because the wrong operator
is being used, used && instead of ||

Addresses-Coverity: ("Constant expression result")
Fixes: fae7a699a925 ("opa_vnic: Convert vport_idr to XArray")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/infiniband/ulp/opa_vnic/opa_vnic_vema.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/infiniband/ulp/opa_vnic/opa_vnic_vema.c b/drivers/infiniband/ulp/opa_vnic/opa_vnic_vema.c
index 76cd09410d9a..be5befd92d16 100644
--- a/drivers/infiniband/ulp/opa_vnic/opa_vnic_vema.c
+++ b/drivers/infiniband/ulp/opa_vnic/opa_vnic_vema.c
@@ -869,7 +869,7 @@ static void opa_vnic_event(struct ib_event_handler *handler,
 	      record->event, dev_name(&record->device->dev),
 	      record->element.port_num);
 
-	if (record->event != IB_EVENT_PORT_ERR ||
+	if (record->event != IB_EVENT_PORT_ERR &&
 	    record->event != IB_EVENT_PORT_ACTIVE)
 		return;
 
-- 
2.20.1

