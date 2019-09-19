Return-Path: <SRS0=X8En=XO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6377C49ED7
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Sep 2019 22:14:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6A67A218AF
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Sep 2019 22:14:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1568931250;
	bh=klpVdtEgbv3eGiHfTAl0evw55doOwNY6qnhkyJYVt7I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ZrvbUOPfDg3yNRN5ab2eGi9x7R5fcJQt3BpumJF7Yg2sWo1BMOYWhgGRViBLGRuVG
	 9tWWO0mTpOw5cWP/o7pZj6wwULbIW89fGzYGjSxrMI5h3z1651MuOAvX/+syxldhTZ
	 JAumTZTCEhy2ZKrGUY5RLpFRAYstPofuhWMhvIkQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392191AbfISWOJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Sep 2019 18:14:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:53508 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2392166AbfISWOH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Sep 2019 18:14:07 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4942721920;
        Thu, 19 Sep 2019 22:14:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1568931246;
        bh=klpVdtEgbv3eGiHfTAl0evw55doOwNY6qnhkyJYVt7I=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=F4wEXAxrtof/zxSBjkFsov6D4FTOEDD2jRNNdYNFb5gE5UPGezvN2juUL6CNeJbsZ
         1Uo9V6HBXO+2vWvXBlcMB3jfeoLAuCU1OFwL07CnUiKpBvhwSHxwzTeY5jMCdqzfnj
         PfUXLRE+vCvWpqGvy/4VoJyMbdYTKOVWrwFylC0o=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Takashi Iwai <tiwai@suse.de>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>, SteveM <swm@swm1.com>
Subject: [PATCH 4.19 57/79] sky2: Disable MSI on yet another ASUS boards (P6Xxxx)
Date:   Fri, 20 Sep 2019 00:03:42 +0200
Message-Id: <20190919214812.394644235@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20190919214807.612593061@linuxfoundation.org>
References: <20190919214807.612593061@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Takashi Iwai <tiwai@suse.de>

[ Upstream commit 189308d5823a089b56e2299cd96589507dac7319 ]

A similar workaround for the suspend/resume problem is needed for yet
another ASUS machines, P6X models.  Like the previous fix, the BIOS
doesn't provide the standard DMI_SYS_* entry, so again DMI_BOARD_*
entries are used instead.

Reported-and-tested-by: SteveM <swm@swm1.com>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/marvell/sky2.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/net/ethernet/marvell/sky2.c b/drivers/net/ethernet/marvell/sky2.c
index 4ade864c8d531..d013f30019b69 100644
--- a/drivers/net/ethernet/marvell/sky2.c
+++ b/drivers/net/ethernet/marvell/sky2.c
@@ -4954,6 +4954,13 @@ static const struct dmi_system_id msi_blacklist[] = {
 			DMI_MATCH(DMI_BOARD_NAME, "P6T"),
 		},
 	},
+	{
+		.ident = "ASUS P6X",
+		.matches = {
+			DMI_MATCH(DMI_BOARD_VENDOR, "ASUSTeK Computer INC."),
+			DMI_MATCH(DMI_BOARD_NAME, "P6X"),
+		},
+	},
 	{}
 };
 
-- 
2.20.1



