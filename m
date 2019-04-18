Return-Path: <SRS0=NWWL=SU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 556E1C10F0E
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 18:12:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 21D73206B6
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 18:12:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555611149;
	bh=sfpjg2hSG6JaJNn1J3X2ihkVqkRPSQCekahtCyS4czQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=qLfRrlE381Kl/ElGQ6rXZ2JmK7zMPvmElwrwDXcF4N+LTNAXqYxf1QHDXPCCAJzuB
	 p+4+S/mIbWkkFWQ2a1yO30qdQRmWC+kWtF5DqZFJOu5sZWYe+FkSz86EF6qpx/W8qv
	 UmMeOBNxzNeGh5lQXLifCl5LWC3HJwrr/y+ILoSE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404278AbfDRSM2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Apr 2019 14:12:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:44928 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391742AbfDRSMY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Apr 2019 14:12:24 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7868520652;
        Thu, 18 Apr 2019 18:12:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1555611143;
        bh=sfpjg2hSG6JaJNn1J3X2ihkVqkRPSQCekahtCyS4czQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qMCt8oS+oVVm3WeXH5hkYFQtmDSpP9SlV+j8kwASnvtum0CenikfXZsKNWAWq7yD0
         dpt+pUkkZ8T8NukBkHBM3rBi4YnUg6DyEZQqsWFe0guX++rZ83aPkN4scyrEkJpaF9
         1ntf79urnyLPJ6htzmm4KEtcqYpUTlgcBMyFe11M=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Leo Yan <leo.yan@linaro.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.0 76/93] coresight: cpu-debug: Support for CA73 CPUs
Date:   Thu, 18 Apr 2019 19:57:54 +0200
Message-Id: <20190418160444.785825021@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190418160436.781762249@linuxfoundation.org>
References: <20190418160436.781762249@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Upstream commit a0f890aba2be33377f4eb24e13633c4a76a68f38 ]

This patch is to add the AMBA device ID for CA73 CPU, so that CPU debug
module can be initialized successfully when a SoC contain CA73 CPUs.

This patch has been verified on 96boards Hikey960.

Signed-off-by: Leo Yan <leo.yan@linaro.org>
Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/hwtracing/coresight/coresight-cpu-debug.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/hwtracing/coresight/coresight-cpu-debug.c b/drivers/hwtracing/coresight/coresight-cpu-debug.c
index 45b2460f3166..e8819d750938 100644
--- a/drivers/hwtracing/coresight/coresight-cpu-debug.c
+++ b/drivers/hwtracing/coresight/coresight-cpu-debug.c
@@ -668,6 +668,10 @@ static const struct amba_id debug_ids[] = {
 		.id	= 0x000bbd08,
 		.mask	= 0x000fffff,
 	},
+	{       /* Debug for Cortex-A73 */
+		.id	= 0x000bbd09,
+		.mask	= 0x000fffff,
+	},
 	{ 0, 0 },
 };
 
-- 
2.19.1



