Return-Path: <SRS0=KBKa=UT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E100C43613
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Jun 2019 18:05:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E5C5F2089C
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Jun 2019 18:05:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1561053931;
	bh=OwZ0qLFkEiHNIobShGBggg/4oh/hdfHyky43omuQniU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=m/YMKHPAYL77FwVwiARmO0+RvhKedprVqdUHsQ8xmKqrX/eJP9UlQTAhnsvX1Pxn1
	 r3KWStY7q179INqE8hpzFNTcQDM6GPRNd4wCQtpo/6U3mIavTfWXqPk06jCokSou5C
	 mJqRUMpFjPXDsqSlXkpaUYesVbMjr3J9PblLmJJk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728056AbfFTSF3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Jun 2019 14:05:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:58868 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726155AbfFTSF1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jun 2019 14:05:27 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E76E521479;
        Thu, 20 Jun 2019 18:05:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1561053926;
        bh=OwZ0qLFkEiHNIobShGBggg/4oh/hdfHyky43omuQniU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=UmeplU1bfZvxXon5noBscFNaLXmaxLliIuyKnLasNsEV5EekdedMzCEX/0CC3jz4Y
         ovxO6Inzf734JZwov/j8XVnpYcJtiviSxhaOfcZF0ScT51I13fWwwR7EDvUPDKHCWX
         6drTKvIiQeM7HxGHJCxkQSL53EXDLUxxZCEuwOhI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Kangjie Lu <kjlu@umn.edu>,
        Aditya Pakki <pakki001@umn.edu>,
        Ferenc Bakonyi <fero@drama.obuda.kando.hu>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.9 046/117] video: hgafb: fix potential NULL pointer dereference
Date:   Thu, 20 Jun 2019 19:56:20 +0200
Message-Id: <20190620174354.722730893@linuxfoundation.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190620174351.964339809@linuxfoundation.org>
References: <20190620174351.964339809@linuxfoundation.org>
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
index 463028543173..59e1cae57948 100644
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



