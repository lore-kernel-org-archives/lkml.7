Return-Path: <SRS0=vL1f=RL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4B18C43381
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 12:58:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8C53020449
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 12:58:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552049911;
	bh=I7XasZIfQBz6BwC7GEFckPwaHhtf4SpEK0J7JXHnIik=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=qsuC+n4jU9T1bQcbXA6A0f9Nw5+G6+UmnE/jDDr2khUJUh1CmWBrtwN2DSs+wSdqb
	 0lulHr9d2kUWSC3y0MiM50mFodWl8CPf37qNdae6IMF0hGLg9d2BDQc0w6QMdNxBsN
	 SM45qIsVcApMFJ0LLyzUVlSzDRoOaexvy8maqiE0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728032AbfCHM6a (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Mar 2019 07:58:30 -0500
Received: from mail.kernel.org ([198.145.29.99]:34858 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727644AbfCHM61 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Mar 2019 07:58:27 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 254B720449;
        Fri,  8 Mar 2019 12:58:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552049906;
        bh=I7XasZIfQBz6BwC7GEFckPwaHhtf4SpEK0J7JXHnIik=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=YjUsHc9d6GIqEKjddwYX/7UzDpY87dIoSCoQ69yOL+4OgN9cfU5JlNyTmZURb+/Ao
         Gu9W7gtZ98AY2L+9TVkCAg8v4bPwcLndubUvPm5Gty42VbIMaxvmqsyoD2MCJuHVQx
         2ezLdMjMWNXJ9zktPiNcU06gN4vuTl6SeBgpc2MU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Michael Chan <michael.chan@broadcom.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.19 23/68] bnxt_en: Drop oversize TX packets to prevent errors.
Date:   Fri,  8 Mar 2019 13:49:53 +0100
Message-Id: <20190308124911.960013215@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190308124910.696595153@linuxfoundation.org>
References: <20190308124910.696595153@linuxfoundation.org>
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
@@ -463,6 +463,12 @@ normal_tx:
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
 


