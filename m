Return-Path: <SRS0=wETr=XU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34DA6C432C1
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Sep 2019 07:42:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 032262054F
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Sep 2019 07:42:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GoMqTIie"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394961AbfIYHmw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Sep 2019 03:42:52 -0400
Received: from mail-pg1-f181.google.com ([209.85.215.181]:36590 "EHLO
        mail-pg1-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2393596AbfIYHmw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Sep 2019 03:42:52 -0400
Received: by mail-pg1-f181.google.com with SMTP id t14so2306652pgs.3
        for <linux-kernel@vger.kernel.org>; Wed, 25 Sep 2019 00:42:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=puF3UNYaJSZMgESC66NJjpK9rhx4xQJhi0e+qQB9l2E=;
        b=GoMqTIieZ8SyZHDOYFDZjiSJ1Q0+ttpr9XBdWpqkHXC6f8iZwjejVQjwmtF1e/eR9S
         KYPnjF4TqQZExSS1xQIRCwTipc8F67nVv5gUt7Q5OMlBxnnsObBkGXCyso/3AtYfEt18
         NIxfXNPEDTWz2Xf+AyKsf6GzKFnXNrWmd0XmactZH8lcp6ijuCho5QQ7a9MR6YQ71T1C
         oTwPL62B057CtHlSR8s9d3wVve2pMp33fX/DTCO6x0DBTrJvftT00eAn3pCjHlCx63EN
         WybPM5C2BnK42hdPz8HPg41fl6/t1ZvzKjJaKGm5DNSRzsCiGRurK4pwPZtcNWS1hsiw
         DCIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=puF3UNYaJSZMgESC66NJjpK9rhx4xQJhi0e+qQB9l2E=;
        b=XQjooS+w28y5Za8Ebcn0BYHlzSWPuPxcOOy1h3R7H8pdS2bqzRWxZNLEG1A/HHPbNf
         QhYgQNc5Ii+oLLiyx7t9sZ4s/I7/0eLx7Xp9Rv1QkwBZDmLSIjfOvJ9vEY8UsuSv3g03
         JM2E/zPT9NUxh+001/s8FX+TcWa7HDLQ7Rs2Z940LdRt2bdiJvmGJhdo7syqETUSZLmG
         WXWrloQyro+KwSSR8IyXy/r+25JGl9/XyQ0fKhoA91qBaoBto1I42UCJ2np5Y+7rrwgY
         iWoheT7i8mSWUypH9nAC2gKFfQaOz+V5is5qTfQFszah/nT9//Hhu+BiOMlKL9lPU0Pk
         OTpQ==
X-Gm-Message-State: APjAAAWU6atsHCx2WesVH+5WO3FfK7exnImMvScfZz0kZkyOzs+C0VQ8
        Rep5Z7X5/vU3H5jD8C5/WyQ=
X-Google-Smtp-Source: APXvYqwUSHV12jCHjZxOw7gvGkcSMh0LGzZ9s7Q+jQ9p7Rthi1qBOlQRrXjdXbDjtrSI4faXBe7oZA==
X-Received: by 2002:a62:27c3:: with SMTP id n186mr8057476pfn.58.1569397371038;
        Wed, 25 Sep 2019 00:42:51 -0700 (PDT)
Received: from compute1 ([210.200.12.126])
        by smtp.gmail.com with ESMTPSA id l189sm4896907pgd.46.2019.09.25.00.42.49
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 25 Sep 2019 00:42:50 -0700 (PDT)
Date:   Wed, 25 Sep 2019 15:42:43 +0800
From:   Jerry Lin <wahahab11@gmail.com>
To:     Jens Frederich <jfrederich@gmail.com>,
        Daniel Drake <dsd@laptop.org>,
        Jon Nettleton <jon.nettleton@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Jerry Lin <wahahab11@gmail.com>
Subject: [PATCH v2] staging: olpc_dcon: fix wrong dependencies in Kconfig file
Message-ID: <20190925074243.GA24947@compute1>
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
Changes in v2:
    - Remove the parentheses
---
 drivers/staging/olpc_dcon/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/olpc_dcon/Kconfig b/drivers/staging/olpc_dcon/Kconfig
index 4ae271f..d1a0dea 100644
--- a/drivers/staging/olpc_dcon/Kconfig
+++ b/drivers/staging/olpc_dcon/Kconfig
@@ -3,7 +3,7 @@ config FB_OLPC_DCON
 	tristate "One Laptop Per Child Display CONtroller support"
 	depends on OLPC && FB
 	depends on I2C
-	depends on (GPIO_CS5535 || ACPI)
+	depends on GPIO_CS5535 && ACPI
 	select BACKLIGHT_CLASS_DEVICE
 	help
 	  In order to support very low power operation, the XO laptop uses a
-- 
2.7.4

