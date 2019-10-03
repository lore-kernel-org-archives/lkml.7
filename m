Return-Path: <SRS0=6dNS=X4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73150C32792
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 15:59:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 493F221783
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 15:59:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570118372;
	bh=nr9hoKbScMqg1mc7m9e/Fq+wOO542/kklUkiHIoAWZw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=tsSQtsWHocyoGKZPCQHrmN2qtmDuRMQndmQ8F5WRE6QjUz4FNQSGT/rjHS807A/rw
	 eZzRwJrPoFOP7cLE8aYEMEYd174oKJbF9B9HIritT9bvW21msaXHpCT1gArW88SWPY
	 LQbd79i65B/4sdxvvUy3o434a0lZci4Xh/iQziig=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731345AbfJCP7b (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Oct 2019 11:59:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:42418 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731178AbfJCP7Z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Oct 2019 11:59:25 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EA2AC20700;
        Thu,  3 Oct 2019 15:59:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570118364;
        bh=nr9hoKbScMqg1mc7m9e/Fq+wOO542/kklUkiHIoAWZw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=oB2PQjh1MRIVoUbutHyjFg45e3Y2PDDH1KvICXlzfPIf4W91p8NJZez3hoOuRhOfw
         cLpoyDxtvnx7UKDt8Y1mKil+0HCw80FF9+hUyi4nTcLqeZd01o6B+J8P0gLQKoqfh1
         KAeknCFYo2TYKcJzj2T2zMEOu+otoutGXhr6Ih6Y=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Vinod Koul <vkoul@kernel.org>,
        Vaishali Thakkar <vaishali.thakkar@linaro.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.4 46/99] base: soc: Export soc_device_register/unregister APIs
Date:   Thu,  3 Oct 2019 17:53:09 +0200
Message-Id: <20191003154317.231270222@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191003154252.297991283@linuxfoundation.org>
References: <20191003154252.297991283@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Vinod Koul <vkoul@kernel.org>

[ Upstream commit f7ccc7a397cf2ef64aebb2f726970b93203858d2 ]

Qcom Socinfo driver can be built as a module, so
export these two APIs.

Tested-by: Vinod Koul <vkoul@kernel.org>
Signed-off-by: Vinod Koul <vkoul@kernel.org>
Signed-off-by: Vaishali Thakkar <vaishali.thakkar@linaro.org>
Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Reviewed-by: Stephen Boyd <swboyd@chromium.org>
Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>
Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/base/soc.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/base/soc.c b/drivers/base/soc.c
index 75b98aad6fafd..84242e6b2897f 100644
--- a/drivers/base/soc.c
+++ b/drivers/base/soc.c
@@ -146,6 +146,7 @@ struct soc_device *soc_device_register(struct soc_device_attribute *soc_dev_attr
 out1:
 	return ERR_PTR(ret);
 }
+EXPORT_SYMBOL_GPL(soc_device_register);
 
 /* Ensure soc_dev->attr is freed prior to calling soc_device_unregister. */
 void soc_device_unregister(struct soc_device *soc_dev)
@@ -154,6 +155,7 @@ void soc_device_unregister(struct soc_device *soc_dev)
 
 	device_unregister(&soc_dev->dev);
 }
+EXPORT_SYMBOL_GPL(soc_device_unregister);
 
 static int __init soc_bus_register(void)
 {
-- 
2.20.1



