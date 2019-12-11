Return-Path: <SRS0=Yvat=2B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AB16C43603
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 15:19:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5D29E22B48
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 15:19:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576077589;
	bh=/LUzzBf+Yofy0eimmBq0G62TXMndjXspkVTWifPx2yg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=g44BoYWr7oUx084HMW46FOyTUybRIJDniAx97jPgI776S0BPFJKI6VqmYkPwx3NFE
	 STH9E2uWBvkTNzcr9rzDdjmEF3sl7BVXB/uJyoXUrMRaSKDJDA3f9HWLiMtIMBojWl
	 hb3Nb+ATpj0kAHiQHwM7ix+pINYFJHrxc0SF6XeU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732094AbfLKPTs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Dec 2019 10:19:48 -0500
Received: from mail.kernel.org ([198.145.29.99]:48672 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732263AbfLKPTq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Dec 2019 10:19:46 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 274DE2073D;
        Wed, 11 Dec 2019 15:19:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576077585;
        bh=/LUzzBf+Yofy0eimmBq0G62TXMndjXspkVTWifPx2yg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=tgXZdiUSgMfpCrFaiTPKITqQBPb8TaFjDmZ/pjJ0QEq9ng0DSzx0QSMo0H2OZaSOG
         gnOxIBsB5kHcmkRfjZ3MWOK6NzMuh27xYLZQEIY4z7KRKX8B2ShAqmrjDJ4quK2nnh
         d91pbOrZ+YrT0I2JzGvoLo74sHNVxDsN8VJkK36M=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Stephen Rothwell <sfr@canb.auug.org.au>,
        Vinod Koul <vkoul@kernel.org>
Subject: [PATCH 4.19 094/243] dmaengine: coh901318: Remove unused variable
Date:   Wed, 11 Dec 2019 16:04:16 +0100
Message-Id: <20191211150345.464670208@linuxfoundation.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20191211150339.185439726@linuxfoundation.org>
References: <20191211150339.185439726@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Vinod Koul <vkoul@kernel.org>

commit 35faaf0df42d285b40f8a6310afbe096720f7758 upstream.

Commit 627469e4445b ("dmaengine: coh901318: Fix a double-lock bug") left
flags variable unused, so remove it to fix the warning.

drivers/dma/coh901318.c: In function 'coh901318_config':
drivers/dma/coh901318.c:1805:16: warning: unused variable 'flags' [-Wunused-variable]
  unsigned long flags;
                ^~~~~

Fixes: 627469e4445b ("dmaengine: coh901318: Fix a double-lock bug")
Reported-By: Stephen Rothwell <sfr@canb.auug.org.au>
Signed-off-by: Vinod Koul <vkoul@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/dma/coh901318.c |    1 -
 1 file changed, 1 deletion(-)

--- a/drivers/dma/coh901318.c
+++ b/drivers/dma/coh901318.c
@@ -1797,7 +1797,6 @@ static struct dma_chan *coh901318_xlate(
 static int coh901318_config(struct coh901318_chan *cohc,
 			    struct coh901318_params *param)
 {
-	unsigned long flags;
 	const struct coh901318_params *p;
 	int channel = cohc->id;
 	void __iomem *virtbase = cohc->base->virtbase;


