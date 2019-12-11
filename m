Return-Path: <SRS0=Yvat=2B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 081DAC43603
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 15:11:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D2E6B208C3
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 15:11:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576077062;
	bh=Xc0eyKlXnbwXsBZJnAPM3DHLQ9UKo918HSZqaDGVZZk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=hyUoUnTzR3NQG2pTDACvdttUZmlcgUVIA5vGF5YHInKhB1v3ALkJjse5Gx0a2vDlH
	 zkN0E64rhzhD96dwQb3JkZCjgbomXX/NB/zZQWE/ZHJuzByV2Us7uJG1bxfyEwBnmM
	 LS/h9ghOTJ+hkS99pRQ3ryouBxT0ivhUO0dzSEsI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730861AbfLKPLB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Dec 2019 10:11:01 -0500
Received: from mail.kernel.org ([198.145.29.99]:59394 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730849AbfLKPK6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Dec 2019 10:10:58 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BB37E2173E;
        Wed, 11 Dec 2019 15:10:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576077058;
        bh=Xc0eyKlXnbwXsBZJnAPM3DHLQ9UKo918HSZqaDGVZZk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=YOjUEZpMu5K2Tx0S+UXMWZ1FRB/u6mDWhJb774YaoF23roee3ONxy5mVK4VP7Uics
         nDLElvV3Pu4B6Wbfrn5ROEMHC+pSJCD9Ci6tyh4W+0PDgfaK8UC4GNzfW7F8e9e6Dg
         PoWF/bj7jveDkf4gw1gOYlMW27G3wqF6ZC0Ehd50=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Jakob Unterwurzacher <jakob.unterwurzacher@theobroma-systems.com>,
        Martin Elshuber <martin.elshuber@theobroma-systems.com>,
        Philipp Tomsich <philipp.tomsich@theobroma-systems.com>,
        Johan Hovold <johan@kernel.org>,
        Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH 5.4 81/92] can: ucan: fix non-atomic allocation in completion handler
Date:   Wed, 11 Dec 2019 16:06:12 +0100
Message-Id: <20191211150300.171772638@linuxfoundation.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20191211150221.977775294@linuxfoundation.org>
References: <20191211150221.977775294@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Johan Hovold <johan@kernel.org>

commit 870db5d1015c8bd63e93b579e857223c96249ff7 upstream.

USB completion handlers are called in atomic context and must
specifically not allocate memory using GFP_KERNEL.

Fixes: 9f2d3eae88d2 ("can: ucan: add driver for Theobroma Systems UCAN devices")
Cc: stable <stable@vger.kernel.org>     # 4.19
Cc: Jakob Unterwurzacher <jakob.unterwurzacher@theobroma-systems.com>
Cc: Martin Elshuber <martin.elshuber@theobroma-systems.com>
Cc: Philipp Tomsich <philipp.tomsich@theobroma-systems.com>
Signed-off-by: Johan Hovold <johan@kernel.org>
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/net/can/usb/ucan.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/net/can/usb/ucan.c
+++ b/drivers/net/can/usb/ucan.c
@@ -792,7 +792,7 @@ resubmit:
 			  up);
 
 	usb_anchor_urb(urb, &up->rx_urbs);
-	ret = usb_submit_urb(urb, GFP_KERNEL);
+	ret = usb_submit_urb(urb, GFP_ATOMIC);
 
 	if (ret < 0) {
 		netdev_err(up->netdev,


