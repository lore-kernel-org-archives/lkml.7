Return-Path: <SRS0=camR=ZD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 940FBC43331
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 18:44:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 572E420674
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 18:44:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573497850;
	bh=YUrDBmEZdgID93bbtuJb1eaRIraFqaGkPIKly41YPBU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=CdIfOD/qL3BzdwpnN/qXJZCCgmVxIffvywTEKbEuotOHq+ayaAJ7FRQmYflOCfb5H
	 R8rLvWQvoLUzeMxalXwNOPJ+QKiqowXX/8/y1Z1oFPMnkTXT6DeNzEVqO6qPBJDeVj
	 /c7Wv1Y61ZVbXFkiTvyE71B26bGDZMoMQk1rL21k=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729299AbfKKSoJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Nov 2019 13:44:09 -0500
Received: from mail.kernel.org ([198.145.29.99]:35668 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729286AbfKKSoG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Nov 2019 13:44:06 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E5A1320659;
        Mon, 11 Nov 2019 18:44:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573497845;
        bh=YUrDBmEZdgID93bbtuJb1eaRIraFqaGkPIKly41YPBU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jS5CXNYeDMqTPSOslGPfvDNLwM6QvO1dd96IUCclbOtuhC6MkiTqkR2ZTqK09IwlV
         JFG5ckKz0ckeJ6JTXQ3mewg53IFABpFEnyqEeAiCXfQZbrCUQSXXZfLmXoHaCfh1Ok
         q8lFU454orDu70DXp8LfWYNXhtYV8PNvmcBG2Ldk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Zhang Lixu <lixu.zhang@intel.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Jiri Kosina <jkosina@suse.cz>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 073/125] HID: intel-ish-hid: fix wrong error handling in ishtp_cl_alloc_tx_ring()
Date:   Mon, 11 Nov 2019 19:28:32 +0100
Message-Id: <20191111181449.856573265@linuxfoundation.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191111181438.945353076@linuxfoundation.org>
References: <20191111181438.945353076@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Zhang Lixu <lixu.zhang@intel.com>

[ Upstream commit 16ff7bf6dbcc6f77d2eec1ac9120edf44213c2f1 ]

When allocating tx ring buffers failed, should free tx buffers, not rx buffers.

Signed-off-by: Zhang Lixu <lixu.zhang@intel.com>
Acked-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Signed-off-by: Jiri Kosina <jkosina@suse.cz>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/hid/intel-ish-hid/ishtp/client-buffers.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hid/intel-ish-hid/ishtp/client-buffers.c b/drivers/hid/intel-ish-hid/ishtp/client-buffers.c
index b9b917d2d50db..c41dbb167c91b 100644
--- a/drivers/hid/intel-ish-hid/ishtp/client-buffers.c
+++ b/drivers/hid/intel-ish-hid/ishtp/client-buffers.c
@@ -90,7 +90,7 @@ int ishtp_cl_alloc_tx_ring(struct ishtp_cl *cl)
 	return	0;
 out:
 	dev_err(&cl->device->dev, "error in allocating Tx pool\n");
-	ishtp_cl_free_rx_ring(cl);
+	ishtp_cl_free_tx_ring(cl);
 	return	-ENOMEM;
 }
 
-- 
2.20.1



