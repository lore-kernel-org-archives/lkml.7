Return-Path: <SRS0=vtn1=VX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3F12C7618B
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 15:29:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 763AB22BF5
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 15:29:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1564154940;
	bh=i4TRmu1fUBZFRG8S4fuS1qYx+hkUoT595nTsFf2200M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=pc/hkewPLk6FA7EwAcUtQrmMGV3zcglcevbZT/+Cb0c1s/K30MRJRwYaVAVNnRZQb
	 xUA+pQiTisI7D6iWsh6ugBIHRXcKH6JtRdDWepKPCVcXDZybqe+4sFyI50h0MhnoON
	 CyY3OeOVtoJYNsSlnln5xBkzYQtJSbBsEvZpOvow=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388635AbfGZP27 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jul 2019 11:28:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:43508 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388632AbfGZP24 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jul 2019 11:28:56 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B972F205F4;
        Fri, 26 Jul 2019 15:28:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564154935;
        bh=i4TRmu1fUBZFRG8S4fuS1qYx+hkUoT595nTsFf2200M=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Pk3vGKnxBrBSf6G8tw6b+CtsdUf+RSG4OBCUSQPlNoXx8wWgXdv9B42dyIubfTWBV
         TFx07ObN+jIlu5C42KXj1bWzo+ds4Tgk26tfNY9kOVqEXMOauGj4p1N7Bf2Po9BTtr
         8ZcqpLWdeY+kknykE5ppry/gJqesVWZI1cA13wH4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Brian King <brking@linux.vnet.ibm.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 5.1 01/62] bnx2x: Prevent load reordering in tx completion processing
Date:   Fri, 26 Jul 2019 17:24:13 +0200
Message-Id: <20190726152301.872603634@linuxfoundation.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190726152301.720139286@linuxfoundation.org>
References: <20190726152301.720139286@linuxfoundation.org>
User-Agent: quilt/0.66
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Brian King <brking@linux.vnet.ibm.com>

[ Upstream commit ea811b795df24644a8eb760b493c43fba4450677 ]

This patch fixes an issue seen on Power systems with bnx2x which results
in the skb is NULL WARN_ON in bnx2x_free_tx_pkt firing due to the skb
pointer getting loaded in bnx2x_free_tx_pkt prior to the hw_cons
load in bnx2x_tx_int. Adding a read memory barrier resolves the issue.

Signed-off-by: Brian King <brking@linux.vnet.ibm.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/broadcom/bnx2x/bnx2x_cmn.c |    3 +++
 1 file changed, 3 insertions(+)

--- a/drivers/net/ethernet/broadcom/bnx2x/bnx2x_cmn.c
+++ b/drivers/net/ethernet/broadcom/bnx2x/bnx2x_cmn.c
@@ -285,6 +285,9 @@ int bnx2x_tx_int(struct bnx2x *bp, struc
 	hw_cons = le16_to_cpu(*txdata->tx_cons_sb);
 	sw_cons = txdata->tx_pkt_cons;
 
+	/* Ensure subsequent loads occur after hw_cons */
+	smp_rmb();
+
 	while (sw_cons != hw_cons) {
 		u16 pkt_cons;
 


