Return-Path: <SRS0=nVcb=SO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F26BAC10F0E
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 20:32:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BECD82171F
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 20:32:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MpCeaRot"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726981AbfDLUcQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Apr 2019 16:32:16 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:42691 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726755AbfDLUcP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Apr 2019 16:32:15 -0400
Received: by mail-wr1-f66.google.com with SMTP id g3so13481545wrx.9;
        Fri, 12 Apr 2019 13:32:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=shRu0w6LOGNuM8eR6LVuZyZO1EnLS3eaLumjGGzE81Y=;
        b=MpCeaRotYXIrnj0Pm+OPm5DM8q7Gi7fXsFYAYpxsT22yY253scGOLOWgHsICdMYrdi
         z1kc0URnkrtZxmVMv5RAni5G6zAtVSO931/qv/Q/Fgv88wt4Rpc7cG1cmjmxiBbstL+K
         9RxaGqvriEZcqjlVjDX7ztrXYu3qAp/16eETbBRESWt+gIUNaQZseVl7rE9G0EZeZktn
         WtvYLDbnRAM3/nKg5z05G/mvTl/LxhRCIn33mWVD9gYKMZeuyu8RfvJRyUmfloX0HMOz
         CaxUWfMO0/xC8v6q9d2DwVmBIvfmVOVqVgGJj6Eq8RiJ4j522t4Nu+4bDi2TLx967Rjj
         Q7cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=shRu0w6LOGNuM8eR6LVuZyZO1EnLS3eaLumjGGzE81Y=;
        b=rC2d0Ctwm0pbEpxncSugu1WyKd+2wgJsT9pnQWyLmXDfY2dL8YhgybuWZ0dPUltug5
         /bjBJ7Ke/76mzvHRZXXAbfjAJo2R5Jt+WUujy9Tcs+qudlrsksnsmYx9RzVtdgSYELzq
         fS8CJGQ/P1RK7DxBS0E/EUTl3hYABhokZ+2ODFV20DgtESJziNAiCH1k1pBun7a/BRBP
         2ehSH3shqWkluFY532t+sTNMRMOEJjXzzKrk7J4EP+nDHwS/wLbJii4pUq86OvNm5EHd
         u3PDkfaKMxkGQ5vig9LMQCjm7Ui5KGLlt7jrCnkUqYaViKwHGu3DW1GMPXjChHHVc8us
         miag==
X-Gm-Message-State: APjAAAUTUkPhyq9hxPwIF1sQi4X9RL5GXMazMqamV3WxcRhP4z9JZz4U
        DSjkMo0SXcuX/2sJjwwh5IozvmnqbCI=
X-Google-Smtp-Source: APXvYqxCVqshd8bEfJb6FRpVXpHrXvUeuzayS49Rd3Mu3ylmyOJJ2TJ65WqBhyVGZAqsC2UK6K3dkw==
X-Received: by 2002:adf:df08:: with SMTP id y8mr1058320wrl.91.1555101133727;
        Fri, 12 Apr 2019 13:32:13 -0700 (PDT)
Received: from [192.168.20.141] ([194.99.104.18])
        by smtp.gmail.com with ESMTPSA id b204sm13251457wmh.29.2019.04.12.13.32.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 12 Apr 2019 13:32:13 -0700 (PDT)
Subject: Re: [PATCH v2 05/11] platform/x86: asus-wmi: Support queued WMI event
 codes
To:     Daniel Drake <drake@endlessm.com>
Cc:     Corentin Chary <corentin.chary@gmail.com>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        acpi4asus-user <acpi4asus-user@lists.sourceforge.net>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        Linux Kernel <linux-kernel@vger.kernel.org>,
        Endless Linux Upstreaming Team <linux@endlessm.com>
References: <a8dd77f3-1e28-6416-5f04-aff44d5bb6d6@gmail.com>
 <777027ac-921e-ee37-493e-974b49242d18@gmail.com>
 <142fe2e3-b560-6136-32df-b14bb4ac46f7@gmail.com>
 <CAD8Lp47yHMt-zYd02s3AgBDNQvRA5=Ccp4id8nTVHnQOtT+4_Q@mail.gmail.com>
From:   Yurii Pavlovskyi <yurii.pavlovskyi@gmail.com>
Message-ID: <b7b1834f-42e2-b652-9944-eb9b45b81cd0@gmail.com>
Date:   Fri, 12 Apr 2019 22:32:10 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <CAD8Lp47yHMt-zYd02s3AgBDNQvRA5=Ccp4id8nTVHnQOtT+4_Q@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 12.04.19 09:48, Daniel Drake wrote:
> On Thu, Apr 11, 2019 at 1:44 PM Yurii Pavlovskyi
> <yurii.pavlovskyi@gmail.com> wrote:
>> Event codes are expected to be polled from a queue on at least some
>> models.
> 
> Maybe avoid the word "poll" since it suggests something else (at least to me).

Ok, will change this in the code as well.

>>> The fix flushes the old key codes out of the queue on load and after
>> receiving event the queue is read until either ..FFFF or 1 is encountered.
>>
>> It might be considered a minor issue and no normal user would likely to
>> observe this (there is little reason unloading the driver), but it does
>> significantly frustrate a developer who is unlucky enough to encounter
>> this.
>>
>> Introduce functionality for flushing and processing queued codes, which is
>> enabled via quirk flag for ASUS7000. It might be considered if it is
>> reasonable to enable it everywhere (might introduce regressions) or always
>> try to flush the queue on module load and try to detect if this quirk is
>> present in the future.
>>
>> This patch limits the effect to the specific hardware defined by ASUS7000
>> device that is used for driver detection by vendor driver of Fx505. The
>> fallback is also implemented in case initial flush fails.
> 
> Which vendor driver are you referring to here?

The ASUS Keyboard hotkeys Driver V2.0.5 which is available to download for
FX505 has this in his INF file:
[ATKP.ntamd64]

%DeviceDesc1% = NO_DRV64, ACPI\ASUS7000

But this driver is not generic. It is limited to very specific hardware,
I'd guess gaming series (for instance K54C does not have this device). It
was rather a way to avoid breaking anything. I think your suggestion below
is much better.

> 
> Researching more:
> In our database of 144 Asus models, 142 of them have GANQ.
> 
> Of those 142, 9 of them return One in the empty-queue case. The other
> 133 match your FX505GM device exactly. So it seems valid to interpret
> both 0xffff and 0x1 as queue-end markers.
> 
> The 2 devices that do not have GANQ are not laptops. They also do not
> have the _UID "ATK" WMI device, they only have "ASUSWMI" and their WMI
> _WED method does not use a queue.
> There are a few more units that have both ASUSWMI and ATK devices, and
> the ASUSWMI device appears to never be queued.
> Another observation is that the ASUSWMI device works with notify code
> 0xD2, and the ATK device works with 0xFF.
> 
> Nailing this down a bit further, I found a DSDT for EEEPC X101H: that
> one only has ASUSWMI and it is also not queued.
> 
> So I think you should make this queue behaviour applied more
> generically, but either avoid it when the WMI device _UID is not "ATK"
> (as discussed in the DCTS/DSTS thread), or avoid it when the notify
> code is not 0x>
> Thanks
> Daniel

Thanks a lot for your research, it's much appreciated! That seems to
confirm that these two quirks are actually connected with ATK device. I
guess it makes sense to combine the detection for both of them. Also to
flush the queue we need to know the notify code beforehand, because it is
checked in _WED so checking for ATK seems reasonable to me.

Best regards,
Yurii
