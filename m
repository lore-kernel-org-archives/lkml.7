Return-Path: <SRS0=b0IM=RT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B302CC43381
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Mar 2019 02:11:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6C17B218AC
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Mar 2019 02:11:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SVnaeziy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726962AbfCPCLF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Mar 2019 22:11:05 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:42089 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726218AbfCPCLF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Mar 2019 22:11:05 -0400
Received: by mail-qk1-f196.google.com with SMTP id b74so6682523qkg.9;
        Fri, 15 Mar 2019 19:11:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=tjeKEKBJwHhgYiPZjRw0Blr1fFyox223oRj9UfoRK4o=;
        b=SVnaeziyQUGhvqQdfiK9ldbscvraUd1tQliL2XSHpCIMgpNbwMIRJIHgYY9/5r+5Ep
         eYDBX6rvRSUU9+uPBt6A0ujh4kWcm0unhYxUpuLXVe+cczXs0JJiaqEmJnCPEf+K9sAd
         +T5nk1ZJz9GcnxLEqbOyK67H7aY+Yllv9E/H8Q5v3cbRnrnhYkvYqVxUux6ClnHRfDAG
         2I1NBZ+pprPHPo06QxFRCd022RBSWShDU8ZhSzB81AwZZbMxFfDGalcgKBYzO9FImQ8u
         HkQwOUUqPf2SmWM7sE+yCSKE6rFcnTkhcoqxVrLXpzdNztyHasqw4r+Wh4kVQ0x7Ud9y
         roXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=tjeKEKBJwHhgYiPZjRw0Blr1fFyox223oRj9UfoRK4o=;
        b=EUOt+5N2sMEQMrVCDkeDtejRM3OZMugidjsdgT/Zm+6LEdgvBTB61OL5/rRz4xP9xn
         69wumAx73Eyi9x+rIhRljaPfH5tHgFQKkYBDJtqPL8uwLSl2JVlD75wZBOz4wNm3+lcK
         Xs5/Le8GzMzvp56AVECYXqWa/ZUibBkJf/rNGIBAnoiBDN4jM94wAOu4ZS6Ez3v+e2FE
         cJis57wOwFe8bIrl1W+0tP8m0203N5wQB9thC8bvYIHCzhB5oJ3tqNsC+wn1vqApvdtO
         dmBFYRHnWRUj6eL8CdB5Sy/kOYEfkS9mCW3DTMEotarJvDed/XxYZBEZaF3t63LtTXcd
         eH3w==
X-Gm-Message-State: APjAAAWoZBFdtKD8L9x/GoAJje/ygxYyndyFlw/ctYqMfboF9gPiDVlj
        4+RCtA1f+GnRGBWdLa0pTmE=
X-Google-Smtp-Source: APXvYqwc0/zQGnxPieREzl+efoSqVj/pgPkyarlvn8iV39BQnUywKn1w1SV+31/u4zUyzqatHnW01Q==
X-Received: by 2002:a37:a246:: with SMTP id l67mr4882876qke.237.1552702264410;
        Fri, 15 Mar 2019 19:11:04 -0700 (PDT)
Received: from renatolg ([186.220.21.102])
        by smtp.gmail.com with ESMTPSA id j64sm2800919qkf.13.2019.03.15.19.11.00
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 15 Mar 2019 19:11:03 -0700 (PDT)
Date:   Fri, 15 Mar 2019 23:10:58 -0300
From:   Renato Lui Geh <renatogeh@gmail.com>
To:     lars@metafoo.de, Michael.Hennerich@analog.com, jic23@kernel.org,
        knaack.h@gmx.de, pmeerw@pmeerw.net, gregkh@linuxfoundation.org,
        stefan.popa@analog.com, alexandru.Ardelean@analog.com,
        giuliano.belinassi@usp.br, robh+dt@kernel.org, mark.rutland@arm.com
Cc:     linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, kernel-usp@googlegroups.com,
        devicetree@vger.kernel.org
Subject: [PATCH v5 00/11] staging: iio: ad7780: move out of staging
Message-ID: <cover.1552700652.git.renatogeh@gmail.com>
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
 - Missing switch default case tidy up;
 - Gain reading for the ad778x;
 - Filter reading for the ad778x;
 - Sets pattern macro values and mask for PATTERN status bits;
 - Adds ID values for the ad7170, ad7171, ad7780 and ad7781 for ID
   status bits checking;
 - Moves regulator initialization to after GPIO init to maintain
   consistency between probe and remove;
 - Copyright edits, adding SPDX identifier and new copyright holder;
 - Moves the ad7780 driver out of staging to the mainline;
 - Adds device tree binding for the ad7780 driver.

Renato Lui Geh (11):
  staging: iio: ad7780: add gain & filter gpio support
  staging: iio: ad7780: add missing switch default case
  staging: iio: ad7780: add gain reading to ad778x
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
*v5
 - Tidy ups
 - Gain reading split from "gain & filter gpio support" commit to its
   own separate patch
 - ad778x_odr_avail moved to more appropriate patch
 - Init GPIOs in a separate function
 - Raise error when ad717x tries to perform a write operation

 .../bindings/iio/adc/adi,ad7780.txt           |  48 +++
 drivers/iio/adc/Kconfig                       |  12 +
 drivers/iio/adc/Makefile                      |   1 +
 drivers/iio/adc/ad7780.c                      | 376 ++++++++++++++++++
 drivers/staging/iio/adc/Kconfig               |  13 -
 drivers/staging/iio/adc/Makefile              |   1 -
 drivers/staging/iio/adc/ad7780.c              | 277 -------------
 7 files changed, 437 insertions(+), 291 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/iio/adc/adi,ad7780.txt
 create mode 100644 drivers/iio/adc/ad7780.c
 delete mode 100644 drivers/staging/iio/adc/ad7780.c

-- 
2.21.0

