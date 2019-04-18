Return-Path: <SRS0=NWWL=SU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2DA2C10F14
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 18:09:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B194F21872
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 18:09:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555610964;
	bh=lI9kc5cDms9hJ8BTMoC0tjOimcd+Pi92HoaaDLv/DMs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=oqaSy24oVEoPBDaQMdAcNdLduMI2ZHhyY9jQoHDSMgwjyrvAs0VZkR7srU73o9XmC
	 qW1VfeXJPCLCM6ckPg/0N4skUdeYbnPXx6+dixTsqpqEB+oZqep8lBKQBx6nZ21WHK
	 gd2+ziQxyT1ZJPjMtU7BPbP81LYIAhJRW7wjEvPo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403902AbfDRSJW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Apr 2019 14:09:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:40892 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391875AbfDRSJT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Apr 2019 14:09:19 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 80F4D2186A;
        Thu, 18 Apr 2019 18:09:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1555610959;
        bh=lI9kc5cDms9hJ8BTMoC0tjOimcd+Pi92HoaaDLv/DMs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Jp2yT/H24IY0G5fm1wJIDU9F62T2y6Cd9bhM3KEkLC2iO3jNQUXcIQwelhUBmlsK7
         0DQ4Fa01VwcaGN7ygSVMniKNfoGpGDaNKo8Z71oetZ8b38yFAQRY+s4WCE4krKExO7
         TNYJdHOCj7lyMh8V7mFn0xwBXzBGZNiw22HCziqo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Siva Rebbagondla <siva.rebbagondla@redpinesignals.com>,
        Kalle Valo <kvalo@codeaurora.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.9 29/50] rsi: improve kernel thread handling to fix kernel panic
Date:   Thu, 18 Apr 2019 19:57:40 +0200
Message-Id: <20190418160426.368110507@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190418160422.455656724@linuxfoundation.org>
References: <20190418160422.455656724@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Upstream commit 4c62764d0fc21a34ffc44eec1210038c3a2e4473 ]

While running regressions, observed below kernel panic when sdio disconnect
called. This is because of, kthread_stop() is taking care of
wait_for_completion() by default. When wait_for_completion triggered
in kthread_stop and as it was done already, giving kernel panic.
Hence, removing redundant wait_for_completion() from rsi_kill_thread().

... skipping ...
BUG: unable to handle kernel NULL pointer dereference at           (null)
IP: [<ffffffff810a63df>] exit_creds+0x1f/0x50
PGD 0
Oops: 0002 [#1] SMP
CPU: 0 PID: 6502 Comm: rmmod Tainted: G  OE   4.15.9-Generic #154-Ubuntu
Hardware name: Dell Inc. Edge Gateway 3003/ , BIOS 01.00.00 04/17/2017
Stack:
ffff88007392e600 ffff880075847dc0 ffffffff8108160a 0000000000000000
ffff88007392e600 ffff880075847de8 ffffffff810a484b ffff880076127000
ffff88003cd3a800 ffff880074f12a00 ffff880075847e28 ffffffffc09bed15
Call Trace:
[<ffffffff8108160a>] __put_task_struct+0x5a/0x140
[<ffffffff810a484b>] kthread_stop+0x10b/0x110
[<ffffffffc09bed15>] rsi_disconnect+0x2f5/0x300 [ven_rsi_sdio]
[<ffffffff81578bcb>] ? __pm_runtime_resume+0x5b/0x80
[<ffffffff816f0918>] sdio_bus_remove+0x38/0x100
[<ffffffff8156cc64>] __device_release_driver+0xa4/0x150
[<ffffffff8156d7a5>] driver_detach+0xb5/0xc0
[<ffffffff8156c6c5>] bus_remove_driver+0x55/0xd0
[<ffffffff8156dfbc>] driver_unregister+0x2c/0x50
[<ffffffff816f0b8a>] sdio_unregister_driver+0x1a/0x20
[<ffffffffc09bf0f5>] rsi_module_exit+0x15/0x30 [ven_rsi_sdio]
[<ffffffff8110cad8>] SyS_delete_module+0x1b8/0x210
[<ffffffff81851dc8>] entry_SYSCALL_64_fastpath+0x1c/0xbb

Signed-off-by: Siva Rebbagondla <siva.rebbagondla@redpinesignals.com>
Signed-off-by: Kalle Valo <kvalo@codeaurora.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wireless/rsi/rsi_common.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/net/wireless/rsi/rsi_common.h b/drivers/net/wireless/rsi/rsi_common.h
index d3fbe33d2324..a13f08fd8690 100644
--- a/drivers/net/wireless/rsi/rsi_common.h
+++ b/drivers/net/wireless/rsi/rsi_common.h
@@ -75,7 +75,6 @@ static inline int rsi_kill_thread(struct rsi_thread *handle)
 	atomic_inc(&handle->thread_done);
 	rsi_set_event(&handle->event);
 
-	wait_for_completion(&handle->completion);
 	return kthread_stop(handle->task);
 }
 
-- 
2.19.1



