Return-Path: <SRS0=N68d=SK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E447FC10F14
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 12:05:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9BF1920883
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 12:05:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=st.com header.i=@st.com header.b="T1Q0MOhN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726629AbfDHMFc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Apr 2019 08:05:32 -0400
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:15092 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726050AbfDHMFb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Apr 2019 08:05:31 -0400
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
        by mx08-00178001.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x38C4JOC022331;
        Mon, 8 Apr 2019 14:05:18 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=STMicroelectronics;
 bh=L0z+4csJiNyTce2krVejTPX5mj6tm9Zy7JKQOd1Eed0=;
 b=T1Q0MOhNBtc3Za+/t27nZ+aP/cs7DOXTGpshnMVXw7WZsYXJNB7ZeLaQBUO/+mGgtWZT
 6c9qDx5zYl6vw5XTx3+CMy1TDee7QkGiz/W+vfZmiUiCpKvOBqSNRZAOAcc8+YeGiP4G
 cWDdZv8/S5bcXed0OI2+teDkU5bVdxXnpcDH0LLJG7N/xSM6K+pAJhw5A4JfTkp++6hm
 E2slVJDsYzLazjsDaJPDnPga1WE+WajTuQkw72RFYXeY5C8RzaQRu3Ru0kvxtiufwzTw
 HYYDsx9ymsofukeZpFtF87N58nPjL2b7j/QtcQkL+PHjMCJvrossOzlegL/SMu/u5iK9 Tw== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx08-00178001.pphosted.com with ESMTP id 2rprcf2vcu-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Mon, 08 Apr 2019 14:05:18 +0200
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id B867B38;
        Mon,  8 Apr 2019 12:05:16 +0000 (GMT)
Received: from Webmail-eu.st.com (sfhdag3node1.st.com [10.75.127.7])
        by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 8649A2490;
        Mon,  8 Apr 2019 12:05:16 +0000 (GMT)
Received: from [10.48.0.131] (10.75.127.50) by SFHDAG3NODE1.st.com
 (10.75.127.7) with Microsoft SMTP Server (TLS) id 15.0.1347.2; Mon, 8 Apr
 2019 14:05:15 +0200
Subject: Re: [PATCH 2/2] tty: add rpmsg driver
To:     xiang xiao <xiaoxiang781216@gmail.com>
CC:     Fabien Dessenne <fabien.dessenne@st.com>,
        Ohad Ben-Cohen <ohad@wizery.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>, <linux-kernel@vger.kernel.org>,
        <linux-remoteproc@vger.kernel.org>,
        Benjamin Gaignard <benjamin.gaignard@st.com>
References: <1553183239-13253-1-git-send-email-fabien.dessenne@st.com>
 <1553183239-13253-3-git-send-email-fabien.dessenne@st.com>
 <CAH2Cfb8K5hB=UeMOeTEXud1XZVp12Qbw9NYoxJ0XQK4FFuF3wQ@mail.gmail.com>
 <4857555a-812d-0b96-9a70-2984ffb50ca9@st.com>
 <CAH2Cfb8NzsOZDt8zBypY9ZiD6oOFWUBkZoPpKfU97ZRF_O0z+A@mail.gmail.com>
 <770c71bc-f387-62b6-f799-07ba6446e7e8@st.com>
 <CAH2Cfb87Wacgsh=xz9h9kgwYgBkxNBDbcDJ4W3uPs2LiKbTD9A@mail.gmail.com>
 <760819dc-4c26-b492-a0ba-8b27c189d5b1@st.com>
 <CAH2Cfb-EvWeP28W=Hqzvwaue55hBFCMecqvt3p8mRh52BZMdNg@mail.gmail.com>
