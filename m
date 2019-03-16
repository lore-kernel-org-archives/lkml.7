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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51F83C10F00
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Mar 2019 02:13:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 17711218D4
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Mar 2019 02:13:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Pg5kgU/s"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726971AbfCPCM7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Mar 2019 22:12:59 -0400
Received: from mail-yw1-f67.google.com ([209.85.161.67]:41735 "EHLO
        mail-yw1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726444AbfCPCM6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Mar 2019 22:12:58 -0400
Received: by mail-yw1-f67.google.com with SMTP id q128so8779051ywg.8;
        Fri, 15 Mar 2019 19:12:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=dEu8li9eItBxKNy+6G3jWEsYP5zwyb5Jqapt02O8WUQ=;
        b=Pg5kgU/sEUk1NP+/ox6wOZmmCOy4b+dzMtveZE7jZJKiKu9DL7TOhd1DPQVV5kLHs3
         J3A9bvy2xJPFWkHuJ8C4M0Ob82rhkH2J5cObp8H0sCSQedtRAFvwfjbJExzdFGRZH/X1
         zsRL88JngKkTDjtBB4eCRjfWSmIrWU7cf8X7GpBFyK0i/YgrkEYLbsYqA9nOZQZfTTwQ
         97dcuPvcWgZf8X+XRhwsPeq7Tg3NXlsKTmnJLWBtsZrvQrNVuJXz/UOSo/z+3I/R3xoB
         Nwowm8h8TUrNVNH8xsf0VfmAaatYZGck5ZVKu7Wh7AvHVdicx3jD7QlcTW9jzpfshgyW
         XdrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=dEu8li9eItBxKNy+6G3jWEsYP5zwyb5Jqapt02O8WUQ=;
        b=R/gtlaiOweG5NXjlUTYMOhPg6Nchs66BmJjLfT9nfd13qYypJZp1Wxqf7gxmhQgYT7
         EqG9bygdNz3+Qhzna6fn/eFpfdLI6TjYaUYc80Li6Lx49biaCjDEkx/hiJhGrvh9psId
         u+Xn814YyPkMI3p6XMhMPNUpeb9j7LZVSHXPXJPxEHKBsa1881q8UnxHHAyYSTfA2lqE
         szjE0i4Ni89elOAmYgUB3+pMu9kpdaCrsnmSr7uhAkhD69hXHkBVRP7YUmYhSePHZu3w
         mgvA6u2CHCRCWeYYIEtdlvC3yxvdBJXiFw6vZfnbOMFz29prP0+jaFARj6I7iq3zK5iF
         EQZw==
X-Gm-Message-State: APjAAAURSEdeyxHnUH9zdaMlKub1xsAJtVgncbus8Bd+GH9V500ulZl6
        dhbbmpOQzbQqxaB6RYlLans=
X-Google-Smtp-Source: APXvYqyDHN2a44MmPWfBs/tl37SUreiHypp6YEggfmZkcsVYgH4VyQLAJII9E3D63HBMsXm6k8gdnw==
X-Received: by 2002:a25:b28e:: with SMTP id k14mr5842910ybj.501.1552702377848;
        Fri, 15 Mar 2019 19:12:57 -0700 (PDT)
Received: from renatolg ([186.220.21.102])
        by smtp.gmail.com with ESMTPSA id t205sm934119ywa.34.2019.03.15.19.12.54
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 15 Mar 2019 19:12:57 -0700 (PDT)
Date:   Fri, 15 Mar 2019 23:12:53 -0300
From:   Renato Lui Geh <renatogeh@gmail.com>
To:     lars@metafoo.de, Michael.Hennerich@analog.com, jic23@kernel.org,
        knaack.h@gmx.de, pmeerw@pmeerw.net, gregkh@linuxfoundation.org,
        stefan.popa@analog.com, alexandru.Ardelean@analog.com,
        giuliano.belinassi@usp.br, robh+dt@kernel.org, mark.rutland@arm.com
Cc:     linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, kernel-usp@googlegroups.com,
        devicetree@vger.kernel.org
Subject: [PATCH v5 02/11] staging: iio: ad7780: add missing switch default
 case
Message-ID: <84375be9b21a30dde736e47a7e2f72c1aedf7e92.1552700652.git.renatogeh@gmail.com>
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

This patch simply adds a missing switch default case in read_raw.

Signed-off-by: Renato Lui Geh <renatogeh@gmail.com>
---
 drivers/staging/iio/adc/ad7780.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/staging/iio/adc/ad7780.c b/drivers/staging/iio/adc/ad7780.c
index 07e5e35c92a3..f4cd7bc3e02f 100644
--- a/drivers/staging/iio/adc/ad7780.c
+++ b/drivers/staging/iio/adc/ad7780.c
@@ -118,6 +118,8 @@ static int ad7780_read_raw(struct iio_dev *indio_dev,
 	case IIO_CHAN_INFO_OFFSET:
 		*val = -(1 << (chan->scan_type.realbits - 1));
 		return IIO_VAL_INT;
+	default:
+		break;
 	}
 
 	return -EINVAL;
-- 
2.21.0

