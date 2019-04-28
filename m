Return-Path: <SRS0=wfQU=S6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 750CDC43218
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Apr 2019 10:46:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 46AAD2075D
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Apr 2019 10:46:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726617AbfD1KqQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 28 Apr 2019 06:46:16 -0400
Received: from gloria.sntech.de ([185.11.138.130]:47650 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726317AbfD1KqP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Apr 2019 06:46:15 -0400
Received: from p57b775bf.dip0.t-ipconnect.de ([87.183.117.191] helo=phil.localnet)
        by gloria.sntech.de with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <heiko@sntech.de>)
        id 1hKhK1-0005J6-QB; Sun, 28 Apr 2019 12:46:13 +0200
From:   Heiko Stuebner <heiko@sntech.de>
To:     Wen Yang <wen.yang99@zte.com.cn>
Cc:     linux-kernel@vger.kernel.org, wang.yi59@zte.com.cn,
        Russell King <linux@armlinux.org.uk>,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org
Subject: Re: [PATCH v3] ARM: rockchip: fix a leaked reference by adding missing of_node_put
Date:   Sun, 28 Apr 2019 12:46:13 +0200
Message-ID: <5474132.bFrQNdgMoI@phil>
In-Reply-To: <1556262488-21072-1-git-send-email-wen.yang99@zte.com.cn>
References: <1556262488-21072-1-git-send-email-wen.yang99@zte.com.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Freitag, 26. April 2019, 09:08:08 CEST schrieb Wen Yang:
> The call to of_get_next_child returns a node pointer with refcount
> incremented thus it must be explicitly decremented after the last
> usage.
> 
> Detected by coccinelle with the following warnings:
> ./arch/arm/mach-rockchip/pm.c:269:2-8: ERROR: missing of_node_put; acquired a node pointer with refcount incremented on line 259, but without a corresponding object release within this function.
> ./arch/arm/mach-rockchip/pm.c:275:2-8: ERROR: missing of_node_put; acquired a node pointer with refcount incremented on line 259, but without a corresponding object release within this function
> ./arch/arm/mach-rockchip/platsmp.c:281:2-8: ERROR: missing of_node_put; acquired a node pointer with refcount incremented on line 272, but without a corresponding object release within this function.
> ./arch/arm/mach-rockchip/platsmp.c:285:2-8: ERROR: missing of_node_put; acquired a node pointer with refcount incremented on line 272, but without a corresponding object release within this function.
> ./arch/arm/mach-rockchip/platsmp.c:289:3-9: ERROR: missing of_node_put; acquired a node pointer with refcount incremented on line 272, but without a corresponding object release within this function.
> ./arch/arm/mach-rockchip/platsmp.c:303:3-9: ERROR: missing of_node_put; acquired a node pointer with refcount incremented on line 294, but without a corresponding object release within this function.
> 
> Signed-off-by: Wen Yang <wen.yang99@zte.com.cn>
> Reviewed-by: Florian Fainelli <f.fainelli@gmail.com>
> Suggested-by: Heiko Stuebner <heiko@sntech.de>
> Cc: Russell King <linux@armlinux.org.uk>
> Cc: Heiko Stuebner <heiko@sntech.de>
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: linux-rockchip@lists.infradead.org
> Cc: linux-kernel@vger.kernel.org

queued for 5.3 (too late for 5.2)

Thanks
Heiko


