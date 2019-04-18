Return-Path: <SRS0=NWWL=SU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B459C10F14
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 14:43:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 34B95206B6
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 14:43:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CX0U2wwx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389378AbfDROnO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Apr 2019 10:43:14 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:36850 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388277AbfDROnN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Apr 2019 10:43:13 -0400
Received: by mail-io1-f66.google.com with SMTP id f6so2113975iop.3;
        Thu, 18 Apr 2019 07:43:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=c+A5eaMzv9zYcABexiYDdO2I+1VpcEFtsO96ORTPI3I=;
        b=CX0U2wwxmEARdNc5X/jPHInm2M28GxG9j5I1lGW0Jx+js6KDkRvKVeWnwEmzK+pwlp
         VMOcmvElKGRpq3I1F6+azoxAJrPurLeslOMRTWY5P/URcop2p35l/eXGIfz/ER1JfX0x
         OeARxwJjCSZ4O0x+CW27VmOrHgFrQwbnxxfsmRQE5HmTPlglHdQArF7tJgl8hTdqHbyh
         Yw2GRxQ+6kfsWu5tfiZlnaQoppxYAydvoQguyQMmmJ/qfd5F7QiYKizLwL6KMb8UT8Pe
         fNmPH0jfnhsExBVtjvJx0U0zIhR5KRkHzRVuq9sTch5XLlCoS6uwQH6FydBYkoRvWvAE
         VguQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=c+A5eaMzv9zYcABexiYDdO2I+1VpcEFtsO96ORTPI3I=;
        b=ODMYyazcl37Axwiy6oCk/lGBH4tdGjHbpMzCwdkolHQigdgEUHI7VSKJMUSU0cZqJx
         fNpu5ZjzG7VgMSX2z92TgnH7g1Ka8NTxCUGD4UjWEqW9aD1ZlH82MaFdJ6oPHZeRmUs/
         ZpOqtLi+7z9iGXlsiDTCbOGgNxzYXo3CNNjEjDj7QKyoyfrwaipWC+VQkN8ad+vUwy/N
         tD50vCUzc7tZUPQ5r2VuG3wy9HY14aXVlzRbD4yKIu4yokICow8vTf5RSG4u+EM2yYMN
         HLmiXbXsN9yIjgApLsKu3u6r/vE4IfU0Ti0MGHDJmXVw9n+Pfu/tjWmo6De87gQj9MwJ
         VEgg==
X-Gm-Message-State: APjAAAWZgcZTUChrowpVB2hwfLogtwtZsoYX+Rh+6JoUXn3+X42pWEie
        RP4d8GBZrl3drAA5WJlXJ6XZA4nuW/HJGobvfe0=
X-Google-Smtp-Source: APXvYqy5KFcgM4pLF9BgFyBZiJrGNRi9PKsnmOiTtyM9uKGjfV82cIXYoQLkExleYTdacGMFnveDAJs+GOqIpmqDdK8=
X-Received: by 2002:a6b:b505:: with SMTP id e5mr62500238iof.277.1555598592936;
 Thu, 18 Apr 2019 07:43:12 -0700 (PDT)
MIME-Version: 1.0
References: <20190415160915.16324-1-jeffrey.l.hugo@gmail.com>
 <20190415161108.16419-1-jeffrey.l.hugo@gmail.com> <CAO-hwJKeACBPW52ej6mVeG4aVDYvGF8zEMtegonVwFjT-ZoLOQ@mail.gmail.com>
 <a47672ed-fc25-dd07-0ddf-2deca08283ef@redhat.com>
In-Reply-To: <a47672ed-fc25-dd07-0ddf-2deca08283ef@redhat.com>
From:   Jeffrey Hugo <jeffrey.l.hugo@gmail.com>
Date:   Thu, 18 Apr 2019 08:43:02 -0600
Message-ID: <CAOCk7NrSiepivq8qjXJ1eKai3gdUD+uNy3eC6wgjA3ubPzt0RQ@mail.gmail.com>
Subject: Re: [PATCH v3 2/3] HID: quirks: Fix keyboard + touchpad on Lenovo
 Miix 630 for DT
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Jiri Kosina <jikos@kernel.org>,
        Lee Jones <lee.jones@linaro.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>, agross@kernel.org,
        David Brown <david.brown@linaro.org>,
        "open list:HID CORE LAYER" <linux-input@vger.kernel.org>,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 18, 2019 at 3:51 AM Hans de Goede <hdegoede@redhat.com> wrote:
>
> Hi,
>
> On 18-04-19 11:34, Benjamin Tissoires wrote:
> > On Mon, Apr 15, 2019 at 6:11 PM Jeffrey Hugo <jeffrey.l.hugo@gmail.com> wrote:
> >>
> >> Following up on commit 2bafa1e96254 ("HID: quirks: Fix keyboard + touchpad
> >> on Lenovo Miix 630"), the devicetree (DT) identifier for the combo keyboard
> >> + touchpad device is "elan,combo400-i2c", which differs from the ACPI ID,
> >> thus if we want the quirk to work properly when booting via DT instead of
> >> ACPI, we need to key off the DT id as well.
> >>
> >> Signed-off-by: Jeffrey Hugo <jeffrey.l.hugo@gmail.com>
> >> ---
> >>   drivers/hid/hid-quirks.c | 3 ++-
> >>   1 file changed, 2 insertions(+), 1 deletion(-)
> >>
> >> diff --git a/drivers/hid/hid-quirks.c b/drivers/hid/hid-quirks.c
> >> index 77ffba48cc73..00c08f8318b8 100644
> >> --- a/drivers/hid/hid-quirks.c
> >> +++ b/drivers/hid/hid-quirks.c
> >> @@ -997,7 +997,8 @@ bool hid_ignore(struct hid_device *hdev)
> >>                          return true;
> >>                  /* Same with product id 0x0400 */
> >>                  if (hdev->product == 0x0400 &&
> >> -                   strncmp(hdev->name, "QTEC0001", 8) != 0)
> >> +                   (strncmp(hdev->name, "QTEC0001", 8) != 0 ||
> >> +                    strncmp(hdev->name, "elan,combo400-i2c", 17) != 0))
> >
> > I think we are taking the problem the wrong way here.
> >
> > When I first introduced 6ccfe64, I thought 0x0400 would be reserved
> > for the elan_i2c touchpads only. But it turns out we are deliberately
> > disabling valid HID touchpads hoping that they would be picked up by
> > elan_i2c when elan_i2c has its own whitelist of devices.
> >
> > How about we turn this into list with the matching ones from elan_i2c:
> > if ((hdev->product == 0x0400 || hdev->product == 0x0401) &&
> >     (strncmp(hdev->name, "ELAN0000", 8) == 0 ||
> >      strncmp(hdev->name, "ELAN0100", 8) == 0 ||
> >      ...
> >      strncmp(hdev->name, "ELAN1000", 8) == 0))
> >        return true;
> >
> > So next time we need to force binding a HID touchpad to elan_i2c, we
> > can just blacklist here and whitelist it in elan_i2c.
>
> This indeed sounds like a better way forward with this.

This sounds good to me.  Let me implement it and test with the Miix
630.  Thanks for the suggestion.
