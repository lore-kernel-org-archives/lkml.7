Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78F06C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 17:30:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4A47420830
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 17:30:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554139801;
	bh=LwJOb7426xEf+neu8tibrQSQsOBKe6VQgaTxb5CnbNw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=x8KQhDpQrc6WlOuhutwOJJ0W9Bg1rinfjYOPNI68eqvcr/+LjwZkzq4aomL1Siv2m
	 pxaJyFqN5WGPduChO0n3laWr3uqp/aWYahmWWBa9u336zfvA4nOh2T1T/NgJpRhOiD
	 694OXOIGEyAyxgNg4pkwRwTYDF19vcKd+6YihM8Y=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733027AbfDAR37 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 13:29:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:36606 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732092AbfDAR34 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 13:29:56 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 81B7A20830;
        Mon,  1 Apr 2019 17:29:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554139796;
        bh=LwJOb7426xEf+neu8tibrQSQsOBKe6VQgaTxb5CnbNw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=QoojQu878zGnwfnaPpAYGg+sFmr0upR3sSLB2O/cG+YGx1PpIlctWByJYO6BOfRhe
         iWR16eFsfJj58MDxl9uGNtESgHNtqykJmRaFZCQlNhH6mUt7E4hOwYklHw0buKmxJr
         qch2MTPIEfph5zNXhMv2Ga84KdQtwxSgsT1QErh4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH 4.4 017/131] mmc: make MAN_BKOPS_EN message a debug
Date:   Mon,  1 Apr 2019 19:01:27 +0200
Message-Id: <20190401170053.349785514@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190401170051.645954551@linuxfoundation.org>
References: <20190401170051.645954551@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Wolfram Sang <wsa+renesas@sang-engineering.com>

commit 4ec96b4cbde8d5714a4477b5a2562c3dd40bc5fa upstream.

IMO this info is only useful for developers. Most users won't need this
information, since there is not much they can do about it.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/mmc/core/mmc.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/mmc/core/mmc.c
+++ b/drivers/mmc/core/mmc.c
@@ -508,7 +508,7 @@ static int mmc_decode_ext_csd(struct mmc
 			card->ext_csd.raw_bkops_status =
 				ext_csd[EXT_CSD_BKOPS_STATUS];
 			if (!card->ext_csd.man_bkops_en)
-				pr_info("%s: MAN_BKOPS_EN bit is not set\n",
+				pr_debug("%s: MAN_BKOPS_EN bit is not set\n",
 					mmc_hostname(card->host));
 		}
 


