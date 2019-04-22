Return-Path: <SRS0=BnvS=SY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28722C10F11
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Apr 2019 20:06:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D5C5E204EC
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Apr 2019 20:06:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="Igpy/2K4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732321AbfDVUGd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Apr 2019 16:06:33 -0400
Received: from mout.gmx.net ([212.227.15.19]:33235 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732289AbfDVUG3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Apr 2019 16:06:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1555963583;
        bh=63y9FsQSH/3hN6yI2OoIBjNoXaH+fyW99Fq3ecVomPo=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=Igpy/2K4gL0TKy4AXAubIVgPVqnptQSPH5ZO38mr1RqAibDE1dTUhcKy7WttUC3k2
         6F8un32O86x5DxltCL19jinlrZo2PwubKQ917U+tQVvKntoASqsn7yw23hbG6ksc9f
         DsrCfI4H4glEYZTvqnvaaU1ko7nnebwVXFa9PEj0=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.188.28] ([37.5.251.40]) by mail.gmx.com (mrgmx002
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0MHoC5-1hFcvq2M3B-003eEL; Mon, 22
 Apr 2019 22:06:23 +0200
Subject: Re: [RFC] Bluetooth: Retry configure request if result is
 L2CAP_CONF_UNKNOWN
To:     Andrey Smirnov <andrew.smirnov@gmail.com>,
        Marcel Holtmann <marcel@holtmann.org>
Cc:     linux-bluetooth@vger.kernel.org,
        "Pierre-Loup A . Griffais" <pgriffais@valvesoftware.com>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
References: <20190208025828.30901-1-andrew.smirnov@gmail.com>
 <3E87E315-0F39-49BA-BD65-2EB0C3A9A782@holtmann.org>
 <CAHQ1cqH+TCrU+7NE7iiiUwUsCQjfHs8hjKe24b7bj9A3R5GNWw@mail.gmail.com>
 <CAHQ1cqHL+CjXhp4TadAQ5fZNbcxpnkNSxC+TaZ=Be_-giP_60A@mail.gmail.com>
From:   Florian Dollinger <dollinger.florian@gmx.de>
Message-ID: <fcdc7234-627c-dff1-d702-c574c975be54@gmx.de>
Date:   Mon, 22 Apr 2019 22:06:22 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <CAHQ1cqHL+CjXhp4TadAQ5fZNbcxpnkNSxC+TaZ=Be_-giP_60A@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-HK
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:7bFnrIv76tGZtQsu6OfpZuPG3cQxSCS9qEKELVrdyesv9NseZtw
 etAuwBatsnvDxBLY7CxBCgwbxi9Hi6jAmzFXxnFsrHzBJucRGMmiKFQ8tA5crhw3Z1N0pNx
 vLbw51V2VHNvjRxyRiqF9pocKuWdz4jMWQ6GTWwBcQ3nDX1nvFmthU0y3X/U4JXgGOEUYRj
 X1H5yoGiNoarVvmSkyBXA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:FBGRglgPBGA=:eUaeTqtve9TciyQlx0hMZl
 WdyisiqEGSw62jmc5Fm+lO4kaS/5iaMbDWZho+H2wgUFTsxHh+am17H0EkWdChB3u56ElApNN
 7ehfpFtk4Dde2zuL60VfiDUY5BHG3zCcxsLcsL7NtuzFE/aUD/I9GamPeSplcaLw29ckJNzHp
 IGxTvnsGLoO+JFdctLagxFO/XtQajiehZriJLDiQqoyTmiILCniFAa0PfDQa9AbKq7kILU8E1
 JRxXO0Fv8quoTU0NFCMFnz9mApwUyxuZM+TcHnkE/9c6iQa5laWdtWItmYaJWeBFYh3gVxBao
 yTjP1oOZohzbP8fJ1pixk0sYWErCjSwiyt5fYAhZAtTea9WiM+gxk6iB1OzGiGER++KcBwwfd
 OlFvEBADxWKiehtVxwo7AH0FesOPtX/KJ88u/veJ7+Ejo9EmBK5nx4iR8TW8BJOXtg0nwRB2n
 s5wlXklSXpkY56y1uY7xH6AQi1+qRT9pxyELS6BekFqL0EQ20tRaTXJQi3qNLwIWkMxO7Ervu
 OYrFNavC7BQw/rqzR/7r56GEWsYaXR9a5klrvEyrTsrW0nYJDImmr487MG+AdkYX3qh2JF5EV
 kPrX3AVRaKVCoQT1zVbrBa1DVUKVqA/JNTcXhkqlm1Kf36qhQh/wfTgBW5zhnmWvhFZZdJ+Qh
 J93UC1DHLxuNhCZC2DvKR5QF1XdS4mznSfyJzTiirHNKtCZ5j02FhVYNqfWR8FAw0WoJ1juaS
 VWIriu0abLkO+OeREndtHPtaSWnxdavwUh+36BFDsl1i28XFEY4CK4CdfCoguTX9XDD7dGkK6
 z0kQ0yHA1qq0090k+huf+6S+nzGuO2/CnZqdfM1/j89IyIPf/G/XT2anDPtRDk8Gj4kEdc3S5
 QRl9zc2GKmarHtaeK2XKi4oVykn8CYDFc8VNEB+DP2VxUsNpZQlRd2Be5E/5UKIajbQQGFigv
 /GU3bQQyE/g==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I think in essence this is the same as my patch from Jan 2018 here:
https://raw.githubusercontent.com/atar-axis/xpadneo/master/misc/kernel_pat=
ches/0001-fix_bluetooth_reconnect.patch

Right? That's maybe why I am in CC :D
If yes, then I can fully confirm that this works as one would expect.

Let me copy&paste my patch description here:

=2D--

The current L2CAP implementation does not change any options if the
other side respons with "unknown options", but does if "unaccepted
options" is the answer. It is up to the implementation to decide on the
effort spent on config negotiations, therefore the current
implementation is  correct at this point - but [...] devices like [the]
Xbox One S controller [is] not useable this way.
  A workaround for many users therefore is to disable_ertm, since this
is [in this case] the option which is unknown. I would prefer to try it
again with altered options instead of globally disable ERTM.

In result, I suggest the following patch. It simply adds a new case
(L2CAP_CONF_UNKNOWN), which does nothing but falling through to
L2CAP_CONF_UNACCEPT.

=2D--

Cheers,
Florian Dollinger (atar-axis)

On 21.03.19 00:08, Andrey Smirnov wrote:
> On Mon, Feb 18, 2019 at 8:57 PM Andrey Smirnov <andrew.smirnov@gmail.com=
> wrote:
>>
>> On Mon, Feb 18, 2019 at 4:58 AM Marcel Holtmann <marcel@holtmann.org> w=
rote:
>>>
>>> Hi Andrey,
>>>
>>>> Due to:
>>>>
>>>> - current implementation of l2cap_config_rsp() dropping BT
>>>>    connection if sender of configuration response replied with unknow=
n
>>>>    option failure (Result=3D0x0003/L2CAP_CONF_UNKNOWN)
>>>>
>>>> - current implementation of l2cap_build_conf_req() adding
>>>>    L2CAP_CONF_RFC(0x04) option to initial configure request sent by
>>>>    the Linux host.
>>>>
>>>> devices that do no recongninze L2CAP_CONF_RFC, such as Xbox One S
>>>> controllers, will get stuck in endless connect -> configure ->
>>>> disconnect loop, never connect and be generaly unusable.
>>>>
>>>> To avoid this problem add code to do the following:
>>>>
>>>> 1. Store a mask of supported conf option types per connection
>>>>
>>>> 2. Parse the body of response L2CAP_CONF_UNKNOWN and adjust
>>>>     connection's supported conf option types mask
>>>>
>>>> 3. Retry configuration step the same way it's done for
>>>>     L2CAP_CONF_UNACCEPT
>>>>
>>>> Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
>>>> Cc: Pierre-Loup A. Griffais <pgriffais@valvesoftware.com>
>>>> Cc: Florian Dollinger <dollinger.florian@gmx.de>
>>>> Cc: Marcel Holtmann <marcel@holtmann.org>
>>>> Cc: Johan Hedberg <johan.hedberg@gmail.com>
>>>> Cc: linux-bluetooth@vger.kernel.org
>>>> Cc: linux-kernel@vger.kernel.org
>>>> ---
>>>>
>>>> Everyone:
>>>>
>>>> I marked this as an RFC, since I don't have a lot of experience with
>>>> Bluetooth subsystem and don't have hight degree of confidence about
>>>> choices made in this patch. I do, however, thins is is good enough to
>>>> start a discussion about the problem.
>>>
>>> can you take a btmon -w trace.log protocol trace so that I can see whe=
re it fails. This seems a really odd behavior of the Xbox controller. We h=
ave to be careful in not breaking Bluetooth qualification to just workarou=
nd some buggy remote device.
>>>
>>
>> Sure, n/p, both "failure" (behavior before this patch) and "success"
>> (behavior with the patch) cases on my machine are available here:
>>
>> https://gist.github.com/ndreys/2b74094933601978e200af1ff0a55372
>>
>> Let me know if that's not accessible to you.
>>
>
> Marcel, did you have a chance to look at the logs?
>
> Thanks,
> Andrey Smirnov
>