From:   Arnaud Pouliquen <arnaud.pouliquen@st.com>
Openpgp: preference=signencrypt
Autocrypt: addr=arnaud.pouliquen@st.com; prefer-encrypt=mutual; keydata=
 xsFNBFZu+HIBEAC/bt4pnj18oKkUw40q1IXSPeDFOuuznWgFbjFS6Mrb8axwtnxeYicv0WAL
 rWhlhQ6W2TfKDJtkDygkfaZw7Nlsj57zXrzjVXuy4Vkezxtg7kvSLYItQAE8YFSOrBTL58Yd
 d5cAFz/9WbWGRf0o9MxFavvGQ9zkfHVd+Ytw6dJNP4DUys9260BoxKZZMaevxobh5Hnram6M
 gVBYGMuJf5tmkXD/FhxjWEZ5q8pCfqZTlN9IZn7S8d0tyFL7+nkeYldA2DdVplfXXieEEURQ
 aBjcZ7ZTrzu1X/1RrH1tIQE7dclxk5pr2xY8osNePmxSoi+4DJzpZeQ32U4wAyZ8Hs0i50rS
 VxZuT2xW7tlNcw147w+kR9+xugXrECo0v1uX7/ysgFnZ/YasN8E+osM2sfa7OYUloVX5KeUK
 yT58KAVkjUfo0OdtSmGkEkILWQLACFEFVJPz7/I8PisoqzLS4Jb8aXbrwgIg7d4NDgW2FddV
 X9jd1odJK5N68SZqRF+I8ndttRGK0o7NZHH4hxJg9jvyEELdgQAmjR9Vf0eZGNfowLCnVcLq
 s+8q3nQ1RrW5cRBgB8YT2kC8wwY5as8fhfp4846pe2b8Akh0+Vba5pXaTvtmdOMRrcS7CtF6
 Ogf9zKAxPZxTp0qGUOLE3PmSc3P3FQBLYa6Y+uS2v2iZTXljqQARAQABzSpBcm5hdWQgUG91
 bGlxdWVuIDxhcm5hdWQucG91bGlxdWVuQHN0LmNvbT7CwX4EEwECACgFAlZu+HICGyMFCQlm
 AYAGCwkIBwMCBhUIAgkKCwQWAgMBAh4BAheAAAoJEP0ZQ+DAfqbfdXgP/RN0bU0gq3Pm1uAO
 4LejmGbYeTi5OSKh7niuFthrlgUvzR4UxMbUBk30utQAd/FwYPHR81mE9N4PYEWKWMW0T3u0
 5ASOBLpQeWj+edSE50jLggclVa4qDMl0pTfyLKOodt8USNB8aF0aDg5ITkt0euaGFaPn2kOZ
 QWVN+9a5O2MzNR3Sm61ojM2WPuB1HobbrCFzCT+VQDy4FLU0rsTjTanf6zpZdOeabt0LfWxF
 M69io06vzNSHYH91RJVl9mkIz7bYEZTBQR23KjLCsRXWfZ+54x6d6ITYZ2hp965PWuAhwWQr
 DdTJ3gPxmXJ7xK9+O15+DdUAbxF9FJXvvt9U5pTk3taTM3FIp/qaw77uxI/wniYA0dnIJRX0
 o51sjR6cCO6hwLciO7+Q0OCDCbtStuKCCCTZY5bF6fuEqgybDwvLGAokYIdoMagJu1DLKu4p
 seKgPqGZ4vouTmEp6cWMzSyRz4pf3xIJc5McsdrUTN2LtcX63E45xKaj/n0Neft/Ce7OuyLB
 rr0ujOrVlWsLwyzpU5w5dX7bzkEW1Hp4mv44EDxH9zRiyI5dNPpLf57I83Vs/qP4bpy7/Hm1
 fqbuM0wMbOquPGFI8fcYTkghntAAXMqNE6IvETzYqsPZwT0URpOzM9mho8u5+daFWWAuUXGA
 qRbo7qRs8Ev5jDsKBvGhzsFNBFZu+HIBEACrw5wF7Uf1h71YD5Jk7BG+57rpvnrLGk2s+YVW
 zmKsZPHT68SlMOy8/3gptJWgddHaM5xRLFsERswASmnJjIdPTOkSkVizfAjrFekZUr+dDZi2
 3PrISz8AQBd+uJ29jRpeqViLiV+PrtCHnAKM0pxQ1BOv8TVlkfO7tZVduLJl5mVoz1sq3/C7
 hT5ZICc2REWrfS24/Gk8mmtvMybiTMyM0QLFZvWyvNCvcGUS8s2a8PIcr+Xb3R9H0hMnYc2E
 7bc5/e39f8oTbKI6xLLFLa5yJEVfTiVksyCkzpJSHo2eoVdW0lOtIlcUz1ICgZ7vVJg7chmQ
 nPmubeBMw73EyvagdzVeLm8Y/6Zux8SRab+ZcU/ZQWNPKoW5clUvagFBQYJ6I2qEoh2PqBI4
 Wx0g1ca7ZIwjsIfWS7L3e310GITBsDmIeUJqMkfIAregf8KADPs4+L71sLeOXvjmdgTsHA8P
 lK8kUxpbIaTrGgHoviJ1IYwOvJBWrZRhdjfXTPl+ZFrJiB2E55XXogAAF4w/XHpEQNGkAXdQ
 u0o6tFkJutsJoU75aHPA4q/OvRlEiU6/8LNJeqRAR7oAvTexpO70f0Jns9GHzoy8sWbnp/LD
 BSH5iRCwq6Q0hJiEzrVTnO3bBp0WXfgowjXqR+YR86JPrzw2zjgr1e2zCZ1gHBTOyJZiDwAR
 AQABwsFlBBgBAgAPBQJWbvhyAhsMBQkJZgGAAAoJEP0ZQ+DAfqbfs5AQAJKIr2+j+U3JaMs3
 px9bbxcuxRLtVP5gR3FiPR0onalO0QEOLKkXb1DeJaeHHxDdJnVV7rCJX/Fz5CzkymUJ7GIO
 gpUGstSpJETi2sxvYvxfmTvE78D76rM5duvnGy8lob6wR2W3IqIRwmd4X0Cy1Gtgo+i2plh2
 ttVOM3OoigkCPY3AGD0ts+FbTn1LBVeivaOorezSGpKXy3cTKrEY9H5PC+DRJ1j3nbodC3o6
 peWAlfCXVtErSQ17QzNydFDOysL1GIVn0+XY7X4Bq+KpVmhQOloEX5/At4FlhOpsv9AQ30rZ
 3F5lo6FG1EqLIvg4FnMJldDmszZRv0bR0RM9Ag71J9bgwHEn8uS2vafuL1hOazZ0eAo7Oyup
 2VNRC7Inbc+irY1qXSjmq3ZrD3SSZVa+LhYfijFYuEgKjs4s+Dvk/xVL0JYWbKkpGWRz5M82
 Pj7co6u8pTEReGBYSVUBHx7GF1e3L/IMZZMquggEsixD8CYMOzahCEZ7UUwD5LKxRfmBWBgK
 36tfTyducLyZtGB3mbJYfWeI7aiFgYsd5ehov6OIBlOz5iOshd97+wbbmziYEp6jWMIMX+Em
 zqSvS5ETZydayO5JBbw7fFBd1nGVYk1WL6Ll72g+iEnqgIckMtxey1TgfT7GhPkR7hl54ZAe
 8mOik8I/F6EW8XyQAA2P
