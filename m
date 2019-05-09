Return-Path: <SRS0=2Nly=TJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB22BC04AB1
	for <linux-kernel@archiver.kernel.org>; Thu,  9 May 2019 18:55:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A1DD220578
	for <linux-kernel@archiver.kernel.org>; Thu,  9 May 2019 18:55:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1557428107;
	bh=lioSarW61e1fg5cWblIDvNnD9WgAyJjR+Tnu0ISsUdQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=gz1JFDRj07XYqT7ngX4MgeJki/xqVz5xpUkUte/OW72elTpj0KxOGtJxEvUSa5diU
	 pQyK7efOQzhfGM8YANh2/54GuZ111T2vX0FKvMxzNpqRl9cepDrhDT1YYwq45plOE8
	 UQqoH7w3kcbmYWIKrcEuyvcZZnm6z11kV4ZmI2YU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728618AbfEISzG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 May 2019 14:55:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:50070 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728172AbfEISzD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 May 2019 14:55:03 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 20CB2204FD;
        Thu,  9 May 2019 18:55:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1557428102;
        bh=lioSarW61e1fg5cWblIDvNnD9WgAyJjR+Tnu0ISsUdQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=zUbtSXLidaizvTbVrfpzeG9cnGJ4DDW8zxixUJ70iLBqfm++b21wUG4L2F61qf/Vq
         8CaWitEUbXm2Vnt3zP0vjP2JrMpKCvGz3QHO2xoy0T66+PHtLLLZZFYNaNpDUlARFs
         UljAA+mciweOuQ7pMqYtILO2P/+RC14p15wFg/v0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
        Ajay Singh <ajay.kathat@microchip.com>,
        Adham Abozaeid <adham.abozaeid@microchip.com>
Subject: [PATCH 5.1 04/30] staging: wilc1000: Avoid GFP_KERNEL allocation from atomic context.
Date:   Thu,  9 May 2019 20:42:36 +0200
Message-Id: <20190509181251.512793363@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190509181250.417203112@linuxfoundation.org>
References: <20190509181250.417203112@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>

commit ae26aa844679cdf660e12c7055f958cb90889eb6 upstream.

Since wilc_set_multicast_list() is called with dev->addr_list_lock
spinlock held, we can't use GFP_KERNEL memory allocation.

Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Fixes: e624c58cf8eb ("staging: wilc1000: refactor code to avoid use of wilc_set_multicast_list global")
Cc: Ajay Singh <ajay.kathat@microchip.com>
Reviewed-by: Adham Abozaeid <adham.abozaeid@microchip.com>
Cc: stable <stable@vger.kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/staging/wilc1000/wilc_netdev.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/staging/wilc1000/wilc_netdev.c
+++ b/drivers/staging/wilc1000/wilc_netdev.c
@@ -708,7 +708,7 @@ static void wilc_set_multicast_list(stru
 		return;
 	}
 
-	mc_list = kmalloc_array(dev->mc.count, ETH_ALEN, GFP_KERNEL);
+	mc_list = kmalloc_array(dev->mc.count, ETH_ALEN, GFP_ATOMIC);
 	if (!mc_list)
 		return;
 


