Return-Path: <SRS0=2kAr=R3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DE6EC43381
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Mar 2019 17:23:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CAF492171F
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Mar 2019 17:23:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Lu99opTI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729022AbfCXRXT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 24 Mar 2019 13:23:19 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:42817 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728957AbfCXRXR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Mar 2019 13:23:17 -0400
Received: by mail-wr1-f67.google.com with SMTP id g3so4010130wrx.9;
        Sun, 24 Mar 2019 10:23:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=7DhGDsGo/YAGKvuME1SMmCwXXgvDVGGsI7+JJ7P7wa4=;
        b=Lu99opTIj+vJ0tNmWilBpH/DmlKhYKTT2BZPP3SX5CSCCB3C26kgVGW54QK50DKoeA
         QrCgC37fi341aNjvcgHL77cBxP07aozJAFPEpXmBe6pFc2zHaGI6bxCZSMHFDub9SqTS
         SvwWhCkl3jJyDm4UZC6iQ+L+bTK9SS1DqDagGh02hi3a/IHlkPXcfasGqfWBKrVjtnpK
         gha8akMEwFcehyQijQcYespkSpOKA8L3l0Zs3Ty4alAGQAnqFaKN4tyaHZOjn0NEZ0gD
         NJ0Rcl2wHt4x0F69RPST1pQl7th5yTkIQ1KhJXpPai+qD+FCLgL+/sQjyrngOwZzj4Th
         dfPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=7DhGDsGo/YAGKvuME1SMmCwXXgvDVGGsI7+JJ7P7wa4=;
        b=ITpk7gaJPSJFQohONAYG5BMlGoZbHcwZGq1VFEGCmsQW9Xfsu3QNhkbcm+4VparmBI
         cv+gyoTM4qWTkScaWg7l04of3rs/p8U8O+q5BOTNUfXg7AqCaYzsdTaXyu25ABLcHEMe
         F3Iq27Y69gObB1fxc82vrBS67FjZW1z446a6lsMg6z+iM2o0Y0EU3svP4owD1G2iZAWp
         JW2DJ2rdtR9KJxutepR7L16JeHD0bmprX1qPt51E+X9z0asBTuKAv+7OAwVpC0zIM1xD
         sQnEjtFTZt0MkF3t5Ch4K40y74mQNQAe0kpzStmUEFgfwdP5Uqp4G903W1AWzxOK5F+x
         wNzA==
X-Gm-Message-State: APjAAAV1R+n5aBIb7S6HcCnF3Vx/43s7K2DVBTtMj4811M0x2/ZsdIzr
        IiOZd2EnXIPJ9qucScqUfec=
X-Google-Smtp-Source: APXvYqyFJ3RhDxY0uIk2i1ZbzQYLRYQVwmiArUmygxw3fMDBTj1+7z0sj8ZS2tHBi+CzSp4VjiHU3g==
X-Received: by 2002:a5d:5287:: with SMTP id c7mr13669110wrv.127.1553448194599;
        Sun, 24 Mar 2019 10:23:14 -0700 (PDT)
Received: from peano ([87.19.116.42])
        by smtp.gmail.com with ESMTPSA id 7sm49392763wrc.81.2019.03.24.10.23.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 24 Mar 2019 10:23:14 -0700 (PDT)
Date:   Sun, 24 Mar 2019 18:23:12 +0100
From:   Cristian Sicilia <sicilia.cristian@gmail.com>
To:     Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 3/5] staging: iio: adc: ad7280a: Avoid precedence issues
 in macro
Message-ID: <5e81974355d8de3cdb3c7bc1d4b0cc0fab691872.1553447138.git.sicilia.cristian@gmail.com>
References: <cover.1553366098.git.sicilia.cristian@gmail.com>
 <cover.1553447138.git.sicilia.cristian@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1553447138.git.sicilia.cristian@gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enclosing parameter with parenthesis due to avoid
possible precedence issue.

Signed-off-by: Cristian Sicilia <sicilia.cristian@gmail.com>
---
 drivers/staging/iio/adc/ad7280a.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/iio/adc/ad7280a.c b/drivers/staging/iio/adc/ad7280a.c
index 571535d..c2391f6 100644
--- a/drivers/staging/iio/adc/ad7280a.c
+++ b/drivers/staging/iio/adc/ad7280a.c
@@ -97,9 +97,10 @@
 #define AD7280A_NUM_CH			(AD7280A_AUX_ADC_6 - \
 					AD7280A_CELL_VOLTAGE_1 + 1)
 
-#define AD7280A_CALC_VOLTAGE_CHAN_NUM(d, c) ((d * AD7280A_CELLS_PER_DEV) + c)
-#define AD7280A_CALC_TEMP_CHAN_NUM(d, c)    ((d * AD7280A_CELLS_PER_DEV) + \
-					     c - AD7280A_CELLS_PER_DEV)
+#define AD7280A_CALC_VOLTAGE_CHAN_NUM(d, c) (((d) * AD7280A_CELLS_PER_DEV) + \
+					     (c))
+#define AD7280A_CALC_TEMP_CHAN_NUM(d, c)    (((d) * AD7280A_CELLS_PER_DEV) + \
+					     (c) - AD7280A_CELLS_PER_DEV)
 
 #define AD7280A_DEVADDR_MASTER		0
 #define AD7280A_DEVADDR_ALL		0x1F
-- 
2.7.4

