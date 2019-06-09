Return-Path: <SRS0=y5Xy=UI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C2C9C28EBD
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Jun 2019 17:03:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D0CFE204EC
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Jun 2019 17:03:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1560099808;
	bh=p0eGVAx9DEf+yAbE4wGVkaYf4pxiEFbzlWxBWGIOJm0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=och0th/v/+tieG3N5xD3y/YffhjoHjfLNJ/MUw1/iFH2JaP5EPWyq3XCVdicR6rsx
	 vJ/zpaV2tELwxwzfjmIFWoXGuNAVEIV/PZJwuIB3OekveSWldb1Z7v1fpl7c2d9riF
	 gNOkiv/+3USewxnT0TYL5mgK5wNEvtUFqZKeCduA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387651AbfFIRD2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Jun 2019 13:03:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:41740 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387792AbfFIRDX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Jun 2019 13:03:23 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1ADD7204EC;
        Sun,  9 Jun 2019 17:03:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560099802;
        bh=p0eGVAx9DEf+yAbE4wGVkaYf4pxiEFbzlWxBWGIOJm0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=0the2MwAiQ1HMszK+E2vSNyABB/Y3K0/K6RRJNtXQVoaMKr/SatP6QUIPPk0NB4qs
         limJejdiSa+kPEgt0DqN4AiCf+omiyXUNolXa+2vOP6fqbQsPIF8gwgcZI7hgr6WAV
         JQ5kZ3XtlhJYSHB7kGucpbTECwwoSa3jFgRevOe4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Tony Lindgren <tony@atomide.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.4 170/241] usb: core: Add PM runtime calls to usb_hcd_platform_shutdown
Date:   Sun,  9 Jun 2019 18:41:52 +0200
Message-Id: <20190609164152.691212874@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190609164147.729157653@linuxfoundation.org>
References: <20190609164147.729157653@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Upstream commit 8ead7e817224d7832fe51a19783cb8fcadc79467 ]

If ohci-platform is runtime suspended, we can currently get an "imprecise
external abort" on reboot with ohci-platform loaded when PM runtime
is implemented for the SoC.

Let's fix this by adding PM runtime support to usb_hcd_platform_shutdown.

Signed-off-by: Tony Lindgren <tony@atomide.com>
Acked-by: Alan Stern <stern@rowland.harvard.edu>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/usb/core/hcd.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/usb/core/hcd.c b/drivers/usb/core/hcd.c
index 9c4f9b6e57e29..99c146f4b6b51 100644
--- a/drivers/usb/core/hcd.c
+++ b/drivers/usb/core/hcd.c
@@ -3007,6 +3007,9 @@ usb_hcd_platform_shutdown(struct platform_device *dev)
 {
 	struct usb_hcd *hcd = platform_get_drvdata(dev);
 
+	/* No need for pm_runtime_put(), we're shutting down */
+	pm_runtime_get_sync(&dev->dev);
+
 	if (hcd->driver->shutdown)
 		hcd->driver->shutdown(hcd);
 }
-- 
2.20.1



