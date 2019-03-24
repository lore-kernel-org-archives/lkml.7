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
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3EAEC43381
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Mar 2019 17:23:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6CE9E2147C
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Mar 2019 17:23:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rlp30LAu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729007AbfCXRXS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 24 Mar 2019 13:23:18 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:36392 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728948AbfCXRXP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Mar 2019 13:23:15 -0400
Received: by mail-wr1-f66.google.com with SMTP id y13so7528401wrd.3;
        Sun, 24 Mar 2019 10:23:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=le4hwhU5UoKaxHO08LbNwF83in7BMskVDQEq5Hh35h4=;
        b=rlp30LAu0l9GhXqbcK80yYUdVkOjrlhBoyDI+69uA/VPgkmLklynYTw34INX62vaJV
         kOJol7TTifhveiq7K52099zDLmJ1H65TIbw/wfb1xyZRGTWdHMxOghVQbHGxsngibOtA
         IRQ9iNUrQGfpKNuxLAxaS7nJ1SXELzLTZ+uy/GWAa2hD1Yz24vO2SG+z5PfWVtYsH+Pk
         Xe38acs0vmI6ms6UgQ57Gq7Ss//fMcAhmyd54D7yNMXSu0M2bRrHGLg/MC4NsnPnLATs
         +HGwpyUDmYlCJHZJMeT4vTU+oRdWrsK2sp/AWmBTYiDZu2xSHdNtibUThYQ4JM4dJZsA
         5Rkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=le4hwhU5UoKaxHO08LbNwF83in7BMskVDQEq5Hh35h4=;
        b=lLUufmffaRiutYG8OeztHP4bhJdwyGLfAAgf7zd1hGPEXL9ctwSqeTMZBBMa/QpSg7
         HCs/1F+rAuEG6en9lslJnhk+STcunlXoZJYThNxnd1IX8zAfQc9OrhU3gEX1oUm3ujFQ
         s7Cix0FElMCR7ABnSopUu86QN51N0P0m0wGZqAJDHF3tc/bkkNxdWI652Wh/ui5jiDL8
         e9xvH5T+cLfnMhMx4eAbqXTDIM2N00EiAhmApYcZXzCPL5kRXrUF9DTLYA9U/bLlMZsP
         XzTnU99fAYk0606TeB1j/5rerehsTakMrLvPH/SitySfqUlMq2IdttJcBFZ3RZ6ARaPb
         nrBw==
X-Gm-Message-State: APjAAAX3HVY14++zI7lA48Yy4Hl/ZFZ4tiQM3ccWFb/uKXBqeADf1fJ5
        1mWk472ebP7m52MAdK9dZ8w=
X-Google-Smtp-Source: APXvYqz/34I/TlI1X32cwr+1p6gnXfcG79imkat83GJzZ8HO8leKmskX7U411HZia+Pnz33IPIAhCg==
X-Received: by 2002:adf:eb89:: with SMTP id t9mr12557703wrn.21.1553448192886;
        Sun, 24 Mar 2019 10:23:12 -0700 (PDT)
Received: from peano ([87.19.116.42])
        by smtp.gmail.com with ESMTPSA id y5sm11964759wrw.23.2019.03.24.10.23.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 24 Mar 2019 10:23:12 -0700 (PDT)
Date:   Sun, 24 Mar 2019 18:23:11 +0100
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
Subject: [PATCH v3 2/5] staging: iio: adc: ad7192: Converted bool to bitfield
 format
Message-ID: <1d0e1d2c7011bfd2d20e8dd728256bf245861a8e.1553447138.git.sicilia.cristian@gmail.com>
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

Changed bool format to bitfield format to save space.

Signed-off-by: Cristian Sicilia <sicilia.cristian@gmail.com>
---
 drivers/staging/iio/adc/ad7192.h | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/staging/iio/adc/ad7192.h b/drivers/staging/iio/adc/ad7192.h
index 7433a43..9c1d223 100644
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
+	u8		refin2_en:1;
+	u8		rej60_en:1;
+	u8		sinc3_en:1;
+	u8		chop_en:1;
+	u8		buf_en:1;
+	u8		unipolar_en:1;
+	u8		burnout_curr_en:1;
 };
 
 #endif /* IIO_ADC_AD7192_H_ */
-- 
2.7.4

