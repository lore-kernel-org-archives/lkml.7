Return-Path: <SRS0=2kAr=R3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AAE4C10F00
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Mar 2019 17:23:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 169FE20989
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Mar 2019 17:23:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X1l4eVYW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728982AbfCXRXR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 24 Mar 2019 13:23:17 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:45016 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728937AbfCXRXN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Mar 2019 13:23:13 -0400
Received: by mail-wr1-f67.google.com with SMTP id y7so3385681wrn.11;
        Sun, 24 Mar 2019 10:23:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ED3pLe1LnHDziRi/Md+Bh+xg/BP/S3ty+eLHfEb+f/g=;
        b=X1l4eVYWg/oL2BQyywN7YHXqI6aYwhLkcGgzpSS4tprkBAcRBa9PQ13Peyti+ee4CC
         PpGYt9h8qdWFwGxsV+dV5GdGa40t7Qdta9vzCp00adR7NyvAZwzTrl7nCxP1TA9mOCmg
         ETXymG7QfRf1oYtkUTnHglmlZ76uUSW3F6qCM5SlCDWe7+O2l5rbyNXrVHwy3odbJ1dD
         vpxJa62ovJlGLxMv578HNUzHfktpGdn8kY7Mxwk8f3RRCXjUuxibUNhbYVawzlHvUvP7
         DtZ73DEKNZT4g3W5wiQLyaEnbh+GHi0CDLkdTNmyFYX4JYkIOQZD/JBbBcZN2jaA8yaO
         fmxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ED3pLe1LnHDziRi/Md+Bh+xg/BP/S3ty+eLHfEb+f/g=;
        b=a7lhOO0epyLyFv9oVlVarfoghqyzfvgWiOM+gKdW9xFzKnRCCqf6fMPt+oiFSQIqOR
         PPB2fBl8+zrMZksf59SmHP8xsm2NV1UA6146eVEuoEcU6BtH213YizVq0M+FaWOvDv4/
         67BtN8cjEzeuoc+bc09TDMOcJAOvtbBY5ZJ76J1jjHX3GYvOkDoPkBxkJsocARJ7TqR6
         sBFiGtulTh0Ax5RdChJSgrdt1qYAIZ/zt8oJjGHj3Hemf0bgSPIS7GwCVzzS8xdfZZkM
         JhrRdlrtjOJgoST0Zlc1h/HHfPDcOpnaSkFwYAwlGil6OblCvWts1t9KiJA4X86EbrfN
         KPXw==
X-Gm-Message-State: APjAAAV0+8ny+VlnwJw/XM5Dhw4Oe2v0I94a32gsCreotVBXBwv/N9ze
        mGIhPDahYYBqKv6CV9gijLU=
X-Google-Smtp-Source: APXvYqwkQgLnlyEuDKyjAguhMwcqmG0Ls+mAZdb4fJOuT803FOOOXhVY0eS08GMW/T8+CKEKIf6dJg==
X-Received: by 2002:adf:dcce:: with SMTP id x14mr2834243wrm.315.1553448191091;
        Sun, 24 Mar 2019 10:23:11 -0700 (PDT)
Received: from peano ([87.19.116.42])
        by smtp.gmail.com with ESMTPSA id c193sm16452376wma.46.2019.03.24.10.23.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 24 Mar 2019 10:23:10 -0700 (PDT)
Date:   Sun, 24 Mar 2019 18:23:09 +0100
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
Subject: [PATCH v3 1/5] staging: iio: adc: ad7280a: Tab alignment
Message-ID: <cc87225c83ca9d0aa18598d3f3519965bbc14764.1553447138.git.sicilia.cristian@gmail.com>
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

Aligned some parameters.

Signed-off-by: Cristian Sicilia <sicilia.cristian@gmail.com>
---
 drivers/staging/iio/adc/ad7280a.c | 36 ++++++++++++++++++------------------
 1 file changed, 18 insertions(+), 18 deletions(-)

diff --git a/drivers/staging/iio/adc/ad7280a.c b/drivers/staging/iio/adc/ad7280a.c
index d9df126..571535d 100644
--- a/drivers/staging/iio/adc/ad7280a.c
+++ b/drivers/staging/iio/adc/ad7280a.c
@@ -830,30 +830,30 @@ static irqreturn_t ad7280_event_handler(int irq, void *private)
 }
 
 static IIO_DEVICE_ATTR_NAMED(in_thresh_low_value,
-		in_voltage-voltage_thresh_low_value,
-		0644,
-		ad7280_read_channel_config,
-		ad7280_write_channel_config,
-		AD7280A_CELL_UNDERVOLTAGE);
+			     in_voltage-voltage_thresh_low_value,
+			     0644,
+			     ad7280_read_channel_config,
+			     ad7280_write_channel_config,
+			     AD7280A_CELL_UNDERVOLTAGE);
 
 static IIO_DEVICE_ATTR_NAMED(in_thresh_high_value,
-		in_voltage-voltage_thresh_high_value,
-		0644,
-		ad7280_read_channel_config,
-		ad7280_write_channel_config,
-		AD7280A_CELL_OVERVOLTAGE);
+			     in_voltage-voltage_thresh_high_value,
+			     0644,
+			     ad7280_read_channel_config,
+			     ad7280_write_channel_config,
+			     AD7280A_CELL_OVERVOLTAGE);
 
 static IIO_DEVICE_ATTR(in_temp_thresh_low_value,
-		0644,
-		ad7280_read_channel_config,
-		ad7280_write_channel_config,
-		AD7280A_AUX_ADC_UNDERVOLTAGE);
+		       0644,
+		       ad7280_read_channel_config,
+		       ad7280_write_channel_config,
+		       AD7280A_AUX_ADC_UNDERVOLTAGE);
 
 static IIO_DEVICE_ATTR(in_temp_thresh_high_value,
-		0644,
-		ad7280_read_channel_config,
-		ad7280_write_channel_config,
-		AD7280A_AUX_ADC_OVERVOLTAGE);
+		       0644,
+		       ad7280_read_channel_config,
+		       ad7280_write_channel_config,
+		       AD7280A_AUX_ADC_OVERVOLTAGE);
 
 static struct attribute *ad7280_event_attributes[] = {
 	&iio_dev_attr_in_thresh_low_value.dev_attr.attr,
-- 
2.7.4

