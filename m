Return-Path: <SRS0=UImc=ZL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C06FC33C8C
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 05:24:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1375D2231E
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 05:24:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574141075;
	bh=3pZtjJxg82RJ4bLROtW2plxaPpzpKc7U4x+pscgL8z4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=G7fwqO1SbfuvkfmYRmCvepFUJVA+n2375qfYONWRaYn8qW4QXBPn6VEx9NnZw8e5e
	 89PSTFONcNZLf087+5BI/BLmWheOeHExx2eMIZ8ANIZnZF3JRmyziyI/Wx4GCbx/64
	 31fmnOJxVzKYz3HLLbdrYmHBNrP/mOIr+tMwBirU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727486AbfKSFYd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Nov 2019 00:24:33 -0500
Received: from mail.kernel.org ([198.145.29.99]:40656 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727452AbfKSFY3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Nov 2019 00:24:29 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 83A5221783;
        Tue, 19 Nov 2019 05:24:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574141069;
        bh=3pZtjJxg82RJ4bLROtW2plxaPpzpKc7U4x+pscgL8z4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ljLjFQMWMVPxJQZnrHhbXy6/rdYzzr6AY10IY58sMRDbEJ+xYPkP1zMI8cnNn9Tzi
         MiKD9fTYmPh/MYHDYuQipZUowUDtxzorF3FNhfKObsuxfpcrYzCtBqLWaTWf6OfFna
         sexJYcIxT0U3u8Vq7rtmmgX5fcR9h0k0Hto2eaGQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Jens Wiklander <jens.wiklander@linaro.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 034/422] tee: optee: take DT status property into account
Date:   Tue, 19 Nov 2019 06:13:51 +0100
Message-Id: <20191119051402.211777274@linuxfoundation.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191119051400.261610025@linuxfoundation.org>
References: <20191119051400.261610025@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ard Biesheuvel <ard.biesheuvel@linaro.org>

[ Upstream commit db878f76b9ff7487da9bb0f686153f81829f1230 ]

DT nodes may have a 'status' property which, if set to anything other
than 'ok' or 'okay', indicates to the OS that the DT node should be
treated as if it was not present. So add that missing logic to the
OP-TEE driver.

Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Signed-off-by: Jens Wiklander <jens.wiklander@linaro.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/tee/optee/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tee/optee/core.c b/drivers/tee/optee/core.c
index e1aafe842d660..34dce850067b9 100644
--- a/drivers/tee/optee/core.c
+++ b/drivers/tee/optee/core.c
@@ -696,7 +696,7 @@ static int __init optee_driver_init(void)
 		return -ENODEV;
 
 	np = of_find_matching_node(fw_np, optee_match);
-	if (!np)
+	if (!np || !of_device_is_available(np))
 		return -ENODEV;
 
 	optee = optee_probe(np);
-- 
2.20.1



