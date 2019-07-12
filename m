Return-Path: <SRS0=V+Ds=VJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 955A6C742B9
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jul 2019 12:20:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 67CD5216E3
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jul 2019 12:20:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1562934039;
	bh=tcuzNV4CwkhlZAaLrml/xtkukk3tnDIOoYJlyeBbn6s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=2Et7fj08r16fsdShTesgiYX13T/A4o9Pl/NI4QGg3zYD2O9kNv0oxtLP0cpwoCupC
	 vC50ZgcmVEz2DMk4K2SKKYE9u5rlJ5QEOqVDYoqTG3ArjwmLUm0ll2SpUevolyPD9F
	 kk7mRy8BzlOv4uZsRdam8Jryskfqhh4wv61gISL0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727373AbfGLMUh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Jul 2019 08:20:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:53878 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727357AbfGLMUd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Jul 2019 08:20:33 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2FEA22166E;
        Fri, 12 Jul 2019 12:20:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1562934032;
        bh=tcuzNV4CwkhlZAaLrml/xtkukk3tnDIOoYJlyeBbn6s=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=S/OVQv8GrPk7mujrFgz1HeVag8SnCdje0Ot3Ce+fgqJJG5flGsLd9XUyjD89UysJW
         HqywThk3Dch9em0Ypwd56mRMgE6MRJ38Nbip6QTktrtmwV2ArBSgIV11luIPQtQnm9
         SOhv1ihBKoT3P3aKCkHHK6MHjNr/XFYMhNOCnZ/g=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Thomas Falcon <tlfalcon@linux.ibm.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 24/91] ibmvnic: Refresh device multicast list after reset
Date:   Fri, 12 Jul 2019 14:18:27 +0200
Message-Id: <20190712121622.707174959@linuxfoundation.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190712121621.422224300@linuxfoundation.org>
References: <20190712121621.422224300@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Upstream commit be32a24372cf162e825332da1a7ccef058d4f20b ]

It was observed that multicast packets were no longer received after
a device reset.  The fix is to resend the current multicast list to
the backing device after recovery.

Signed-off-by: Thomas Falcon <tlfalcon@linux.ibm.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/ibm/ibmvnic.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/ethernet/ibm/ibmvnic.c b/drivers/net/ethernet/ibm/ibmvnic.c
index bf0a5fe0da17..b88af81499e8 100644
--- a/drivers/net/ethernet/ibm/ibmvnic.c
+++ b/drivers/net/ethernet/ibm/ibmvnic.c
@@ -1854,6 +1854,9 @@ static int do_reset(struct ibmvnic_adapter *adapter,
 		return 0;
 	}
 
+	/* refresh device's multicast list */
+	ibmvnic_set_multi(netdev);
+
 	/* kick napi */
 	for (i = 0; i < adapter->req_rx_queues; i++)
 		napi_schedule(&adapter->napi[i]);
-- 
2.20.1



