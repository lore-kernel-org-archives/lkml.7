Return-Path: <SRS0=fWiu=Y6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4B5EC5DF64
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Nov 2019 17:33:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8EDB0214D8
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Nov 2019 17:33:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gerhold.net header.i=@gerhold.net header.b="SCKMVvki"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732233AbfKFRdd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Nov 2019 12:33:33 -0500
Received: from mo4-p02-ob.smtp.rzone.de ([81.169.146.168]:22189 "EHLO
        mo4-p02-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727824AbfKFRdd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Nov 2019 12:33:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1573061612;
        s=strato-dkim-0002; d=gerhold.net;
        h=References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        X-RZG-CLASS-ID:X-RZG-AUTH:From:Subject:Sender;
        bh=mIldqttqfk8PseguvjP4Q5zAd8L6jVCOWD5lW5sYXnk=;
        b=SCKMVvkiv9G7tKetlD3EgFJ9AXIB8QlCOqQ0eUzyg4YfGiJs1mY8V+1iqK0Oa9qeG4
        7UqPPWbG/+2ZF9QPF5LWEezkhQEhlMO6o8KU8qkxEOX07Ot97sN1w0zUCs6tM+IRIJUs
        sh2vRykIpnILl5yIffjY+2ayA9+/wjP40rCt3+b5lXjFqM630Kv5o/kNlSH3qZ9Gr7p8
        iTYgaC9yrp5KVBbtb6XIT6k4Y1e8OfDGDpNTzFAPBuuRnz7oMr0udkgiIliUj/wOlcts
        1OMpoymmUr1tBxUXjGJSQIMS0uaJVGweUCD4IuQjbgjztbSD90erTOpoL3wJAO+nkXz1
        y8/g==
X-RZG-AUTH: ":P3gBZUipdd93FF5ZZvYFPugejmSTVR2nRPhVORvLd4SsytBXQrEOHTIXs8PvtBNfIQ=="
X-RZG-CLASS-ID: mo00
Received: from localhost.localdomain
        by smtp.strato.de (RZmta 44.29.0 AUTH)
        with ESMTPSA id e07688vA6HXVhYU
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (curve secp521r1 with 521 ECDH bits, eq. 15360 bits RSA))
        (Client did not present a certificate);
        Wed, 6 Nov 2019 18:33:31 +0100 (CET)
From:   Stephan Gerhold <stephan@gerhold.net>
To:     Mark Brown <broonie@kernel.org>
Cc:     Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org,
        Stephan Gerhold <stephan@gerhold.net>,
        Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH 2/2] regulator: ab8500: Remove SYSCLKREQ from enum ab8505_regulator_id
Date:   Wed,  6 Nov 2019 18:31:25 +0100
Message-Id: <20191106173125.14496-2-stephan@gerhold.net>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191106173125.14496-1-stephan@gerhold.net>
References: <20191106173125.14496-1-stephan@gerhold.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Those regulators are not actually supported by the AB8500 regulator
driver. There is no ab8500_regulator_info for them and no entry in
ab8505_regulator_match.

As such, they cannot be registered successfully, and looking them
up in ab8505_regulator_match causes an out-of-bounds array read.

Fixes: 547f384f33db ("regulator: ab8500: add support for ab8505")
Cc: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Stephan Gerhold <stephan@gerhold.net>
---
 include/linux/regulator/ab8500.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/include/linux/regulator/ab8500.h b/include/linux/regulator/ab8500.h
index 505e94a6e3e8..3ab1ddf151a2 100644
--- a/include/linux/regulator/ab8500.h
+++ b/include/linux/regulator/ab8500.h
@@ -42,8 +42,6 @@ enum ab8505_regulator_id {
 	AB8505_LDO_ANAMIC2,
 	AB8505_LDO_AUX8,
 	AB8505_LDO_ANA,
-	AB8505_SYSCLKREQ_2,
-	AB8505_SYSCLKREQ_4,
 	AB8505_NUM_REGULATORS,
 };
 
-- 
2.23.0

