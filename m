Return-Path: <SRS0=xaRW=WR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C617C3A5A0
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Aug 2019 21:30:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5E1BF2332A
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Aug 2019 21:30:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="iMJnFRHD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730903AbfHUVaU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Aug 2019 17:30:20 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:37767 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727484AbfHUVaT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Aug 2019 17:30:19 -0400
Received: by mail-pg1-f196.google.com with SMTP id d1so2098977pgp.4
        for <linux-kernel@vger.kernel.org>; Wed, 21 Aug 2019 14:30:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:in-reply-to:references:date:message-id
         :mime-version;
        bh=JamKzvdT5n0JRFMyDQS1FT/k6bVQThWvvzDjprEJ6CY=;
        b=iMJnFRHDKKfY2TVix6Kg7QyOZkDIj5MTwOzwwrn9Yh0Quv6TKjoaBAZkhZHd1kOHee
         LXYDawRhFHEgBNVxflMeMS/vKJFbK02GEskP/b6ppziRxRi71zF0RENhjAVb7LQCWOtV
         CHhrElk4aIvJMy7kf/RDsJ3S7caNHIVvHYd+xe2R1sU6oYZpkGVwZCAfBXtXXFTrXwvg
         AVFLU7xkUCQi9Uk9PR83GQaRgRbRYRgV+B9KFifQie13IcraLry4MNr3OCU0avrjxreC
         K2PcHaPYxhKddpS94bCbVgYQ2dv1df8KAJmlVi0wYxdGfp48vGlzZyybK6pyDqhS7qmA
         HZ4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=JamKzvdT5n0JRFMyDQS1FT/k6bVQThWvvzDjprEJ6CY=;
        b=cJOBzaIadNWa4YD/csf13OJE7RDJ2d6Q3F9zLpicwd1A3xMLiq73+ystTWkdKBCJpg
         JClDZgCosmFSKaKa3VvXNrub7XhPudiwmk/Y5QweBuaelqWD7JdBvm8VWXsvm0sEReMv
         LJhGW1mFpPiREnV18isVdqBDhX2mvndQZ/1VLBH7Ssd4/QfxOm0l6imhpQbZ9SNO2fBH
         vG/xIrkuRHCce2I7z6e70feNDsAp6XSbz1BFE588ONNxbjqOO+Wl80guP4IW37w10rB4
         YbQbMMqyeqBF35HYkr371bj6jDEl2cjinQ276ZfxnFxVXa0DCIA50mdQAn5ZvrIalRDz
         Y68A==
X-Gm-Message-State: APjAAAVBWtKNs3vGeK7hfFT5yY298jAd9kRvGAkIbClfjmP3eevLsSXt
        tnkZLdEMV0B/G2hvAH88GDQbmQ==
X-Google-Smtp-Source: APXvYqxJgS3AGYB65QX2eSGKbfHabg/mZAuaZCmr2wu/yKCdqUmPctixFz2Q12im4wy2hl85+1FtNA==
X-Received: by 2002:a63:5a4d:: with SMTP id k13mr30104074pgm.174.1566423018409;
        Wed, 21 Aug 2019 14:30:18 -0700 (PDT)
Received: from localhost (c-71-197-186-152.hsd1.wa.comcast.net. [71.197.186.152])
        by smtp.gmail.com with ESMTPSA id a128sm24706235pfb.185.2019.08.21.14.30.17
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 21 Aug 2019 14:30:17 -0700 (PDT)
From:   Kevin Hilman <khilman@baylibre.com>
To:     Guillaume La Roque <glaroque@baylibre.com>,
        daniel.lezcano@linaro.org
Cc:     linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v3 0/6] Add support of New Amlogic temperature sensor for G12 SoCs
In-Reply-To: <7hd0hd3mme.fsf@baylibre.com>
References: <20190806130506.8753-1-glaroque@baylibre.com> <7hd0hd3mme.fsf@baylibre.com>
Date:   Wed, 21 Aug 2019 14:30:17 -0700
Message-ID: <7himqq9pg6.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Kevin Hilman <khilman@baylibre.com> writes:

> Guillaume La Roque <glaroque@baylibre.com> writes:
>
>> This patchs series add support of New Amlogic temperature sensor and minimal
>> thermal zone for SEI510 and ODROID-N2 boards.
>>
>> First implementation was doing on IIO[1] but after comments i move on thermal framework.
>> Formulas and calibration values come from amlogic.
>>
>> Changes since v2:
>>   - fix yaml documention 
>>   - remove unneeded status variable for temperature-sensor node
>>   - rework driver after Martin review
>>   - add some information in commit message
>>
>> Changes since v1:
>>   - fix enum vs const in documentation
>>   - fix error with thermal-sensor-cells value set to 1 instead of 0
>>   - add some dependencies needed to add cooling-maps
>>
>> Dependencies :
>> - patch 3,4 & 5: depends on Neil's patch and series :
>>               - missing dwc2 phy-names[2]
>>               - patchsets to add DVFS on G12a[3] which have deps on [4] and [5]
>>
>> [1] https://lore.kernel.org/linux-amlogic/20190604144714.2009-1-glaroque@baylibre.com/
>> [2] https://lore.kernel.org/linux-amlogic/20190625123647.26117-1-narmstrong@baylibre.com/
>> [3] https://lore.kernel.org/linux-amlogic/20190729132622.7566-1-narmstrong@baylibre.com/
>> [4] https://lore.kernel.org/linux-amlogic/20190731084019.8451-5-narmstrong@baylibre.com/
>> [5] https://lore.kernel.org/linux-amlogic/20190729132622.7566-3-narmstrong@baylibre.com/
>
> Thank you for the detailed list of dependencies!  Much appreciated.
>
> With all the deps, I tested this on sei510 and odroid-n2, and basic
> functionality seems to work.
>
> As discussed off-list: it would be nice to have an example of how
> cpufreq could be used as a cooling device for hot temperatures.  The
> vendor kernel has some trip points that could be included as examples,
> or even included as extra patches.
>
> Also the driver patch is missing the two main thermal maintainers, so
> please resend at least the driver and bindings including them.

Forgot to add...

Tested-by: Kevin Hilman <khilman@baylibre.com>
