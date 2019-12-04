Return-Path: <SRS0=oopU=Z2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0ABB2C43603
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 18:26:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CA27520661
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 18:25:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1575483959;
	bh=QbBuGS/coJEwh6RluN11VrD758/GAztJk087GoksdZc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=HY0tM9M9uUZHf7IrGG/EDpfAzHKpkJ21syEWNInwAh2w7nah08ni1eTPMXziPM8bG
	 f+lqevjtU7Pcyit2s8ahVWMkbHoNHFd3qAOZUdobBuTanzmftDQmo2Pkw5ki6XuT2b
	 zPc4dAl20kkxx7tnnsQVP1eHXDa5j2XNF4zt6JgA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729305AbfLDSAR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Dec 2019 13:00:17 -0500
Received: from mail.kernel.org ([198.145.29.99]:38406 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728236AbfLDSAO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Dec 2019 13:00:14 -0500
Received: from localhost (unknown [217.68.49.72])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 896432081B;
        Wed,  4 Dec 2019 18:00:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1575482414;
        bh=QbBuGS/coJEwh6RluN11VrD758/GAztJk087GoksdZc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qSTbBVdWEDwo5vHPMuLsfKv6HGxCButCwjVETvSVLs6fuWn+jcIDaMSvty96opA5C
         rOF1hZaxclClpZc/DdgGCCt9hkl0GnCtsTGjcL8MmdPE9/ugAdzDuLMxufzB5notPk
         w4Yqs+r76GFYH0s8JaxGKTodlbQEg+4b2RdoiFRk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Pan Bian <bianpan2016@163.com>,
        Dan Carpenter <dan.carpenter@oracle.com>
Subject: [PATCH 4.4 77/92] staging: rtl8192e: fix potential use after free
Date:   Wed,  4 Dec 2019 18:50:17 +0100
Message-Id: <20191204174334.879073522@linuxfoundation.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191204174327.215426506@linuxfoundation.org>
References: <20191204174327.215426506@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Pan Bian <bianpan2016@163.com>

commit b7aa39a2ed0112d07fc277ebd24a08a7b2368ab9 upstream.

The variable skb is released via kfree_skb() when the return value of
_rtl92e_tx is not zero. However, after that, skb is accessed again to
read its length, which may result in a use after free bug. This patch
fixes the bug by moving the release operation to where skb is never
used later.

Signed-off-by: Pan Bian <bianpan2016@163.com>
Reviewed-by: Dan Carpenter <dan.carpenter@oracle.com>
Cc: stable <stable@vger.kernel.org>
Link: https://lore.kernel.org/r/1572965351-6745-1-git-send-email-bianpan2016@163.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/staging/rtl8192e/rtl8192e/rtl_core.c |    5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

--- a/drivers/staging/rtl8192e/rtl8192e/rtl_core.c
+++ b/drivers/staging/rtl8192e/rtl8192e/rtl_core.c
@@ -1631,14 +1631,15 @@ static void _rtl92e_hard_data_xmit(struc
 	memcpy((unsigned char *)(skb->cb), &dev, sizeof(dev));
 	skb_push(skb, priv->rtllib->tx_headroom);
 	ret = _rtl92e_tx(dev, skb);
-	if (ret != 0)
-		kfree_skb(skb);
 
 	if (queue_index != MGNT_QUEUE) {
 		priv->rtllib->stats.tx_bytes += (skb->len -
 						 priv->rtllib->tx_headroom);
 		priv->rtllib->stats.tx_packets++;
 	}
+
+	if (ret != 0)
+		kfree_skb(skb);
 }
 
 static int _rtl92e_hard_start_xmit(struct sk_buff *skb, struct net_device *dev)


