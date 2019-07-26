Return-Path: <SRS0=vtn1=VX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B00C5C7618B
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 13:42:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D30722CBF
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 13:42:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1564148561;
	bh=Qpjzsm+fRNhDRErGNwLJjXGpuo84iqjZYGVsf3hADoE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=bF43wShGWw1PeEaV3tzoAAENRzrydoqLMVWDHyivkw+DSbiYXBu825xehf8kJ4zGy
	 1tyAmqAUzWqQQkgPqG28x6uPDkoemo4ZkuGh+VaTv6IhzVjOePxIJg7TK38tPwWa6v
	 UuJrGgiAfrxXW4qghlZQoDQkpfIUze/A502Q1DkY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388001AbfGZNmk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jul 2019 09:42:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:49734 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387948AbfGZNm3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jul 2019 09:42:29 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2D3F322CC0;
        Fri, 26 Jul 2019 13:42:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564148548;
        bh=Qpjzsm+fRNhDRErGNwLJjXGpuo84iqjZYGVsf3hADoE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ujlfoQ79QNmwGC46Brvfun77LHxsOQWgImRJ/gfdZbYmsWEhbSfHI4enssynwzO/m
         SyE+RIQeLCy85yu5N5njYRDFLA3XirOv3AKCBozvZXygPLl9TuTMFbtv/Aad9BIyg8
         /aIdJd04x3ssFDtuxAzU7oXJPyXnIeXX4wKw2K/0=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Petr Cvek <petrcvekcz@gmail.com>,
        Paul Burton <paul.burton@mips.com>, hauke@hauke-m.de,
        john@phrozen.org, linux-mips@vger.kernel.org,
        openwrt-devel@lists.openwrt.org, pakahmar@hotmail.com,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.19 10/47] MIPS: lantiq: Fix bitfield masking
Date:   Fri, 26 Jul 2019 09:41:33 -0400
Message-Id: <20190726134210.12156-10-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190726134210.12156-1-sashal@kernel.org>
References: <20190726134210.12156-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Petr Cvek <petrcvekcz@gmail.com>

[ Upstream commit ba1bc0fcdeaf3bf583c1517bd2e3e29cf223c969 ]

The modification of EXIN register doesn't clean the bitfield before
the writing of a new value. After a few modifications the bitfield would
accumulate only '1's.

Signed-off-by: Petr Cvek <petrcvekcz@gmail.com>
Signed-off-by: Paul Burton <paul.burton@mips.com>
Cc: hauke@hauke-m.de
Cc: john@phrozen.org
Cc: linux-mips@vger.kernel.org
Cc: openwrt-devel@lists.openwrt.org
Cc: pakahmar@hotmail.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/mips/lantiq/irq.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/mips/lantiq/irq.c b/arch/mips/lantiq/irq.c
index c4ef1c31e0c4..37caeadb2964 100644
--- a/arch/mips/lantiq/irq.c
+++ b/arch/mips/lantiq/irq.c
@@ -156,8 +156,9 @@ static int ltq_eiu_settype(struct irq_data *d, unsigned int type)
 			if (edge)
 				irq_set_handler(d->hwirq, handle_edge_irq);
 
-			ltq_eiu_w32(ltq_eiu_r32(LTQ_EIU_EXIN_C) |
-				(val << (i * 4)), LTQ_EIU_EXIN_C);
+			ltq_eiu_w32((ltq_eiu_r32(LTQ_EIU_EXIN_C) &
+				    (~(7 << (i * 4)))) | (val << (i * 4)),
+				    LTQ_EIU_EXIN_C);
 		}
 	}
 
-- 
2.20.1

