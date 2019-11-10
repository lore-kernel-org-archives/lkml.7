Return-Path: <SRS0=U1ji=ZC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 264A3C43331
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Nov 2019 03:11:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EB126215EA
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Nov 2019 03:11:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573355489;
	bh=gi0fFzVngAvPuitwbmsk2jTMbC43FgfYPfful1aETBg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ngoytKk/ItLfeurYN1vNFIaC6mRY7FfKwtXwY03SGdZ3EWs8bAIdTUV54pr1g2RUR
	 dyjA2p5uSp+zZFrx+Mh+D+rYXA9QOZwlacv9PcUlq22MqKnPRyZ8Rru5jQzAywql9G
	 7ibkQNAzGqOm1soBGLx3QWCoXrC/EJWekoNKIecs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728250AbfKJDL1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 9 Nov 2019 22:11:27 -0500
Received: from mail.kernel.org ([198.145.29.99]:42160 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728394AbfKJCnl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Nov 2019 21:43:41 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 387CE21D7B;
        Sun, 10 Nov 2019 02:43:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573353821;
        bh=gi0fFzVngAvPuitwbmsk2jTMbC43FgfYPfful1aETBg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=K/+RCy+AWeUi0Y0i4NILllAfXDqZLGbp3V/l5SHO2wMXgRU3RjE9mGC96ZY86/qhN
         sV/CtUKaR0cV/o+6yQuxgKxw5baHY1eHxRczjD06JNVRFLLTvTEAF+SeMn3BKHCDzz
         Ie3+MBhd4R+zfRHiJnFk1Y2cSyJGCAgPzVV1xHcM=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Leo Yan <leo.yan@linaro.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Mike Leach <mike.leach@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.19 116/191] coresight: tmc: Fix byte-address alignment for RRP
Date:   Sat,  9 Nov 2019 21:38:58 -0500
Message-Id: <20191110024013.29782-116-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191110024013.29782-1-sashal@kernel.org>
References: <20191110024013.29782-1-sashal@kernel.org>
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
index 0549249f4b398..e31061308e19e 100644
--- a/drivers/hwtracing/coresight/coresight-tmc-etf.c
+++ b/drivers/hwtracing/coresight/coresight-tmc-etf.c
@@ -438,10 +438,10 @@ static void tmc_update_etf_buffer(struct coresight_device *csdev,
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

