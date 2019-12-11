Return-Path: <SRS0=Yvat=2B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C340C43603
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 15:07:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 46721208C3
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 15:07:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576076863;
	bh=LKxzpUfyF+oYSQX+FKuJTBK46/nO+5dzYVqWq0NnofU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=T2ff56JqPT3XBlLc/i9wCrljyvsnq5RLdKJJ7topNMjGmqcBIZPDSGlQOdE4EyfuZ
	 1sO+KSKmm9jrAlVGYD6feq1FHQmOLxtI2AU0oUkoMS6yDzTTSwTOgexjQuJ+NGEd/D
	 trKBw9TWEdKHKNA2SGFdu0pJURy4ZD/mi+VlXpl0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730078AbfLKPHl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Dec 2019 10:07:41 -0500
Received: from mail.kernel.org ([198.145.29.99]:54816 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730010AbfLKPHj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Dec 2019 10:07:39 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8DF4B20663;
        Wed, 11 Dec 2019 15:07:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576076858;
        bh=LKxzpUfyF+oYSQX+FKuJTBK46/nO+5dzYVqWq0NnofU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=XbP8AwfAjPxu/DGbMEvlz+0xgga6ge+hui840zxyHN2pcjA6BQ/rVIE0whCRUmpkZ
         xcrV1gJ5pIFjaFqP32U0J1nZiRZCwVkl8fogWblXo0LdP6LI1rQdywNxJsAsEGCrlo
         3QeMwCymzKkWzk8nNWa45oHvyIvomQ/n4++U6Dw8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Chuhong Yuan <hslester96@gmail.com>
Subject: [PATCH 5.4 18/92] serial: ifx6x60: add missed pm_runtime_disable
Date:   Wed, 11 Dec 2019 16:05:09 +0100
Message-Id: <20191211150226.990625436@linuxfoundation.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20191211150221.977775294@linuxfoundation.org>
References: <20191211150221.977775294@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Chuhong Yuan <hslester96@gmail.com>

commit 50b2b571c5f3df721fc81bf9a12c521dfbe019ba upstream.

The driver forgets to call pm_runtime_disable in remove.
Add the missed calls to fix it.

Signed-off-by: Chuhong Yuan <hslester96@gmail.com>
Cc: stable <stable@vger.kernel.org>
Link: https://lore.kernel.org/r/20191118024833.21587-1-hslester96@gmail.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/tty/serial/ifx6x60.c |    3 +++
 1 file changed, 3 insertions(+)

--- a/drivers/tty/serial/ifx6x60.c
+++ b/drivers/tty/serial/ifx6x60.c
@@ -1230,6 +1230,9 @@ static int ifx_spi_spi_remove(struct spi
 	struct ifx_spi_device *ifx_dev = spi_get_drvdata(spi);
 	/* stop activity */
 	tasklet_kill(&ifx_dev->io_work_tasklet);
+
+	pm_runtime_disable(&spi->dev);
+
 	/* free irq */
 	free_irq(gpio_to_irq(ifx_dev->gpio.reset_out), ifx_dev);
 	free_irq(gpio_to_irq(ifx_dev->gpio.srdy), ifx_dev);


