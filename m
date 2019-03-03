Return-Path: <SRS0=GAfv=RG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 833E5C4360F
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Mar 2019 13:52:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 467D820836
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Mar 2019 13:52:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gs9P4bZP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726359AbfCCNwa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 3 Mar 2019 08:52:30 -0500
Received: from mail-qk1-f194.google.com ([209.85.222.194]:37739 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726186AbfCCNw3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Mar 2019 08:52:29 -0500
Received: by mail-qk1-f194.google.com with SMTP id m9so1418295qkl.4;
        Sun, 03 Mar 2019 05:52:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=vVKH27wJS7+cOMDP8DvHCQLrRQHLTE7flgi1uer+sT0=;
        b=gs9P4bZP/oqNpe3evrSx7hF0i2t/DTORJQJcGpi8lXC61sUg03oPLS0DGe1ASvO0x4
         +yBTu+uy15Fq4XB8ZMBJwmqueaiXBhMrTikuq81/dPXWYDcPzVfyFIHCbzCJyleXr95a
         ooVvXtOBEl+c3RHzr2BNpvws0pdrf7HsPs5Pe1yh/uDIYQ4jGyXYGLq7W7PtxumYucaC
         fUJtr75tHYBZpyvapzhCqLaWslH+ez/byhSm2dNf/Mu4xwW54ZQ2hk5qv1c273xIbt32
         BGYZjXCEsQa90zKonu1T+GOovKUpunvLUoH9ZWJva+P/JKPAkk3HdlbC6TMUPOGfnTYR
         6Wng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=vVKH27wJS7+cOMDP8DvHCQLrRQHLTE7flgi1uer+sT0=;
        b=qLLBF2hYbHEmFIrMUyIm2kIcFdfJ60l5QrxMYlqxi4q6vqE+OUVt/IO7W4cqcQORsI
         gn7ahYg169KNp9WPsTwUxuWVs87Uq7S1MBl9onI/Za2wwI3/LNOdMtPMV40hN8+6NiOo
         BapEXlLvhxsPr5l39IZAH0VziD9Qqis0rJx31UDyiv5Zlhjm5dnXn8D0AU2SF/REAnLm
         TI1peDi6wUH+SZVkLIeSpYyZQCemZJy4ddbQdCQcbhwgQEKuKpRcSV/qnbaZgz+MVIJA
         pbVo6Icl3qCss4fmYs4YB4Mwmn6nZ/Q0tPf6rzE2ZaAVThtp4IfhX9S/Sj8dN33FWjjm
         KvVQ==
X-Gm-Message-State: APjAAAUH/37xo5j8eurhBUMZ/lzQD/6+l5MusMEzpIanwIj76A7BiJ/y
        1kdZg/p7O6OLAXTDMWwxEb8=
X-Google-Smtp-Source: APXvYqy2RFKurXlsJz536Y1ny6Kq7mOiFkwoYjY8rVyAY0E7oZlxskeJDIjr1ituAD1PHQkVdOeWeA==
X-Received: by 2002:a37:62ce:: with SMTP id w197mr10192281qkb.108.1551621147863;
        Sun, 03 Mar 2019 05:52:27 -0800 (PST)
Received: from renatolg ([186.220.23.48])
        by smtp.gmail.com with ESMTPSA id w1sm2201498qtc.75.2019.03.03.05.52.23
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 03 Mar 2019 05:52:27 -0800 (PST)
From:   Renato Lui Geh <renatogeh@gmail.com>
X-Google-Original-From: Renato Lui Geh <renatogeh@renatolg>
Date:   Sun, 3 Mar 2019 10:52:21 -0300
To:     "Ardelean, Alexandru" <Alex.Ardelean@analog.com>
Cc:     "lars@metafoo.de" <lars@metafoo.de>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "Popa, Stefan Serban" <StefanSerban.Popa@analog.com>,
        "knaack.h@gmx.de" <knaack.h@gmx.de>,
        "jic23@kernel.org" <jic23@kernel.org>,
        "Hennerich, Michael" <Michael.Hennerich@analog.com>,
        "renatogeh@gmail.com" <renatogeh@gmail.com>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "giuliano.belinassi@usp.br" <giuliano.belinassi@usp.br>,
        "pmeerw@pmeerw.net" <pmeerw@pmeerw.net>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "devel@driverdev.osuosl.org" <devel@driverdev.osuosl.org>,
        "kernel-usp@googlegroups.com" <kernel-usp@googlegroups.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Subject: Re: [PATCH v4 0/9] staging: iio: ad7780: move out of staging
Message-ID: <20190303135220.swjrc4r7jb52rw6n@renatolg>
References: <cover.1551358569.git.renatogeh@gmail.com>
 <72a54cd5f58aeb9507b95b7e33ca3d9a38c853e9.camel@analog.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
In-Reply-To: <72a54cd5f58aeb9507b95b7e33ca3d9a38c853e9.camel@analog.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alexandru,

Thanks for the review. Some questions inline.

Thanks,
Renato

On 03/01, Ardelean, Alexandru wrote:
>On Thu, 2019-02-28 at 11:23 -0300, Renato Lui Geh wrote:
>>
>
>The patch-series is a bit big.
>I guess that the intent is to move this out-of-staging, but various patches
>are holding this in it's place.
>For patch series above a certain size, you could get many re-spins
>[V2,3,4... so on].
>
>You could send some of the changes as individual patches, or group them in
>series of 1,2 or 3 patches. That way, you "parallelize" patch sending, and
>when you get reviews on each patch, you can re-spin them individually.
>You'll find over time that certain patches get accepted on V1, others on V2
>and some on V7 [ hopefully, there isn't any frustration at that point ].

On these subseries, should versioning follow this patchset (v5) or should
they start anew (v1), ignoring this series version?
>
>Well, this is a technique I use to distribute some of my upstream-patch-
>work, so that I can switch easier between internal-work & upstreaming-work.
>
>Coming back to this patch-series.
>My general input, is that the patches are fine over-all; some are just
>cosmetics/noise/a-different-way-of-doing-things-for-this-driver, and those
>usually can be left to preference [of the maintainer usually].
>
>I do suggest to not hurry when re-spinning patches, and not change too much
>the number of patches in a new series. That can complicate things
>sometimes. But, if doing small patch-series or individual patches, you
>won't have this problem too much.
>
>Thanks
>Alex
>
>>
>> This series of patches contains the following:
>>  - Adds user input for the 'gain' and 'filter' GPIO pins for the ad778x
>>    family chips;
>>  - Filter reading for the ad778x;
>>  - Sets pattern macro values and mask for PATTERN status bits;
>>  - Adds ID values for the ad7170, ad7171, ad7780 and ad7781 for ID
>>    status bits checking;
>>  - Moves regulator initialization to after GPIO init to maintain
>>    consistency between probe and remove;
>>  - Copyright edits, adding SPDX identifier and new copyright holder;
>>  - Moves the ad7780 driver out of staging to the mainline;
>>  - Adds device tree binding for the ad7780 driver.
>>
>> Renato Lui Geh (9):
>>   staging: iio: ad7780: add gain & filter gpio support
>>   staging: iio: ad7780: add filter reading to ad778x
>>   staging: iio: ad7780: set pattern values and masks directly
>>   staging:iio:ad7780: add chip ID values and mask
>>   staging: iio: ad7780: move regulator to after GPIO init
>>   staging: iio: ad7780: add SPDX identifier
>>   staging: iio: ad7780: add new copyright holder
>>   staging: iio: ad7780: moving ad7780 out of staging
>>   staging: iio: ad7780: add device tree binding
>>
>> Changelog:
>> *v3
>>  - SPDX and regulator init as patches
>>  - Renamed filter to odr and ad778x_filter to ad778x_odr_avail
>>  - Removed unnecessary regulator disabling
>>  - Removed unnecessary AD_SD_CHANNEL macro
>>  - Changed unsigned int to unsigned long long to avoid overflow
>> *v4
>>  - Split gain & filter patch into two, with the new commit adding only
>>    filter reading
>>  - Changed pattern values to direct values, and added pattern mask
>>  - Added ID values and mask
>>  - Added new copyright holder
>>  - Added device tree binding to the ad7780 driver
>>
>>  .../bindings/iio/adc/adi,ad7780.txt           |  48 +++
>>  drivers/iio/adc/Kconfig                       |  12 +
>>  drivers/iio/adc/Makefile                      |   1 +
>>  drivers/iio/adc/ad7780.c                      | 365 ++++++++++++++++++
>>  drivers/staging/iio/adc/Kconfig               |  13 -
>>  drivers/staging/iio/adc/Makefile              |   1 -
>>  drivers/staging/iio/adc/ad7780.c              | 277 -------------
>>  7 files changed, 426 insertions(+), 291 deletions(-)
>>  create mode 100644
>> Documentation/devicetree/bindings/iio/adc/adi,ad7780.txt
>>  create mode 100644 drivers/iio/adc/ad7780.c
>>  delete mode 100644 drivers/staging/iio/adc/ad7780.c
>>
>> --
>> 2.21.0
>>
>
>-- 
>You received this message because you are subscribed to the Google Groups "Kernel USP" group.
>To unsubscribe from this group and stop receiving emails from it, send an email to kernel-usp+unsubscribe@googlegroups.com.
>To post to this group, send email to kernel-usp@googlegroups.com.
>To view this discussion on the web visit https://groups.google.com/d/msgid/kernel-usp/72a54cd5f58aeb9507b95b7e33ca3d9a38c853e9.camel%40analog.com.
>For more options, visit https://groups.google.com/d/optout.