Message-ID: <596f9e4d-2db1-8040-211b-173ad19d9d0e@st.com>
Date:   Mon, 8 Apr 2019 14:05:15 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <CAH2Cfb-EvWeP28W=Hqzvwaue55hBFCMecqvt3p8mRh52BZMdNg@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.75.127.50]
X-ClientProxiedBy: SFHDAG2NODE1.st.com (10.75.127.4) To SFHDAG3NODE1.st.com
 (10.75.127.7)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-04-08_04:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 4/6/19 9:56 AM, xiang xiao wrote:
> On Sat, Apr 6, 2019 at 12:08 AM Arnaud Pouliquen
> <arnaud.pouliquen@st.com> wrote:
>>
>>
>>
>> On 4/5/19 4:03 PM, xiang xiao wrote:
>>> On Fri, Apr 5, 2019 at 8:33 PM Arnaud Pouliquen <arnaud.pouliquen@st.com> wrote:
>>>>
>>>>
>>>>
>>>> On 4/5/19 12:12 PM, xiang xiao wrote:
>>>>> On Fri, Apr 5, 2019 at 12:14 AM Arnaud Pouliquen
>>>>> <arnaud.pouliquen@st.com> wrote:
>>>>>>
>>>>>> Hello Xiang,
>>>>>>
>>>>>>
>>>>>> On 4/3/19 2:47 PM, xiang xiao wrote:
>>>>>>> On Thu, Mar 21, 2019 at 11:48 PM Fabien Dessenne <fabien.dessenne@st.com> wrote:
>>>>>>>>
>>>>>>>> This driver exposes a standard tty interface on top of the rpmsg
>>>>>>>> framework through the "rpmsg-tty-channel" rpmsg service.
>>>>>>>>
>>>>>>>> This driver supports multi-instances, offering a /dev/ttyRPMSGx entry
>>>>>>>> per rpmsg endpoint.
>>>>>>>>
>>>>>>>
>>>>>>> How to support multi-instances from the same remoteproc instance? I
>>>>>>> saw that the channel name is fixed to "rpmsg-tty-channel" which mean
>>>>>>> only one channel can be created for each remote side.
>>>>>> The driver is multi-instance based on muti-endpoints on top of the
>>>>>> "rpmsg-tty-channel" service.
>>>>>> On remote side you just have to call rpmsg_create_ept with destination
>>>>>> address set to ANY. The result is a NS service announcement that trigs a
>>>>>>  probe with a new endpoint.
>>>>>> You can find code example for the remote side here:
>>>>>> https://github.com/STMicroelectronics/STM32CubeMP1/blob/master/Projects/STM32MP157C-DK2/Applications/OpenAMP/OpenAMP_TTY_echo/Src/main.c
>>>>>
>>>>> Demo code create two uarts(huart0 and huart1), and both use the same
>>>>> channel name( "rpmsg-tty-channel").
>>>>> But rpmsg_create_channel in kernel will complain the duplication:
>>>>> /* make sure a similar channel doesn't already exist */
>>>>> tmp = rpmsg_find_device(dev, chinfo);
>>>>> if (tmp) {
>>>>>         /* decrement the matched device's refcount back */
>>>>>         put_device(tmp);
>>>>>         dev_err(dev, "channel %s:%x:%x already exist\n",
>>>>>                    chinfo->name, chinfo->src, chinfo->dst);
>>>>>         return NULL;
>>>>> }
>>>>> Do you have some local change not upstream yet?
>>>> Nothing is missing. There is no complain as the function
>>>> rpmsg_device_match returns 0, because the chinfo->dst (that corresponds
>>>> to the remote ept address) is different.
>>>>
>>>
>>> Yes, you are right.
>>>
>>>> If i well remember you have also a similar implementation of the service
>>>> on your side. Do you see any incompatibility with your implementation?
>>>>
>>>
>>> Our implementation is similar to yours, but has two major difference:
>>> 1.Each instance has a different channel name but share the same prefix
>>> "rpmsg-tty*", the benefit is that:
>>>    a.Device name(/dev/tty*) is derived from rpmsg-tty*, instead the
>>> random /dev/ttyRPMSGx
>>>    b.Don't need tty_idr to allocate the unique device id
>> I understand the need but in your implementation it look like you hack
>> the rpmsg service to instantiate your tty... you introduce a kind of
>> meta rpmsg tty service with sub-service related to the serial content.
>> Not sure that this could be upstreamed...
> 
> Not too much hack here, the only change in common is:
> 1.Add match callback into rpmsg_driver
> 2.Call match callback in rpmsg_dev_match
> so rpmsg driver could join the bus match decision process(e.g. change
> the exact match to the prefix match).
> The similar mechanism exist in other subsystem for many years.
The mechanism also exists in rpmsg but based on the service. it is
similar to the compatible, based on the rpmsg_device_id structure that
should list the cervices supported.
My concern here is that you would like to expose the service on top of
the tty while aim of this driver is just to expose a tty over rpmsg. So
in this case seems not a generic implementation but a platform dependent
implementation.

