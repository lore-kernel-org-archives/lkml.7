Return-Path: <SRS0=6aFo=TE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93A4FC43219
	for <linux-kernel@archiver.kernel.org>; Sat,  4 May 2019 10:30:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5A175206BB
	for <linux-kernel@archiver.kernel.org>; Sat,  4 May 2019 10:30:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556965806;
	bh=b5/REvLuj5EedkrELyJMPb1LKUssGcL2wMYSc8F2S2o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=pXIFdBUQ/XNAorjWjSlqru8CJ0JjbRyuZzouZWjoTL+65YRKuAPvtSv9qW0r/uJBN
	 4LjPYZ+j0JLjQk2qdv0T2GWKnxiTcUG8rDC8FJR1F4BtDFNnTDRNUWIVFNjw62p+as
	 aDzFc/wsiPkt0pMQwkZKSafiS1PKxhu6XZ9gvMP4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727950AbfEDKaF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 4 May 2019 06:30:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:35584 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726631AbfEDK0K (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 May 2019 06:26:10 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CF2C52084A;
        Sat,  4 May 2019 10:26:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556965569;
        bh=b5/REvLuj5EedkrELyJMPb1LKUssGcL2wMYSc8F2S2o=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=wJOs0T2Pn4SOjGz71OEAClVwSIC7TGDGq1ehrQpj0CJILkODKoL1LJ3ASZp19oQwt
         wGJ7VvLTiUdGJUe3YcN3ePCQEXBy3i+PvZa85+jRa6aaqjuLhGyoEycCZ+0pVHfA3Q
         rQ1SONqgYKCZUHyAkeGPrEXRXLAxiG55SCj9zje0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Vasundhara Volam <vasundhara-v.volam@broadcom.com>,
        Michael Chan <michael.chan@broadcom.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 5.0 21/32] bnxt_en: Free short FW command HWRM memory in error path in bnxt_init_one()
Date:   Sat,  4 May 2019 12:25:06 +0200
Message-Id: <20190504102453.156461845@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190504102452.523724210@linuxfoundation.org>
References: <20190504102452.523724210@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Vasundhara Volam <vasundhara-v.volam@broadcom.com>

[ Upstream commit f9099d611449836a51a65f40ea7dc9cb5f2f665e ]

In the bnxt_init_one() error path, short FW command request memory
is not freed. This patch fixes it.

Fixes: e605db801bde ("bnxt_en: Support for Short Firmware Message")
Signed-off-by: Vasundhara Volam <vasundhara-v.volam@broadcom.com>
Signed-off-by: Michael Chan <michael.chan@broadcom.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/broadcom/bnxt/bnxt.c |    1 +
 1 file changed, 1 insertion(+)

--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -10632,6 +10632,7 @@ init_err_cleanup_tc:
 	bnxt_clear_int_mode(bp);
 
 init_err_pci_clean:
+	bnxt_free_hwrm_short_cmd_req(bp);
 	bnxt_free_hwrm_resources(bp);
 	bnxt_free_ctx_mem(bp);
 	kfree(bp->ctx);


