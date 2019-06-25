Return-Path: <SRS0=/s9R=UY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FB78C48BD6
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 11:35:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 44F6020656
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 11:35:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=fau.de header.i=@fau.de header.b="Wbkoi/6o"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731640AbfFYLfC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Jun 2019 07:35:02 -0400
Received: from mx-rz-1.rrze.uni-erlangen.de ([131.188.11.20]:36389 "EHLO
        mx-rz-1.rrze.uni-erlangen.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730554AbfFYLe7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jun 2019 07:34:59 -0400
Received: from mx-exchlnx-1.rrze.uni-erlangen.de (mx-exchlnx-1.rrze.uni-erlangen.de [IPv6:2001:638:a000:1025::37])
        by mx-rz-1.rrze.uni-erlangen.de (Postfix) with ESMTP id 45Y3pD0YVSz8vFq;
        Tue, 25 Jun 2019 13:29:08 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fau.de; s=fau-2013;
        t=1561462148; bh=vFj2pVZ/HOC1MKUbfynpfE4dgH7Iemsw5b/nvKkMoDo=;
        h=From:To:CC:Subject:Date:In-Reply-To:References:From:To:CC:
         Subject;
        b=Wbkoi/6os6nyxFc/7Al5oU8p7uVfwk2HoT1b3GKrwREv6j3HCZXvwNCxyIa0m1Xqu
         OgUIhObhTzDwAs5jm34lnRPCE0q+Em4k+BgAAUkBKS9JgLkG5Vumqxx1HPB/7AqgNu
         ayn9BoLStR11ZS0EIbVw1/4dGELstT/z8GZV+yaPPuarvdXPkhSpTLhvepRP7mUzpE
         Cw3zBd9xJW0jJzNe0i8VvuaUKwTYULF5aDc/+tUJuS8seFOHTeAL5XIiWJBLWEuAt5
         mY0WKgELSDRWr66E+6Dt6NbnvTe8hYcIOtUm9BXP4yJBIspBnjgZeHaI+Hwnw2FBoC
         UdGrWn4H08v9g==
X-Virus-Scanned: amavisd-new at boeck5.rrze.uni-erlangen.de (RRZE)
X-RRZE-Flag: Not-Spam
Received: from hbt1.exch.fau.de (hbt1.exch.fau.de [10.15.8.13])
        by mx-exchlnx-1.rrze.uni-erlangen.de (Postfix) with ESMTP id 45Y3p96QJFz8vVF;
        Tue, 25 Jun 2019 13:29:05 +0200 (CEST)
Received: from MBX3.exch.uni-erlangen.de (10.15.8.45) by hbt1.exch.fau.de
 (10.15.8.13) with Microsoft SMTP Server (TLS) id 14.3.439.0; Tue, 25 Jun 2019
 13:28:36 +0200
Received: from TroubleWorld.pool.uni-erlangen.de (10.21.22.37) by
 MBX3.exch.uni-erlangen.de (10.15.8.45) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1591.10; Tue, 25 Jun 2019 13:28:34 +0200
From:   Fabian Krueger <fabian.krueger@fau.de>
CC:     <fabian.krueger@fau.de>,
        Michael Scheiderer <michael.scheiderer@fau.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        <devel@driverdev.osuosl.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH 8/8] staging: kpc2000: remove needless 'break'
Date:   Tue, 25 Jun 2019 13:27:19 +0200
Message-ID: <20190625112725.10154-9-fabian.krueger@fau.de>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190625112725.10154-1-fabian.krueger@fau.de>
References: <20190625112725.10154-1-fabian.krueger@fau.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.21.22.37]
X-ClientProxiedBy: MBX3.exch.uni-erlangen.de (10.15.8.45) To
 MBX3.exch.uni-erlangen.de (10.15.8.45)
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The unconditioned jump will prohibit to ever reach the break-statement.
Deleting this needless statement, the code becomes more understandable.

Signed-off-by: Fabian Krueger <fabian.krueger@fau.de>
Signed-off-by: Michael Scheiderer <michael.scheiderer@fau.de>
---
 drivers/staging/kpc2000/kpc2000_spi.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/staging/kpc2000/kpc2000_spi.c b/drivers/staging/kpc2000/kpc2000_spi.c
index f258f369e065..e65f0c34db50 100644
--- a/drivers/staging/kpc2000/kpc2000_spi.c
+++ b/drivers/staging/kpc2000/kpc2000_spi.c
@@ -515,7 +515,6 @@ kp_spi_probe(struct platform_device *pldev)
 	default:
 		dev_err(&pldev->dev, "Unknown hardware, cant know what partition table to use!\n");
 		goto free_master;
-		break;
 	}
 
 	return status;
-- 
2.17.1

