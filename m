Return-Path: <SRS0=K9bG=V2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EA6CC433FF
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 20:24:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 46ACA20679
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 20:24:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b="h3AQ9Evo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387862AbfG2UY1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jul 2019 16:24:27 -0400
Received: from gateway20.websitewelcome.com ([192.185.44.20]:11551 "EHLO
        gateway20.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2387512AbfG2UY0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jul 2019 16:24:26 -0400
X-Greylist: delayed 1364 seconds by postgrey-1.27 at vger.kernel.org; Mon, 29 Jul 2019 16:24:26 EDT
Received: from cm16.websitewelcome.com (cm16.websitewelcome.com [100.42.49.19])
        by gateway20.websitewelcome.com (Postfix) with ESMTP id DD19E400CCC8E
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jul 2019 13:58:12 -0500 (CDT)
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with SMTP
        id sBq1hg8Ty4FKpsBq1hpxG4; Mon, 29 Jul 2019 15:01:41 -0500
X-Authority-Reason: nr=8
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=embeddedor.com; s=default; h=Content-Transfer-Encoding:Content-Type:
        MIME-Version:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=8IG03zJ4dGQM2zbEUf5K8f+GqYdtT4wDuV0aUuJyIEc=; b=h3AQ9EvojkPpBuTQyEEMrXpXZq
        nSPz/PMP8BOP/Gkpovpf4ecOi0Bgk1Nj5vZeZuBCjFi7MHcr8mrCsTfHJtd6xdHjqwmCv/2Vtauqa
        OZ//RWt45ZLleJ711Q0j3wzO75rler0Spa/gO0E1YCVNVtiImHsDaFqUby2/WfTdQZl68xzDsE5Xu
        0T6Y4kiSO98nkftvORk+VbjLpfg0oEYNZZPMPpZHe7COxSx95ZGsKvvyEuFf536pc3khda2KjBwe9
        vV0xJFcJCOokYnV+JNKOahJIvEUkJ9RGdHY4zg0Dk9CNfxeah9RUVHS7yGdWmSNd/C33YeA7xswHQ
        aYERSh3Q==;
Received: from [187.192.11.120] (port=59520 helo=embeddedor)
        by gator4166.hostgator.com with esmtpa (Exim 4.92)
        (envelope-from <gustavo@embeddedor.com>)
        id 1hsBq0-000tYi-Gi; Mon, 29 Jul 2019 15:01:40 -0500
Date:   Mon, 29 Jul 2019 15:01:39 -0500
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
To:     "David S. Miller" <davem@davemloft.net>
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Kees Cook <keescook@chromium.org>
Subject: [PATCH] net: wan: sdla: Mark expected switch fall-through
Message-ID: <20190729200139.GA6102@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.9.4 (2018-02-28)
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 187.192.11.120
X-Source-L: No
X-Exim-ID: 1hsBq0-000tYi-Gi
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: (embeddedor) [187.192.11.120]:59520
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 3
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Mark switch cases where we are expecting to fall through.

This patch fixes the following warning (Building: i386):

drivers/net/wan/sdla.c: In function ‘sdla_errors’:
drivers/net/wan/sdla.c:414:7: warning: this statement may fall through [-Wimplicit-fallthrough=]
    if (cmd == SDLA_INFORMATION_WRITE)
       ^
drivers/net/wan/sdla.c:417:3: note: here
   default:
   ^~~~~~~

Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
---
 drivers/net/wan/sdla.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/wan/sdla.c b/drivers/net/wan/sdla.c
index a9ac3f37b904..e2e679a01b65 100644
--- a/drivers/net/wan/sdla.c
+++ b/drivers/net/wan/sdla.c
@@ -413,6 +413,7 @@ static void sdla_errors(struct net_device *dev, int cmd, int dlci, int ret, int
 		case SDLA_RET_NO_BUFS:
 			if (cmd == SDLA_INFORMATION_WRITE)
 				break;
+			/* Else, fall through */
 
 		default: 
 			netdev_dbg(dev, "Cmd 0x%02X generated return code 0x%02X\n",
-- 
2.22.0

