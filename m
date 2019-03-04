Return-Path: <SRS0=91bA=RH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFADDC43381
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 08:35:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7BF9F20823
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 08:35:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551688528;
	bh=kCO6HItyBmkTHB4+oG8JmH85Dar7lRPmsy2lQXqMpLc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=FwMYbgAOMdf5lRtmpeel636EJb5dFVIxf3seAlNR3Vso0lkgOwwSi1jKSgTK4rKNx
	 8jmdOwmeTuirff9K+tVg40dD7E8u06Eh+HDQFwFnXQXUVZlbqzta3E4D4ocK5HgAVT
	 Gp83Nc3kqjDSQ/l7Kbax2DIPDYbDrCXPON61BOgs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728449AbfCDIf1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Mar 2019 03:35:27 -0500
Received: from mail.kernel.org ([198.145.29.99]:43342 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727709AbfCDIfY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Mar 2019 03:35:24 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 33A2F20823;
        Mon,  4 Mar 2019 08:35:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551688523;
        bh=kCO6HItyBmkTHB4+oG8JmH85Dar7lRPmsy2lQXqMpLc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=1NUbSbSr38e+W9fdyh3HZuAN6XtXIkI2N9Sdwlpm2gLI28ZhO3QyMRM6S/nEiGPfO
         G1+d8yUbV9Tz1/5pCjfUsiBt0zZWb/uBfCHUuOOaZ8bZN0imN6F107GiFtHrRUb9uH
         OWT7ZQZH2xk4Aw0iXwD0RAfaSYXUQbTwXF83619M=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Ritesh Harjani <riteshh@codeaurora.org>,
        Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH 4.20 71/88] mmc: core: Fix NULL ptr crash from mmc_should_fail_request
Date:   Mon,  4 Mar 2019 09:22:54 +0100
Message-Id: <20190304081633.424873717@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190304081630.610632175@linuxfoundation.org>
References: <20190304081630.610632175@linuxfoundation.org>
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

4.20-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Ritesh Harjani <riteshh@codeaurora.org>

commit e5723f95d6b493dd437f1199cacb41459713b32f upstream.

In case of CQHCI, mrq->cmd may be NULL for data requests (non DCMD).
In such case mmc_should_fail_request is directly dereferencing
mrq->cmd while cmd is NULL.
Fix this by checking for mrq->cmd pointer.

Fixes: 72a5af554df8 ("mmc: core: Add support for handling CQE requests")
Signed-off-by: Ritesh Harjani <riteshh@codeaurora.org>
Cc: stable@vger.kernel.org
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/mmc/core/core.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/mmc/core/core.c
+++ b/drivers/mmc/core/core.c
@@ -95,7 +95,7 @@ static void mmc_should_fail_request(stru
 	if (!data)
 		return;
 
-	if (cmd->error || data->error ||
+	if ((cmd && cmd->error) || data->error ||
 	    !should_fail(&host->fail_mmc_request, data->blksz * data->blocks))
 		return;
 


