Return-Path: <SRS0=g5d9=RD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87A1AC10F00
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 14:23:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5596F2171F
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 14:23:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HrKVlRXS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732642AbfB1OXJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Feb 2019 09:23:09 -0500
Received: from mail-qt1-f193.google.com ([209.85.160.193]:38819 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727789AbfB1OXI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Feb 2019 09:23:08 -0500
Received: by mail-qt1-f193.google.com with SMTP id s1so23645659qte.5;
        Thu, 28 Feb 2019 06:23:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=jFGfRyvX1Bua5dA9/UwdF9ZZoYKBJTBkCX2r3CP1LEA=;
        b=HrKVlRXS3AqGEYQwU+jaPRc6FeAEefhnW/hneOgZc+v6MnTS6rF9wJld1A4vVSaFMU
         3Tf7EEv2ymHrce/qX9y0erpnm3O09jjV1zu2e7C/DT36toSFUEc0JdlqT9ztNlz73Km5
         cElEEYTt+k1p2DtO+TTXFTQLs7SB76E7+Sw1z4Gd1lGzFPblkKMYv3nvbFf6cOheod5h
         YNtfketsO1HR1zG4i6g7LTcgcJ08F7vWb7Qn/jfXMGbtxT5WUg/O2ML+cqkRrH/qxwdZ
         GOQ7xKSRzuJ5IRbSaFgH9gVtLolTnuiiajX0qEiAw3720PWgBrcNUjjc8MHyUURHOfdK
         z/1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=jFGfRyvX1Bua5dA9/UwdF9ZZoYKBJTBkCX2r3CP1LEA=;
        b=lEzOC4jduI45o4+t4//dIDr49Z5qGMAAaH+xjtqOO1YixfIZ3uFdMaLJEGx/yyPk+L
         yJgcsxK/KVpnA1yqM9pRxJKJpW6VnUsE9HGuXCdyljZ19wObwhuQOp4YWeqhy0zzj6cv
         N3Sca75DjQ315QB4FZiFKUYNDpiye+mgLuhZvGQdS5iySdX8rHKFDFIBcmUr18IGV5hh
         W7qk9fxjnjd5xdfA8SgFv+FWLW4Jv5QRdKIp0Ez7aIwZP9erfRlZbjAILgIvUc84YHNJ
         2minpqE3MG1rvblE2NToL4y2PgkaTXCcs4elJQlXeaYdP/Unei6Ccp5fU/D/yM0/qAic
         gFvA==
X-Gm-Message-State: AHQUAubf7adGrouOimjmGIHcDN9hgYwMPv1SAYuxto/cz1Z6mXN63C98
        EIUlgSrX6c/icvT8Y6hZUBc=
X-Google-Smtp-Source: APXvYqxb/SThTCslMWfw9aewjFCfWWCb5CSZBtdh7u+MVDefxJZTOKRULQ/Yi3RC3pfCZ7I2lYkRqg==
X-Received: by 2002:ac8:581:: with SMTP id a1mr6537526qth.168.1551363786986;
        Thu, 28 Feb 2019 06:23:06 -0800 (PST)
Received: from renatolg ([143.107.45.1])
        by smtp.gmail.com with ESMTPSA id a43sm2378556qtk.86.2019.02.28.06.23.02
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 28 Feb 2019 06:23:06 -0800 (PST)
Date:   Thu, 28 Feb 2019 11:23:00 -0300
From:   Renato Lui Geh <renatogeh@gmail.com>
To:     lars@metafoo.de, Michael.Hennerich@analog.com, jic23@kernel.org,
        knaack.h@gmx.de, pmeerw@pmeerw.net, gregkh@linuxfoundation.org,
        stefan.popa@analog.com, alexandru.Ardelean@analog.com,
        giuliano.belinassi@usp.br, robh+dt@kernel.org, mark.rutland@arm.com
Cc:     linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, kernel-usp@googlegroups.com,
        devicetree@vger.kernel.org
Subject: [PATCH v4 0/9] staging: iio: ad7780: move out of staging
Message-ID: <cover.1551358569.git.renatogeh@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series of patches contains the following:
 - Adds user input for the 'gain' and 'filter' GPIO pins for the ad778x
   family chips;
 - Filter reading for the ad778x;
 - Sets pattern macro values and mask for PATTERN status bits;
 - Adds ID values for the ad7170, ad7171, ad7780 and ad7781 for ID
   status bits checking;
 - Moves regulator initialization to after GPIO init to maintain
   consistency between probe and remove;
 - Copyright edits, adding SPDX identifier and new copyright holder;
 - Moves the ad7780 driver out of staging to the mainline;
 - Adds device tree binding for the ad7780 driver.

Renato Lui Geh (9):
  staging: iio: ad7780: add gain & filter gpio support
  staging: iio: ad7780: add filter reading to ad778x
  staging: iio: ad7780: set pattern values and masks directly
  staging:iio:ad7780: add chip ID values and mask
  staging: iio: ad7780: move regulator to after GPIO init
  staging: iio: ad7780: add SPDX identifier
  staging: iio: ad7780: add new copyright holder
  staging: iio: ad7780: moving ad7780 out of staging
  staging: iio: ad7780: add device tree binding

Changelog:
*v3
 - SPDX and regulator init as patches
 - Renamed filter to odr and ad778x_filter to ad778x_odr_avail
 - Removed unnecessary regulator disabling
 - Removed unnecessary AD_SD_CHANNEL macro
 - Changed unsigned int to unsigned long long to avoid overflow
*v4
 - Split gain & filter patch into two, with the new commit adding only
   filter reading
 - Changed pattern values to direct values, and added pattern mask
 - Added ID values and mask
 - Added new copyright holder
 - Added device tree binding to the ad7780 driver

 .../bindings/iio/adc/adi,ad7780.txt           |  48 +++
 drivers/iio/adc/Kconfig                       |  12 +
 drivers/iio/adc/Makefile                      |   1 +
 drivers/iio/adc/ad7780.c                      | 365 ++++++++++++++++++
 drivers/staging/iio/adc/Kconfig               |  13 -
 drivers/staging/iio/adc/Makefile              |   1 -
 drivers/staging/iio/adc/ad7780.c              | 277 -------------
 7 files changed, 426 insertions(+), 291 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/iio/adc/adi,ad7780.txt
 create mode 100644 drivers/iio/adc/ad7780.c
 delete mode 100644 drivers/staging/iio/adc/ad7780.c

--
2.21.0

