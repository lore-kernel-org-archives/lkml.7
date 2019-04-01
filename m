Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93DB4C4360F
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 17:30:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5B9BF20856
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 17:30:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554139827;
	bh=BWjjC4zWRdvzKt76zuRuIpyET9A2mPjV75DpMQsUn3M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=2O06DV5YsyHVOB5btS/0xwGTNH+95mHtfj7HRe5Eoa8FuafkzyrnaBpnHWffOVzoe
	 wp4eKW16PQvDlFXba6cngq9ddWefb94e5t99TFYzNNUysQA/by0sK0TBXNVJe4FUGS
	 EtWFsGXfsVGSjxKCUeJjMT9IOBsdrMggeesBzQME=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733090AbfDARa0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 13:30:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:37338 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732727AbfDARaX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 13:30:23 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6C08C2070B;
        Mon,  1 Apr 2019 17:30:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554139822;
        bh=BWjjC4zWRdvzKt76zuRuIpyET9A2mPjV75DpMQsUn3M=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=IETYHxpz+NroYDxonG6jEX/AT9FN25EYXTudwU/28AsmbCsZmnmbr/PcuOXFZnmUd
         TZEjzacE5hnIDluqKj2Jwp6h1UHsebFnPne147XhIjT49Z4qOn3wCxitmMecb4a+Gb
         NiYSIUz7G9voaWufeXswT+2pZts/zEIdHt0k4gHM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Roger Quadros <rogerq@ti.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH 4.4 024/131] extcon: usb-gpio: Dont miss event during suspend/resume
Date:   Mon,  1 Apr 2019 19:01:34 +0200
Message-Id: <20190401170054.044149101@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190401170051.645954551@linuxfoundation.org>
References: <20190401170051.645954551@linuxfoundation.org>
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

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Roger Quadros <rogerq@ti.com>

commit 04c080080855ce84dcd490a2e04805608a21085d upstream.

Pin state might have changed during suspend/resume while
our interrupts were disabled and if device doesn't support wakeup.

Scan for change during resume for such case.

Signed-off-by: Roger Quadros <rogerq@ti.com>
Signed-off-by: Chanwoo Choi <cw00.choi@samsung.com>
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/extcon/extcon-usb-gpio.c |    3 +++
 1 file changed, 3 insertions(+)

--- a/drivers/extcon/extcon-usb-gpio.c
+++ b/drivers/extcon/extcon-usb-gpio.c
@@ -192,6 +192,9 @@ static int usb_extcon_resume(struct devi
 	}
 
 	enable_irq(info->id_irq);
+	if (!device_may_wakeup(dev))
+		queue_delayed_work(system_power_efficient_wq,
+				   &info->wq_detcable, 0);
 
 	return ret;
 }


