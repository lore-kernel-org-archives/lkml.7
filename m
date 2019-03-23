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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30D95C43381
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Mar 2019 12:54:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F10CB21902
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Mar 2019 12:54:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="druwLLZC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727646AbfCWMyJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 23 Mar 2019 08:54:09 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:52550 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727596AbfCWMyF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Mar 2019 08:54:05 -0400
Received: by mail-wm1-f65.google.com with SMTP id a184so4572935wma.2;
        Sat, 23 Mar 2019 05:54:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=kblbWvCyq1UZrHknp/mh7+F4dSszEzTXTDTT5S5waO4=;
        b=druwLLZCDE70RHKT7mv111okJ/gAfl2evFGTkms5kf61dJR4EsPdhK+rkDZ/6YhKYK
         JtoFgr2wwMveJUiWS0l0OVL3yNLMAxruYvzK2drJUMDJrSryXxkHawcNl1ogdXq4qvKk
         W5tXY3E0nlTA3PxtvTZyQ7ldJrzqsvI/9HA2RWAUOcLzKBkoTAb6QfUVQFPfiVwu9J7l
         w+ABhpB8b2MyzxMaEELupy34961p8Udr/1OlafhB33wiJ+9gOC73y3cFnZdhq+Aiqu8u
         WCXMey/iS6/oRO7UsX15xivNKO2fxouTOUxYRiV671HTz/ohGTgYIsZJPQR0SMFJoiH2
         pHqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=kblbWvCyq1UZrHknp/mh7+F4dSszEzTXTDTT5S5waO4=;
        b=A4DsPnR5+GK6HK6kcpLuotwz2TqtPVnqTicZ0qt2ACuQLOyHEBWHMMPoi5txGTpvmC
         lyy8O1FZh773ar2MX+6DIa4tnhFhFshNj7e1VKZ+LjoIMwyVEdZpbrTRxyrXI1uh8KK7
         V+FoEn7IRo0i/xoZvWcCO4yuyhtwguz752R9CSZUitjySWJjXPPa2Dj4efkWuBuebKLE
         536SXuoOBPtdPAiGUQG9qo0JQzRXoIOSE5SqpLTfgl8UxMzQLY0vsIFOyHu3ubiiEjxC
         I8abLUMOfucwMtUZIbQ0EpnlnHSEiOaXG73JIm37MD3gyG9wp4daxgpCZhbZhfvhcy9k
         vFnw==
X-Gm-Message-State: APjAAAV00LmWQz1aE8X1Du97JcNu2Uc4Siyvvfnsn15/K9g/kJYVgOye
        nVp/6dRkuyCRkm+jsmLuaGM=
X-Google-Smtp-Source: APXvYqxISfXbTFDY7189tIOFWALOtGLocOLMcNn37I/c84QHy3weyJib27BUrDXhGnTKVwb7c4jkYw==
X-Received: by 2002:a7b:c34e:: with SMTP id l14mr22790wmj.68.1553345643673;
        Sat, 23 Mar 2019 05:54:03 -0700 (PDT)
Received: from peano ([87.19.116.42])
        by smtp.gmail.com with ESMTPSA id z7sm340627wml.40.2019.03.23.05.54.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 23 Mar 2019 05:54:03 -0700 (PDT)
Date:   Sat, 23 Mar 2019 13:54:01 +0100
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
Subject: [PATCH 2/5] staging: iio: adc: Converted bool to bitfield format
Message-ID: <93b82557f3610f4bf4d09d0556e502b418376420.1553335775.git.sicilia.cristian@gmail.com>
References: <cover.1553335775.git.sicilia.cristian@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1553335775.git.sicilia.cristian@gmail.com>
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

