Return-Path: <SRS0=6dNS=X4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 317F9C32792
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 16:13:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EE59D215EA
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 16:13:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570119198;
	bh=RzBBn1sBdiFhmbdzNBun+vapTG+24oKBd7pOWXsexII=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=O5WM1w4mkwH1LWx1Hg7Clx1zQ+E4dmCJApNkq/09hbMmF2+qGUs8L84rZK9RSFLHe
	 Pn+uMi7yal0zDGRnq+k3zqYHScYAvwQoLCiBFdKnA9DSTTIBMEZqkM/hM0b4GmnbGc
	 6eLw9vLSx4bmbVourAEooy/2SYJajGY3E1+dlQGw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388199AbfJCQNR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Oct 2019 12:13:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:35784 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388360AbfJCQNL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Oct 2019 12:13:11 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1EDE42054F;
        Thu,  3 Oct 2019 16:13:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570119190;
        bh=RzBBn1sBdiFhmbdzNBun+vapTG+24oKBd7pOWXsexII=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=UHLUYPlXHNWZxGv20/mz6AfBgYHOfFj8HNSrHsRy6rtRSZEE3kap6R7b1haqTnEyQ
         60w1/oVmXtwXLr6+HPnSwdhk4/SpiPWuMWYYL//884ojcdtP04y/UO4fd6urpRGiGc
         +ERX5BzJ9IasUPOom6M4pnBKEUMT9HCILyYwjv2Q=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Lihua Yao <ylhuajnu@outlook.com>,
        Krzysztof Kozlowski <krzk@kernel.org>
Subject: [PATCH 4.14 158/185] ARM: samsung: Fix system restart on S3C6410
Date:   Thu,  3 Oct 2019 17:53:56 +0200
Message-Id: <20191003154515.001351358@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191003154437.541662648@linuxfoundation.org>
References: <20191003154437.541662648@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lihua Yao <ylhuajnu@outlook.com>

commit 16986074035cc0205472882a00d404ed9d213313 upstream.

S3C6410 system restart is triggered by watchdog reset.

Cc: <stable@vger.kernel.org>
Fixes: 9f55342cc2de ("ARM: dts: s3c64xx: Fix infinite interrupt in soft mode")
Signed-off-by: Lihua Yao <ylhuajnu@outlook.com>
Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/arm/plat-samsung/watchdog-reset.c |    1 +
 1 file changed, 1 insertion(+)

--- a/arch/arm/plat-samsung/watchdog-reset.c
+++ b/arch/arm/plat-samsung/watchdog-reset.c
@@ -67,6 +67,7 @@ void samsung_wdt_reset(void)
 #ifdef CONFIG_OF
 static const struct of_device_id s3c2410_wdt_match[] = {
 	{ .compatible = "samsung,s3c2410-wdt" },
+	{ .compatible = "samsung,s3c6410-wdt" },
 	{},
 };
 


