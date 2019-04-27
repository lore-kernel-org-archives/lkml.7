Return-Path: <SRS0=SjSX=S5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B0A3C43218
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 20:09:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 50BF02077B
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 20:09:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="DvqO45eV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726335AbfD0UJ0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 27 Apr 2019 16:09:26 -0400
Received: from mail-oi1-f193.google.com ([209.85.167.193]:34460 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725947AbfD0UJ0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Apr 2019 16:09:26 -0400
Received: by mail-oi1-f193.google.com with SMTP id v10so5581787oib.1;
        Sat, 27 Apr 2019 13:09:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pHMz3rI79/njeGoNvnnMmMVDwBZ8a5Z9yd2P7n1PACg=;
        b=DvqO45eVQbl8Y73TLqa6O5+0+o3mHgTDKvR2x3Iwr9wLCJ14YwevFy65FiH6HhIF3f
         +5xX+2cWer4C9CZenWMzgHjGR3gDQ4BkcWphcK6xtMJzCcERPhGeMJp9EjnfKtwVfEBI
         UqXtzu+B6psyWnH2+oOXYZmxnm19gStvCs/y0deWVhhB7YC+dqSM2LGr7Nu6rgy0Q3qZ
         +I1la49F6qKZ2HjkK8RYTTauKxdn08/w9WdIAte+ORs9CMwe73H01oKnRcyW0ugW774Z
         rCPZ70c2AtAJtjtcr2wo6WIr5VjcHOVYEAe5Nla9e+OMX6piG5W+bZ4kYN4+A73ma0ym
         3Flg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pHMz3rI79/njeGoNvnnMmMVDwBZ8a5Z9yd2P7n1PACg=;
        b=iuvkuLpGTm81eeOnhsjJpFOPaINPaY21Ku5vfSbsEOs6dn4AnnTBB3e5LwHTkclerU
         EeZQUvmx0gKPY7XkjFJ4lFGYqpomkL3i1EZb5dY6WuVimNFFHFHbUxiqlHjpxiZCbmWq
         utkZ8Jx2bu4mbckrw8aibetNEvNUvOh/xugueYpAYeaNUGnBAhvO73Gd/tRFCGvUtLZQ
         tfIV6/ur3zYhopMEPiksditRt4kU0U5Xad9dBV30J66wN5AUMR05GSHGsLICrBSlFFFT
         QdV+sfHUWdtLjHZ6hp9+rziD75KlbbXPaGVVdXIZ6yrFEFnqyLl2Uuob3kO9qsCm4PeN
         SBFg==
X-Gm-Message-State: APjAAAVXnhK4vpp3aDvvT+0g7aIaO3Jt1mC14RQeqfovO+y3qcHqorvm
        ufcWcExGHRJQ0id5YQDKFEcsbw5dBKN0Y07sM8w=
X-Google-Smtp-Source: APXvYqzfmzyNX5EQjlFONRG3rDdocVivj9UxvNPZm/Ddo3brrImV3Mp//aQ2akfeA4VPpyUaP0LWrbT2w5Mp5flc7v4=
X-Received: by 2002:aca:b905:: with SMTP id j5mr11145937oif.15.1556395765620;
 Sat, 27 Apr 2019 13:09:25 -0700 (PDT)
MIME-Version: 1.0
References: <20190423090235.17244-1-jbrunet@baylibre.com> <20190423090235.17244-7-jbrunet@baylibre.com>
In-Reply-To: <20190423090235.17244-7-jbrunet@baylibre.com>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Sat, 27 Apr 2019 22:09:14 +0200
Message-ID: <CAFBinCDJZ2B_1_DdTRN+P9ter7kOgUHegMT-7pVODwKp7mkTKw@mail.gmail.com>
Subject: Re: [PATCH v2 6/7] mmc: meson-gx: remove Rx phase tuning
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
> This remove all the code related to phase settings. Using the Rx phase
> for tuning has not been reliable. We had several issues over the past
> months, on both v2 and v3 mmc chips After discussing the issue matter
> with Amlogic, They suggested to set a phase shift of 180 between Core and
> Tx and use signal resampling for the tuning.
>
> Since we won't be playing with the phase anymore, let's remove all the
> clock code related to it and set the appropriate value on init.
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
