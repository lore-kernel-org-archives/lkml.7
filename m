Return-Path: <SRS0=NWWL=SU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22CAFC10F14
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 09:35:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E7413214DA
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 09:35:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388441AbfDRJfA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Apr 2019 05:35:00 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:40395 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388346AbfDRJfA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Apr 2019 05:35:00 -0400
Received: by mail-qt1-f193.google.com with SMTP id x12so1434583qts.7
        for <linux-kernel@vger.kernel.org>; Thu, 18 Apr 2019 02:34:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AH2jzuxgQkHCo2L+2wZAXOkBXc1bgQpke4ii6ID2BoY=;
        b=R+gYijRyXqOPl2u2YyiZ67ewAzVjodQt5egzDfw2lD7WUhDCLXZSfT2NYrMchiAFSz
         N8JgkvVGVlyDpyN7aXTWLmX95g4OlWKyt6w8BVqlE5jzHonL16RcNfK3Ebsvrh+AdDD2
         gI+f5Exzd7ASeZmyF3LG0DLciV5t4X+VudENx7HPSfzZOTJXaBNEW4nJFawY3HOvfryV
         P5mYWNWdzo26c1zqpd5NhDaM+9PGHk1pcsdhrZj7e6ZZegKWBV7Q3nOnovEcDdezcC5z
         nEBYMRTUwfnnqZHWJ3EXqi2AcpVBgFR54d+oPnP/rTjJtcZEFU6o7ucsYiKxi8uyziWY
         vGSQ==
X-Gm-Message-State: APjAAAUDWsmCsqaM6bk+bjXLnQDhlrQo5Mx6MNnxoZc096lBDKXeB8P9
        n/Yjty/GQn9enoMRw7b8ZdH2w2M1v/4R0hEkWyqkyg==
X-Google-Smtp-Source: APXvYqxDSHpQXPNMTTgzHfDvUmGXScaKdmthOpUsh28o7Tyenw0R4snaJ6HkzjsvAm0TVijSsQIKD0+N7F2D2s2l5Ss=
X-Received: by 2002:ac8:24cf:: with SMTP id t15mr79009585qtt.112.1555580099339;
 Thu, 18 Apr 2019 02:34:59 -0700 (PDT)
MIME-Version: 1.0
References: <20190415160915.16324-1-jeffrey.l.hugo@gmail.com> <20190415161108.16419-1-jeffrey.l.hugo@gmail.com>
In-Reply-To: <20190415161108.16419-1-jeffrey.l.hugo@gmail.com>
From:   Benjamin Tissoires <benjamin.tissoires@redhat.com>
Date:   Thu, 18 Apr 2019 11:34:47 +0200
Message-ID: <CAO-hwJKeACBPW52ej6mVeG4aVDYvGF8zEMtegonVwFjT-ZoLOQ@mail.gmail.com>
Subject: Re: [PATCH v3 2/3] HID: quirks: Fix keyboard + touchpad on Lenovo
 Miix 630 for DT
To:     Jeffrey Hugo <jeffrey.l.hugo@gmail.com>,
        Hans de Goede <hdegoede@redhat.com>
Cc:     Rob Herring <robh+dt@kernel.org>, mark.rutland@arm.com,
        Jiri Kosina <jikos@kernel.org>,
        Lee Jones <lee.jones@linaro.org>, bjorn.andersson@linaro.org,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>, agross@kernel.org,
        david.brown@linaro.org,
        "open list:HID CORE LAYER" <linux-input@vger.kernel.org>,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 15, 2019 at 6:11 PM Jeffrey Hugo <jeffrey.l.hugo@gmail.com> wrote:
>
> Following up on commit 2bafa1e96254 ("HID: quirks: Fix keyboard + touchpad
> on Lenovo Miix 630"), the devicetree (DT) identifier for the combo keyboard
> + touchpad device is "elan,combo400-i2c", which differs from the ACPI ID,
> thus if we want the quirk to work properly when booting via DT instead of
> ACPI, we need to key off the DT id as well.
>
> Signed-off-by: Jeffrey Hugo <jeffrey.l.hugo@gmail.com>
> ---
>  drivers/hid/hid-quirks.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/hid/hid-quirks.c b/drivers/hid/hid-quirks.c
> index 77ffba48cc73..00c08f8318b8 100644
> --- a/drivers/hid/hid-quirks.c
> +++ b/drivers/hid/hid-quirks.c
> @@ -997,7 +997,8 @@ bool hid_ignore(struct hid_device *hdev)
>                         return true;
>                 /* Same with product id 0x0400 */
>                 if (hdev->product == 0x0400 &&
> -                   strncmp(hdev->name, "QTEC0001", 8) != 0)
> +                   (strncmp(hdev->name, "QTEC0001", 8) != 0 ||
> +                    strncmp(hdev->name, "elan,combo400-i2c", 17) != 0))

I think we are taking the problem the wrong way here.

When I first introduced 6ccfe64, I thought 0x0400 would be reserved
for the elan_i2c touchpads only. But it turns out we are deliberately
disabling valid HID touchpads hoping that they would be picked up by
elan_i2c when elan_i2c has its own whitelist of devices.

How about we turn this into list with the matching ones from elan_i2c:
if ((hdev->product == 0x0400 || hdev->product == 0x0401) &&
   (strncmp(hdev->name, "ELAN0000", 8) == 0 ||
    strncmp(hdev->name, "ELAN0100", 8) == 0 ||
    ...
    strncmp(hdev->name, "ELAN1000", 8) == 0))
      return true;

So next time we need to force binding a HID touchpad to elan_i2c, we
can just blacklist here and whitelist it in elan_i2c.

Cheers,
Benjamin

>                         return true;
>                 break;
>         }
> --
> 2.17.1
>
