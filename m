Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1087EC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 12:29:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D3B1D2070D
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 12:29:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553257763;
	bh=9aeln6Ool/Ll6KWF7ShclDeaLBUuQmPB7EEuAjJlmuo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=gdJvWT/OCte0u0w4k/lnnMNd46VUCMITS4pM/qc+4WsRCeo9lBlHJvtykHe0EBu7z
	 YtwgzFdzwiKg4/2wJibYzt5BO8MNahIX0gok2LvnA/mvquaCVO7ABEduvpURSSJ0DR
	 VIOa4h4sVj88QsALh0RmYsfs6RO8vJjAV8TpJ0+k=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390227AbfCVMTU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 08:19:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:58152 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390402AbfCVMTK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 08:19:10 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 69A322054F;
        Fri, 22 Mar 2019 12:19:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553257149;
        bh=9aeln6Ool/Ll6KWF7ShclDeaLBUuQmPB7EEuAjJlmuo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=o5fUwSTbuzXtYaWzn/tZMOeaaCo5vrceCobMIfMyHO/VrckJZ/bibeQavhEKGetcj
         1UdUb1ELbmfc+E5kNZmmiiCZnlx4tV1iVN6icqKs64ULfg/pXa2sj/zVpHcyFw4vqU
         6haR0XXu+MPkjMdh6lI1P2+bw8dTvc4PC/fV9OLM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Phuong Nguyen <phuong.nguyen.xw@renesas.com>,
        Hiroyuki Yokoyama <hiroyuki.yokoyama.vx@renesas.com>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Vinod Koul <vkoul@kernel.org>
Subject: [PATCH 5.0 147/238] dmaengine: usb-dmac: Make DMAC system sleep callbacks explicit
Date:   Fri, 22 Mar 2019 12:16:06 +0100
Message-Id: <20190322111307.041335199@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190322111258.383569278@linuxfoundation.org>
References: <20190322111258.383569278@linuxfoundation.org>
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

5.0-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Phuong Nguyen <phuong.nguyen.xw@renesas.com>

commit d9140a0da4a230a03426d175145989667758aa6a upstream.

This commit fixes the issue that USB-DMAC hangs silently after system
resumes on R-Car Gen3 hence renesas_usbhs will not work correctly
when using USB-DMAC for bulk transfer e.g. ethernet or serial
gadgets.

The issue can be reproduced by these steps:
 1. modprobe g_serial
 2. Suspend and resume system.
 3. connect a usb cable to host side
 4. Transfer data from Host to Target
 5. cat /dev/ttyGS0 (Target side)
 6. echo "test" > /dev/ttyACM0 (Host side)

The 'cat' will not result anything. However, system still can work
normally.

Currently, USB-DMAC driver does not have system sleep callbacks hence
this driver relies on the PM core to force runtime suspend/resume to
suspend and reinitialize USB-DMAC during system resume. After
the commit 17218e0092f8 ("PM / genpd: Stop/start devices without
pm_runtime_force_suspend/resume()"), PM core will not force
runtime suspend/resume anymore so this issue happens.

To solve this, make system suspend resume explicit by using
pm_runtime_force_{suspend,resume}() as the system sleep callbacks.
SET_NOIRQ_SYSTEM_SLEEP_PM_OPS() is used to make sure USB-DMAC
suspended after and initialized before renesas_usbhs."

Signed-off-by: Phuong Nguyen <phuong.nguyen.xw@renesas.com>
Signed-off-by: Hiroyuki Yokoyama <hiroyuki.yokoyama.vx@renesas.com>
Cc: <stable@vger.kernel.org> # v4.16+
[shimoda: revise the commit log and add Cc tag]
Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Signed-off-by: Vinod Koul <vkoul@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/dma/sh/usb-dmac.c |    2 ++
 1 file changed, 2 insertions(+)

--- a/drivers/dma/sh/usb-dmac.c
+++ b/drivers/dma/sh/usb-dmac.c
@@ -694,6 +694,8 @@ static int usb_dmac_runtime_resume(struc
 #endif /* CONFIG_PM */
 
 static const struct dev_pm_ops usb_dmac_pm = {
+	SET_NOIRQ_SYSTEM_SLEEP_PM_OPS(pm_runtime_force_suspend,
+				      pm_runtime_force_resume)
 	SET_RUNTIME_PM_OPS(usb_dmac_runtime_suspend, usb_dmac_runtime_resume,
 			   NULL)
 };


