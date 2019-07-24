Return-Path: <SRS0=3iFO=VV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D1DCC76186
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 20:20:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DB3F1206BF
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 20:20:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1563999605;
	bh=Ac4+0kdxBm/sPaXK+zxCsEvKI3E60ZZYmePwII+BD2k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ZxN8KIqTe8JypeeMHnnm5FkgDxxTW8sfZLIguqZZez5HPWEPytQlT9bBdKW2bh3FU
	 WQhwiCsiICnCaqN05fYEIxVfAmrj+Vxfyo3VV9yjDuTVaIyrkxyOCP57TwzJW5TwBJ
	 69uO/m2B0sM4MMFknbHcdZ1VulEGtURMcXn8lMmg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391837AbfGXUUE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jul 2019 16:20:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:53894 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391213AbfGXTrR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jul 2019 15:47:17 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 73946205C9;
        Wed, 24 Jul 2019 19:47:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563997636;
        bh=Ac4+0kdxBm/sPaXK+zxCsEvKI3E60ZZYmePwII+BD2k=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=EYx5GO4sbx4oiKUfNFsW7I1y63r+LgrBGSvk0jYMDPIg49LtBKqOsZseUUr03Ol17
         xqSt4AxyjIM3JUPK2nsyO9H1PFAWvKwQG9appfqXXCvv6lFyMMCEx2snEItElrQWGe
         9D3xGhDSGC7TTxg+4VrCkAca7eybMm52+htUzosw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Ariel Elior <ariel.elior@marvell.com>,
        Michal Kalderon <michal.kalderon@marvell.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.1 093/371] qed: iWARP - Fix tc for MPA ll2 connection
Date:   Wed, 24 Jul 2019 21:17:25 +0200
Message-Id: <20190724191731.827411154@linuxfoundation.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190724191724.382593077@linuxfoundation.org>
References: <20190724191724.382593077@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Upstream commit cb94d52b93c74fe1f2595734fabeda9f8ae891ee ]

The driver needs to assign a lossless traffic class for the MPA ll2
connection to ensure no packets are dropped when returning from the
driver as they will never be re-transmitted by the peer.

Fixes: ae3488ff37dc ("qed: Add ll2 connection for processing unaligned MPA packets")
Signed-off-by: Ariel Elior <ariel.elior@marvell.com>
Signed-off-by: Michal Kalderon <michal.kalderon@marvell.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/qlogic/qed/qed_iwarp.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/ethernet/qlogic/qed/qed_iwarp.c b/drivers/net/ethernet/qlogic/qed/qed_iwarp.c
index ded556b7bab5..eeea8683d99b 100644
--- a/drivers/net/ethernet/qlogic/qed/qed_iwarp.c
+++ b/drivers/net/ethernet/qlogic/qed/qed_iwarp.c
@@ -2708,6 +2708,8 @@ qed_iwarp_ll2_start(struct qed_hwfn *p_hwfn,
 	data.input.rx_num_desc = n_ooo_bufs * 2;
 	data.input.tx_num_desc = data.input.rx_num_desc;
 	data.input.tx_max_bds_per_packet = QED_IWARP_MAX_BDS_PER_FPDU;
+	data.input.tx_tc = PKT_LB_TC;
+	data.input.tx_dest = QED_LL2_TX_DEST_LB;
 	data.p_connection_handle = &iwarp_info->ll2_mpa_handle;
 	data.input.secondary_queue = true;
 	data.cbs = &cbs;
-- 
2.20.1



