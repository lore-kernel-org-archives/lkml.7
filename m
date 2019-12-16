Return-Path: <SRS0=TLrx=2G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 167B5C43603
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 17:55:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E1B0B206B7
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 17:55:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576518939;
	bh=TxFF3dCzgNZSD/LydwsZgVZni2PRmnqkI8Is8MlGsmM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Puu2GHKtHBD1HIYFM5M4FTJ9RhzpFBN82vkmXuJNYUjxXSy5GsUexnAfsxC9Y/gio
	 HSUgJBRphkeWOvtIuR/3n9OUYyPuYO2FdIBYWwsO62ZweEqhdF5BDmsc4RJe2XG10w
	 zWlEH/Cop7Lr6+1/TV56qYqr/TfqOtHiBWwguYd0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727407AbfLPRzh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Dec 2019 12:55:37 -0500
Received: from mail.kernel.org ([198.145.29.99]:52880 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727864AbfLPRzf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Dec 2019 12:55:35 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8BCA2206B7;
        Mon, 16 Dec 2019 17:55:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576518935;
        bh=TxFF3dCzgNZSD/LydwsZgVZni2PRmnqkI8Is8MlGsmM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=c4JXiovsO11CaPoT1jTfKYejDclMWC83rFjCseVuQxOQygn5DSkKgJzCjzl/yIpPx
         FkVuHI+AeP38LwscVuzQKrsU6/08HmtWNNpBi7ipkvJqWoJAnGYLVt3BYFAuu2a4f4
         aSVgDWUDLsz+p8niULQZDE2GO6qCT8W8MNcqgLKA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Lucas Stach <l.stach@pengutronix.de>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [PATCH 4.14 127/267] Input: synaptics-rmi4 - re-enable IRQs in f34v7_do_reflash
Date:   Mon, 16 Dec 2019 18:47:33 +0100
Message-Id: <20191216174904.447628873@linuxfoundation.org>
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

From: Lucas Stach <l.stach@pengutronix.de>

commit 86bcd3a12999447faad60ec59c2d64d18d8e61ac upstream.

F34 is a bit special as it reinitializes the device and related driver
structs during the firmware update. This clears the fn_irq_mask which
will then prevent F34 from receiving further interrupts, leading to
timeouts during the firmware update. Make sure to reinitialize the
IRQ enables at the appropriate times.

The issue is in F34 code, but the commit in the fixes tag exposed the
issue, as before this commit things would work by accident.

Fixes: 363c53875aef (Input: synaptics-rmi4 - avoid processing unknown IRQs)
Signed-off-by: Lucas Stach <l.stach@pengutronix.de>
Link: https://lore.kernel.org/r/20191129133514.23224-1-l.stach@pengutronix.de
Cc: stable@vger.kernel.org
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/input/rmi4/rmi_f34v7.c |    3 +++
 1 file changed, 3 insertions(+)

--- a/drivers/input/rmi4/rmi_f34v7.c
+++ b/drivers/input/rmi4/rmi_f34v7.c
@@ -1192,6 +1192,9 @@ int rmi_f34v7_do_reflash(struct f34_data
 {
 	int ret;
 
+	f34->fn->rmi_dev->driver->set_irq_bits(f34->fn->rmi_dev,
+					       f34->fn->irq_mask);
+
 	rmi_f34v7_read_queries_bl_version(f34);
 
 	f34->v7.image = fw->data;