> 
>> proposal to integrate your need in the ST driver: it seems possible to
>> have /dev/ttyRPMSGx with x corresponding to the remote endpoint address?
>> So if you want to have a fixed tty name you can fix the remote endpoint.
>> Is it something reasonable for you?
> 
> But in our system, we have more than ten rpmsg services running at the
> same time, it's difficult to manage them by the hardcode endpoint
> address.
Seems not so difficult. Today you identify your service by a name. Seems
just a matter of changing it by an address, it just an identifier by an
address instead of a string.

> 
>>
>>
>>> 2.Each transfer need get response from peer to avoid the buffer
>>> overflow. This is very important if the peer use pull
>>> model(read/write) instead of push model(callback).
>> I not sure to understand your point... You mean that you assume that the
>> driver should be blocked until a response from the remote side?
> 
> For example, in your RTOS demo code:
> 1.VIRT_UART0_RxCpltCallback save the received data in a global buffer
> VirtUart0ChannelBuffRx
> 2.Main loop poll VirtUart0RxMsg flag and echo the data back to kernel
> if this flag is set
> Between step1 and step 2, kernel may send additional data and then
> overwrite the data not get processed by main loop.
> It's very easy to reproduce by:
>   cat /dev/ttyRPMSGx > /tmp/dump &
>   cat /a/huge/file > /dev/ttyRPMSGx
>   diff /a/hug/file /tmp/dump
Yes our example is very limited, aim is not to be robust for this use
case but just giving a simple sample to allow user to send a simple text
in console and echo it.
> The push model mean the receiver could process the data completely in
> callback context, and
> the pull model mean the receiver just save the data in buffer and
> process it late(e.g. by read call).
Thanks for the clarification.
>> This seems not compatible with a "generic" tty and with Johan remarks:
>> "Just a drive-by comment; it looks like rpmsg_send() may block, but
>> the tty-driver write() callback must never sleep."
>>
> 
> The handshake doesn't mean the write callback must block, we can
> provide write_room callback to tell tty core to stop sending.
In the write function you have implemented the wait_for_completion that
blocks, waiting answer from the remote side. For instance in case of
remote firmware crash, you should be blocked.

