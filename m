Return-Path: <SRS0=6dNS=X4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89886C10F14
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 20:56:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4880921783
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 20:56:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aAvisvvP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730360AbfJCU4c (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Oct 2019 16:56:32 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:29857 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727175AbfJCU4b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Oct 2019 16:56:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1570136190;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=VC/LlBcR/5mNVDb/D015rZ9V1BXd6w3MDPPfMofQMc0=;
        b=aAvisvvPgqtx5Ol9tMIr1i47Qfso1Qij2ZmDMc/nYL0t3krGw1QpzsuZgqbBFvs8gqycUT
        csQ6ZjgXFGcU69mNklT/KN2NCBgsEibTadI8ZhK1tp6gsN8kRnwSa3zQJI5JQlNQUJloQt
        5yVCNricKo3Gv4BSm/XtFS0c0Y652y4=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-358-cGhKLty9Oz-cX_aPtf9akw-1; Thu, 03 Oct 2019 16:56:27 -0400
Received: by mail-wr1-f69.google.com with SMTP id z1so1642301wrw.21
        for <linux-kernel@vger.kernel.org>; Thu, 03 Oct 2019 13:56:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=A5kOIo5QkieVFmBFAtLwxKf3nxk646ajjZrARZPXdLI=;
        b=Zt1fp7l6JzcGU13hRsnKtP2N6PQgVHxmHJ65/Vapdx88xcjlli1pkfq2HZVTNYNXSf
         rLMhM4gEqbjZrYg/XLbCBcK7LJXNtXegUHZFyihBYYMtOBSoqyk6iUf7pTJnGIq5IdEF
         TBZCz40i3zLyWNmtKROVJHftJ3OVa6qJ8jMz2D8LOsKFroCFMLVlOry5zHqdzOGc1uiB
         AO7vAfJdcJwOz8hUeWFsJeTyRta0h8sTZefdhoApD7uJBSWtddOWInnyaKYKOTwH0XMb
         mM8t4YqNpAPZwDWkG8ru2VozYLfPKAqCphiS+b8q7Sk2P14r7IWuxsHoOw/63+NDsBbK
         BvZg==
X-Gm-Message-State: APjAAAWt3U56Wc5BWxgAaJWS4iNRMVicGAHFFnkdgvsmfj1jOrI7sH4q
        VsfyCc1VI36oMjZZ83zcXzrcNwXP4+4wZij3c/6rQ/ClSZXba+Mof5fzedIchA9XAtWXh4ttqPU
        y49+CUhU7Fq19BHOt+aIWwkLO
X-Received: by 2002:a1c:1aca:: with SMTP id a193mr8470578wma.120.1570136186729;
        Thu, 03 Oct 2019 13:56:26 -0700 (PDT)
X-Google-Smtp-Source: APXvYqyTDfMkHtgwnWS6hHN107FbUrB3SZTNQ+JCS+Zycf70DOxLyHXyYisZjPmgWq6URjChzPNdOQ==
X-Received: by 2002:a1c:1aca:: with SMTP id a193mr8470560wma.120.1570136186423;
        Thu, 03 Oct 2019 13:56:26 -0700 (PDT)
Received: from shalem.localdomain (2001-1c00-0c14-2800-ec23-a060-24d5-2453.cable.dynamic.v6.ziggo.nl. [2001:1c00:c14:2800:ec23:a060:24d5:2453])
        by smtp.gmail.com with ESMTPSA id l9sm4075992wme.45.2019.10.03.13.56.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Oct 2019 13:56:25 -0700 (PDT)
Subject: Re: [RFC][PATCH 2/3] usb: roles: Add usb role switch notifier.
To:     John Stultz <john.stultz@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     lkml <linux-kernel@vger.kernel.org>, Yu Chen <chenyu56@huawei.com>,
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
 <20191003112618.GA2420393@kroah.com>
 <CALAqxLWm_u3KsXHn4a6PdBCOKM1vs5k0xS3G5jY+M-=HBqUJag@mail.gmail.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <9cfccb6a-fba1-61a3-3eb6-3009c2f5e747@redhat.com>
Date:   Thu, 3 Oct 2019 22:56:24 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <CALAqxLWm_u3KsXHn4a6PdBCOKM1vs5k0xS3G5jY+M-=HBqUJag@mail.gmail.com>
Content-Language: en-US
X-MC-Unique: cGhKLty9Oz-cX_aPtf9akw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 03-10-2019 22:45, John Stultz wrote:
> On Thu, Oct 3, 2019 at 4:26 AM Greg Kroah-Hartman
> <gregkh@linuxfoundation.org> wrote:
>>
>> On Wed, Oct 02, 2019 at 11:16:16PM +0000, John Stultz wrote:
>>> From: Yu Chen <chenyu56@huawei.com>
>>>
>>> This patch adds notifier for drivers want to be informed of the usb rol=
e
>>> switch.
>>
>> Ick, I hate notifiers, they always come back to cause problems.
>>
>> What's just wrong with a "real" call to who ever needs to know this?
>> And who does need to know this anyway?  Like Hans said, if we don't have
>> a user for it, we should not add it.
>=20
> So in this case, its used for interactions between the dwc3 driver and
> the hikey960 integrated USB hub, which is controlled via gpio (which I
> didn't submit here as I was trying to keep things short and
> reviewable, but likely misjudged).
>=20
> The HiKey960 has only one USB controller, but in order to support both
> USB-C gadget/OTG and USB-A (host only) ports. When the USB-C
> connection is attached, it powers down and disconnects the hub. When
> the USB-C connection is detached, it powers the hub on and connects
> the controller to the hub.

When you say one controller, do you mean 1 host and 1 gadget controller,
or is this one of these lovely devices where a gadget controller gets
abused as / confused with a proper host controller?

And since you are doing a usb-role-switch driver, I guess that the
role-switch is integrated inside the SoC, so you only get one pair
of USB datalines to the outside ?

This does seem rather special, it might help if you can provide a diagram
with both the relevant bits inside the SoC as well as what lives outside
the Soc. even if it is in ASCII art...

Regards,

Hans

