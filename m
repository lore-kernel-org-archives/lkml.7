Return-Path: <SRS0=q9dy=R2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98A07C43381
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Mar 2019 19:21:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 66A6F2183E
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Mar 2019 19:21:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TrHcvgGr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727898AbfCWTVp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 23 Mar 2019 15:21:45 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:55582 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727544AbfCWTVn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Mar 2019 15:21:43 -0400
Received: by mail-wm1-f68.google.com with SMTP id o25so5125105wmf.5;
        Sat, 23 Mar 2019 12:21:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=kblbWvCyq1UZrHknp/mh7+F4dSszEzTXTDTT5S5waO4=;
        b=TrHcvgGrgPB7qkt3XaSDn58liqYHKpUrUDPrmgGDZNhEtmiUPvAS5cE0eO8wOkqyg5
         4oYuHAqg6R4mLLSaR8OIZTAAJRL+TRvfMrrBD97bYnEwy5C209X2lqrtPpql+IPMQlZz
         ro69iQaRA91rjEFmQ/ut0y9PpAlfaLRmdXhZHFs181StPR/Ra9aLkYuXE2Ts+zVieOdW
         bMqEgR7qubGzWO4A1b6PYayS5M2AD8pwsE9HfVm+FX5LE+lmqdqBvKjsN8EFP+Ca1lP0
         Gx6m3OpBW1bxx7Sguk0CiT/ejkuyEXMQ4znYbDPmakK8yyySiC0dv9fGyaHwRsERLyr1
         tUFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=kblbWvCyq1UZrHknp/mh7+F4dSszEzTXTDTT5S5waO4=;
        b=MaXVZs+R7ZJlzAy8AYdk0TYUrYDwLBQv+fmy4kJoFuhzrEIP99jidM3hV3pkHslBOR
         kY2q+bUkywbdudY7PUbiSPM2UPgNM1d7SOIbaZ5OJV2nmpw2At/UVtKVc21yGcC5j4/E
         Eap3AG8Zrk+DYdkR8VQz4Jj0N//FhBffkjL0qqXsiRlA4q+eDrw19eDBY+8c9HSEX+eT
         V4PXknnD/nXFdz0QE43KNSZnVnLNTHsyoKXvA5Y5qOn2yrnTPvrOlt4a/nlbHea147QE
         X2G8E++vnEfRnb+cd3m7yva4GZojeG0+1bM0rPJqUipyUGmevsSv9zd77eWLuTx8/Alj
         r9UA==
X-Gm-Message-State: APjAAAVbyakh5XKZvCnF2nv5jiAyJ0tkXXNv78n7JipxFBBhwBDzSZC6
        J6GjdbeU/jMOIoLNB+mn5V8=
X-Google-Smtp-Source: APXvYqxYL6RnraC1/ufTRuGndOMaLG3h0U5xQlSSj6bayXMBom8QLm5TiFEP5Wxc6VjOe2A9BU4V3w==
X-Received: by 2002:a1c:1a53:: with SMTP id a80mr6859687wma.15.1553368901136;
        Sat, 23 Mar 2019 12:21:41 -0700 (PDT)
Received: from peano ([87.19.116.42])
        by smtp.gmail.com with ESMTPSA id r12sm18259628wrr.71.2019.03.23.12.21.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 23 Mar 2019 12:21:40 -0700 (PDT)
Date:   Sat, 23 Mar 2019 20:21:39 +0100
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
Subject: [PATCH v2 2/5] staging: iio: adc: Converted bool to bitfield format
Message-ID: <93b82557f3610f4bf4d09d0556e502b418376420.1553366098.git.sicilia.cristian@gmail.com>
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

Changed bool format to bitfield format to save space.

Signed-off-by: Cristian Sicilia <sicilia.cristian@gmail.com>

---
The strange thing is that this struct seems not populated
using a DTS binding function.
---
 drivers/staging/iio/adc/ad7192.h | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/staging/iio/adc/ad7192.h b/drivers/staging/iio/adc/ad7192.h
index 7433a43..87891ba 100644
--- a/drivers/staging/iio/adc/ad7192.h
+++ b/drivers/staging/iio/adc/ad7192.h
@@ -35,13 +35,13 @@ struct ad7192_platform_data {
 	u16		vref_mv;
 	u8		clock_source_sel;
 	u32		ext_clk_hz;
-	bool		refin2_en;
-	bool		rej60_en;
-	bool		sinc3_en;
-	bool		chop_en;
-	bool		buf_en;
-	bool		unipolar_en;
-	bool		burnout_curr_en;
-};
+	u8		refin2_en:1;
+	u8		rej60_en:1;
+	u8		sinc3_en:1;
+	u8		chop_en:1;
+	u8		buf_en:1;
+	u8		unipolar_en:1;
+	u8		burnout_curr_en:1;
+} __attribute__((__packed__));
 
 #endif /* IIO_ADC_AD7192_H_ */
-- 
2.7.4

