Return-Path: <SRS0=6OEZ=YL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A420CA9EA0
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 20:00:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EF23821925
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 19:59:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="exyDsaRy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2443365AbfJRT76 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Oct 2019 15:59:58 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:20854 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2440148AbfJRT76 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Oct 2019 15:59:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1571428796;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=HY9LZl5Qc/JmP6FOZkiAXVJNeytiYRMe4zXOpb3ECF4=;
        b=exyDsaRyHxDCMDgc+2sPWih2wgvAKUl9o7j3yTCAG3Ye0oyRCpZxI8v94uNC06Zxm19UTy
        g48B3b4AmW1Fng+W2mAn5DAzzTY+/vUYlyyhYNbyR6llLqFaWS7H9EOz9B+sbFNJPatrmA
        u/VrGpFhpz8latE6WbXO6B66/6ttIKk=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-380-trmYH-7xMKqJ8goLgs8ZEA-1; Fri, 18 Oct 2019 15:59:54 -0400
Received: by mail-wm1-f71.google.com with SMTP id f63so2765458wma.7
        for <linux-kernel@vger.kernel.org>; Fri, 18 Oct 2019 12:59:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=mdVnAWOXIUqPZERi9Vvyl1DX/oz70rB8oZJj6tien0A=;
        b=kliQr/KE8Ha8dkrx9qwBhw04QmteivpA8r/TOspVso0t2WfbhDRRzUj/jQko8I4p5g
         Iwf+xUpOCtirjpVTUBJ061T90REoWV+vDRYsZbK52anmJlRUd8xU64ruAoPQGC6fB7Ml
         DRANZ+X6urYvhd0Z2dzWetOnUgwEZpMXWBLABwlfsqq2+m+emjS2kZ90QOlT6rm4qB9u
         QTFsvbN151tngw5PDbqn3VijyVmC95ZgrYcIp2zRefCfwJDFegLoXwiWTOr2EL7QTLZt
         a7uBhbV56jhDWKgPwc+nmz5Nip7+bLLtz3jn/M90knigO2zCVTNK7EXHBkRp/q40Lu/C
         /YhQ==
X-Gm-Message-State: APjAAAXraWYm3jOpt08hS02RYDTJNE5RtJcIsHgTaNtADQLFne9pM/2a
        jFCDyk/6TylMQ7fXg1IGbxEC48FX0FXwe8broouQreDlwjxVrx1j92m/CHPWQCOfnJSaKmDOzTf
        CxzeUI1jcXSGuS3kZE9sNdG/t
X-Received: by 2002:a1c:f60d:: with SMTP id w13mr9661976wmc.150.1571428793498;
        Fri, 18 Oct 2019 12:59:53 -0700 (PDT)
X-Google-Smtp-Source: APXvYqxBZX8nOVNI/ZgwbU6kp7bzmIkZW189C+ngLEMg/4SVkGuCV6L3PLcChQuI2EwAl2Qz7NnazA==
X-Received: by 2002:a1c:f60d:: with SMTP id w13mr9661961wmc.150.1571428793247;
        Fri, 18 Oct 2019 12:59:53 -0700 (PDT)
Received: from shalem.localdomain (2001-1c00-0c14-2800-ec23-a060-24d5-2453.cable.dynamic.v6.ziggo.nl. [2001:1c00:c14:2800:ec23:a060:24d5:2453])
        by smtp.gmail.com with ESMTPSA id d4sm8485046wrc.54.2019.10.18.12.59.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 18 Oct 2019 12:59:52 -0700 (PDT)
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
 <b8695418-9d3a-96a6-9587-c9a790f49740@redhat.com>
 <CALAqxLVh6GbiKmuK60e6f+_dWh-TS2ZLrwx0WsSo5bKp-F3iLA@mail.gmail.com>
 <648e2943-42f5-e07d-5bb4-f6fd8b38b726@redhat.com>
 <CALAqxLWh0=GRod5ORpi+ENpWCkmY39mUw_=NV67sKY8qH_otZw@mail.gmail.com>
 <f2236442-111d-cd84-fc47-0737df71cf3a@redhat.com>
 <CALAqxLWHbhst5KXAGCswKVp7ztzFHxdb6nskfze+Jk+xWo2Ssw@mail.gmail.com>
 <7877d69b-b17c-d4a4-9806-3dca98fc9e26@redhat.com>
 <CALAqxLWE-8YkYmrKoP6-+2xherwsGZ8-CeUyOFe9YPQj6EuSpg@mail.gmail.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <7ea7824f-abc2-4cf6-720a-3668b6286781@redhat.com>
Date:   Fri, 18 Oct 2019 21:59:51 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <CALAqxLWE-8YkYmrKoP6-+2xherwsGZ8-CeUyOFe9YPQj6EuSpg@mail.gmail.com>
Content-Language: en-US
X-MC-Unique: trmYH-7xMKqJ8goLgs8ZEA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 18-10-2019 21:53, John Stultz wrote:
> On Fri, Oct 18, 2019 at 12:30 PM Hans de Goede <hdegoede@redhat.com> wrot=
e:
>> Looking at drivers/usb/typec/tcpm/tcpci.c: tcpci_set_vconn I see that
>> there is a data struct with vendor specific callbacks and that the
>> drivers/usb/typec/tcpm/tcpci_rt1711h.c implements that.
>>
>> So you may want something similar here. But things are tricky here,
>> because when nothing is connected you want to provide Vbus for
>> the USB-A ports, which means that if someone then connects a
>> USB-A to C cable to connect the board to a PC (switching the port
>> to device mode) there will be a time when both sides are supplying
>> 5V if I remember the schedule correctly.
>=20
> Ok. Thanks for the pointer, I'll take a look at that to see if I can
> get it to work.
>=20
>> I think that the original hack might not be that bad, the whole hw
>> design seems so, erm, broken, that you probably cannot do proper
>> roleswapping anyways.  So just tying Vbus to host mode might be
>> fine, the question then becomes again how can some other piece
>> of code listen to the role-switch events...
>=20
> So, at least in the current approach (see the v3 series), I've
> basically set the hub driver as an role-switch intermediary, sitting
> between the calls from the tcpm to the dwc3 driver. It actually works
> better then the earlier notifier method (which had some issues with
> reliably establishing the initial state on boot).  Does that approach
> work for you?

That sounds like it might be a nice solution. But I have not seen the
code, I think I was not Cc-ed on v3. Do you have a patchwork or
lore.kernel.org link for me?

Regards,

Hans

