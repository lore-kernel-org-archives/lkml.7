Return-Path: <SRS0=6dNS=X4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30265C4CED1
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 20:51:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F093F21A4C
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 20:51:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WWLg/P0l"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732433AbfJCUvp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Oct 2019 16:51:45 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:50882 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729551AbfJCUvp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Oct 2019 16:51:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1570135903;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=vnjoTOFDyQSJChzhjYIQAV73Xgv8Ni7ZDZOSyZVwggE=;
        b=WWLg/P0l/Sdx9yaoZ04O++bCaQoKzb71tWAgtSsfVPpxkwiCgrmZ1mblbWpbnYVsAE4v4G
        1mrShOFKMN9uHoI2+I6S1iiPMWBYHm7z85vd4QqWE3Ya/BuvepIdrSFqjxyQ+OamOP9xj3
        3hUciNquw+/wFytfvseXAVKtycR5TsI=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-147-vqf078ZoNVuMd2brbxAlOw-1; Thu, 03 Oct 2019 16:51:41 -0400
Received: by mail-wr1-f72.google.com with SMTP id v18so1645387wro.16
        for <linux-kernel@vger.kernel.org>; Thu, 03 Oct 2019 13:51:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=QdG6MOJurSUHQTcdmBqDPB7/rDTugK2vGncWCK5z81o=;
        b=J+gu7//oQRS9j/EKidj4Rj9/aZ1n4rAiSPF3T7qWz+mfixaT8SNk8msv4e3KTen/Fc
         B0zvLZaAsqSGYLeUgcwPif6QHbhEBuCky9KTnhYt35sc6LsSjtzWy2fJCaECi/o0BJ8T
         eKfzaPdh91l/1wrCMezJqhAdA0KgISqKgqHQWWNU7+wd0hCWkSskRF0OqpxFChKHDQlE
         uH1Mlou7Jk+5v/WiXMRWgNJ/TQU7PJr3WMEkMcFuink/Cy1X5x7+erM8E1+2kkMp4tCK
         dPFUUbTbmljyqp4fKVv1Bkt8QFIlrd9IksGs/87yS10vPpQBAo2s7dY3br44xV+PvKPw
         fBKg==
X-Gm-Message-State: APjAAAUTIbjVk1nnvqPW61n8pCqLTTSJHHlsGLMoULK6d/btapPpoXdA
        seAztYt2Gx9xYS5Ni2lCr5p3DwCZdAPWSpEIWTVMFPQlPaOGLVlLevRxHu6asfYvjSG6nNiA9GE
        sVXZMM5xQ0y31va3BibYJOYOl
X-Received: by 2002:a5d:5708:: with SMTP id a8mr8343533wrv.240.1570135900521;
        Thu, 03 Oct 2019 13:51:40 -0700 (PDT)
X-Google-Smtp-Source: APXvYqxRoK2g19GQf2eAvJp7MRLHXk5+kqndlWHvUn9T3mCNKkdGU4maJmBDOT0p4s0oRgkz7ZChhg==
X-Received: by 2002:a5d:5708:: with SMTP id a8mr8343517wrv.240.1570135900337;
        Thu, 03 Oct 2019 13:51:40 -0700 (PDT)
Received: from shalem.localdomain (2001-1c00-0c14-2800-ec23-a060-24d5-2453.cable.dynamic.v6.ziggo.nl. [2001:1c00:c14:2800:ec23:a060:24d5:2453])
        by smtp.gmail.com with ESMTPSA id b7sm2535993wrj.28.2019.10.03.13.51.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Oct 2019 13:51:39 -0700 (PDT)
Subject: Re: [RFC][PATCH 2/3] usb: roles: Add usb role switch notifier.
To:     John Stultz <john.stultz@linaro.org>
Cc:     lkml <linux-kernel@vger.kernel.org>, Yu Chen <chenyu56@huawei.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Felipe Balbi <balbi@kernel.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Jun Li <lijun.kernel@gmail.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Linux USB List <linux-usb@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>
References: <20191002231617.3670-1-john.stultz@linaro.org>
 <20191002231617.3670-3-john.stultz@linaro.org>
 <2e369349-41f6-bd15-2829-fa886f209b39@redhat.com>
 <CALAqxLVcQ7yZuJCUEqGmvqcz5u0Gd=xJzqLbmiXKR+LJrOhvMQ@mail.gmail.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <b8695418-9d3a-96a6-9587-c9a790f49740@redhat.com>
Date:   Thu, 3 Oct 2019 22:51:38 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <CALAqxLVcQ7yZuJCUEqGmvqcz5u0Gd=xJzqLbmiXKR+LJrOhvMQ@mail.gmail.com>
Content-Language: en-US
X-MC-Unique: vqf078ZoNVuMd2brbxAlOw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 03-10-2019 22:37, John Stultz wrote:
> On Thu, Oct 3, 2019 at 2:25 AM Hans de Goede <hdegoede@redhat.com> wrote:
>> On 03-10-2019 01:16, John Stultz wrote:
>>> From: Yu Chen <chenyu56@huawei.com>
>>>
>>> This patch adds notifier for drivers want to be informed of the usb rol=
e
>>> switch.
>>
>> I do not see any patches in this series actually using this new
>> notifier.
>>
>> Maybe it is best to drop this patch until we actually have in-kernel
>> users of this new API show up ?
>=20
> Fair point. I'm sort of taking a larger patchset and trying to break
> it up into more easily reviewable chunks, but I guess here I mis-cut.
>=20
> The user is the hikey960 gpio hub driver here:
>    https://git.linaro.org/people/john.stultz/android-dev.git/commit/?id=
=3Db06158a2d3eb00c914f12c76c93695e92d9af00f

Hmm, that seems to tie the TypeC data-role to the power-role, which
is not going to work with role swapping.

What is controlling the usb-role-switch, and thus ultimately
causing the notifier you are suggesting to get called ?

Things like TYPEC_VBUS_POWER_OFF and TYPEC_VBUS_POWER_ON
really beg to be modeled as a regulator and then the
Type-C controller (using e.g. the drivers/usb/typec/tcpm/tcpm.c
framework) can use that regulator to control things.
in case of the tcpm.c framework it can then use that
regulator to implement the set_vbus callback.

You really do not want to tie this do the usb_switch, both
because doing so ties the data and power-roles together
which is not supposed to happen and because role-swapping
requires careful timing of the VBUS on / off at different
moments then the moments when you actually set the mux/switch
for connecting the Dp/Dn lines to the host or gadget
controller.

The usb role switch abstraction is really only intended
for the data-lines switch and should not be tied together
with other stuff.

Regards,

Hans

