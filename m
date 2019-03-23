Return-Path: <SRS0=q9dy=R2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EF26C43381
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Mar 2019 19:22:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2F9882183E
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Mar 2019 19:22:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="s/yH6WI+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727953AbfCWTVu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 23 Mar 2019 15:21:50 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:37939 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727880AbfCWTVq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Mar 2019 15:21:46 -0400
Received: by mail-wr1-f68.google.com with SMTP id g12so5814203wrm.5;
        Sat, 23 Mar 2019 12:21:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=FJUzo17mizqgSIFXopeV0NTSnrdioOo9EKUBALEoNaY=;
        b=s/yH6WI+KEj31wuYwRe8SJXbsy26mdjNpSf3CPGsE7uEgaAvn75Ypeo4g/Ft49h87v
         KZRycgqGzaUktONfMBDPgcJIsWzuqRJAIs4KuZtybQhhoKz0/QF7xLpz1+oXdGiBiLxJ
         lxVhwyun/UDn7MobC+BKauN0eii5q48+lRUqBSZJoxlxalUjPSq9f/ZfOYViqHMBawae
         9k3zk2GJDZSr8JFfng416hOerkDbRLq2EHpBjPr0mBBKX0TSJDNLmbakBrmdLKPsnJLv
         rwQ+umAal9sdEi+DfhCsmB3Kr6NFML/6WoctU+7NQGMuA7C59o7Y9VGPvk9WsXT+tZ/A
         NH+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=FJUzo17mizqgSIFXopeV0NTSnrdioOo9EKUBALEoNaY=;
        b=inTaA62j4EvU36gGbqYtvQRVA+YVv6cqMgQ2UGKzt53PviE59Uk9xd/z6xznP/H+Cz
         jD9sbna9JgWxtjZMbBSVib/kU3ZQxIA5SfmmQ4f5HiAuIRnhBEXKAM7R9UJzltfpkjcm
         AxAgWsW0bZM3HWqanCmhfEDQxtNOtZf8j4ffm2dLJ/1PGA/KDCqdL+cUWCKi9uCTCnop
         ndektMXQzWhM6E0CfMH3y1vNiC8NZS7X/ky7vFlng3MiGSTaYefh/+dRIH88gVC3vqUQ
         HqMJOK89GzZMdWFmMkNpryasbgdalQgRoBVhPOHW3gic0zS/VQ7iP2baVBjPnU5B7x5Z
         97rQ==
X-Gm-Message-State: APjAAAXaMXHFCbJmJbj9jTdOuMq4USNfdXGCEWYv2lrkaYNCHLqD3DkX
        kj9gteIpEDAh4Bp6Du2Qhgc=
X-Google-Smtp-Source: APXvYqzZRofnjR7vhGY58rmBF2mdYEYkLzJ6fd5U3sZXXd/dv1hVq5Bub9nLmCU6+t481R1A0hWlvw==
X-Received: by 2002:a5d:63c5:: with SMTP id c5mr8977875wrw.82.1553368904427;
        Sat, 23 Mar 2019 12:21:44 -0700 (PDT)
Received: from peano ([87.19.116.42])
        by smtp.gmail.com with ESMTPSA id b204sm8250761wmh.29.2019.03.23.12.21.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 23 Mar 2019 12:21:43 -0700 (PDT)
Date:   Sat, 23 Mar 2019 20:21:42 +0100
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
Subject: [PATCH v2 3/5] staging: iio: adc: Avoid precedence issues in macro
Message-ID: <e57e377b86436d4c15ee7c1e6142acd0fded703d.1553366098.git.sicilia.cristian@gmail.com>
References: <cover.1553335775.git.sicilia.cristian@gmail.com>
 <cover.1553366098.git.sicilia.cristian@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1553366098.git.sicilia.cristian@gmail.com>
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
index 55b5879..d81a5bd 100644
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

