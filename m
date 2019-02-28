Return-Path: <SRS0=g5d9=RD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44A01C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 14:25:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 131052171F
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 14:25:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D1at2AIp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732813AbfB1OZD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Feb 2019 09:25:03 -0500
Received: from mail-qt1-f193.google.com ([209.85.160.193]:46762 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726027AbfB1OZC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Feb 2019 09:25:02 -0500
Received: by mail-qt1-f193.google.com with SMTP id z25so23591916qti.13;
        Thu, 28 Feb 2019 06:25:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=JlOPTet1jflBzo+5BdxF8+Muf08K1vBJXDoi85DvXoE=;
        b=D1at2AIpfc4kQH9PDPQ7Hu+KVHj75AmMkEbR48B5PmKzB21NL+YaM/YbuU1NgyXguE
         MpacssVkC+snup9EkdUDD59MyG/u6NQfg8Tc3xMw2u10WC4jb/lnhrBuVIPBCj9QN5jW
         L7DK8cp58FC0QDc4p0gsuhOZU4hwvj/wie0rIolWWFo9yL/4+v7+bdi+x4iIJKiR1NYp
         Rnzrr9XE7nltNUiZjJ84wV4VF+lN3V0x5MUZ3yPudPlxdB0szmop3brD2qBevAFj5xkm
         fCvas5JWXMGI8TG/e9SAL9sjtwPD2kBIEP0IA/Dllz0+PT0UXN/qVmlvvUlfNRy5/shA
         yhgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=JlOPTet1jflBzo+5BdxF8+Muf08K1vBJXDoi85DvXoE=;
        b=K+I47oz2jTTD+t9ARSdpUxjBsxXplaEWLhTLMI2OSY/j0KbOEzp91RRyOb32Tb/Ahd
         399JFoUD9c2OOyl5+m+QkTf63tDlZ9QradeBUv7m0jlyfdwsTDuu8Q5RatbVDJScNYdX
         qiaQM2WlgmWjdkCP3Be0j8/m1wKEg6xQfRCH9KHHcAL30ElMw7nTeU5tyvNU3E14mrVy
         XJz12xrxiMHV/sfRlWVe3Qf0Y5/j/gKy3YobDsxyLCcS6QU87XSd/XgIYoZdgDNiftk4
         pB8755NCtMAl9Tw2uPo/V+1hKKPwP8OeLauwhHZz/B9O/Veu5wAQUVrtnn0qMCjDNEz3
         MZ7Q==
X-Gm-Message-State: AHQUAuZ0670Vt8rVPACX4wghKzWnLDVNLPloUUgR3KMasb5/bWTwtIra
        GsbHkrEfPQzOsuXf6H0fDxA=
X-Google-Smtp-Source: AHgI3IbNBQSWJZ7YL9OnkX9z4vP0Vihqwk9J8bKDwKdnWuks71j/SYxjKVcOlli3gz3ODWhqUMTQmQ==
X-Received: by 2002:ac8:3474:: with SMTP id v49mr6334393qtb.132.1551363901206;
        Thu, 28 Feb 2019 06:25:01 -0800 (PST)
Received: from renatolg ([143.107.45.1])
        by smtp.gmail.com with ESMTPSA id e4sm10608705qta.84.2019.02.28.06.24.57
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 28 Feb 2019 06:25:00 -0800 (PST)
Date:   Thu, 28 Feb 2019 11:24:55 -0300
From:   Renato Lui Geh <renatogeh@gmail.com>
To:     lars@metafoo.de, Michael.Hennerich@analog.com, jic23@kernel.org,
        knaack.h@gmx.de, pmeerw@pmeerw.net, gregkh@linuxfoundation.org,
        stefan.popa@analog.com, alexandru.Ardelean@analog.com,
        giuliano.belinassi@usp.br, robh+dt@kernel.org, mark.rutland@arm.com
Cc:     linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, kernel-usp@googlegroups.com,
        devicetree@vger.kernel.org
Subject: [PATCH v4 4/9] staging:iio:ad7780: add chip ID values and mask
Message-ID: <90c573cd53bb54d49de6ac270bcff66880ccfeb5.1551358569.git.renatogeh@gmail.com>
References: <cover.1551358569.git.renatogeh@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
In-Reply-To: <cover.1551358569.git.renatogeh@gmail.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The ad7780 supports both the ad778x and ad717x families. Each chip has
a corresponding ID. This patch provides a mask for extracting ID values
from the status bits and also macros for the correct values for the
ad7170, ad7171, ad7780 and ad7781.

Signed-off-by: Renato Lui Geh <renatogeh@gmail.com>
---
 drivers/staging/iio/adc/ad7780.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/iio/adc/ad7780.c b/drivers/staging/iio/adc/ad7780.c
index 56c49e28f432..ad7617a3a141 100644
--- a/drivers/staging/iio/adc/ad7780.c
+++ b/drivers/staging/iio/adc/ad7780.c
@@ -26,10 +26,14 @@
 #define AD7780_RDY		BIT(7)
 #define AD7780_FILTER		BIT(6)
 #define AD7780_ERR		BIT(5)
-#define AD7780_ID1		BIT(4)
-#define AD7780_ID0		BIT(3)
 #define AD7780_GAIN		BIT(2)
 
+#define AD7170_ID		0
+#define AD7171_ID		1
+#define AD7780_ID		1
+#define AD7781_ID		0
+
+#define AD7780_ID_MASK		(BIT(3) | BIT(4))
 
 #define AD7780_PATTERN_GOOD	1
 #define AD7780_PATTERN_MASK	GENMASK(1, 0)
-- 
2.21.0

