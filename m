Return-Path: <SRS0=4nbc=R5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C54DC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 06:44:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2EBB82070B
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 06:44:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553582689;
	bh=4aBRf0haxtOYMFj3AWjls1iGeACZVfWrSPIxwp+2wzQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=pXPgLmDYRzNUCXekFOM+cYdLt+9h1lpriW9vYjCZI0ZubO8J7euABDD0Y/bhNU9bt
	 2cXz1k7jUb8JRc59typ+BdBUueucDB7BqoobN5WVVa5HCbMZAMuRnUj0UP5sQqQfbU
	 B0Zi6qWPwwCcviFG9W8K2W4d4mTPXVjJnf73e4MI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732009AbfCZGfN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Mar 2019 02:35:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:46496 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731601AbfCZGfM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Mar 2019 02:35:12 -0400
Received: from localhost (unknown [104.132.152.111])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B8A2720870;
        Tue, 26 Mar 2019 06:35:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553582112;
        bh=4aBRf0haxtOYMFj3AWjls1iGeACZVfWrSPIxwp+2wzQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=hWx/1CbjttibIcOUuWhweDemMFZy3gqBn3+GAmnrVTpzFSn7teQLhWO1gv+Sy5+Fv
         0tOsbMTqe3NVZCPoiQGHX3Wp5FYDEmvsqA+Otiso4M/NUGGm26GS4STPN3+7K3RWVv
         j/bfOk7FEM28dY/4bKSwwMTo2lviJMQs2t9OMyMk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Baolin Wang <baolin.wang@linaro.org>,
        Sebastian Reichel <sebastian.reichel@collabora.com>
Subject: [PATCH 4.14 40/41] power: supply: charger-manager: Fix incorrect return value
Date:   Tue, 26 Mar 2019 15:30:17 +0900
Message-Id: <20190326042652.062095960@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190326042649.889479098@linuxfoundation.org>
References: <20190326042649.889479098@linuxfoundation.org>
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

4.14-stable review patch.  If anyone has any objections, please let me know.

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
@@ -1629,7 +1628,7 @@ static int charger_manager_probe(struct
 
 	if (IS_ERR(desc)) {
 		dev_err(&pdev->dev, "No platform data (desc) found\n");
-		return -ENODEV;
+		return PTR_ERR(desc);
 	}
 
 	cm = devm_kzalloc(&pdev->dev, sizeof(*cm), GFP_KERNEL);


