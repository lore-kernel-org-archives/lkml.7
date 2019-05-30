Return-Path: <SRS0=Dgga=T6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B366C072B1
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 03:41:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6FA7424C18
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 03:41:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1559187705;
	bh=v5+OdRiroJNePL+EMSWqYBpZD6+2xfylolszboFxqXU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=XL19kEskNBkQew7/NVSE5tCmD17SbJh1wtPCVTrw5Bun3KaB3vrZBQtd5PPXzOl4+
	 C+94a37Azzt+0rA/xERPoMIt+DDkS4ce7zY50vyiHjAWjBZippjDsHajog2xft3Fdu
	 CJVzvip8E/6nhy/pOhvE+gjon9LrLPPaPOzOuWrg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732688AbfE3Dlo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 May 2019 23:41:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:34090 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731590AbfE3DVS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 May 2019 23:21:18 -0400
Received: from localhost (ip67-88-213-2.z213-88-67.customer.algx.net [67.88.213.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 64215249F7;
        Thu, 30 May 2019 03:21:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559186478;
        bh=v5+OdRiroJNePL+EMSWqYBpZD6+2xfylolszboFxqXU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=MwSu3Z+l0b4xqFcpXVcFfwC+NQhPddz+V4bS3wzGx5p90wJQQK0bz1KNPx/7W3HgB
         HO44QVTPwqPGIwjfdoMyi7aXfERHlZ0wqqwNHp+zIVSMfcf3pnF9ZSCL3lhwVNF1D9
         m0Hdk14AUYyuE9Udh+FMbGv04+SlYa2dcVQoBVJ4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Kangjie Lu <kjlu@umn.edu>,
        David Sterba <dsterba@suse.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.9 112/128] tty: ipwireless: fix missing checks for ioremap
Date:   Wed, 29 May 2019 20:07:24 -0700
Message-Id: <20190530030454.762402652@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190530030432.977908967@linuxfoundation.org>
References: <20190530030432.977908967@linuxfoundation.org>
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
index 655c7948261c7..2fa4f91234693 100644
--- a/drivers/tty/ipwireless/main.c
+++ b/drivers/tty/ipwireless/main.c
@@ -113,6 +113,10 @@ static int ipwireless_probe(struct pcmcia_device *p_dev, void *priv_data)
 
 	ipw->common_memory = ioremap(p_dev->resource[2]->start,
 				resource_size(p_dev->resource[2]));
+	if (!ipw->common_memory) {
+		ret = -ENOMEM;
+		goto exit1;
+	}
 	if (!request_mem_region(p_dev->resource[2]->start,
 				resource_size(p_dev->resource[2]),
 				IPWIRELESS_PCCARD_NAME)) {
@@ -133,6 +137,10 @@ static int ipwireless_probe(struct pcmcia_device *p_dev, void *priv_data)
 
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



