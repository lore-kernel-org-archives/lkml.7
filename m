Return-Path: <SRS0=Yvat=2B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CBA1C43603
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 15:20:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2387B24658
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 15:20:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576077613;
	bh=xZjEc4Xr/AqWgZBND/PK/05kelS3CIMjzvTBe38DF6o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=KouQyxvIZoCgfTAWW7hoiTu9J6Q67kSjhk88idAQJzMZ+6jRCbpMLpOV/5REwaPsn
	 LhZN/PilBBR/O5ffiobEfoTSeUNgHltEzBjqfacTLzbiictDfM6WGcgndos4UzcpUD
	 mA9MJzTEiaJ1tddFfIA2YfeMh2djlopzFyXic1GA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732315AbfLKPUL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Dec 2019 10:20:11 -0500
Received: from mail.kernel.org ([198.145.29.99]:49092 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732297AbfLKPUE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Dec 2019 10:20:04 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7F8CB24654;
        Wed, 11 Dec 2019 15:20:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576077604;
        bh=xZjEc4Xr/AqWgZBND/PK/05kelS3CIMjzvTBe38DF6o=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=2XHqMuUnkGlDht0eUZRZ07sPNs6pAGEKHMmbCfpIZzYfuGfJ0y3ePqLh82JxrYQzZ
         h9zhbMdd92rq86t+5jeDnMjgEumE5i6djzFZliXrI7zEgvxkQpxZvFbyU9FO1cnlRO
         qvxvvUk2dy5Kf9yXdXsvMtchLVtmfRzrjj8MqaZE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Brian Norris <briannorris@chromium.org>,
        Felipe Balbi <felipe.balbi@linux.intel.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 100/243] usb: dwc3: dont log probe deferrals; but do log other error codes
Date:   Wed, 11 Dec 2019 16:04:22 +0100
Message-Id: <20191211150345.869230770@linuxfoundation.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20191211150339.185439726@linuxfoundation.org>
References: <20191211150339.185439726@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Brian Norris <briannorris@chromium.org>

[ Upstream commit 408d3ba006af57380fa48858b39f72fde6405031 ]

It's not very useful to repeat a bunch of probe deferral errors. And
it's also not very useful to log "failed" without telling the error
code.

Signed-off-by: Brian Norris <briannorris@chromium.org>
Signed-off-by: Felipe Balbi <felipe.balbi@linux.intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/usb/dwc3/core.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
index aca7e7fa5e47d..f52fcbc5c9718 100644
--- a/drivers/usb/dwc3/core.c
+++ b/drivers/usb/dwc3/core.c
@@ -1481,7 +1481,8 @@ static int dwc3_probe(struct platform_device *pdev)
 
 	ret = dwc3_core_init(dwc);
 	if (ret) {
-		dev_err(dev, "failed to initialize core\n");
+		if (ret != -EPROBE_DEFER)
+			dev_err(dev, "failed to initialize core: %d\n", ret);
 		goto err4;
 	}
 
-- 
2.20.1



