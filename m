Return-Path: <SRS0=UImc=ZL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38BE8C432C3
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 05:22:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0FC8222317
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 05:22:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574140957;
	bh=e6CICMOupY8NFEmXVT/oiRzp/oDxkEoLf0qYaYMSIQk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=w0LuBaELC88qKJVGjjaXS6fu9iRI5C4Ky574m96xgICYLUqTjyOvJMhmZiCZrKMjN
	 0jFopJ4XB5zcDFJ1grp29gIxcF+LBYS/tQVrFbh1qLLpyWTr/R5FySnM/CVBV/Owhh
	 dW+5vM/QPwAAmAWajCHARZUnoGrwMh/TZgQZd42w=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727781AbfKSFWf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Nov 2019 00:22:35 -0500
Received: from mail.kernel.org ([198.145.29.99]:37856 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727744AbfKSFWc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Nov 2019 00:22:32 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A22832231A;
        Tue, 19 Nov 2019 05:22:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574140952;
        bh=e6CICMOupY8NFEmXVT/oiRzp/oDxkEoLf0qYaYMSIQk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=NYVCs9G9GVDzlQXAwAS6LlMbavY7+L8AHiFW6Dw2XVk8AvKCDWCP6QYAz5IQBUlIe
         HCM+Irx796xre6eNpCc+mYimOvvUOGZQGWkN9Jj+NLg/s/I/4AxVfqYuehxvMbhyoE
         L4Qv46hD6/DpNdOUNKajC/MBhDUcfDaAz9N5FNA4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Corentin Labbe <clabbe@baylibre.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 5.3 40/48] net: ethernet: dwmac-sun8i: Use the correct function in exit path
Date:   Tue, 19 Nov 2019 06:20:00 +0100
Message-Id: <20191119051022.818468781@linuxfoundation.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191119050946.745015350@linuxfoundation.org>
References: <20191119050946.745015350@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Corentin Labbe <clabbe@baylibre.com>

commit 40a1dcee2d1846a24619fe9ca45c661ca0db7dda upstream.

When PHY is not powered, the probe function fail and some resource are
still unallocated.
Furthermore some BUG happens:
dwmac-sun8i 5020000.ethernet: EMAC reset timeout
------------[ cut here ]------------
kernel BUG at /linux-next/net/core/dev.c:9844!

So let's use the right function (stmmac_pltfr_remove) in the error path.

Fixes: 9f93ac8d4085 ("net-next: stmmac: Add dwmac-sun8i")
Cc: <stable@vger.kernel.org> # v4.15+
Signed-off-by: Corentin Labbe <clabbe@baylibre.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/net/ethernet/stmicro/stmmac/dwmac-sun8i.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-sun8i.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-sun8i.c
@@ -1225,7 +1225,7 @@ static int sun8i_dwmac_probe(struct plat
 dwmac_mux:
 	sun8i_dwmac_unset_syscon(gmac);
 dwmac_exit:
-	sun8i_dwmac_exit(pdev, plat_dat->bsp_priv);
+	stmmac_pltfr_remove(pdev);
 return ret;
 }
 


