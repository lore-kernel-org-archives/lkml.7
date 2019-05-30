Return-Path: <SRS0=Dgga=T6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 802AAC072B1
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 04:43:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5519625A84
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 04:43:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1559191392;
	bh=6ZasBnQkNWDrauYS3P0AR+Bx7T/GvEgr4cuwvTY9LWw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=hJIdtbrAa8BfY+a6ROwjU5a0rfKzS2mDJIWvTle6xdH9/TdENdhZyPMssvWDeNnEr
	 9CE9EQuK/ZJNePUrqzXIVCTR0cTn8DnLokU7xPbjJlwU/XbqxgjjgwPzAwqNOVSxXD
	 hFolu88xC8r8qz3YesK2VYN0uyNqL0Sq0uVxSmP0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388723AbfE3EnL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 May 2019 00:43:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:53754 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728876AbfE3DMN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 May 2019 23:12:13 -0400
Received: from localhost (ip67-88-213-2.z213-88-67.customer.algx.net [67.88.213.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 849A6244A0;
        Thu, 30 May 2019 03:12:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559185932;
        bh=6ZasBnQkNWDrauYS3P0AR+Bx7T/GvEgr4cuwvTY9LWw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=x0M1KdQ5xh1mChOa96AwYK4QiiNqUozf9HNku9MRSw5FwYfxybqZS5C2Wo4d4wvjo
         5OLkWTLSGf04i+0mljyozbaw8pXMs2eXcb/n8+GZK3JQvvRVE8Al1sJcfX+MHONDwL
         GYqti1iOY8wo8t/rV+YtNKeQ+MoC903JA1f5gBR0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Mark Brown <broonie@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.1 328/405] spi: export tracepoint symbols to modules
Date:   Wed, 29 May 2019 20:05:26 -0700
Message-Id: <20190530030557.335473736@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190530030540.291644921@linuxfoundation.org>
References: <20190530030540.291644921@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Upstream commit ca1438dcb34c7fcad63b6ce14ea63a870b92a69b ]

The newly added tracepoints in the spi-mxs driver cause a link
error when the driver is a loadable module:

ERROR: "__tracepoint_spi_transfer_stop" [drivers/spi/spi-mxs.ko] undefined!
ERROR: "__tracepoint_spi_transfer_start" [drivers/spi/spi-mxs.ko] undefined!

I'm not quite sure where to put the export statements, but
directly after the inclusion of the header seems as good as
any other place.

Fixes: f3fdea3af405 ("spi: mxs: add tracing to custom .transfer_one_message callback")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/spi/spi.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index e3f2e15b75ad4..6cb72287eac82 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -36,6 +36,8 @@
 
 #define CREATE_TRACE_POINTS
 #include <trace/events/spi.h>
+EXPORT_TRACEPOINT_SYMBOL(spi_transfer_start);
+EXPORT_TRACEPOINT_SYMBOL(spi_transfer_stop);
 
 #include "internals.h"
 
-- 
2.20.1



