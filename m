Return-Path: <SRS0=lq4r=TU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D06B1C46470
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 17:57:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AD659206B6
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 17:57:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="iJIoy/ix"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727030AbfETR5B (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 May 2019 13:57:01 -0400
Received: from mail-oi1-f193.google.com ([209.85.167.193]:33879 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726566AbfETR5B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 May 2019 13:57:01 -0400
Received: by mail-oi1-f193.google.com with SMTP id u64so1456658oib.1
        for <linux-kernel@vger.kernel.org>; Mon, 20 May 2019 10:57:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=O+YhahOwl72NephherQ5nxh/plQqDrRpWmjW6ty6chw=;
        b=iJIoy/ixx6XMCclG0KXm7/4HGgiK0ifwcRsSK37SAmbU7SEWP52EOkgkw2QGxih4u3
         Mvmx69eb8ymJWNLX8R8nwQ+TvKECMa3frmpyCQW7cvsqa8vvziYTt4I9VpDD6v6jWrZd
         szvPKHxgce/lkR4cBCMufNwPZvr84X/vSxLkrRDTwDyi6Y0O/SJrJCj0jTO5a+SGHZoC
         16VXZP/dmKFRa90rzfzm32BhmJ8gVX/IaTKNEEvWzhl+W1mvIVtCCTyMoXq4csxFQwPV
         DbDQbZyM2g9m1FlQbvEGBY7YUopt/O8GJl17DO4IdeVWj7bmAmwBEPAH4a5whgKvaKYH
         dHqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=O+YhahOwl72NephherQ5nxh/plQqDrRpWmjW6ty6chw=;
        b=NFMS/uhWRwL5uiyukeea4+8GTPeEXy3NTMCiq0gDI9rJ3Hx6i3oC3VSs9zz37SaXbj
         5ytiXPlhnebN29hjUDTclEoj+VnwJXxeGknITNSJqqRXMipOQvc19pkTR4CpLwU+RuMz
         OjRV3Of8quvqfi66T46eWpkuLTh9D85qfdSFAbyyiUIGyFzlTY1AB8YxqP8g9DgG2ymc
         3MUiPvZiCKxT9aclvAhMDCXfd3TeVAtxRGbmti/HdrnvQOMYa6O1ARbT4aVUlWCDVWbf
         RXo4iiKVOrbG5zwuU2muNB6Vy6mEiOb6byaWQgHJe+8mq7u2ayEUbwt3R+qxdY3kV65B
         /7ZQ==
X-Gm-Message-State: APjAAAXd3uubvyFBmGI0ZdPlcBD4WS91v+vQICiBh6D80r0nH0A92xFv
        O9sc7OQ++YMLxp7Z2KThwN8k12bfippW37RSDw0=
X-Google-Smtp-Source: APXvYqy5VAnJeMmPXq3sDvFlEOPBnOK7QobZpzr9pilr4EW7NuXmZblLmTpenR3KYHgu/fJsbCTCAfXRp2y1aTbqpYA=
X-Received: by 2002:aca:5b06:: with SMTP id p6mr282468oib.129.1558375020345;
 Mon, 20 May 2019 10:57:00 -0700 (PDT)
MIME-Version: 1.0
References: <20190520143732.2701-1-narmstrong@baylibre.com> <20190520143732.2701-3-narmstrong@baylibre.com>
In-Reply-To: <20190520143732.2701-3-narmstrong@baylibre.com>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Mon, 20 May 2019 19:56:49 +0200
Message-ID: <CAFBinCAxhEJXO9dsd0e=zJuKgEsAwHrX+Jr7seJpGNjDL+63qg@mail.gmail.com>
Subject: Re: [PATCH 2/2] nvmem: meson-mx-efuse: update with SPDX Licence identifier
To:     Neil Armstrong <narmstrong@baylibre.com>
Cc:     srinivas.kandagatla@linaro.org, linux-amlogic@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 20, 2019 at 4:38 PM Neil Armstrong <narmstrong@baylibre.com> wrote:
>
> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
Reviewed-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
