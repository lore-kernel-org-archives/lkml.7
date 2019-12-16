Return-Path: <SRS0=TLrx=2G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34116C43603
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 17:51:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0B19520726
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 17:51:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576518689;
	bh=aq0A2mojfdId3Ozrdb6Opkd/Bkum79BJcrUlwhuY3k0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=gBTAOehutomPVkMamaPqPxAsTnpKAJlFoYhjHo8G3Uigra3HFpn4Tb19bOOE5Q0Xw
	 J/4Zf2weV1HNIlG1hejjptSNhBQSiB5e7wGhIz1irRbENinGGQi3xZretCRBfKQDPs
	 QTFyWzCxQhB/dXGI1hO1OOsMbeCdsEeUCeIf9+Ns=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726940AbfLPRv1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Dec 2019 12:51:27 -0500
Received: from mail.kernel.org ([198.145.29.99]:41332 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726890AbfLPRvX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Dec 2019 12:51:23 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 74B6C20717;
        Mon, 16 Dec 2019 17:51:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576518682;
        bh=aq0A2mojfdId3Ozrdb6Opkd/Bkum79BJcrUlwhuY3k0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=QcXfKqcp9sGd0XjJFCk0uV7h8I/4iWmKYb5wdG/2C81bTmI1nV6Ipd8tS15ffuWFc
         YkV7VNgPBShJMcLU48YVeQCMQIRHJiJhdUCf3i+H6ZzVLpDi2qIqPNMJPerLZUeq83
         M96jPlfxGagHlziwUSZiNjuDlO6PwESf8zpl2AZM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Chuhong Yuan <hslester96@gmail.com>
Subject: [PATCH 4.14 008/267] serial: ifx6x60: add missed pm_runtime_disable
Date:   Mon, 16 Dec 2019 18:45:34 +0100
Message-Id: <20191216174849.761772472@linuxfoundation.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20191216174848.701533383@linuxfoundation.org>
References: <20191216174848.701533383@linuxfoundation.org>
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
@@ -1245,6 +1245,9 @@ static int ifx_spi_spi_remove(struct spi
 	struct ifx_spi_device *ifx_dev = spi_get_drvdata(spi);
 	/* stop activity */
 	tasklet_kill(&ifx_dev->io_work_tasklet);
+
+	pm_runtime_disable(&spi->dev);
+
 	/* free irq */
 	free_irq(gpio_to_irq(ifx_dev->gpio.reset_out), ifx_dev);
 	free_irq(gpio_to_irq(ifx_dev->gpio.srdy), ifx_dev);


