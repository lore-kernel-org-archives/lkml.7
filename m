Return-Path: <SRS0=vtn1=VX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F1F5C7618B
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 13:49:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 483BC22CD8
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 13:49:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1564148973;
	bh=n+nlJtchozJZ8leL1o6vdx/6HO6aHBlkfFt66h3Juyc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=jN6oX6QUXL7BigQzSbwqVOuzRVX8QJ+ujQMxZY+FGiPcmLf4NZD41CRn0qnP2GOhu
	 HAc7uf9RxaWu4be0Urhd/7OI8L2DZC8TuzeVGfh6gNF/+RgD9hacR1u7hCrMyBnfVe
	 fJjmkyr2lPh1Yu1b7sYMXlGvcG3KVutwwtoM01B8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388486AbfGZNtb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jul 2019 09:49:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:53020 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387969AbfGZNol (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jul 2019 09:44:41 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1FAC722CD7;
        Fri, 26 Jul 2019 13:44:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564148681;
        bh=n+nlJtchozJZ8leL1o6vdx/6HO6aHBlkfFt66h3Juyc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=t92/xn6wps26nSH7IzudbOtFvbyjcJA/SPyOa77bphhJGMio9EXV81DPCX6j3xA1+
         Lmx7Ww73nJlkx7++5lM51m/wqSXNXb8Bpo6Gb8T74t1E7e+QV8jq15lTD7kGTSKIPA
         kTKYaB5yxmHRMeb0tEToez9BLYDRNcsxWRLYvPLo=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Petr Cvek <petrcvekcz@gmail.com>,
        Paul Burton <paul.burton@mips.com>, hauke@hauke-m.de,
        john@phrozen.org, linux-mips@vger.kernel.org,
        openwrt-devel@lists.openwrt.org, pakahmar@hotmail.com,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.9 07/30] MIPS: lantiq: Fix bitfield masking
Date:   Fri, 26 Jul 2019 09:44:09 -0400
Message-Id: <20190726134432.12993-7-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190726134432.12993-1-sashal@kernel.org>
References: <20190726134432.12993-1-sashal@kernel.org>
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
index 8ac0e5994ed2..7c6f75c2aa4d 100644
--- a/arch/mips/lantiq/irq.c
+++ b/arch/mips/lantiq/irq.c
@@ -160,8 +160,9 @@ static int ltq_eiu_settype(struct irq_data *d, unsigned int type)
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

