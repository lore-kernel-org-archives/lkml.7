Return-Path: <SRS0=tMFY=W7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84888C3A5A8
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 17:56:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 56FD022CEA
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 17:56:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1567619819;
	bh=hXNgBmLhSvA+800WNKverQyu+RTuxcBFAaJch3/JGUM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=0alkxbE128MsdmHLrssBnTE9wPNf5xnvgTqcHN9OfIQi0HdbIMDKXJmG5wEn09hws
	 xFTVK9s7+SnqkC+UCRs40/Mki3v56GLKweJlqQindvJwsgCANA4IhUYWAt54+dWUjb
	 ItwOzjoaPMD7+XfYM7F+4multpRidXkTEbO9E1A4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387753AbfIDR46 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Sep 2019 13:56:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:34514 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387737AbfIDR44 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Sep 2019 13:56:56 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C61882339E;
        Wed,  4 Sep 2019 17:56:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1567619815;
        bh=hXNgBmLhSvA+800WNKverQyu+RTuxcBFAaJch3/JGUM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=w7oIcsRetKQwBYeejXNUn+WwPIl8Jh05PYQOVT/zg3KsSsvgeg9PD2VGLzN+mC4un
         e2U1fqEq9NP0P1pBRDpisH5e8YSxgkOhtRFw+kAHDPJ33YWQoKB05gep0OV6WmcSOs
         Mf6sASno7SB241lY9knLwwPCex2svcY3TBo0Phwo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.4 17/77] net: cxgb3_main: Fix a resource leak in a error path in init_one()
Date:   Wed,  4 Sep 2019 19:53:04 +0200
Message-Id: <20190904175305.233882308@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20190904175303.317468926@linuxfoundation.org>
References: <20190904175303.317468926@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Upstream commit debea2cd3193ac868289e8893c3a719c265b0612 ]

A call to 'kfree_skb()' is missing in the error handling path of
'init_one()'.
This is already present in 'remove_one()' but is missing here.

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/chelsio/cxgb3/cxgb3_main.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/chelsio/cxgb3/cxgb3_main.c b/drivers/net/ethernet/chelsio/cxgb3/cxgb3_main.c
index 3dd4c39640dc4..bee615cddbdd8 100644
--- a/drivers/net/ethernet/chelsio/cxgb3/cxgb3_main.c
+++ b/drivers/net/ethernet/chelsio/cxgb3/cxgb3_main.c
@@ -3260,7 +3260,7 @@ static int init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
 	if (!adapter->regs) {
 		dev_err(&pdev->dev, "cannot map device registers\n");
 		err = -ENOMEM;
-		goto out_free_adapter;
+		goto out_free_adapter_nofail;
 	}
 
 	adapter->pdev = pdev;
@@ -3378,6 +3378,9 @@ out_free_dev:
 		if (adapter->port[i])
 			free_netdev(adapter->port[i]);
 
+out_free_adapter_nofail:
+	kfree_skb(adapter->nofail_skb);
+
 out_free_adapter:
 	kfree(adapter);
 
-- 
2.20.1



