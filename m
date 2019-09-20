Return-Path: <SRS0=vU+5=XP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5881EC4CECD
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Sep 2019 08:26:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 300C520640
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Sep 2019 08:26:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="V/Ep7Zr1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2395230AbfITI0C (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Sep 2019 04:26:02 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:48328 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2393485AbfITI0A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Sep 2019 04:26:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1568967958;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=r8MGonTFVdpjASlfAFrsQcR94wwuke9pmPqJjwL2ARA=;
        b=V/Ep7Zr1PKchtk+18mjolDKLHMAUb0nK/BC/hMXUHzpqLrtfJvFQS0Ey0Kl8g/tOL2Rpm6
        z8bR8tpiwjoV/kv0eRLmAe9WajgD8yrXTQAhymTM9k5UrHAN501eK859fUCtep8IRGyTXA
        qZbfUiLuaR0GQ/s224VPd9NJsQySPYs=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-363-UVZEZGXvNumjfgUQa8Jd7Q-1; Fri, 20 Sep 2019 04:25:58 -0400
Received: by mail-ed1-f71.google.com with SMTP id l5so552760edr.10
        for <linux-kernel@vger.kernel.org>; Fri, 20 Sep 2019 01:25:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=4hsw2OCRdLgrAW4Yeak8FOMwaa+mJKoCk0ZlY8muiX0=;
        b=HmsvE6wW+BRpYXtuyKFew302uZhvmzwZjKqc7TYmKkbywCiHS78lVmcGKgpulGl6a6
         UanVxw7EXY3OK/bEX6rUAUKHMwP5GNa2W6tFX2cUEvd98TWkssShYgJu55CkaAQBbaQP
         mw2BrSGXy9w4+lroPHprF5Zar1KGSDLHIR1OhiVHQ4ATvU4h96Jl8P6S5ZF+Yh+WcL67
         RN+bAC2otMGibAdYtmUMf1uX/2z4tfqV8B75NRYTmmFwxQQUiJGzlzHsM2o4V43eaN1k
         P0hp4XRZO17jxrOeJy0M5h/zMHH1GF4wWXdDlda3uEIcdk5v7Irb2KSyd8ugCngs04P5
         o0cQ==
X-Gm-Message-State: APjAAAWAD8Rzrslc3dZ/LH0uIZvPo8xMh3uxfuaYLaM6UGOiiJxH5u99
        iTWKJTu2Nb9lJ/yeuYCb0abxhCpwaSFNlmT1iBoPiZYMHzu5MiSIMzaTOYInfUpRrvqTcyzhGTm
        M1U6MI55Gbk0gMUqFG0RVehNr
X-Received: by 2002:aa7:c1d4:: with SMTP id d20mr20280813edp.223.1568967956122;
        Fri, 20 Sep 2019 01:25:56 -0700 (PDT)
X-Google-Smtp-Source: APXvYqz4ECaEH5yi1nNGb2T6JpxBw1IUeNWJDkLqw3EkA+fF9rzpEigjtCD/uc67Fl2hfK4NA4oQWw==
X-Received: by 2002:aa7:c1d4:: with SMTP id d20mr20280801edp.223.1568967956014;
        Fri, 20 Sep 2019 01:25:56 -0700 (PDT)
Received: from shalem.localdomain (84-106-84-65.cable.dynamic.v4.ziggo.nl. [84.106.84.65])
        by smtp.gmail.com with ESMTPSA id i53sm200485eda.33.2019.09.20.01.25.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 20 Sep 2019 01:25:55 -0700 (PDT)
Subject: Re: [PATCH v3 0/2] tcpm: AMS and Collision Avoidance
To:     Kyle Tso <kyletso@google.com>
Cc:     Guenter Roeck <linux@roeck-us.net>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        Badhri Jagan Sridharan <badhri@google.com>,
        Adam Thomson <Adam.Thomson.Opensource@diasemi.com>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20190920032437.242187-1-kyletso@google.com>
 <cb225c94-da97-1b47-48b6-3802dc3eb93b@redhat.com>
 <CAGZ6i=3O2zLJMPY5UevjTrJJj7fxpWcn28dZYRptWES74=4Tgg@mail.gmail.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <ce0e1163-cb0f-29ef-e071-3c0ee795a7e6@redhat.com>
Date:   Fri, 20 Sep 2019 10:25:54 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
MIME-Version: 1.0
In-Reply-To: <CAGZ6i=3O2zLJMPY5UevjTrJJj7fxpWcn28dZYRptWES74=4Tgg@mail.gmail.com>
Content-Language: en-US
X-MC-Unique: UVZEZGXvNumjfgUQa8Jd7Q-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Kyle,

On 20-09-2019 10:19, Kyle Tso wrote:
> Hi Hans,
>=20
> I have tested these on an Android device (ARM64).
> All the swap operations work fine (Power Role/Data Role/Vconn Swap).
> (except for Fast Role Swap because it is still not supported in TCPM)

May I ask which type-c controller are these devices using?

Regards,

Hans



>=20
> Regards,
> Kyle Tso
>=20
>=20
> On Fri, Sep 20, 2019 at 4:02 PM Hans de Goede <hdegoede@redhat.com> wrote=
:
>>
>> Hi Kyle,
>>
>> On 20-09-2019 05:24, Kyle Tso wrote:
>>> *** BLURB HERE ***
>>>
>>> Kyle Tso (2):
>>>     usb: typec: tcpm: AMS and Collision Avoidance
>>>     usb: typec: tcpm: AMS for PD2.0
>>
>> May I ask how and on which hardware you have tested this?
>>
>> And specifically if you have tested this in combination with pwr-role sw=
apping?
>>
>> Regards,
>>
>> Hans
>>

