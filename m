Return-Path: <SRS0=U1ji=ZC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FDB6C17443
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Nov 2019 02:55:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0367E22573
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Nov 2019 02:55:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573354539;
	bh=C/p5ffkx9IEH3kI+wV1/WForkf/HV3MApMb1oJBFRpg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=VOCshYsjCmD0hcLBvqGWFefkCh7aMPkqVUufLD/SbpS2Niul2nzc8AgDnujuGxunJ
	 ViBQR9Os6ehMcEN38iaiW0l/xMQ/gWPlehpOjbWQZwv/kMTN2vxCfmrZxqmuiJf2f3
	 UqZ9dD0Gu8NerSRbiWcuQpbVDwAHKbj9SgnpMncY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729658AbfKJCuQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 9 Nov 2019 21:50:16 -0500
Received: from mail.kernel.org ([198.145.29.99]:60302 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729572AbfKJCtx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Nov 2019 21:49:53 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 81A7022581;
        Sun, 10 Nov 2019 02:49:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573354192;
        bh=C/p5ffkx9IEH3kI+wV1/WForkf/HV3MApMb1oJBFRpg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=hUsPTCdfTyb5wnmJvfw2byxvW3QaTqwurTrpUhcXEYz3cOvRhlDmATfdJ9vcTw6dm
         tMOkkM9bdvco+cJB68AF3F+gLdxpwZmFwgJx85jbQsqJEkgFXOtFZskfFOiW2QhiEF
         UE+5YtPCy9MBsjlYhCTkcOmzykMGTSWbz1Vzjbzg=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Leo Yan <leo.yan@linaro.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Mike Leach <mike.leach@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.9 40/66] coresight: tmc: Fix byte-address alignment for RRP
Date:   Sat,  9 Nov 2019 21:48:19 -0500
Message-Id: <20191110024846.32598-40-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191110024846.32598-1-sashal@kernel.org>
References: <20191110024846.32598-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Leo Yan <leo.yan@linaro.org>

[ Upstream commit e7753f3937610633a540f2be81be87531f96ff04 ]

>From the comment in the code, it claims the requirement for byte-address
alignment for RRP register: 'for 32-bit, 64-bit and 128-bit wide trace
memory, the four LSBs must be 0s. For 256-bit wide trace memory, the
five LSBs must be 0s'.  This isn't consistent with the program, the
program sets five LSBs as zeros for 32/64/128-bit wide trace memory and
set six LSBs zeros for 256-bit wide trace memory.

After checking with the CoreSight Trace Memory Controller technical
reference manual (ARM DDI 0461B, section 3.3.4 RAM Read Pointer
Register), it proves the comment is right and the program does wrong
setting.

This patch fixes byte-address alignment for RRP by following correct
definition in the technical reference manual.

Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
Cc: Mike Leach <mike.leach@linaro.org>
Signed-off-by: Leo Yan <leo.yan@linaro.org>
Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/hwtracing/coresight/coresight-tmc-etf.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-tmc-etf.c b/drivers/hwtracing/coresight/coresight-tmc-etf.c
index d6941ea24d8df..14df4e34c21cf 100644
--- a/drivers/hwtracing/coresight/coresight-tmc-etf.c
+++ b/drivers/hwtracing/coresight/coresight-tmc-etf.c
@@ -425,10 +425,10 @@ static void tmc_update_etf_buffer(struct coresight_device *csdev,
 		case TMC_MEM_INTF_WIDTH_32BITS:
 		case TMC_MEM_INTF_WIDTH_64BITS:
 		case TMC_MEM_INTF_WIDTH_128BITS:
-			mask = GENMASK(31, 5);
+			mask = GENMASK(31, 4);
 			break;
 		case TMC_MEM_INTF_WIDTH_256BITS:
-			mask = GENMASK(31, 6);
+			mask = GENMASK(31, 5);
 			break;
 		}
 
-- 
2.20.1

