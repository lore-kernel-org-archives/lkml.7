Return-Path: <SRS0=lTpO=2Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 497C4C2D0C2
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Jan 2020 14:16:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 139E722B48
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Jan 2020 14:16:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pTAE/TWG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726050AbgADOOo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 4 Jan 2020 09:14:44 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:45419 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725924AbgADOOo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Jan 2020 09:14:44 -0500
Received: by mail-pg1-f195.google.com with SMTP id b9so24705277pgk.12
        for <linux-kernel@vger.kernel.org>; Sat, 04 Jan 2020 06:14:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=N1zAzNFuGiZZLxkXFIxcCFopAhIskKxqeAZ70oWHN78=;
        b=pTAE/TWGL4KOmpshoapLVk4oal5VsWsqN1WERVXpTbb8CJqLFoY773wx3GEKbJSYp5
         oiIYqn8PaoCJyi7gxGY4he4K3s9jQEjPSMIEjHIFkSqoJ0Rb5/tGkf/4MnJwgIqo8clL
         EJLXW/eP2Ckycm0sQFudGQ47S/yXCa9wzc0lcTbl8//LDupJ7NV8ynqvmPk5qklZ0a0Y
         /1C1cdDwtdgADigLLn6cfdtOnBGVGuH6O/tG5zP3pFEnRrNm2T+EEOqlEk6WxAolC+eR
         NKMQIKVgdPVNexnTbpD0OVpP4NoJLXPWdFlPrRz7MJL0vEqB1dR9PPUows/WfmG3msuT
         56IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=N1zAzNFuGiZZLxkXFIxcCFopAhIskKxqeAZ70oWHN78=;
        b=kz1QIDQ/5E3vdN9blrNabphX533lc8qMVfNVPDzsSRiXD3LCT0ZnwATWiWOkCJ0FN4
         p5MZKzPorN3F9JNxVi8kLTNZGZ1mbYYc0OjDuqZJBfIzFy9uQJFbX8N4iok1hvaUnrbq
         tPE1JMYYYv8amt/wi8wYo6/C3g5fOGrRU8eDzvhBx51l5svm0UiPw8004BaNXyE2F7eI
         IDAx+6glf54/LZw5dkizB+zwz/kAeuHkqAmIjrLiC0CDtqc0e5CR1fucQkdqh2S85ofx
         6QCgSUOhWxGAUZDihKydMwoTLHUxs7s+UeFlRC0qW6Z+eRV5LHj0jJRYpw3eCKtzGX1Y
         VwSg==
X-Gm-Message-State: APjAAAUFCwmRUnEAYfAuFmh3Wuc1zRLsglcHN3PNwnDCTtiwPxbOZ4uP
        FckvEeJeeJX+KNEsPVRixpc=
X-Google-Smtp-Source: APXvYqxXOCrgGL6D/EiQqmJ8Z0X+5hRA7oPRVgi4k2IF91Zl4z7AINE3kaOaDElLnzGCqpXfSWuaKA==
X-Received: by 2002:a63:ff5c:: with SMTP id s28mr99938380pgk.196.1578147283228;
        Sat, 04 Jan 2020 06:14:43 -0800 (PST)
Received: from nishad ([106.51.232.103])
        by smtp.gmail.com with ESMTPSA id m6sm18310663pjn.21.2020.01.04.06.14.40
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 04 Jan 2020 06:14:42 -0800 (PST)
Date:   Sat, 4 Jan 2020 19:44:36 +0530
From:   Nishad Kamdar <nishadkamdar@gmail.com>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Joe Perches <joe@perches.com>
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Subject: [PATCH] slimbus: Use the correct style for SPDX License Identifier
Message-ID: <20200104141433.GA3684@nishad>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch corrects the SPDX License Identifier style in
header file related to SLIMbus driver.
For C header files Documentation/process/license-rules.rst
mandates C-like comments (opposed to C source files where
C++ style should be used).

Changes made by using a script provided by Joe Perches here:
https://lkml.org/lkml/2019/2/7/46.

Suggested-by: Joe Perches <joe@perches.com>
Signed-off-by: Nishad Kamdar <nishadkamdar@gmail.com>
---
 drivers/slimbus/slimbus.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/slimbus/slimbus.h b/drivers/slimbus/slimbus.h
index b2f013bfe42e..c73035915f1d 100644
--- a/drivers/slimbus/slimbus.h
+++ b/drivers/slimbus/slimbus.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0
+/* SPDX-License-Identifier: GPL-2.0 */
 /*
  * Copyright (c) 2011-2017, The Linux Foundation
  */
-- 
2.17.1

