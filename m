Return-Path: <SRS0=UImc=ZL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 508F3C432C0
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 05:44:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 23CCD2071B
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 05:44:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574142290;
	bh=IMTxs0Vg3w+Hwrt3XgNErfmtrm2IarEi/exW/jkwuQc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=zvXEc+TtJz8eujbpGq3r6U38EvBKCRXDIyYxoTQN7dRzYzJZBtysLfI4/lSe3fCGn
	 R8BQs1WS0Q4JL33dNqnDbXv7MJSm5XGS0EjybvvndeXlE7Kzx6IADd/8zfa5lPDxBM
	 ZoZtCppJ2AhCWtEH7n16nj8IqWpFE0Ksi8Io4q1I=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730885AbfKSFos (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Nov 2019 00:44:48 -0500
Received: from mail.kernel.org ([198.145.29.99]:40218 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730389AbfKSFop (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Nov 2019 00:44:45 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 13DB721783;
        Tue, 19 Nov 2019 05:44:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574142285;
        bh=IMTxs0Vg3w+Hwrt3XgNErfmtrm2IarEi/exW/jkwuQc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=N+xDokePfH3mNKRFI3uo4SvdTpu+9PChnXsxocEAAdaNbnm4m1AfevJgIwNrLlKsY
         bo80nKZiZXMhTPNTqoy1+1xbxqL1Fzg41dfEDV7LCvj4H+5jA5Qcqu9vJoIh7NUSkW
         9nfK8iLYoGdwJXHWfbjGYwwpYL2ssx3pR5U19GgA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Jens Wiklander <jens.wiklander@linaro.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 029/239] tee: optee: take DT status property into account
Date:   Tue, 19 Nov 2019 06:17:09 +0100
Message-Id: <20191119051303.264037709@linuxfoundation.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191119051255.850204959@linuxfoundation.org>
References: <20191119051255.850204959@linuxfoundation.org>
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
index edb6e4e9ef3ac..ca79c2ba2ef2a 100644
--- a/drivers/tee/optee/core.c
+++ b/drivers/tee/optee/core.c
@@ -590,7 +590,7 @@ static int __init optee_driver_init(void)
 		return -ENODEV;
 
 	np = of_find_matching_node(fw_np, optee_match);
-	if (!np)
+	if (!np || !of_device_is_available(np))
 		return -ENODEV;
 
 	optee = optee_probe(np);
-- 
2.20.1



