Return-Path: <SRS0=Dgga=T6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A828C46470
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 04:00:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EEADD24F57
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 04:00:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1559188821;
	bh=jP6U941xMJ/pMv0W8Qfpa6TpUNeBvAA7kHsdYd6KMp0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=JjXwaDcxzJRJWUE99BvB1/Sd4FFwDxJbWpFOmRi0WlbD+y0xefqxb9HBTGhPZAzo2
	 qMd9vQb1WdH55uqGM8z79Tl4E8nxyDNjqN/To2+/ihNo/zDljQFT22MjqNnXzWOKhQ
	 8qNDdS7mxk3S9FH/dyKR2vNIG6hSAdLEvwZPPBkg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727118AbfE3EAT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 May 2019 00:00:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:51202 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731542AbfE3DSZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 May 2019 23:18:25 -0400
Received: from localhost (ip67-88-213-2.z213-88-67.customer.algx.net [67.88.213.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 18958247B4;
        Thu, 30 May 2019 03:18:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559186305;
        bh=jP6U941xMJ/pMv0W8Qfpa6TpUNeBvAA7kHsdYd6KMp0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=EfASfxLfgsJQ6sktYX5S/1KqUTJ25GfACTOTcM8rXQmGyslJNx1ggCRBCKyR0n/uQ
         UC1wSLH/ikwCuTDGblrIz57im6b7UrSr3swRUIMzINGBTA9poYE/IfoHsa9r4urhvQ
         6Rb9ya4NA5oytJyiik6oTXcwtyeDjIqjlz8zalSY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Kangjie Lu <kjlu@umn.edu>,
        David Sterba <dsterba@suse.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 229/276] tty: ipwireless: fix missing checks for ioremap
Date:   Wed, 29 May 2019 20:06:27 -0700
Message-Id: <20190530030539.436725256@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190530030523.133519668@linuxfoundation.org>
References: <20190530030523.133519668@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Upstream commit 1bbb1c318cd8a3a39e8c3e2e83d5e90542d6c3e3 ]

ipw->attr_memory and ipw->common_memory are assigned with the
return value of ioremap. ioremap may fail, but no checks
are enforced. The fix inserts the checks to avoid potential
NULL pointer dereferences.

Signed-off-by: Kangjie Lu <kjlu@umn.edu>
Reviewed-by: David Sterba <dsterba@suse.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/tty/ipwireless/main.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/tty/ipwireless/main.c b/drivers/tty/ipwireless/main.c
index 3475e841ef5c1..4c18bbfe1a92e 100644
--- a/drivers/tty/ipwireless/main.c
+++ b/drivers/tty/ipwireless/main.c
@@ -114,6 +114,10 @@ static int ipwireless_probe(struct pcmcia_device *p_dev, void *priv_data)
 
 	ipw->common_memory = ioremap(p_dev->resource[2]->start,
 				resource_size(p_dev->resource[2]));
+	if (!ipw->common_memory) {
+		ret = -ENOMEM;
+		goto exit1;
+	}
 	if (!request_mem_region(p_dev->resource[2]->start,
 				resource_size(p_dev->resource[2]),
 				IPWIRELESS_PCCARD_NAME)) {
@@ -134,6 +138,10 @@ static int ipwireless_probe(struct pcmcia_device *p_dev, void *priv_data)
 
 	ipw->attr_memory = ioremap(p_dev->resource[3]->start,
 				resource_size(p_dev->resource[3]));
+	if (!ipw->attr_memory) {
+		ret = -ENOMEM;
+		goto exit3;
+	}
 	if (!request_mem_region(p_dev->resource[3]->start,
 				resource_size(p_dev->resource[3]),
 				IPWIRELESS_PCCARD_NAME)) {
-- 
2.20.1



