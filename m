Return-Path: <SRS0=NWWL=SU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E94BC10F14
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 09:52:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1DF6120821
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 09:52:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388564AbfDRJwB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Apr 2019 05:52:01 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:38874 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388359AbfDRJwA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Apr 2019 05:52:00 -0400
Received: by mail-ed1-f65.google.com with SMTP id d13so1284937edr.5
        for <linux-kernel@vger.kernel.org>; Thu, 18 Apr 2019 02:51:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Py+W8O5r+OgardGm4gdSqsDVm4dd/+R1JdVdjbJLkL4=;
        b=rfv52c2FnkFqliZNCSsvAUIOV0Ti4S8RCT3MGsek4mkCiTN/pKFJNsIAVKiQuQuQUK
         dxezfRN3fMUqrmut7j3t5rQ8kIYVqGLggML61eniLCTiyxgo7Lyeh2WvtcA5Jo5/fx1s
         HmFgRsZWo5SP4kKT2I7cOdKNgeeZGyl4qNmTubiaHvDaA4jslP1z+9d6+KrhPRCCYgSC
         B8L/dQUhPSVqCn7gTWkjllJC4lfnMieVziFsEIQaRWnmX09EXPidXsRHjPZTj5kflzL9
         3zE4QwldBhyDlTHC3QpjcWW3NI329cEfcbE5DngcxqmuFV/HBwJpO4qOh8zIwNQQyXxo
         wWtg==
X-Gm-Message-State: APjAAAUKxqA5M0Wd6hOkwjHWnMpiOnxTQoh3KYYijMPOZpLBOxYCbL3c
        ozJWssE+nfGw7rTd8O+cyTzqxb5XzLw=
X-Google-Smtp-Source: APXvYqx2gsxzK3X1zm/CM1fBagbTF7LGU65ElbodXTDR2rtaPtk+1a1Gb8oIqhrHO+PljRQVcM0/OA==
X-Received: by 2002:a17:906:b298:: with SMTP id q24mr50365887ejz.62.1555581118296;
        Thu, 18 Apr 2019 02:51:58 -0700 (PDT)
Received: from shalem.localdomain (84-106-84-65.cable.dynamic.v4.ziggo.nl. [84.106.84.65])
        by smtp.gmail.com with ESMTPSA id h11sm388982eds.44.2019.04.18.02.51.57
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Thu, 18 Apr 2019 02:51:57 -0700 (PDT)
Subject: Re: [PATCH v3 2/3] HID: quirks: Fix keyboard + touchpad on Lenovo
 Miix 630 for DT
To:     Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Jeffrey Hugo <jeffrey.l.hugo@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>, mark.rutland@arm.com,
        Jiri Kosina <jikos@kernel.org>,
        Lee Jones <lee.jones@linaro.org>, bjorn.andersson@linaro.org,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>, agross@kernel.org,
        david.brown@linaro.org,
        "open list:HID CORE LAYER" <linux-input@vger.kernel.org>,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        lkml <linux-kernel@vger.kernel.org>
References: <20190415160915.16324-1-jeffrey.l.hugo@gmail.com>
 <20190415161108.16419-1-jeffrey.l.hugo@gmail.com>
 <CAO-hwJKeACBPW52ej6mVeG4aVDYvGF8zEMtegonVwFjT-ZoLOQ@mail.gmail.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <a47672ed-fc25-dd07-0ddf-2deca08283ef@redhat.com>
Date:   Thu, 18 Apr 2019 11:51:56 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <CAO-hwJKeACBPW52ej6mVeG4aVDYvGF8zEMtegonVwFjT-ZoLOQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 18-04-19 11:34, Benjamin Tissoires wrote:
> On Mon, Apr 15, 2019 at 6:11 PM Jeffrey Hugo <jeffrey.l.hugo@gmail.com> wrote:
>>
>> Following up on commit 2bafa1e96254 ("HID: quirks: Fix keyboard + touchpad
>> on Lenovo Miix 630"), the devicetree (DT) identifier for the combo keyboard
>> + touchpad device is "elan,combo400-i2c", which differs from the ACPI ID,
>> thus if we want the quirk to work properly when booting via DT instead of
>> ACPI, we need to key off the DT id as well.
>>
>> Signed-off-by: Jeffrey Hugo <jeffrey.l.hugo@gmail.com>
>> ---
>>   drivers/hid/hid-quirks.c | 3 ++-
>>   1 file changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/hid/hid-quirks.c b/drivers/hid/hid-quirks.c
>> index 77ffba48cc73..00c08f8318b8 100644
>> --- a/drivers/hid/hid-quirks.c
>> +++ b/drivers/hid/hid-quirks.c
>> @@ -997,7 +997,8 @@ bool hid_ignore(struct hid_device *hdev)
>>                          return true;
>>                  /* Same with product id 0x0400 */
>>                  if (hdev->product == 0x0400 &&
>> -                   strncmp(hdev->name, "QTEC0001", 8) != 0)
>> +                   (strncmp(hdev->name, "QTEC0001", 8) != 0 ||
>> +                    strncmp(hdev->name, "elan,combo400-i2c", 17) != 0))
> 
> I think we are taking the problem the wrong way here.
> 
> When I first introduced 6ccfe64, I thought 0x0400 would be reserved
> for the elan_i2c touchpads only. But it turns out we are deliberately
> disabling valid HID touchpads hoping that they would be picked up by
> elan_i2c when elan_i2c has its own whitelist of devices.
> 
> How about we turn this into list with the matching ones from elan_i2c:
> if ((hdev->product == 0x0400 || hdev->product == 0x0401) &&
>     (strncmp(hdev->name, "ELAN0000", 8) == 0 ||
>      strncmp(hdev->name, "ELAN0100", 8) == 0 ||
>      ...
>      strncmp(hdev->name, "ELAN1000", 8) == 0))
>        return true;
> 
> So next time we need to force binding a HID touchpad to elan_i2c, we
> can just blacklist here and whitelist it in elan_i2c.

This indeed sounds like a better way forward with this.

Regards,

Hans

