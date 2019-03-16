Return-Path: <SRS0=b0IM=RT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_NEOMUTT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB863C10F00
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Mar 2019 02:13:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AA17521871
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Mar 2019 02:13:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z31pZ43v"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727063AbfCPCNU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Mar 2019 22:13:20 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:41820 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726444AbfCPCNU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Mar 2019 22:13:20 -0400
Received: by mail-qt1-f193.google.com with SMTP id w30so6969033qta.8;
        Fri, 15 Mar 2019 19:13:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=EW53I3tp34rqtQ/MxyH8jsvT9bUM1N0O3iRAvZzkV/I=;
        b=Z31pZ43v3zmFMa+52uuvPtWcEq5rQS55LJv3qM8rd3Pnm24SU5/dHfU/n4QegNmJCV
         R5j/FKnQo8Z5g7iyV6a7ziYPdKODmyrgKzxG+I9jVeYqSJAt6f7TD4U3mJq/2DjGJxtk
         bd0qBTnZVB9+DhE8byT2Qb+cFboXZF1i54EzLnVB61qq8rUrL9c7sih8AN1FJGHKYnpZ
         LQEXPOKXMzo5lft5CjYRLr1eRHd+HArLD/BgBKijHVkwfVvIOGQkonW5maBI8AkID4Sn
         Vcyk7n03MiCJ+BrbMBlxP5QYfyWqeY+GD+5J8LdkvduiM1FYlkS78K+uRW6AgIdP23cZ
         ciyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=EW53I3tp34rqtQ/MxyH8jsvT9bUM1N0O3iRAvZzkV/I=;
        b=c4TMo/SHcgiB5wWFQru5/VF+ahxhKkxBA5eB+wCzV6slU2nx4qe8gZmrxZVXMwrmIF
         NTXYKx4pt76MCvwivxNh5EdsKkYmfRPK7n5mqQSL9Xu+AtwORsdJTMgtCXxfVca/NmwZ
         rvBrNizEugktc0bDT2PEGozAMfViWnhJFJqEnl/E3/PDgJaraK9o/C0jV7UKyhYTn+HX
         SQ5/5S8tiaRbYpyacyqVl455aBDkm0oZB7275kJkL+bJWgG7eqlUuPs5Bs2bgXGfI1IA
         q6SZaqOTpWn9yisHWXK5YgAJWtldWqEF2A+rOShfZdWFO7MqzZKNgYi9WC+PPcefU87y
         avYA==
X-Gm-Message-State: APjAAAX5KEGtRnfWpWwx2kQWsUfv+lNsbGo/nFcJPxnYGx5D+ftLE+tP
        vYzd7q1Hs7cvKP6ekue0xK4=
X-Google-Smtp-Source: APXvYqzC3y/u8oW7CZ5EAA75ZsRiDj9ppDu78YognyI5EIZQkNWrlxnP+dp00F4TD7prq+S3r4ip0Q==
X-Received: by 2002:ac8:1bc6:: with SMTP id m6mr5104987qtk.8.1552702399222;
        Fri, 15 Mar 2019 19:13:19 -0700 (PDT)
Received: from renatolg ([186.220.21.102])
        by smtp.gmail.com with ESMTPSA id d8sm1774846qtp.50.2019.03.15.19.13.15
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 15 Mar 2019 19:13:19 -0700 (PDT)
Date:   Fri, 15 Mar 2019 23:13:13 -0300
From:   Renato Lui Geh <renatogeh@gmail.com>
To:     lars@metafoo.de, Michael.Hennerich@analog.com, jic23@kernel.org,
        knaack.h@gmx.de, pmeerw@pmeerw.net, gregkh@linuxfoundation.org,
        stefan.popa@analog.com, alexandru.Ardelean@analog.com,
        giuliano.belinassi@usp.br, robh+dt@kernel.org, mark.rutland@arm.com
Cc:     linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, kernel-usp@googlegroups.com,
        devicetree@vger.kernel.org
Subject: [PATCH v5 03/11] staging: iio: ad7780: add gain reading to ad778x
Message-ID: <aed4d900061c5733decc429d0d0816122dba0991.1552700652.git.renatogeh@gmail.com>
References: <cover.1552700652.git.renatogeh@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
In-Reply-To: <cover.1552700652.git.renatogeh@gmail.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds a new functionality of reading gain values from the
ad778x chips. This value is stored in the chip's state struct and is
updated whenever a read or write call is performed on the driver.

Signed-off-by: Renato Lui Geh <renatogeh@gmail.com>
---
 drivers/staging/iio/adc/ad7780.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/staging/iio/adc/ad7780.c b/drivers/staging/iio/adc/ad7780.c
index f4cd7bc3e02f..fbcc0d3345ca 100644
--- a/drivers/staging/iio/adc/ad7780.c
+++ b/drivers/staging/iio/adc/ad7780.c
@@ -42,6 +42,8 @@
 #define AD7780_GAIN_MIDPOINT	64
 #define AD7780_FILTER_MIDPOINT	13350
 
+static const unsigned int ad778x_gain[2] = { 1, 128 };
+
 struct ad7780_chip_info {
 	struct iio_chan_spec	channel;
 	unsigned int		pattern_mask;
@@ -179,6 +181,9 @@ static int ad7780_postprocess_sample(struct ad_sigma_delta *sigma_delta,
 	    ((raw_sample & chip_info->pattern_mask) != chip_info->pattern))
 		return -EIO;
 
+	if (chip_info->is_ad778x)
+		st->gain = ad778x_gain[raw_sample & AD7780_GAIN];
+
 	return 0;
 }
 
-- 
2.21.0

