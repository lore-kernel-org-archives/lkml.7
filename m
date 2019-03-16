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
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1189C10F00
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Mar 2019 02:14:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A1B0A206DF
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Mar 2019 02:14:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A+yeRwMu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727112AbfCPCOe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Mar 2019 22:14:34 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:43876 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726549AbfCPCOe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Mar 2019 22:14:34 -0400
Received: by mail-qt1-f196.google.com with SMTP id v32so12267582qtc.10;
        Fri, 15 Mar 2019 19:14:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=UyV0RQ6Ay3hRInLPzMBULAGnAUWrot2JtsvIp1TAUNg=;
        b=A+yeRwMu/MaA68qjpPiqy+MMCUUPoiIt9YS8Ha5CBEbfs4Gpl88XIC3WtdCaS1Pht4
         6NAi+YwULeePYD846LZ7LGSzD0MCTWjFUA13ggtEwiEYae6huVb/mBQTMzba+ImYy7OO
         jjzfIIImriQbhIt4rOOrFWDBHlhyVyPmaftMXYBIta0NdJHrc5schiEE51DCDPpoVmmT
         J0OwPxta9rRnR2CELrlIfKbYXe2unrjZ/Pkp7k76xE7kCZMmHRBNaDa9z072dE2Kne7H
         YM7oLtBZP7Le4f7ReT/7Jo3OhR2YoB/gcgP4QWXOci6/6CUC0ExA9gobn6s7JuObE7Ze
         Uu2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=UyV0RQ6Ay3hRInLPzMBULAGnAUWrot2JtsvIp1TAUNg=;
        b=JcotAjWbdyu/w906BzUGNRby1fePPDv5MJU2D+5FkFlnyYwH99PyZto0xuzC/vkJdu
         wfUKrA+8ewrstkXdlUGxzD9lP0ss116RcihPGVud2ZKG9fG3iWdDmWaxGy/cx8eUJP5m
         HnkZaViYvl6tn8M/IR9zIltN72TnU6+4Krmo5D471VjQpTbnxUI20EXdsJrCaLljuAMz
         uhfHGDWxdrV5JMrqsx7wWanTlBtY7nblMecRrtAXltCP0LZn6T9RpM7UDEKy3TKx3yuJ
         /tPPzmscx1myXTu8jmud4+aWeWkrn1ROxJ3YQ1bN60Gb4ajdU/t3mVIW+ihipaXH7fqy
         o39A==
X-Gm-Message-State: APjAAAWkVrJeDZmxgJsCC5QOes/0wWqkfUZGNksY2ON6bGPzSaSL26QW
        3mNogpggb/NyCaj6buB4IBU=
X-Google-Smtp-Source: APXvYqzZmdW4ebM1mZpK4ieK/sE/Vh5ok8DEgcL1GQisBAGDs1APtkDahJeVOLTU8jkdCK6PHMCkdg==
X-Received: by 2002:aed:2507:: with SMTP id v7mr5406022qtc.131.1552702473093;
        Fri, 15 Mar 2019 19:14:33 -0700 (PDT)
Received: from renatolg ([186.220.21.102])
        by smtp.gmail.com with ESMTPSA id d4sm1240583qth.45.2019.03.15.19.14.29
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 15 Mar 2019 19:14:32 -0700 (PDT)
Date:   Fri, 15 Mar 2019 23:14:27 -0300
From:   Renato Lui Geh <renatogeh@gmail.com>
To:     lars@metafoo.de, Michael.Hennerich@analog.com, jic23@kernel.org,
        knaack.h@gmx.de, pmeerw@pmeerw.net, gregkh@linuxfoundation.org,
        stefan.popa@analog.com, alexandru.Ardelean@analog.com,
        giuliano.belinassi@usp.br, robh+dt@kernel.org, mark.rutland@arm.com
Cc:     linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, kernel-usp@googlegroups.com,
        devicetree@vger.kernel.org
Subject: [PATCH v5 06/11] staging:iio:ad7780: add chip ID values and mask
Message-ID: <8154410f6c1b6cdde21cfb781dbc2088f5c91d21.1552700652.git.renatogeh@gmail.com>
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

The ad7780 supports both the ad778x and ad717x families. Each chip has
a corresponding ID. This patch provides a mask for extracting ID values
from the status bits and also macros for the correct values for the
ad7170, ad7171, ad7780 and ad7781.

Signed-off-by: Renato Lui Geh <renatogeh@gmail.com>
---
Changes in v5:
 - Put AD7780_ID{0,1} back

 drivers/staging/iio/adc/ad7780.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/staging/iio/adc/ad7780.c b/drivers/staging/iio/adc/ad7780.c
index 94cb60c327d0..977b381c1260 100644
--- a/drivers/staging/iio/adc/ad7780.c
+++ b/drivers/staging/iio/adc/ad7780.c
@@ -30,6 +30,12 @@
 #define AD7780_ID0		BIT(3)
 #define AD7780_GAIN		BIT(2)
 
+#define AD7170_ID		0
+#define AD7171_ID		1
+#define AD7780_ID		1
+#define AD7781_ID		0
+
+#define AD7780_ID_MASK		(AD7780_ID0 | AD7780_ID1)
 
 #define AD7780_PATTERN_GOOD	1
 #define AD7780_PATTERN_MASK	GENMASK(1, 0)
-- 
2.21.0

