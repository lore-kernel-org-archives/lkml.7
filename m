Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6FEBC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 11:47:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 77A6A21929
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 11:47:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553255223;
	bh=eSI5Y3rZxvIRd0WF/euWnnMY3i3QGkeWLsC7ep3KVgA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=nYwbvleFb6rsz8loxxdeNImazX7myQ+rJzb5nl7e/6wRlaoNrr1hmMqGjw7zwIapT
	 t4H6Hg3tipPodxErc0BDOqpx1BUJjJboZ9cEPyoCQydlt4e7KU9nTByuEw7wr9vuMf
	 ZKPDi92v0Lo6M5UljOeiNkSc+mytNCWHLLTZEZKg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732124AbfCVLrB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 07:47:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:50138 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728373AbfCVLq7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 07:46:59 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CEBAD2082C;
        Fri, 22 Mar 2019 11:46:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553255219;
        bh=eSI5Y3rZxvIRd0WF/euWnnMY3i3QGkeWLsC7ep3KVgA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=2CReIw0ZmuYPf9CuC7E++hBHIkqgRYciRrirQ7vRxwHp2a6XP4oRPTwCymeLQUUR+
         WQ23LLiFumP0ne3qp11cQB7T/SpfwY/SpaMbzjyNDiS/SMmbpjW2MU0uGReRSJAWVM
         twrFJsrkAXfPLcNbr8qvXYZ4QKM+ZKeH6MYVOgtY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Sven Van Asbroeck <thesven73@gmail.com>,
        Danilo Krummrich <danilokrummrich@dk-develop.de>,
        Sven Van Asbroeck <TheSven73@gmail.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 023/183] Input: ps2-gpio - flush TX work when closing port
Date:   Fri, 22 Mar 2019 12:14:11 +0100
Message-Id: <20190322111243.435755148@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190322111241.819468003@linuxfoundation.org>
References: <20190322111241.819468003@linuxfoundation.org>
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

[ Upstream commit 33a841ce5cef4ca6c18ad333248b6d273f54c839 ]

To ensure that TX work is not running after serio port has been torn down,
let's flush it when closing the port.

Reported-by: Sven Van Asbroeck <thesven73@gmail.com>
Acked-by: Danilo Krummrich <danilokrummrich@dk-develop.de>
Reviewed-by: Sven Van Asbroeck <TheSven73@gmail.com>
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/input/serio/ps2-gpio.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/input/serio/ps2-gpio.c b/drivers/input/serio/ps2-gpio.c
index b50e3817f3c4..4a64ab30589c 100644
--- a/drivers/input/serio/ps2-gpio.c
+++ b/drivers/input/serio/ps2-gpio.c
@@ -76,6 +76,7 @@ static void ps2_gpio_close(struct serio *serio)
 {
 	struct ps2_gpio_data *drvdata = serio->port_data;
 
+	flush_delayed_work(&drvdata->tx_work);
 	disable_irq(drvdata->irq);
 }
 
-- 
2.19.1



