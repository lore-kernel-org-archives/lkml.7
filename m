Return-Path: <SRS0=SjSX=S5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D96E3C43219
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 20:09:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A6ECA2077B
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 20:09:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="ahByQctc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726396AbfD0UJm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 27 Apr 2019 16:09:42 -0400
Received: from mail-oi1-f174.google.com ([209.85.167.174]:43053 "EHLO
        mail-oi1-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725947AbfD0UJm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Apr 2019 16:09:42 -0400
Received: by mail-oi1-f174.google.com with SMTP id t81so5539628oig.10;
        Sat, 27 Apr 2019 13:09:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hhsMH/X03raw9aMWA8APU3MELLU8bVy7VgvUJ5xTuQQ=;
        b=ahByQctc83TUY/CQh/dPlAaavJHHUyzHS85EJUSSaZs/0yKXkeaH+KC0K5EeJlmJlP
         /GnMqEVO/GvrdLsJ0x1xW461cPFCXN1k6KRSAU2GZJNpFYDZJfn4A4UoLNdbF5acfyar
         UaymDSi8P6LDrBAnvvqK8GQ/5Vt7kdhyhz+yvRvhdwUSwOOSVhfaafpzeZiCb67mi6j5
         YvyblL0MKBnXryvzfZe8Wlon1UnfUFgbP/HWh7ejJjiqBl/WPKk1z7K6Deg3fAci+ctN
         mH1w0W7+V6uQXw/uWu+CicN9AUQSLLCmeoKR9KQzqqmNvagiqkv1Bf2fsPF/v99XoS71
         f4SQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hhsMH/X03raw9aMWA8APU3MELLU8bVy7VgvUJ5xTuQQ=;
        b=HZSifSVhXfb6uWc8zZTvG4K+eFqjzy0xYTJ/kMz+wI/Yrbm86kqT1ScHDSO040zyTu
         56jEFo+tYaVQ7WGjFMsA/z+U0DcefGLOIufa/Ahe8rQRwrOV4+oNnQoXRKy4AgHHhUPn
         9Wttmk7+ocCAMr18nj6Y7vSd0EiD1RubUXt6Yurg8H6aWuH5BITgwfn1UaDjbCLEwsrP
         eLKRLJaHdfWYF90B88nGebhxh4KJEIclE8XAyvrZGU3OYrcD6Ttwr5rzN55VzQIpc6bP
         qUkcqQL0pZ4QkaXRkL5ouh9KzWq5J552F/j90SYEiLFQn9R6edTXGeqQyEnL6xScMxGG
         CLGw==
X-Gm-Message-State: APjAAAUsOm0D7E3g36DhqBc+NQlmkb2aEBGKc3M4T7DUycWrZEgbrI9Z
        0fwC9lPxeUBG0Sbv3qhJZQ17ctALV3P6/ILrGIA=
X-Google-Smtp-Source: APXvYqyw/N9NTESkuor+2z/IpAyy1XeCCxc+w0NMyAXNuozuD5lok5KS2ZvFbHDoVbRRbeeopt3j5qvzedSocw82urg=
X-Received: by 2002:aca:5b06:: with SMTP id p6mr10591975oib.129.1556395781412;
 Sat, 27 Apr 2019 13:09:41 -0700 (PDT)
MIME-Version: 1.0
References: <20190423090235.17244-1-jbrunet@baylibre.com> <20190423090235.17244-8-jbrunet@baylibre.com>
In-Reply-To: <20190423090235.17244-8-jbrunet@baylibre.com>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Sat, 27 Apr 2019 22:09:30 +0200
Message-ID: <CAFBinCB4BC01=ryTPAc77RbKucMRhQNUN-9C++=pM_u=dFYK6w@mail.gmail.com>
Subject: Re: [PATCH v2 7/7] mmc: meson-gx: add signal resampling tuning
To:     Jerome Brunet <jbrunet@baylibre.com>
Cc:     Ulf Hansson <ulf.hansson@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        linux-amlogic@lists.infradead.org, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 23, 2019 at 11:03 AM Jerome Brunet <jbrunet@baylibre.com> wrote:
>
> Use signal resampling tuning for the UHS and HS200 modes.
> Instead of trying to get the *best* resampling setting with complex
> window calculation, we just stop on the first working setting.
>
> If the tuning setting later proves unstable, we will just continue the
> tuning where we left it.
>
> Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
[Khadas VIM now shows the HS200 eMMC]
Tested-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>


BEFORE (no patches from this series applied):
# dmesg | grep mmc1
(no output)

AFTER (all 7 patches from this series applied):
# dmesg | grep mmc1
[    2.945155] mmc1: new HS200 MMC card at address 0001
[    2.957737] mmcblk1: mmc1:0001 AWPD3R 14.6 GiB
[    2.966278] mmcblk1boot0: mmc1:0001 AWPD3R partition 1 4.00 MiB
[    2.976114] mmcblk1boot1: mmc1:0001 AWPD3R partition 2 4.00 MiB
[    2.986354] mmcblk1rpmb: mmc1:0001 AWPD3R partition 3 4.00 MiB,
chardev (241:0)


Regards
Martin
