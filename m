Return-Path: <SRS0=vISB=2T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56567C2D0CE
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Dec 2019 18:12:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 23DA420748
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Dec 2019 18:12:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1577643135;
	bh=MOYIgWAP8DXe6sfwEWuxE2tRlxNZzRBowLo1xbmA7PU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=gKsJrkc5fwZCGWoycNPKTkOIi/9iR/nvoaMpInzXuFrhny1ILHCpojlk6/Uu7FWyT
	 yvzOILCSKLWToClwAD14NsZBVsEpnrgYCWuGjY80a21Q56PUJrSFRCGq+m6lfXxyuZ
	 0ZGiIVOT2bAJ0oZ055VlMRcwLF1mns0AcYiu+b1k=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732940AbfL2SMO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 29 Dec 2019 13:12:14 -0500
Received: from mail.kernel.org ([198.145.29.99]:47834 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730113AbfL2Rl7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Dec 2019 12:41:59 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 81C24206A4;
        Sun, 29 Dec 2019 17:41:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1577641319;
        bh=MOYIgWAP8DXe6sfwEWuxE2tRlxNZzRBowLo1xbmA7PU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=b60lffrRsfDd757e/yoynU+K92qJb00ThM+vH/JdCC79LAmp7/4CEUgg1745T7cxK
         raIxUm7ThBzFpyoDw23IZS4OqbAJl6mEsRauDZ3K3SMpgiSc5S8szuyWoAuNnKo0l7
         /Uw25031YWHhSHeUD/bOjyZQlSDgyVHzmSH8b/Fk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Chuhong Yuan <hslester96@gmail.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 5.4 002/434] fjes: fix missed check in fjes_acpi_add
Date:   Sun, 29 Dec 2019 18:20:55 +0100
Message-Id: <20191229172702.537468638@linuxfoundation.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20191229172702.393141737@linuxfoundation.org>
References: <20191229172702.393141737@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Chuhong Yuan <hslester96@gmail.com>

[ Upstream commit a288f105a03a7e0e629a8da2b31f34ebf0343ee2 ]

fjes_acpi_add() misses a check for platform_device_register_simple().
Add a check to fix it.

Fixes: 658d439b2292 ("fjes: Introduce FUJITSU Extended Socket Network Device driver")
Signed-off-by: Chuhong Yuan <hslester96@gmail.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/fjes/fjes_main.c |    3 +++
 1 file changed, 3 insertions(+)

--- a/drivers/net/fjes/fjes_main.c
+++ b/drivers/net/fjes/fjes_main.c
@@ -166,6 +166,9 @@ static int fjes_acpi_add(struct acpi_dev
 	/* create platform_device */
 	plat_dev = platform_device_register_simple(DRV_NAME, 0, fjes_resource,
 						   ARRAY_SIZE(fjes_resource));
+	if (IS_ERR(plat_dev))
+		return PTR_ERR(plat_dev);
+
 	device->driver_data = plat_dev;
 
 	return 0;


