Return-Path: <SRS0=KBKa=UT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BF2EC43613
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Jun 2019 18:31:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3B3BD20675
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Jun 2019 18:31:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1561055508;
	bh=u3lAwZ1/m/YLABeQxX+mwIpnzJaL+/Nm/ycMVCNYwZk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=NxT6eL5pxs0ItRScqQiGTACpn1TVGTPUva4lP8jFI6/oOfc5LAGOZ9gOlLUpL0ggZ
	 Spn6rcsl7hIScDdJw7MKnRdeRzpMb+Jd64JtUzUzc6mN6iEUV1Xhb7oBm8ViXRJBCl
	 MYfeBfyv3BtOLUrteNZPQ4EbEIMyNQXHXbsKVQLM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727223AbfFTSbq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Jun 2019 14:31:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:46590 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725913AbfFTR7Q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jun 2019 13:59:16 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 14B822147A;
        Thu, 20 Jun 2019 17:59:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1561053555;
        bh=u3lAwZ1/m/YLABeQxX+mwIpnzJaL+/Nm/ycMVCNYwZk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=inEPWZY3eu5zKPcFTm/SIor/qO1VRCq9vgHZrYVaOVhksYZ2IpnoTTolJYEVucIEh
         K9xET0TlNDg+0qIrkFq0w51R8Z1VxCfX9NrNpyBnkhyQSLDBEoyL2lRBpb6MLXqXe0
         InWDIpH+B9ziVCMAo1yVD6rB9DzS/8VGfWJ9mLIw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Kangjie Lu <kjlu@umn.edu>,
        Aditya Pakki <pakki001@umn.edu>,
        Ferenc Bakonyi <fero@drama.obuda.kando.hu>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.4 29/84] video: hgafb: fix potential NULL pointer dereference
Date:   Thu, 20 Jun 2019 19:56:26 +0200
Message-Id: <20190620174342.159575293@linuxfoundation.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190620174337.538228162@linuxfoundation.org>
References: <20190620174337.538228162@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Upstream commit ec7f6aad57ad29e4e66cc2e18e1e1599ddb02542 ]

When ioremap fails, hga_vram should not be dereferenced. The fix
check the failure to avoid NULL pointer dereference.

Signed-off-by: Kangjie Lu <kjlu@umn.edu>
Cc: Aditya Pakki <pakki001@umn.edu>
Cc: Ferenc Bakonyi <fero@drama.obuda.kando.hu>
[b.zolnierkie: minor patch summary fixup]
Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/video/fbdev/hgafb.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/video/fbdev/hgafb.c b/drivers/video/fbdev/hgafb.c
index 15d3ccff2965..4a397c7c1b56 100644
--- a/drivers/video/fbdev/hgafb.c
+++ b/drivers/video/fbdev/hgafb.c
@@ -285,6 +285,8 @@ static int hga_card_detect(void)
 	hga_vram_len  = 0x08000;
 
 	hga_vram = ioremap(0xb0000, hga_vram_len);
+	if (!hga_vram)
+		goto error;
 
 	if (request_region(0x3b0, 12, "hgafb"))
 		release_io_ports = 1;
-- 
2.20.1



