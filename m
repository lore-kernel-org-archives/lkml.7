Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D02E3C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 17:32:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A37C821473
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 17:32:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554139972;
	bh=uJ6gsK0LCcesog+H6nmztF8G++QYcT2aNfM7n/IFh+k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=s/42vz87TOWfOwf3HC6ZAFldnlBzkFJiSIbyAJGVsBT0nRq1GLLlTpCPs5b/dWT7w
	 pQPHy/puLXAYqw4A56qnv4sFGFl6tyotSnMS4DiQJ0EQZQC0lVnKdG4y3IXe/+OvTu
	 bznr+HKbEru3lyxhyJELZvOYBryqPqqeI/kFE0RM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732561AbfDARcv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 13:32:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:41208 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732841AbfDARct (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 13:32:49 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3B3AB20856;
        Mon,  1 Apr 2019 17:32:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554139968;
        bh=uJ6gsK0LCcesog+H6nmztF8G++QYcT2aNfM7n/IFh+k=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=A5EhnHy+9Ss8On627PYPfTxy/5523kjlfa677xmCSDGIC9xzbQf9dVO69bBVVw+i4
         vLCk2800dwR74SDiUfso0etYv+13nByjQsp5wi+FmVzmn4+LjM2RnJaAcmV/gzgWUZ
         nJKxkwsY8H+Ds+XmU7886iORxwRRXM0tZKUHUFyc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Eric Long <eric.long@linaro.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.4 067/131] coresight: etm4x: Check every parameter used by dma_xx_coherent.
Date:   Mon,  1 Apr 2019 19:02:17 +0200
Message-Id: <20190401170057.800988502@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190401170051.645954551@linuxfoundation.org>
References: <20190401170051.645954551@linuxfoundation.org>
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

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

[ Upstream commit 61390593f72377c3a8f41ef998462e2d3985adac ]

The dma_alloc_coherent return an "void *" not an "void __iomen *".
It uses the wrong parameters when calls dma_free_coherent function.

The sparse tool output logs as the following:
coresight-tmc.c:199:23:    expected void *<noident>
coresight-tmc.c:199:23:    got void [noderef] <asn:2>*vaddr
coresight-tmc.c:336:30: warning: incorrect type in assignment
(different address spaces)
coresight-tmc.c:336:30:    expected char *buf
coresight-tmc.c:336:30:    got void [noderef] <asn:2>*
coresight-tmc.c:769:50: warning: incorrect type in argument 4
(different base types)
coresight-tmc.c:769:50:    expected unsigned long long
[unsigned] [usertype] dma_handle
coresight-tmc.c:769:50:    got restricted gfp_t

Signed-off-by: Eric Long <eric.long@linaro.org>
Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/hwtracing/coresight/coresight-tmc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-tmc.c b/drivers/hwtracing/coresight/coresight-tmc.c
index a57c7ec1661f..62f9d7372e3a 100644
--- a/drivers/hwtracing/coresight/coresight-tmc.c
+++ b/drivers/hwtracing/coresight/coresight-tmc.c
@@ -124,7 +124,7 @@ struct tmc_drvdata {
 	bool			reading;
 	char			*buf;
 	dma_addr_t		paddr;
-	void __iomem		*vaddr;
+	void			*vaddr;
 	u32			size;
 	bool			enable;
 	enum tmc_config_type	config_type;
@@ -766,7 +766,7 @@ static int tmc_probe(struct amba_device *adev, const struct amba_id *id)
 err_devm_kzalloc:
 	if (drvdata->config_type == TMC_CONFIG_TYPE_ETR)
 		dma_free_coherent(dev, drvdata->size,
-				&drvdata->paddr, GFP_KERNEL);
+				drvdata->vaddr, drvdata->paddr);
 	return ret;
 }
 
-- 
2.19.1



