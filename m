Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29A84C10F0B
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 17:35:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EF581208E4
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 17:35:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554140120;
	bh=Wkmjcgy4nUN0i65BuBCOoOOHKKjbqhGyr5XDgqHYlZM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=mhp5RVVaOagDMUcYJujqHzuKIwvKbKe+91QcUAutAxe87JJ9WZ4cNBG+Mlr8L9MB1
	 pnwUhVff+vW+iAfAbrIhDXX/MppbPr2MBm6bjvRhDhk4hXxCD/1UpSR2Hyj3xjkiL9
	 xsXy8yOilOpetNTfOYYRDPAHWIO1GO6W6uekMO3w=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387900AbfDARfS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 13:35:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:45664 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387527AbfDARfM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 13:35:12 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EFFE820880;
        Mon,  1 Apr 2019 17:35:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554140111;
        bh=Wkmjcgy4nUN0i65BuBCOoOOHKKjbqhGyr5XDgqHYlZM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=sUFpTxGpEqVPMXZPwAtOBSJZUGT3n0yOcxLYcMcOL9ObvyhCepe9QoUxkKyuYeK6P
         186iqzafVaETtzM6WvWxcMpsZa1mijztPeMnfzOspo1SWov1gM9APGnkgky9ESTpFb
         m9gI/9r7FxS0JDdFoac1ZvYeITbMwfdqFQJmY/b0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Winter Wang <wente.wang@nxp.com>,
        Felipe Balbi <felipe.balbi@linux.intel.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.4 082/131] usb: gadget: configfs: add mutex lock before unregister gadget
Date:   Mon,  1 Apr 2019 19:02:32 +0200
Message-Id: <20190401170058.971706294@linuxfoundation.org>
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

[ Upstream commit cee51c33f52ebf673a088a428ac0fecc33ab77fa ]

There may be a race condition if f_fs calls unregister_gadget_item in
ffs_closed() when unregister_gadget is called by UDC store at the same time.
this leads to a kernel NULL pointer dereference:

[  310.644928] Unable to handle kernel NULL pointer dereference at virtual address 00000004
[  310.645053] init: Service 'adbd' is being killed...
[  310.658938] pgd = c9528000
[  310.662515] [00000004] *pgd=19451831, *pte=00000000, *ppte=00000000
[  310.669702] Internal error: Oops: 817 [#1] PREEMPT SMP ARM
[  310.675211] Modules linked in:
[  310.678294] CPU: 0 PID: 1537 Comm: ->transport Not tainted 4.1.15-03725-g793404c #2
[  310.685958] Hardware name: Freescale i.MX6 Quad/DualLite (Device Tree)
[  310.692493] task: c8e24200 ti: c945e000 task.ti: c945e000
[  310.697911] PC is at usb_gadget_unregister_driver+0xb4/0xd0
[  310.703502] LR is at __mutex_lock_slowpath+0x10c/0x16c
[  310.708648] pc : [<c075efc0>]    lr : [<c0bfb0bc>]    psr: 600f0113
<snip..>
[  311.565585] [<c075efc0>] (usb_gadget_unregister_driver) from [<c075e2b8>] (unregister_gadget_item+0x1c/0x34)
[  311.575426] [<c075e2b8>] (unregister_gadget_item) from [<c076fcc8>] (ffs_closed+0x8c/0x9c)
[  311.583702] [<c076fcc8>] (ffs_closed) from [<c07736b8>] (ffs_data_reset+0xc/0xa0)
[  311.591194] [<c07736b8>] (ffs_data_reset) from [<c07738ac>] (ffs_data_closed+0x90/0xd0)
[  311.599208] [<c07738ac>] (ffs_data_closed) from [<c07738f8>] (ffs_ep0_release+0xc/0x14)
[  311.607224] [<c07738f8>] (ffs_ep0_release) from [<c023e030>] (__fput+0x80/0x1d0)
[  311.614635] [<c023e030>] (__fput) from [<c014e688>] (task_work_run+0xb0/0xe8)
[  311.621788] [<c014e688>] (task_work_run) from [<c010afdc>] (do_work_pending+0x7c/0xa4)
[  311.629718] [<c010afdc>] (do_work_pending) from [<c010770c>] (work_pending+0xc/0x20)

for functions using functionFS, i.e. android adbd will close /dev/usb-ffs/adb/ep0
when usb IO thread fails, but switch adb from on to off also triggers write
"none" > UDC. These 2 operations both call unregister_gadget, which will lead
to the panic above.

add a mutex before calling unregister_gadget for api used in f_fs.

Signed-off-by: Winter Wang <wente.wang@nxp.com>
Signed-off-by: Felipe Balbi <felipe.balbi@linux.intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/usb/gadget/configfs.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/usb/gadget/configfs.c b/drivers/usb/gadget/configfs.c
index 6abb6a10ee82..d412e234f336 100644
--- a/drivers/usb/gadget/configfs.c
+++ b/drivers/usb/gadget/configfs.c
@@ -1496,7 +1496,9 @@ void unregister_gadget_item(struct config_item *item)
 {
 	struct gadget_info *gi = to_gadget_info(item);
 
+	mutex_lock(&gi->lock);
 	unregister_gadget(gi);
+	mutex_unlock(&gi->lock);
 }
 EXPORT_SYMBOL_GPL(unregister_gadget_item);
 
-- 
2.19.1



