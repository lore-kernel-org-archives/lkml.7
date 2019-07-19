Return-Path: <SRS0=NvuC=VQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D3B3C76188
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jul 2019 04:19:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2D0382084C
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jul 2019 04:19:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1563509941;
	bh=QoNhA/E3iRwdS19rm21kkSOAa3YfFVivd0airztDrc8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=QkpxMBbbUXa5ZmZVDqF8qs4cRAFw/yDMRZi88LxufL0SjJgIlEf+3lpm3sJJHJVlq
	 XtOQufbpPMj2xOerR2Dx3TzaF86Sd8yfHNVgrAeFNqY81pY2WB63741ZsDZu8hhKlt
	 W01BIJD0d4N2OeAqpt+QM/b/Evf+GlxEnAPiWuK0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389210AbfGSEN0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jul 2019 00:13:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:49222 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389152AbfGSENV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jul 2019 00:13:21 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C2F6621872;
        Fri, 19 Jul 2019 04:13:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563509600;
        bh=QoNhA/E3iRwdS19rm21kkSOAa3YfFVivd0airztDrc8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fFGR6JuiN+37yXjDHC22k85lRgodS/JZYW5daUSzYn2SeD3NlXkOzZJe/e0WV9u1u
         wWH/poDmVaXZusFbeT/lr0XR/sgg2TrwMHy0wQufjdfH9MyTLMUBOHvsB2xqTD6P9i
         KgnNY4hPw6PmLR8jTnEXD3GnvHfd5QpcFb0i5Jng=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Kefeng Wang <wangkefeng.wang@huawei.com>,
        Hulk Robot <hulkci@huawei.com>,
        Baruch Siach <baruch@tkos.co.il>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sasha Levin <sashal@kernel.org>, linux-serial@vger.kernel.org
Subject: [PATCH AUTOSEL 4.9 10/45] tty/serial: digicolor: Fix digicolor-usart already registered warning
Date:   Fri, 19 Jul 2019 00:12:29 -0400
Message-Id: <20190719041304.18849-10-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190719041304.18849-1-sashal@kernel.org>
References: <20190719041304.18849-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kefeng Wang <wangkefeng.wang@huawei.com>

[ Upstream commit c7ad9ba0611c53cfe194223db02e3bca015f0674 ]

When modprobe/rmmod/modprobe module, if platform_driver_register() fails,
the kernel complained,

  proc_dir_entry 'driver/digicolor-usart' already registered
  WARNING: CPU: 1 PID: 5636 at fs/proc/generic.c:360 proc_register+0x19d/0x270

Fix this by adding uart_unregister_driver() when platform_driver_register() fails.

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
Acked-by: Baruch Siach <baruch@tkos.co.il>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/tty/serial/digicolor-usart.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/serial/digicolor-usart.c b/drivers/tty/serial/digicolor-usart.c
index 02ad6953b167..50ec5f1ac77f 100644
--- a/drivers/tty/serial/digicolor-usart.c
+++ b/drivers/tty/serial/digicolor-usart.c
@@ -545,7 +545,11 @@ static int __init digicolor_uart_init(void)
 	if (ret)
 		return ret;
 
-	return platform_driver_register(&digicolor_uart_platform);
+	ret = platform_driver_register(&digicolor_uart_platform);
+	if (ret)
+		uart_unregister_driver(&digicolor_uart);
+
+	return ret;
 }
 module_init(digicolor_uart_init);
 
-- 
2.20.1

