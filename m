Return-Path: <SRS0=NvuC=VQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08FA2C76188
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jul 2019 04:15:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C767A21851
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jul 2019 04:15:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1563509736;
	bh=oANLC7WHZmzBsxpSyh336LuozaVfENH9ahkjL4LXp90=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=B+4Mmr7NipRcw3atVJ3RwSTTrVZ9yrb4pu0hAs6r5vy092xmvaVge0dKPfRpz5t3y
	 hU06gKzIczL21/wqZwIKea71n952QrDDm7/XZVBhe6y1l/QOSRA1TR9FqrzjF6hTl6
	 AQJrELyQF9WsYCsvjfjHta720TzFp7bV4jQrsKWs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390139AbfGSEPf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jul 2019 00:15:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:51644 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390079AbfGSEPX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jul 2019 00:15:23 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A42042189E;
        Fri, 19 Jul 2019 04:15:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563509722;
        bh=oANLC7WHZmzBsxpSyh336LuozaVfENH9ahkjL4LXp90=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=NVlqxZuew0GzKdhBePEbF1xOEy+xMaWBYt29Jf0Oq/c39wmBJt655tLEAWkCnbILS
         UcD+eLyEYmptZwV7fZp3HThMcbIawmkCGUzuiomW2v+KnXqEEqmpkZDumo6i10b2QH
         OSNkvtoJB9ZRUjSSNzNJ8dUicgLeqjkr3aqJveW4=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     morten petersen <morten_bp@live.dk>,
        Jassi Brar <jaswinder.singh@linaro.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.4 29/35] mailbox: handle failed named mailbox channel request
Date:   Fri, 19 Jul 2019 00:14:17 -0400
Message-Id: <20190719041423.19322-29-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190719041423.19322-1-sashal@kernel.org>
References: <20190719041423.19322-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: morten petersen <morten_bp@live.dk>

[ Upstream commit 25777e5784a7b417967460d4fcf9660d05a0c320 ]

Previously, if mbox_request_channel_byname was used with a name
which did not exist in the "mbox-names" property of a mailbox
client, the mailbox corresponding to the last entry in the
"mbox-names" list would be incorrectly selected.
With this patch, -EINVAL is returned if the named mailbox is
not found.

Signed-off-by: Morten Borup Petersen <morten_bp@live.dk>
Signed-off-by: Jassi Brar <jaswinder.singh@linaro.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/mailbox/mailbox.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/mailbox/mailbox.c b/drivers/mailbox/mailbox.c
index 9cf826df89b1..b4ad85251cf7 100644
--- a/drivers/mailbox/mailbox.c
+++ b/drivers/mailbox/mailbox.c
@@ -389,11 +389,13 @@ struct mbox_chan *mbox_request_channel_byname(struct mbox_client *cl,
 
 	of_property_for_each_string(np, "mbox-names", prop, mbox_name) {
 		if (!strncmp(name, mbox_name, strlen(name)))
-			break;
+			return mbox_request_channel(cl, index);
 		index++;
 	}
 
-	return mbox_request_channel(cl, index);
+	dev_err(cl->dev, "%s() could not locate channel named \"%s\"\n",
+		__func__, name);
+	return ERR_PTR(-EINVAL);
 }
 EXPORT_SYMBOL_GPL(mbox_request_channel_byname);
 
-- 
2.20.1

