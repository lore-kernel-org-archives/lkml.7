Return-Path: <SRS0=3iFO=VV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_SBL,URIBL_SBL_A,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D002C7618B
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 06:49:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1FBC72190F
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 06:49:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="BUOqIo/x"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726408AbfGXGtG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jul 2019 02:49:06 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:39719 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725851AbfGXGtG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jul 2019 02:49:06 -0400
Received: by mail-wr1-f66.google.com with SMTP id x4so45577313wrt.6
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jul 2019 23:49:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:openpgp:autocrypt:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=rVBZFDEe6GlwoB61u8GoPEgkc+ywoIeVzBMII2nQSVg=;
        b=BUOqIo/xN9pAYyQd9luaZ8F6vihcN9vgU7dLJ85uWoTV9TBl+g0jD7uakEoxVgeAqy
         668/J4GuDA1VCKxGoW/YtSDhn2nApeaWFKqPijRsaqqE9gzB4Lhp8lUZe8IfASYQRVwp
         7wQBGj7MmORGywMOEmmt+SYKfV/DZ/HeOgz3s7wiUGmGa/Zy3XHSvIH3IpFrNIzlvPKp
         VnSt/88t/YsU9aN2E4dQP87zzgYnmuQVx1R4GwFLIgHHehQ+nPQMMgXsACjLs3n4j/fX
         icbuodNZVEP80uXd36I97CTBiOTDue9D2EG4QgjaXfD5uuCvEzOCypQ95uNB4qx1V0+8
         FIZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
         :organization:message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=rVBZFDEe6GlwoB61u8GoPEgkc+ywoIeVzBMII2nQSVg=;
        b=mNYmVfh5Q23Wb/KO+KlwJ1LWYw1kqqkucCnwkoZgI3YGIFPKFcvYCUXi/GSdm44C+J
         hCZZfV6PZ5Cw+Jg/TFa8X0kXlASShSlYwgAG2r0xQGJmG4q9LFgW7fazhAeLm0KY4FfH
         1EfX43aXN1tY93ZrjdR4HITaXqYyrXdZDJHZ131jHMhIxlmkG7557OfIfJGVwv1GVq6f
         xnnWQDSfgadLcCZTnan1gheKtC7r2JtXRfUHRM5jmZM9ELWKkrnZD6x8FEhEj15/vLyr
         v3jSKvWkj6ofOXWNX+lsBNKZveakRttDIxVG4ocTqyr6akIpi39b2VExOUW/doiPzXXa
         vheQ==
X-Gm-Message-State: APjAAAW7nH6rR5uACfFRGAGFacwJ9cONrl1eps+Gh7JYxZYu84lP6gCP
        XMzDTEIlzGaI3V+VECAGt1njYw==
X-Google-Smtp-Source: APXvYqyb8y6xZQDAepGq+kAcakKbyUotanWH8No0Jcn34mStLscqEaHiOpGjBd6o+jDCz36RHMTQ7w==
X-Received: by 2002:a05:6000:100f:: with SMTP id a15mr64905486wrx.325.1563950943127;
        Tue, 23 Jul 2019 23:49:03 -0700 (PDT)
Received: from [192.168.1.62] (176-150-251-154.abo.bbox.fr. [176.150.251.154])
        by smtp.gmail.com with ESMTPSA id j9sm50350060wrn.81.2019.07.23.23.49.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 23 Jul 2019 23:49:02 -0700 (PDT)
Subject: Re: [PATCH] arm64: dts: meson: odroid-n2: keep SD card regulator
 always on
To:     Anand Moon <linux.amoon@gmail.com>
Cc:     Xavier Ruppen <xruppen@gmail.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        linux-amlogic@lists.infradead.org,
        Linux Kernel <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
References: <20190719192954.26481-1-xruppen@gmail.com>
 <eadcf7ef-4aad-fa4f-3b1b-a5238f394b1e@baylibre.com>
 <CANAwSgTbvQO5qum1K3q8+J=WO4yLjadnZSZYf_AAhbf+CJm92Q@mail.gmail.com>
From:   Neil Armstrong <narmstrong@baylibre.com>
Openpgp: preference=signencrypt
Autocrypt: addr=narmstrong@baylibre.com; prefer-encrypt=mutual; keydata=
 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
 ZaTUOEkgIor5losDrePdPgE=
