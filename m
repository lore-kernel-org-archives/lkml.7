Return-Path: <SRS0=91bA=RH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99647C4360F
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 08:41:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 637B720836
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 08:41:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551688916;
	bh=NGVdP+kNCu9UohM9jfY3usNf7xIxjpSW0pLp3kcYq5g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=whgE7xqO236QkvBBptZeCRhYZxOIZISwtZ0DaAUOKoI3FzDCdvYu7Rj1RzeL+QvwK
	 JXeobCP2kQ4p7b0JqXdM5GG32NSnN4HBPgR0GoVKAEa30sVkcVD2zYDEtKWthHm20G
	 9QzaoPO3HJHrIy88rqiIhNb0vAlbp0S+ER9awA0U=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727096AbfCDIbd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Mar 2019 03:31:33 -0500
Received: from mail.kernel.org ([198.145.29.99]:33432 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726313AbfCDIb3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Mar 2019 03:31:29 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 216772146E;
        Mon,  4 Mar 2019 08:31:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551688288;
        bh=NGVdP+kNCu9UohM9jfY3usNf7xIxjpSW0pLp3kcYq5g=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=B4ukQdfLCQ0XjsxORHhcmVxFND0akn+gumhSiEYunYPkYePo1UK3CZxNws/m/u+Yp
         jk6cQoR033yG8F5ZQf1sRqi5zwuhmVIfof52P1tDcScMuIa4az5ufLGv4Y0689qe4+
         7jrZ1BG0nJlGpeWwbnDLbuQzoyuA+Te5j2znvY4Q=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jonas Gorski <jonas.gorski@gmail.com>,
        Christoph Hellwig <hch@lst.de>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Paul Burton <paul.burton@mips.com>, linux-mips@linux-mips.org,
        Ralf Baechle <ralf@linux-mips.org>,
        James Hogan <jhogan@kernel.org>
Subject: [PATCH 4.19 76/78] MIPS: BCM63XX: provide DMA masks for ethernet devices
Date:   Mon,  4 Mar 2019 09:22:59 +0100
Message-Id: <20190304081628.997687332@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190304081625.508788074@linuxfoundation.org>
References: <20190304081625.508788074@linuxfoundation.org>
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

From: Jonas Gorski <jonas.gorski@gmail.com>

commit 18836b48ebae20850631ee2916d0cdbb86df813d upstream.

The switch to the generic dma ops made dma masks mandatory, breaking
devices having them not set. In case of bcm63xx, it broke ethernet with
the following warning when trying to up the device:

[    2.633123] ------------[ cut here ]------------
[    2.637949] WARNING: CPU: 0 PID: 325 at ./include/linux/dma-mapping.h:516 bcm_enetsw_open+0x160/0xbbc
[    2.647423] Modules linked in: gpio_button_hotplug
[    2.652361] CPU: 0 PID: 325 Comm: ip Not tainted 4.19.16 #0
[    2.658080] Stack : 80520000 804cd3ec 00000000 00000000 804ccc00 87085bdc 87d3f9d4 804f9a17
[    2.666707]         8049cf18 00000145 80a942a0 00000204 80ac0000 10008400 87085b90 eb3d5ab7
[    2.675325]         00000000 00000000 80ac0000 000022b0 00000000 00000000 00000007 00000000
[    2.683954]         0000007a 80500000 0013b381 00000000 80000000 00000000 804a1664 80289878
[    2.692572]         00000009 00000204 80ac0000 00000200 00000002 00000000 00000000 80a90000
[    2.701191]         ...
[    2.703701] Call Trace:
[    2.706244] [<8001f3c8>] show_stack+0x58/0x100
[    2.710840] [<800336e4>] __warn+0xe4/0x118
[    2.715049] [<800337d4>] warn_slowpath_null+0x48/0x64
[    2.720237] [<80289878>] bcm_enetsw_open+0x160/0xbbc
[    2.725347] [<802d1d4c>] __dev_open+0xf8/0x16c
[    2.729913] [<802d20cc>] __dev_change_flags+0x100/0x1c4
[    2.735290] [<802d21b8>] dev_change_flags+0x28/0x70
[    2.740326] [<803539e0>] devinet_ioctl+0x310/0x7b0
[    2.745250] [<80355fd8>] inet_ioctl+0x1f8/0x224
[    2.749939] [<802af290>] sock_ioctl+0x30c/0x488
[    2.754632] [<80112b34>] do_vfs_ioctl+0x740/0x7dc
[    2.759459] [<80112c20>] ksys_ioctl+0x50/0x94
[    2.763955] [<800240b8>] syscall_common+0x34/0x58
[    2.768782] ---[ end trace fb1a6b14d74e28b6 ]---
[    2.773544] bcm63xx_enetsw bcm63xx_enetsw.0: cannot allocate rx ring 512

Fix this by adding appropriate DMA masks for the platform devices.

Fixes: f8c55dc6e828 ("MIPS: use generic dma noncoherent ops for simple noncoherent platforms")
Signed-off-by: Jonas Gorski <jonas.gorski@gmail.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Florian Fainelli <f.fainelli@gmail.com>
Signed-off-by: Paul Burton <paul.burton@mips.com>
Cc: linux-mips@linux-mips.org
Cc: linux-kernel@vger.kernel.org
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: James Hogan <jhogan@kernel.org>
Cc: stable@vger.kernel.org # v4.19+
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/mips/bcm63xx/dev-enet.c |    8 ++++++++
 1 file changed, 8 insertions(+)

--- a/arch/mips/bcm63xx/dev-enet.c
+++ b/arch/mips/bcm63xx/dev-enet.c
@@ -70,6 +70,8 @@ static struct platform_device bcm63xx_en
 
 static int shared_device_registered;
 
+static u64 enet_dmamask = DMA_BIT_MASK(32);
+
 static struct resource enet0_res[] = {
 	{
 		.start		= -1, /* filled at runtime */
@@ -99,6 +101,8 @@ static struct platform_device bcm63xx_en
 	.resource	= enet0_res,
 	.dev		= {
 		.platform_data = &enet0_pd,
+		.dma_mask = &enet_dmamask,
+		.coherent_dma_mask = DMA_BIT_MASK(32),
 	},
 };
 
@@ -131,6 +135,8 @@ static struct platform_device bcm63xx_en
 	.resource	= enet1_res,
 	.dev		= {
 		.platform_data = &enet1_pd,
+		.dma_mask = &enet_dmamask,
+		.coherent_dma_mask = DMA_BIT_MASK(32),
 	},
 };
 
@@ -157,6 +163,8 @@ static struct platform_device bcm63xx_en
 	.resource	= enetsw_res,
 	.dev		= {
 		.platform_data = &enetsw_pd,
+		.dma_mask = &enet_dmamask,
+		.coherent_dma_mask = DMA_BIT_MASK(32),
 	},
 };
 