> 
>> Why no just let rpmsg should manage the case with no Tx buffer free,
>> with a rpmsg_trysend...
> 
> We can't do this since the buffer(e.g. VirtUart0ChannelBuffRx) is
> managed by the individual driver:
> The rpmsg buffer free, doesn't mean the driver buffer also free.
Yes but this should be solved by your implementation in the remote
firmware and/or in the linux client code, not by blocking the write,
waiting an answer from remote.
If you want a mechanism it should be manage in your application or in a
client driver.

I think the main difference here is that the rpmsg_tty driver we propose
is only a wrapper that should have same behavior as a standard UART
link. This is our main requirement to allow to have same communication
with a firmware running on a co-processor or a external processor (with
an UART link).
In your driver, you introduce some extra mechanisms that probably
simplify your implementation, but that seems not compatible with a basic
link:
 - write ack
 - wakeup
...


> 
>>
>>>
>>> Here is the patch for kernel side:
>>> https://github.com/xiaoxiang781216/linux/commit/f04d2386eb11e0781f0eb47d99fae838abf7eb53
>>> https://github.com/xiaoxiang781216/linux/commit/1a41be362d916eb9104bf21065cb38a0a63d2e91
>>>
>>> And RTOS side:
>>> https://github.com/PineconeCode/nuttx/blob/song-u1/include/nuttx/serial/uart_rpmsg.h
>>> https://github.com/PineconeCode/nuttx/blob/song-u1/drivers/serial/uart_rpmsg.c
>>>
>>> Maybe, we can consider how to unify these two implementation into one.
>> Yes sure.
>>
>>>
