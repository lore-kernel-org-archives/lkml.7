Return-Path: <SRS0=wETr=XU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AB37C432C1
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Sep 2019 07:25:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 064A8222CC
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Sep 2019 07:25:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mBo1BAtZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2442591AbfIYHZo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Sep 2019 03:25:44 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:34107 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2442580AbfIYHZn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Sep 2019 03:25:43 -0400
Received: by mail-pf1-f194.google.com with SMTP id b128so2870488pfa.1
        for <linux-kernel@vger.kernel.org>; Wed, 25 Sep 2019 00:25:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=TZNqrj2QAxEBu1qPwHKDkmLtrJOXHa9jCvlD2ZZka3c=;
        b=mBo1BAtZL6GrTwty97MNeDEPjs8uwwAm14qDPoFYx8spNht6JtGdyWIqeG2yPmg/W+
         emqstlxrZLFUUcnypW4AJXbArR7CItrZoB1aMut8+X8o9ePxHvzTRgW/SEo4pAP3YUdY
         8i797GXfJQaCzAqxHilVpENjxgoiNY8Kfk+nv7rkeyfD1iJi/lgqGfX/+vDlCHuJK46M
         AOXDJCgwP8DXQsQh0c/g2owQuyJyWjq2Wfzbs9JDSQ40bJjLcRNEq0RRb63KBcLzAFmN
         FWFg+WmXOu/9Q+lE5dOsWvwhceWXOnMnNBkyBGLZR2gBK8sL78c/3/j62f5bI5cNf4wu
         pJzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=TZNqrj2QAxEBu1qPwHKDkmLtrJOXHa9jCvlD2ZZka3c=;
        b=Fhf2AXKGvqekwZHQ83LIN7GjiSy0UuQ0xBZq5WMhgiIWFNIR1zcA3UrO+MioWsQfWs
         kK0aeIsUWvApjR7XbZcxor9zGq8Wv8JuXmit7AkFAqd1SbkqOllH1UKwpsesCThygXF7
         MiitTGEh/bsFbWFwpbt+NRx/RzPb7GOc8kBzSYWAc77RiKQ3X5RgrX9ScD7QwIT7zi16
         lBkQGnNQCBcOfnIerLrZ/7RlwFFzmEqYxTB/LFInsETd8lizmERraQOruH7JSXdSxd4U
         DphHRBg8DCogs5xMCyKNhuQt3FYALNjKtGWQFsTKVbHzGqBYvJVakS0cTTWGizt/0e4X
         c9wQ==
X-Gm-Message-State: APjAAAVmHevZoME9sUVpgpj849CKJjCI45z62qtmfu4ObMGUsEcPsTan
        gcbHHzwblviLxWCzcnDpx5Y=
X-Google-Smtp-Source: APXvYqyWbVuE1DkVBU8FfUNXH/1D2n57BNh+ll24cli6H0xYdB3fPZJo+CFBN4vMciI0JdgAQ9sgyg==
X-Received: by 2002:a63:5652:: with SMTP id g18mr7204831pgm.393.1569396342746;
        Wed, 25 Sep 2019 00:25:42 -0700 (PDT)
Received: from compute1 ([123.51.210.126])
        by smtp.gmail.com with ESMTPSA id x11sm4441028pja.3.2019.09.25.00.25.41
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 25 Sep 2019 00:25:41 -0700 (PDT)
Date:   Wed, 25 Sep 2019 15:25:33 +0800
From:   Jerry Lin <wahahab11@gmail.com>
To:     Jens Frederich <jfrederich@gmail.com>,
        Daniel Drake <dsd@laptop.org>,
        Jon Nettleton <jon.nettleton@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Jerry Lin <wahahab11@gmail.com>
Subject: [PATCH] staging: olpc_dcon: fix wrong dependencies in Kconfig file
Message-ID: <20190925072533.GA18121@compute1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To allow simultaneous support for XO-1 and XO-1.5.
This module require GPIO_CS5535 (for 1.0) and ACPI (for 1.5) now.

Reported-by: kbuild test robot <lkp@intel.com>
Signed-off-by: Jerry Lin <wahahab11@gmail.com>
---
 drivers/staging/olpc_dcon/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/olpc_dcon/Kconfig b/drivers/staging/olpc_dcon/Kconfig
index 4ae271f..c2429e4 100644
--- a/drivers/staging/olpc_dcon/Kconfig
+++ b/drivers/staging/olpc_dcon/Kconfig
@@ -3,7 +3,7 @@ config FB_OLPC_DCON
 	tristate "One Laptop Per Child Display CONtroller support"
 	depends on OLPC && FB
 	depends on I2C
-	depends on (GPIO_CS5535 || ACPI)
+	depends on (GPIO_CS5535 && ACPI)
 	select BACKLIGHT_CLASS_DEVICE
 	help
 	  In order to support very low power operation, the XO laptop uses a
-- 
2.7.4

