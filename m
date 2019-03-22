Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27F7FC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 12:46:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ED3CD218E2
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 12:46:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553258800;
	bh=0W5Q8NhRdxpqmyEWfw5BzSNkOEfm8fizWfo/POFGvCY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=wKTto/CH/y+y/Q3jGu53wsLP3tWaLgIuvUk6hh/2vR4usm6RJKBHAZxTfaTOITXFz
	 RmOLkF8O4LKU7ijX5PYukPicY490LdD6tkfhojq8BExu6kPi50RhpcdOyxQmBN+cHe
	 Mo3VoloN1ZGc3B6nDJu8xXrQb3f/iEU2B/axVknk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388336AbfCVMqi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 08:46:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:36172 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387934AbfCVL7L (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 07:59:11 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 75ECE20830;
        Fri, 22 Mar 2019 11:59:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553255951;
        bh=0W5Q8NhRdxpqmyEWfw5BzSNkOEfm8fizWfo/POFGvCY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=uTW7RtVoPn/gyiG+edIXU8cYanV9OtsSUaLbuD3ogr+u+4I9W+iXsvtocGKN7U/vC
         Nd41XgTvcUs8kxtGvmOsJQ8RgXS33OWlyLfFK4ZeHBWcssdIw5WsRghAnjAWE+l5du
         wGvdwmuEQAqvrHHqvgOwqA2eZQUQw+Cwm0/XuCik=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Sven Van Asbroeck <thesven73@gmail.com>,
        Danilo Krummrich <danilokrummrich@dk-develop.de>,
        Sven Van Asbroeck <TheSven73@gmail.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 046/280] Input: ps2-gpio - flush TX work when closing port
Date:   Fri, 22 Mar 2019 12:13:19 +0100
Message-Id: <20190322111308.898999766@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190322111306.356185024@linuxfoundation.org>
References: <20190322111306.356185024@linuxfoundation.org>
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
index c62cceb97bb1..5e8d8384aa2a 100644
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



