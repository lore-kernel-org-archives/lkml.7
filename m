Return-Path: <SRS0=6OEZ=YL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B75ADCA9EA0
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 19:31:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8214D2082C
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 19:31:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ilKVSCYU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2505985AbfJRTbB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Oct 2019 15:31:01 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:30034 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S2410703AbfJRTbA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Oct 2019 15:31:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1571427059;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=GCowdiB5wH88eDhECViL4GzSTGcbuiwoq+hzcOFtFWA=;
        b=ilKVSCYUL7S+aA1ejU9432MG4SuQsIUd09WQ+dlG36j1AB2777zYg3/CIoUaUSCZaaLkfh
        tK5DYnpYlcuOwWE/+shoYM8pxW0dmUl8uhgrP+WS2QguFUDDib2dH47jFbNSBAV/rE58xA
        KwAmaom2PzNB45ByTT9FtKbiHE8e9YY=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-323-kMpf113cPDaWjU9g-ADfVw-1; Fri, 18 Oct 2019 15:30:52 -0400
Received: by mail-wr1-f70.google.com with SMTP id s9so3138536wrw.23
        for <linux-kernel@vger.kernel.org>; Fri, 18 Oct 2019 12:30:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=zXQhJk8nZ3hMJ2QotwK3o31o6jt9cup6ThIJ+icUhu0=;
        b=IAA9zyq6L8z0WzZUccYhC6I5sy2oDxOa/jW4+XjXWUdGJHPoOQKrhd7b4iO967GHQo
         aqWthQul4JjAAtEsc8KIsjN3I3YpOd1NyQSvFmocMvpBMPGjIt+a4/u/8u0/eOzS20P9
         e+MgG7FgkIDDwnYMx/K2BuZ10XT/kKURjytbgIG5I8+J7oXZfOg+cdCGOEZwVs5iA95l
         WjVP7cR7KmOyRAWnT586Et/KzIfbeJ6JbmX9w+ABd8/5nkM0lHmo7apsBBJzrOHm4/FN
         bDU1rUhaJr5PnGPOx5jGJ+Ul8drI4baGqVSDivzI01ZGB3+t0UY7DErdgH2knlPedA/j
         vASw==
X-Gm-Message-State: APjAAAU3nGE2Olebp9w+1HsEgsVLpQ4kX33R82PTX8G6JKZWYD0K9LbI
        UfQNxcpd1r/T68MNATPSKdbkizdWj2w0UXLpDkqZOd4CQ2LY6FVbcqSmMFoi+KDUoDU/pr1UlWH
        NcE3Bm31rZMU207h+cuplneeq
X-Received: by 2002:a1c:1d15:: with SMTP id d21mr8852419wmd.5.1571427051729;
        Fri, 18 Oct 2019 12:30:51 -0700 (PDT)
X-Google-Smtp-Source: APXvYqzB5ZuAbSbEpJBbWhzk7s06BVvp1z0AurRYFn3yyELAtFY9VenvhylaTxh6cbJT5cmWp0tPIg==
X-Received: by 2002:a1c:1d15:: with SMTP id d21mr8852400wmd.5.1571427051474;
        Fri, 18 Oct 2019 12:30:51 -0700 (PDT)
Received: from shalem.localdomain (2001-1c00-0c14-2800-ec23-a060-24d5-2453.cable.dynamic.v6.ziggo.nl. [2001:1c00:c14:2800:ec23:a060:24d5:2453])
        by smtp.gmail.com with ESMTPSA id q10sm6905431wrd.39.2019.10.18.12.30.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 18 Oct 2019 12:30:50 -0700 (PDT)
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
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <7877d69b-b17c-d4a4-9806-3dca98fc9e26@redhat.com>
Date:   Fri, 18 Oct 2019 21:30:49 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <CALAqxLWHbhst5KXAGCswKVp7ztzFHxdb6nskfze+Jk+xWo2Ssw@mail.gmail.com>
Content-Language: en-US
X-MC-Unique: kMpf113cPDaWjU9g-ADfVw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 18-10-2019 20:39, John Stultz wrote:
> On Fri, Oct 18, 2019 at 1:06 AM Hans de Goede <hdegoede@redhat.com> wrote=
:
>> On 18-10-2019 07:55, John Stultz wrote:
>>> On Wed, Oct 16, 2019 at 12:27 AM Hans de Goede <hdegoede@redhat.com> wr=
ote:
>>>> Look at the tcpm_set_vbus implementation in drivers/usb/typec/tcpm/fus=
b302.c
>>>> you need to do something similar in your Type-C controller driver and
>>>> export the GPIO as as a gpio-controlled regulator and tie the regulato=
r to
>>>> the connector.
>>>
>>> Thanks for the suggestion, I really appreciate it! One more question
>>> though, since I'm using the tcpci_rt1711h driver, which re-uses the
>>> somewhat sparse tcpci.c implementation, would you recommend trying to
>>> add generic regulator support to the tcpci code or trying to extend
>>> the implementation somehow allow the tcpci_rt1711h driver replace just
>>> the set_vbus function?
>>
>> I have the feeling that this is more of a question for Heikki.
>>
>> My first instinct is: if you are using tcpci can't you put all
>> the hacks you need for the usb connection shared between hub
>> and type-c in your firmware ?
>=20
> I appreciate the suggestion, but I'm not aware of any USB firmware for
> the board, nor do I think I have any such source.  :(

My bad, I was under the impression that tcpci was a firmware interface,
but it is not (I was confusing it with ucsi).

Looking at drivers/usb/typec/tcpm/tcpci.c: tcpci_set_vconn I see that
there is a data struct with vendor specific callbacks and that the
drivers/usb/typec/tcpm/tcpci_rt1711h.c implements that.

So you may want something similar here. But things are tricky here,
because when nothing is connected you want to provide Vbus for
the USB-A ports, which means that if someone then connects a
USB-A to C cable to connect the board to a PC (switching the port
to device mode) there will be a time when both sides are supplying
5V if I remember the schedule correctly.

I think that the original hack might not be that bad, the whole hw
design seems so, erm, broken, that you probably cannot do proper
roleswapping anyways.  So just tying Vbus to host mode might be
fine, the question then becomes again how can some other piece
of code listen to the role-switch events...

Regards,

Hans

