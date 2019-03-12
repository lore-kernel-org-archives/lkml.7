Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3921EC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 17:30:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 06B37206DF
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 17:30:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552411834;
	bh=S9FFNboo1CPnTlB0u0t3IuC7pji7zYwgt5316U25/ik=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=EJl1c/QxTsY7B8sGDh5GHjcBG167WrbdeVrrRWzdriGTPCryVwcHVxjAVI5sTyhqG
	 85Uo3pZZPIlVbXtC4kau+U0uYN+Uh3j6PU5H9yGGoCwYMKfYvdBKyVMScZz2EDkezm
	 qzDNcUGsNXf1S+YPhz6UgToSy6o4FDEJwfSTjcHw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729684AbfCLRac (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Mar 2019 13:30:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:60744 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729517AbfCLRRQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Mar 2019 13:17:16 -0400
Received: from localhost (unknown [104.133.8.98])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3244721874;
        Tue, 12 Mar 2019 17:17:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552411036;
        bh=S9FFNboo1CPnTlB0u0t3IuC7pji7zYwgt5316U25/ik=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Kw0H5+HprGVSrHaHMlutFvN813tp3WkdNm7tnxlS0/TlrK8UR4tquwbqMWmzDT90F
         TXrbWZtiOvYxfT5smkqLmeJrK7xIygn0m1QZ9t9pe2QPCgEcM9RemTJJD8ZY3Skf3v
         6QNQ5PkYyFiH5FgL5ArePFg1u2QoIDy1H5qMQrhI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Michael Chan <michael.chan@broadcom.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.9 14/96] bnxt_en: Drop oversize TX packets to prevent errors.
Date:   Tue, 12 Mar 2019 10:09:32 -0700
Message-Id: <20190312171035.626885470@linuxfoundation.org>
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

From: Michael Chan <michael.chan@broadcom.com>

[ Upstream commit 2b3c6885386020b1b9d92d45e8349637e27d1f66 ]

There have been reports of oversize UDP packets being sent to the
driver to be transmitted, causing error conditions.  The issue is
likely caused by the dst of the SKB switching between 'lo' with
64K MTU and the hardware device with a smaller MTU.  Patches are
being proposed by Mahesh Bandewar <maheshb@google.com> to fix the
issue.

In the meantime, add a quick length check in the driver to prevent
the error.  The driver uses the TX packet size as index to look up an
array to setup the TX BD.  The array is large enough to support all MTU
sizes supported by the driver.  The oversize TX packet causes the
driver to index beyond the array and put garbage values into the
TX BD.  Add a simple check to prevent this.

Signed-off-by: Michael Chan <michael.chan@broadcom.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/broadcom/bnxt/bnxt.c |    6 ++++++
 1 file changed, 6 insertions(+)

--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -428,6 +428,12 @@ normal_tx:
 	}
 
 	length >>= 9;
+	if (unlikely(length >= ARRAY_SIZE(bnxt_lhint_arr))) {
+		dev_warn_ratelimited(&pdev->dev, "Dropped oversize %d bytes TX packet.\n",
+				     skb->len);
+		i = 0;
+		goto tx_dma_error;
+	}
 	flags |= bnxt_lhint_arr[length];
 	txbd->tx_bd_len_flags_type = cpu_to_le32(flags);
 


