Return-Path: <SRS0=oopU=Z2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	PDS_BTC_ID,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49E6AC43603
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 18:16:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1DFB1206DF
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 18:16:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1575483369;
	bh=UE13o5NrIZhLN81xQOZBSUABipSuNtXeuxUj/NUsRM8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=v+OS95JIClN0efpQnkAk7iHZ34G3iIQO+GZO6DJPuY8ijHLYUNtn2xORperT7EM8n
	 3Yjajw7wf+QGpfROAir5QsKHuy51K9KZzrofjfe4KHW0UQrS/XIq90giKB5/+xNcXl
	 sTHV37TCOG9vgt/tnvqquaGNy9H5lz/SZB22/3kI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731836AbfLDSQH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Dec 2019 13:16:07 -0500
Received: from mail.kernel.org ([198.145.29.99]:42668 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731762AbfLDSNa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Dec 2019 13:13:30 -0500
Received: from localhost (unknown [217.68.49.72])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 75A62206DF;
        Wed,  4 Dec 2019 18:13:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1575483210;
        bh=UE13o5NrIZhLN81xQOZBSUABipSuNtXeuxUj/NUsRM8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=NTunWYox9mo8cV6jG0zkpezGWv9PBUTlNtA2KNBvBREPvRJqOX6IlbiiAfVQOz3NK
         +XsfnDfQbIGcLbD4bATboNh0rnjSIa47uPWYKCJti6owzmQEO56RhjXjHlq/CINFp/
         PJsENwbjyxyI9SCQlqr3Z097THlukG7Ltn5ucfmo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.9 098/125] net: dev: Use unsigned integer as an argument to left-shift
Date:   Wed,  4 Dec 2019 18:56:43 +0100
Message-Id: <20191204175325.062669571@linuxfoundation.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191204175308.377746305@linuxfoundation.org>
References: <20191204175308.377746305@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

[ Upstream commit f4d7b3e23d259c44f1f1c39645450680fcd935d6 ]

1 << 31 is Undefined Behaviour according to the C standard.
Use U type modifier to avoid theoretical overflow.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/linux/netdevice.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index 2ecf0f32444e0..29ed5977ac041 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -3565,7 +3565,7 @@ static inline u32 netif_msg_init(int debug_value, int default_msg_enable_bits)
 	if (debug_value == 0)	/* no output */
 		return 0;
 	/* set low N bits */
-	return (1 << debug_value) - 1;
+	return (1U << debug_value) - 1;
 }
 
 static inline void __netif_tx_lock(struct netdev_queue *txq, int cpu)
-- 
2.20.1



