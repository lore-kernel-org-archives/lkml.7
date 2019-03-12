Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E405C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 17:14:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2E934206DF
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 17:14:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552410882;
	bh=HypgB1R5/K6v+RlmL4REoK+WmSjdPZEgea/NfpOebHg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=GxDqcipNqXNWbC9jTfSefwVw7ZVlMisKqAt5kbjxmsOcgJ4ukdnqlaXXlSG8dznSh
	 aC+ulvZ8sBXN2Qf3V/dMvkOgmas76jkyX7mVpSxfBHN+4psZlz3pGjBOkCJuoVkRCF
	 tXJtMTPf+/qxCJVQ/hAnC5PWv2aapDbU7qR+Jk9s=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728449AbfCLROk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Mar 2019 13:14:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:51438 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728104AbfCLRNu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Mar 2019 13:13:50 -0400
Received: from localhost (unknown [104.133.8.98])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6F5DA2171F;
        Tue, 12 Mar 2019 17:13:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552410829;
        bh=HypgB1R5/K6v+RlmL4REoK+WmSjdPZEgea/NfpOebHg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=vSgU55dy9TrQrvppfP0TU6KzSuaHD146RVvZF8ADo/7AK7s+9XZzoYY+iM4nZFWav
         j/DR9k9i2d9yEL9teA6MMbQTBIMVQRPDaJTGYSyuY1YGS0avUIeDXVR5LlvUdJ2n17
         Rrwsbz0DBKsnMyB8xp36eT/D2D0IDYbhp8udzlck=
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
Subject: [PATCH 4.19 007/149] IB/{hfi1, qib}: Fix WC.byte_len calculation for UD_SEND_WITH_IMM
Date:   Tue, 12 Mar 2019 10:07:05 -0700
Message-Id: <20190312170350.141047661@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190312170349.421581206@linuxfoundation.org>
References: <20190312170349.421581206@linuxfoundation.org>
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

4.19-stable review patch.  If anyone has any objections, please let me know.

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
index 70d39fc450a1..54eb69564264 100644
--- a/drivers/infiniband/hw/hfi1/ud.c
+++ b/drivers/infiniband/hw/hfi1/ud.c
@@ -980,7 +980,6 @@ void hfi1_ud_rcv(struct hfi1_packet *packet)
 	    opcode == IB_OPCODE_UD_SEND_ONLY_WITH_IMMEDIATE) {
 		wc.ex.imm_data = packet->ohdr->u.ud.imm_data;
 		wc.wc_flags = IB_WC_WITH_IMM;
-		tlen -= sizeof(u32);
 	} else if (opcode == IB_OPCODE_UD_SEND_ONLY) {
 		wc.ex.imm_data = 0;
 		wc.wc_flags = 0;
diff --git a/drivers/infiniband/hw/qib/qib_ud.c b/drivers/infiniband/hw/qib/qib_ud.c
index f8d029a2390f..bce2b5cd3c7b 100644
--- a/drivers/infiniband/hw/qib/qib_ud.c
+++ b/drivers/infiniband/hw/qib/qib_ud.c
@@ -513,7 +513,6 @@ void qib_ud_rcv(struct qib_ibport *ibp, struct ib_header *hdr,
 	    opcode == IB_OPCODE_UD_SEND_ONLY_WITH_IMMEDIATE) {
 		wc.ex.imm_data = ohdr->u.ud.imm_data;
 		wc.wc_flags = IB_WC_WITH_IMM;
-		tlen -= sizeof(u32);
 	} else if (opcode == IB_OPCODE_UD_SEND_ONLY) {
 		wc.ex.imm_data = 0;
 		wc.wc_flags = 0;
-- 
2.19.1



