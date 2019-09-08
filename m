Return-Path: <SRS0=sd1o=XD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEE02C4332F
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Sep 2019 12:50:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A665E2190F
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Sep 2019 12:50:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1567947010;
	bh=Hj/mEbfDcU4RvJYf9sQAXSGASOLtPSMuI0BJocJkky8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=xl6xcCjRX+X0T5jEfaQPERM7Veg4dTALAFgGEurT6K/Y7DcaXzipd7wDIilX6fERd
	 PiICyaduA2T4IaL8TRGnjm7YhsD1F7W+VOtgbOaO/Mhj0aV736aL4Mp1Temb7McGXd
	 aNNcB6Jb3i2F/7Eo+kryYKDTZFv85g3o6fxK8w7M=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731987AbfIHMuJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 8 Sep 2019 08:50:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:40664 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731953AbfIHMuG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Sep 2019 08:50:06 -0400
Received: from localhost (unknown [62.28.240.114])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CA0B821927;
        Sun,  8 Sep 2019 12:50:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1567947006;
        bh=Hj/mEbfDcU4RvJYf9sQAXSGASOLtPSMuI0BJocJkky8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=gjVW2hRUU3xihrU4tdaxIT2vhmtUfzgy2VdErNBMlOdollEGPIY9DX8FvJuYcrfcH
         XH0v+TVeAjZtR8bovAchUzaV7Sxl2VEBZN27vsrJeDsuNTCMX6o7SVCy8wxrZCUWF9
         hke+Fla3Ncro9e8ZdXAeGHSU1DoWrhzvYn5JEEl8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, John Hurley <john.hurley@netronome.com>,
        Jakub Kicinski <jakub.kicinski@netronome.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 5.2 08/94] nfp: flower: prevent ingress block binds on internal ports
Date:   Sun,  8 Sep 2019 13:41:04 +0100
Message-Id: <20190908121150.669979451@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20190908121150.420989666@linuxfoundation.org>
References: <20190908121150.420989666@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: John Hurley <john.hurley@netronome.com>

[ Upstream commit 739d7c5752b255e89ddbb1b0474f3b88ef5cd343 ]

Internal port TC offload is implemented through user-space applications
(such as OvS) by adding filters at egress via TC clsact qdiscs. Indirect
block offload support in the NFP driver accepts both ingress qdisc binds
and egress binds if the device is an internal port. However, clsact sends
bind notification for both ingress and egress block binds which can lead
to the driver registering multiple callbacks and receiving multiple
notifications of new filters.

Fix this by rejecting ingress block bind callbacks when the port is
internal and only adding filter callbacks for egress binds.

Fixes: 4d12ba42787b ("nfp: flower: allow offloading of matches on 'internal' ports")
Signed-off-by: John Hurley <john.hurley@netronome.com>
Reviewed-by: Jakub Kicinski <jakub.kicinski@netronome.com>
Signed-off-by: Jakub Kicinski <jakub.kicinski@netronome.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/netronome/nfp/flower/offload.c |    7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

--- a/drivers/net/ethernet/netronome/nfp/flower/offload.c
+++ b/drivers/net/ethernet/netronome/nfp/flower/offload.c
@@ -1280,9 +1280,10 @@ nfp_flower_setup_indr_tc_block(struct ne
 	struct nfp_flower_priv *priv = app->priv;
 	int err;
 
-	if (f->binder_type != TCF_BLOCK_BINDER_TYPE_CLSACT_INGRESS &&
-	    !(f->binder_type == TCF_BLOCK_BINDER_TYPE_CLSACT_EGRESS &&
-	      nfp_flower_internal_port_can_offload(app, netdev)))
+	if ((f->binder_type != TCF_BLOCK_BINDER_TYPE_CLSACT_INGRESS &&
+	     !nfp_flower_internal_port_can_offload(app, netdev)) ||
+	    (f->binder_type != TCF_BLOCK_BINDER_TYPE_CLSACT_EGRESS &&
+	     nfp_flower_internal_port_can_offload(app, netdev)))
 		return -EOPNOTSUPP;
 
 	switch (f->command) {