Organization: Baylibre
Message-ID: <cdb986e9-e905-8001-630a-cf3e3f8c5369@baylibre.com>
Date:   Wed, 24 Jul 2019 08:49:01 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <CANAwSgTbvQO5qum1K3q8+J=WO4yLjadnZSZYf_AAhbf+CJm92Q@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Anand,

On 24/07/2019 07:30, Anand Moon wrote:
> Hi All,
> 
> On Mon, 22 Jul 2019 at 12:51, Neil Armstrong <narmstrong@baylibre.com> wrote:
>>
>> On 19/07/2019 21:29, Xavier Ruppen wrote:
>>> When powering off the Odroid N2, the tflash_vdd regulator is
>>> automatically turned off by the kernel. This is a problem
>>> when issuing the "reboot" command while using an SD card.
>>> The boot ROM does not power this regulator back on, blocking
>>> the reboot process at the boot ROM stage, preventing the
>>> SD card from being detected.
>>>
>>> Adding the "regulator-always-on" property fixes the problem.
>>>
>>> Signed-off-by: Xavier Ruppen <xruppen@gmail.com>
>>> ---
>>>
>>> Here is what the boot ROM output looks like without this patch:
>>>
>>>     [root@alarm ~]# reboot
>>>     [...]
>>>     [   24.275860] shutdown[1]: All loop devices detached.
>>>     [   24.278864] shutdown[1]: Detaching DM devices.
>>>     [   24.287105] kvm: exiting hardware virtualization
>>>     [   24.318776] reboot: Restarting system
>>>     bl31 reboot reason: 0xd
>>>     bl31 reboot reason: 0x0
>>>     system cmd  1.
>>>     G12B:BL:6e7c85:7898ac;FEAT:E0F83180:2000;POC:F;RCY:0;
>>>     EMMC:800;NAND:81;SD?:0;SD:400;USB:8;LOOP:1;EMMC:800;
>>>     NAND:81;SD?:0;SD:400;USB:8;LOOP:2;EMMC:800;NAND:81;
>>>     SD?:0;SD:400;USB:8;LOOP:3; [...]
>>>
>>> Other people can be seen having this problem on the odroid
>>> forum [1].
>>>
>>> The cause of the problem was found by Martin Blumenstingl
>>> on #linux-amlogic. We may want to add his Suggested-by tag
>>> if he agrees.
>>>
>>> [1] https://forum.odroid.com/viewtopic.php?f=176&t=33993
>>>
>>>  arch/arm64/boot/dts/amlogic/meson-g12b-odroid-n2.dts | 1 +
>>>  1 file changed, 1 insertion(+)
>>>
>>> diff --git a/arch/arm64/boot/dts/amlogic/meson-g12b-odroid-n2.dts b/arch/arm64/boot/dts/amlogic/meson-g12b-odroid-n2.dts
>>> index 81780ffcc7f0..4e916e1f71f7 100644
>>> --- a/arch/arm64/boot/dts/amlogic/meson-g12b-odroid-n2.dts
>>> +++ b/arch/arm64/boot/dts/amlogic/meson-g12b-odroid-n2.dts
>>> @@ -53,6 +53,7 @@
>>>
>>>               gpio = <&gpio_ao GPIOAO_8 GPIO_ACTIVE_HIGH>;
>>>               enable-active-high;
>>> +             regulator-always-on;
>>>       };
>>>
>>>       tf_io: gpio-regulator-tf_io {
>>>
>>
>> Surely solves the situation, thanks !
>>
>> please add a comment on top of "regulator-always-on" to explain why we always enable it,
>> note we should always enable it in case of watchdog reboot or other uncontrolled reset,
>> this regulator must never be disabled.
>>
>> Reviewed-by: Neil Armstrong <narmstrong@baylibre.com>
>>
>> Thanks,
>> Neil
>>
> 
> I am afraid this did not fix the issue I was also facing with
> Archlinux on Odroid N2 using mainline u-boot.

Seems to be a separate issue, could we start a separate thread with all your
setup (branch, git SHAa, configs, board setup, ...) for this ?

Thanks,
Neil

> Here is the log of at my end using latest mainline u-boot with Neil's patches.
> 
> [0] https://pastebin.com/HNmeY5uF
> 
> Well this issue also persist with eMMC not getting detected after reboot
> If I try to change the dts to fix the sdcard.
> 
> I am checking this should we enable regulator-boot-on option but still no luck.
> 
> Best Regards
> -Anand
> 

