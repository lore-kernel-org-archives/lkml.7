Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32A13C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 17:28:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 061F0206DF
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 17:28:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552411694;
	bh=Vpvpd3UfTT1ABzTxjCKoR8xR76cu82baE97d2A3GOf4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=A1lQPpr7mBegmbXJ7bGbUrq38+e0+sF5e2UiqjROHu7qWkJFFMOwQ1XsxF1ZvzXT4
	 Mo4ZyjXBuwDkd97qVSHlASJFarpZ8iMpbD3s8suEtNwHFmJpbjKw9Fqei0mMB5IHfH
	 Nhyv85DZbecRNtbxChvlisLj3Plp0U6BuEIIiI5g=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729651AbfCLR2N (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Mar 2019 13:28:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:33468 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729649AbfCLRRd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Mar 2019 13:17:33 -0400
Received: from localhost (unknown [104.133.8.98])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 754D9217F5;
        Tue, 12 Mar 2019 17:17:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552411052;
        bh=Vpvpd3UfTT1ABzTxjCKoR8xR76cu82baE97d2A3GOf4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qzbX9udVEr20iyd8tgHgSTzM8ZGPUkD30s5dNdpleF1ksulVUdmGvlmAEhh4CaLUl
         Wvvm6/HlhO+OBMRcWgDaWkuCOUCHCWvcpbqdc8w6P5yjha1DU8XDTpyMV17BfNQV2H
         J9WiFA3x4kJwPGeSaHpellmJpJWxHdQmOJfunANg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        "Michael J. Ruhl" <michael.j.ruhl@intel.com>,
        Brian Welty <brian.welty@intel.com>,
        Mike Marciniszyn <mike.marciniszyn@intel.com>,
        Dennis Dalessandro <dennis.dalessandro@intel.com>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.9 37/96] IB/{hfi1, qib}: Fix WC.byte_len calculation for UD_SEND_WITH_IMM
Date:   Tue, 12 Mar 2019 10:09:55 -0700
Message-Id: <20190312171037.301004820@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190312171034.530434962@linuxfoundation.org>
References: <20190312171034.530434962@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

[ Upstream commit 904bba211acc2112fdf866e5a2bc6cd9ecd0de1b ]

The work completion length for a receiving a UD send with immediate is
short by 4 bytes causing application using this opcode to fail.

The UD receive logic incorrectly subtracts 4 bytes for immediate
value. These bytes are already included in header length and are used to
calculate header/payload split, so the result is these 4 bytes are
subtracted twice, once when the header length subtracted from the overall
length and once again in the UD opcode specific path.

Remove the extra subtraction when handling the opcode.

Fixes: 7724105686e7 ("IB/hfi1: add driver files")
Reviewed-by: Michael J. Ruhl <michael.j.ruhl@intel.com>
Signed-off-by: Brian Welty <brian.welty@intel.com>
Signed-off-by: Mike Marciniszyn <mike.marciniszyn@intel.com>
Signed-off-by: Dennis Dalessandro <dennis.dalessandro@intel.com>
Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/infiniband/hw/hfi1/ud.c    | 1 -
 drivers/infiniband/hw/qib/qib_ud.c | 1 -
 2 files changed, 2 deletions(-)

diff --git a/drivers/infiniband/hw/hfi1/ud.c b/drivers/infiniband/hw/hfi1/ud.c
index 1a7ce1d740ce..292d7b6a0536 100644
--- a/drivers/infiniband/hw/hfi1/ud.c
+++ b/drivers/infiniband/hw/hfi1/ud.c
@@ -772,7 +772,6 @@ void hfi1_ud_rcv(struct hfi1_packet *packet)
 	    opcode == IB_OPCODE_UD_SEND_ONLY_WITH_IMMEDIATE) {
 		wc.ex.imm_data = ohdr->u.ud.imm_data;
 		wc.wc_flags = IB_WC_WITH_IMM;
-		tlen -= sizeof(u32);
 	} else if (opcode == IB_OPCODE_UD_SEND_ONLY) {
 		wc.ex.imm_data = 0;
 		wc.wc_flags = 0;
diff --git a/drivers/infiniband/hw/qib/qib_ud.c b/drivers/infiniband/hw/qib/qib_ud.c
index f45cad1198b0..93012fba287d 100644
--- a/drivers/infiniband/hw/qib/qib_ud.c
+++ b/drivers/infiniband/hw/qib/qib_ud.c
@@ -525,7 +525,6 @@ void qib_ud_rcv(struct qib_ibport *ibp, struct ib_header *hdr,
 	    opcode == IB_OPCODE_UD_SEND_ONLY_WITH_IMMEDIATE) {
 		wc.ex.imm_data = ohdr->u.ud.imm_data;
 		wc.wc_flags = IB_WC_WITH_IMM;
-		tlen -= sizeof(u32);
 	} else if (opcode == IB_OPCODE_UD_SEND_ONLY) {
 		wc.ex.imm_data = 0;
 		wc.wc_flags = 0;
-- 
2.19.1



