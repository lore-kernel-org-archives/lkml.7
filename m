Return-Path: <SRS0=FrXW=TP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D6EEC04E53
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 11:27:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2E54E20818
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 11:27:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1557919641;
	bh=8/Z5dCoaC5wW9RYrpO0xkNItYoYYuTELsM5iftxkzV4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=u/43yXrLK2Z43uU24/vOve7xMf5QQiqgj6MMUakwF5AquXOPq9ZMdqOTOkkaHA/6z
	 jJRwTY9bd6q5ZlsoMgEwSvGPLt6txStig+qCpEVoFL7YjqmCmA28/C8OP1/7j3tWPX
	 Jiyo+KWKxAr9lmVjPABfinvvWoZYeGNKvzi9IjKA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732208AbfEOL1U (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 May 2019 07:27:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:38148 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732190AbfEOL1Q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 May 2019 07:27:16 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9C4E620818;
        Wed, 15 May 2019 11:27:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1557919636;
        bh=8/Z5dCoaC5wW9RYrpO0xkNItYoYYuTELsM5iftxkzV4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Cg5Z4A1P6UsyIoE83fUnm/rvkk1BGILDnwQVjCl3LxKrwS+XFKGb+G+xXWKAYnhsA
         KSlg9/OMataJncp/az82BjVrGVBmljjObxw6+ao89I5P+XPGblSV6ZpwZNpYEg5EH7
         KQgfkAx2cWLc76hCsNrjfny+nDxBzyxi4FnsFxCE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Colin Ian King <colin.king@canonical.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.0 037/137] vxge: fix return of a freed memblock on a failed dma mapping
Date:   Wed, 15 May 2019 12:55:18 +0200
Message-Id: <20190515090656.063194505@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190515090651.633556783@linuxfoundation.org>
References: <20190515090651.633556783@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Upstream commit 0a2c34f18c94b596562bf3d019fceab998b8b584 ]

Currently if a pci dma mapping failure is detected a free'd
memblock address is returned rather than a NULL (that indicates
an error). Fix this by ensuring NULL is returned on this error case.

Addresses-Coverity: ("Use after free")
Fixes: 528f727279ae ("vxge: code cleanup and reorganization")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/neterion/vxge/vxge-config.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ethernet/neterion/vxge/vxge-config.c b/drivers/net/ethernet/neterion/vxge/vxge-config.c
index 7cde387e5ec62..51cd57ab3d958 100644
--- a/drivers/net/ethernet/neterion/vxge/vxge-config.c
+++ b/drivers/net/ethernet/neterion/vxge/vxge-config.c
@@ -2366,6 +2366,7 @@ static void *__vxge_hw_blockpool_malloc(struct __vxge_hw_device *devh, u32 size,
 				dma_object->addr))) {
 			vxge_os_dma_free(devh->pdev, memblock,
 				&dma_object->acc_handle);
+			memblock = NULL;
 			goto exit;
 		}
 
-- 
2.20.1



