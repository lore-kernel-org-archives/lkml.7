Return-Path: <SRS0=q9dy=R2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1B2EC43381
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Mar 2019 19:21:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6D8FE2183E
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Mar 2019 19:21:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V+lbCYnA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728028AbfCWTV4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 23 Mar 2019 15:21:56 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:41050 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727992AbfCWTVw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Mar 2019 15:21:52 -0400
Received: by mail-wr1-f65.google.com with SMTP id p1so5789347wrs.8;
        Sat, 23 Mar 2019 12:21:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=sPOAJ9vL8DU/xUjWj8EP8edXqBAmU66fIW2knqs1718=;
        b=V+lbCYnAwY/h04/Zvl1drG8lfzpELzkN2oT/tMqAANoavCxze8psTI+8vCMxxobpIA
         SyidnLDjayUg50UOsQr68MsD4BKDQJJ4M0G5w7aU016oGUDT0ijxcRuxwIb8NKIhGbdh
         8e1RhE7lIYdwP04apMHzhLukDcnX6bHjfWFE6Th1hZWlXeCv5ftXHgZleazvPz6pmyTm
         o6XlrPvPdVxuNQQOo18cx9XX3LqKBpt9gDTP4ISyGHbGORqVcPbZnQDY3lOLT8oao4eJ
         TH79Zxw7jiF5I5j/oSaZPBfHgCu639gUZxv6z7RUpSRz/oKfFGqsgtoHDddBIzQbLgqn
         UNQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=sPOAJ9vL8DU/xUjWj8EP8edXqBAmU66fIW2knqs1718=;
        b=AySx5mhYebwgxsC3vVFlu6PhJ9t6rmPXy4p5lSPHWKX2gbT6HweDE+zkgKZEOtrEtd
         MKPdmzrlLE4HXDphAZTAQVg0sMXQU4o5mdSddGXhTZdw/r2vY87Osi6pZgaijdG778Pz
         tWWC4lNj6ZbHL2T6fD+dRIfpOr0CY8ywSQ8V43Jxlc9M9maz3SIC2xktOjmJBqnwCeJh
         KG7MoxirVMXUrLOefg0Gqcl8QwdfDBkVk37CBnLJ1AMV02fmvjIioQ0ZekprHuChhn5y
         aG8pP2OIJtDUxk/KPun4lBHd6CiBAL0/O0NmTDO+jPuvutXLDBQoDxyqASK2FCFVdJcD
         Kywg==
X-Gm-Message-State: APjAAAX/eNcPoBacL/HECwexOexNninOcgSp88s2IUOL6uNLOgR/rZSO
        kCWBOEbolaJWKAcnoU3vDPk=
X-Google-Smtp-Source: APXvYqypSk6ArhDszUebngbYXDWZ+SphioAqHfYwS5eOprH6FJbotK+w05qWUVEg97mubWk7HUYxMA==
X-Received: by 2002:a05:6000:12c8:: with SMTP id l8mr10116627wrx.80.1553368911097;
        Sat, 23 Mar 2019 12:21:51 -0700 (PDT)
Received: from peano ([87.19.116.42])
        by smtp.gmail.com with ESMTPSA id h2sm16665789wro.11.2019.03.23.12.21.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 23 Mar 2019 12:21:50 -0700 (PDT)
Date:   Sat, 23 Mar 2019 20:21:49 +0100
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
Subject: [PATCH v2 5/5] staging: iio: adc: Remove CamelCase notation
Message-ID: <e1a9e28d72babe4781c577c68e6508e01367943f.1553366098.git.sicilia.cristian@gmail.com>
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

Fix CamelCase naming.

Signed-off-by: Cristian Sicilia <sicilia.cristian@gmail.com>
---
 drivers/staging/iio/adc/ad7280a.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/drivers/staging/iio/adc/ad7280a.c b/drivers/staging/iio/adc/ad7280a.c
index 5d848aa..c02454c 100644
--- a/drivers/staging/iio/adc/ad7280a.c
+++ b/drivers/staging/iio/adc/ad7280a.c
@@ -917,8 +917,8 @@ static int ad7280_probe(struct spi_device *spi)
 	const struct ad7280_platform_data *pdata = dev_get_platdata(&spi->dev);
 	struct ad7280_state *st;
 	int ret;
-	const unsigned short tACQ_ns[4] = {465, 1010, 1460, 1890};
-	const unsigned short nAVG[4] = {1, 2, 4, 8};
+	const unsigned short t_acq_ns[4] = {465, 1010, 1460, 1890};
+	const unsigned short n_avg[4] = {1, 2, 4, 8};
 	struct iio_dev *indio_dev;
 
 	indio_dev = devm_iio_device_alloc(&spi->dev, sizeof(*st));
@@ -966,10 +966,9 @@ static int ad7280_probe(struct spi_device *spi)
 	 */
 
 	st->readback_delay_us =
-		((tACQ_ns[pdata->acquisition_time & 0x3] + 695) *
-		(AD7280A_NUM_CH * nAVG[pdata->conversion_averaging & 0x3]))
-		- tACQ_ns[pdata->acquisition_time & 0x3] +
-		st->slave_num * 250;
+		((t_acq_ns[pdata->acquisition_time & 0x3] + 695) *
+		 (AD7280A_NUM_CH * n_avg[pdata->conversion_averaging & 0x3])) -
+		t_acq_ns[pdata->acquisition_time & 0x3] + st->slave_num * 250;
 
 	/* Convert to usecs */
 	st->readback_delay_us = DIV_ROUND_UP(st->readback_delay_us, 1000);
-- 
2.7.4

