Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33259C10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 17:43:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0267D2064A
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 17:43:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556127839;
	bh=z981xmIv5GFseVieToUS3RoWgludgzJjPyZ6c/6qReE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=kbFDI+KaaKp1JRxfxY4j4vBGzqjKt7APw4sxJ8qAJVLBRSGRYqRpmmDbbpmhkTMV9
	 J90ZgJC6cRBe3mC6YJJjExhbS59JYg7+1zl/xqtrVKrpmBEYXAY4fdZMDL3+YJpzdn
	 aIbGQvcF5XiCxjBHj2W6ZVX1Kz/zSclEQN8f3G8Y=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391752AbfDXRek (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 13:34:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:33416 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390550AbfDXRee (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 13:34:34 -0400
Received: from localhost (62-193-50-229.as16211.net [62.193.50.229])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6F8FA2054F;
        Wed, 24 Apr 2019 17:34:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556127273;
        bh=z981xmIv5GFseVieToUS3RoWgludgzJjPyZ6c/6qReE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=pnI7hYTx8jMQbrfe0WSn08w8u4camP2bPYyQ/zQ6jmn9gEHHX9EM4y546Ne6ptC2G
         LK+44WVphzygTtrMeIoFrcP+98H2bjAcbXXDkQp9y8z56Pe9YDUyuXBz9dHMqx0TAz
         SCbFasC/lV02MU764/k9PP2k3Ti/1maymvEBiEUk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Or Gerlitz <ogerlitz@mellanox.com>,
        Avi Urman <aviu@mellanox.com>,
        Tariq Toukan <tariqt@mellanox.com>,
        Saeed Mahameed <saeedm@mellanox.com>
Subject: [PATCH 5.0 032/115] Revert "net/mlx5e: Enable reporting checksum unnecessary also for L3 packets"
Date:   Wed, 24 Apr 2019 19:09:28 +0200
Message-Id: <20190424170926.932672175@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190424170924.797924502@linuxfoundation.org>
References: <20190424170924.797924502@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Or Gerlitz <ogerlitz@mellanox.com>

[ Upstream commit 8c8811d46d00d119ffbe039a6e52a0b504df1c2c ]

This reverts commit b820e6fb0978f9c2ac438c199d2bb2f35950e9c9.

Prior the commit we are reverting, checksum unnecessary was only set when
both the L3 OK and L4 OK bits are set on the CQE. This caused packets
of IP protocols such as SCTP which are not dealt by the current HW L4
parser (hence the L4 OK bit is not set, but the L4 header type none bit
is set) to go through the checksum none code, where currently we wrongly
report checksum unnecessary for them, a regression. Fix this by a revert.

Note that on our usual track we report checksum complete, so the revert
isn't expected to have any notable performance impact. Also, when we are
not on the checksum complete track, the L4 protocols for which we report
checksum none are not high performance ones, we will still report
checksum unnecessary for UDP/TCP.

Fixes: b820e6fb0978 ("net/mlx5e: Enable reporting checksum unnecessary also for L3 packets")
Signed-off-by: Or Gerlitz <ogerlitz@mellanox.com>
Reported-by: Avi Urman <aviu@mellanox.com>
Reviewed-by: Tariq Toukan <tariqt@mellanox.com>
Signed-off-by: Saeed Mahameed <saeedm@mellanox.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/mellanox/mlx5/core/en_rx.c |    3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

--- a/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c
@@ -848,8 +848,7 @@ static inline void mlx5e_handle_csum(str
 
 csum_unnecessary:
 	if (likely((cqe->hds_ip_ext & CQE_L3_OK) &&
-		   ((cqe->hds_ip_ext & CQE_L4_OK) ||
-		    (get_cqe_l4_hdr_type(cqe) == CQE_L4_HDR_TYPE_NONE)))) {
+		   (cqe->hds_ip_ext & CQE_L4_OK))) {
 		skb->ip_summed = CHECKSUM_UNNECESSARY;
 		if (cqe_is_tunneled(cqe)) {
 			skb->csum_level = 1;


