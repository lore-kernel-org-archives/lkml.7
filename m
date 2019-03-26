Return-Path: <SRS0=4nbc=R5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29FA0C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 06:37:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E40BE2075E
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 06:37:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553582255;
	bh=In6n76Grm55JBYWka4e2uS8Tmi32MIa6z3NTVB7jlzw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=pYzNnpvz4LA/X0b3jJRCAPwp+HtPGqyMvwgtU6nwAOLNzNJYvTSsxP1NU99dEmkuq
	 Ts/LThL7I99kpPH1os6uyb7iRufSewz2J9tIc5XVILk+/XUxV90bTUb1+soPFvXMhb
	 TQkKXWzmvYTIgeYXu5iVw/BmZIe7j1zpVxn1munc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732396AbfCZGhd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Mar 2019 02:37:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:50968 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732381AbfCZGha (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Mar 2019 02:37:30 -0400
Received: from localhost (unknown [104.132.152.111])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0FE8F2070B;
        Tue, 26 Mar 2019 06:37:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553582249;
        bh=In6n76Grm55JBYWka4e2uS8Tmi32MIa6z3NTVB7jlzw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qtUyf/Nk41YGuHujACqW877SMtaCFNpMStyWVfJhybfxYhxsuR6GA/FIBWhvyePRB
         djNDpG+mnZ6S6mvd8JneMRKRNeH+fze0rlza78bsPhfFWkuaMMZET2s+77Z4o7aXH1
         nPUeDDQGxkIVNx5jCi2PtHg9x7yQV8P3B7jzXwZo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Baolin Wang <baolin.wang@linaro.org>,
        Sebastian Reichel <sebastian.reichel@collabora.com>
Subject: [PATCH 4.19 45/45] power: supply: charger-manager: Fix incorrect return value
Date:   Tue, 26 Mar 2019 15:30:28 +0900
Message-Id: <20190326042705.047364226@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190326042702.565683325@linuxfoundation.org>
References: <20190326042702.565683325@linuxfoundation.org>
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

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Baolin Wang <baolin.wang@linaro.org>

commit f25a646fbe2051527ad9721853e892d13a99199e upstream.

Fix incorrect return value.

Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/power/supply/charger-manager.c |    3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

--- a/drivers/power/supply/charger-manager.c
+++ b/drivers/power/supply/charger-manager.c
@@ -1212,7 +1212,6 @@ static int charger_extcon_init(struct ch
 	if (ret < 0) {
 		pr_info("Cannot register extcon_dev for %s(cable: %s)\n",
 			cable->extcon_name, cable->name);
-		ret = -EINVAL;
 	}
 
 	return ret;
@@ -1633,7 +1632,7 @@ static int charger_manager_probe(struct
 
 	if (IS_ERR(desc)) {
 		dev_err(&pdev->dev, "No platform data (desc) found\n");
-		return -ENODEV;
+		return PTR_ERR(desc);
 	}
 
 	cm = devm_kzalloc(&pdev->dev, sizeof(*cm), GFP_KERNEL);


