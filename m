Return-Path: <SRS0=eolO=2I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65A52C43603
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 16:37:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0F2542146E
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 16:37:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="L4CJqu4i"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727548AbfLRQhR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Dec 2019 11:37:17 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:37567 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727185AbfLRQhQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Dec 2019 11:37:16 -0500
Received: by mail-wr1-f68.google.com with SMTP id w15so3014056wru.4
        for <linux-kernel@vger.kernel.org>; Wed, 18 Dec 2019 08:37:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=subject:to:cc:references:from:openpgp:autocrypt:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=QydrVO/rNZd63JheuO9lqD6sfCU1B2E4W4CkJuCYMB0=;
        b=L4CJqu4iC/Cdb84U5mDKCTKM4RacewHvLUzKH8AMMNXL1sivqGoA3ZG5FnTGPf896f
         lviLXF3BBmD65/gay0C6dNTG5VzbdQ6/bGqDtgLcQBkfVZrRmG4qxj+xDo9YiLtOe7N6
         cm45zzKN5AWA0VzRgE4lroBimCSnmMcrgPaJw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-transfer-encoding:content-language;
        bh=QydrVO/rNZd63JheuO9lqD6sfCU1B2E4W4CkJuCYMB0=;
        b=ZPjTRuntD3xSPkYJ+x7M8zmLzHwUjtqo/G6+7X+qwgI60qOxHqipg2lrr+45sxB2KF
         xHUgPhw0Lifvkco6o3fONO1+vSpUCagxUt+2z/T6SrZBRQHS93NZrLghgWQGThiqFLTE
         Elp3R3CwZfQ6iu8hHrBTwv1Zy48prrt0upUT+EOp8EEYAJ7qHhAOqCXSdUuIBtVpRfwW
         7OZ13JdnmF0ALbDerRBycyOyD0jaz9ih6Oaepqhsw9WFhjv7h/V239vh8LYkjHkiZYQq
         otWuwTZwVPv+7q/O4POVyk8i/KzrtgXww3xedECCXQO6fi16ghclaqhgb6XEz9aqBITV
         SBbA==
X-Gm-Message-State: APjAAAWZDCL+1bBY+2lZwYVlefC1RJFwMTgTMa1bG9eCzhelqP9nzL8U
        OXNKZcVopgdDEPfzW1/3Gtrugg==
X-Google-Smtp-Source: APXvYqxSvZ3lKWdFwwu7l/PNa+A2cXnj/cTcXUqK5MFusm/tEkRwm/aMhvrVyvRlqLLsHOIo/Lg/Wg==
X-Received: by 2002:a5d:494f:: with SMTP id r15mr3995530wrs.143.1576687033389;
        Wed, 18 Dec 2019 08:37:13 -0800 (PST)
Received: from [10.28.17.247] ([192.19.231.250])
        by smtp.gmail.com with ESMTPSA id w8sm7025763wmd.2.2019.12.18.08.37.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Dec 2019 08:37:12 -0800 (PST)
Subject: Re: [PATCH 1/2] include: trace: Add SCMI header with trace events
To:     Sudeep Holla <sudeep.holla@arm.com>
Cc:     lukasz.luba@arm.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, mingo@redhat.com, rostedt@goodmis.org
References: <20191216161650.21844-1-lukasz.luba@arm.com>
 <20191216161650.21844-1-lukasz.luba@arm.com> <20191218120900.GA28599@bogus>
From:   Jim Quinlan <james.quinlan@broadcom.com>
Openpgp: preference=signencrypt
Autocrypt: addr=james.quinlan@broadcom.com; prefer-encrypt=mutual; keydata=
 mQENBFOXa3ABCADHz9QNP8upEMOGzf0RJ1lhBRnacq5Gz9fcbmcxK2y4PXtT1JR2WJWT3roY
 oHUXKL42zA74Iv6ODOjvO/VcvmJTllbz5zhuj5hDHBTNdSdspHWJMS3VdRtB5YQ4+4SNfi4O
 +ucstwf5U8HHLtsFes1udLWgujK4CD2mHBpR1tIc7dXP7jsCcxvkwA/jMN8D8w80kE1RY1eM
 3Chfft2oJOMK54n8f9x+iWdDsXV2e5vk0TLAJPB8ErGbAWj+HF+SQ/QdI6hdn/KbEQgJyZCV
 t8mB2uDfjvp14PIY02OSu9vgEWVYMMPoNLazromChJBtflewbp/Uim7BWYvcYRCPwx7VABEB
 AAG0KEppbSBRdWlubGFuIDxqYW1lcy5xdWlubGFuQGJyb2FkY29tLmNvbT6JATgEEwECACIF
 AlazUjUCGwMGCwkIBwMCBhUIAgkKCwQWAgMBAh4BAheAAAoJENnFxA/a7tJZiMwH/RHLgTPx
 BzrlFPQbEDfh05FXthTM0r1wC8AwHGmXhaxMT352Ju4jqCPvhF4YbczqEmuSFqOHZ6hQhBah
 L/O4QYRtBUCYhGg/cQ5WzklE48A2iNEoSsA8rP6Cy4wzXKrO0yPHQPyDtQ/o/Fa6T6r2EBAT
 mVtQBizeiDkUKDgfYU+o0iTW+205myQ9tTe3R0BJmq+F6dYdusKHRn9QXkm5oUC/tea3bq6N
 jnExBVz8LFaZRxe5uVs5Hwa+ZZqqsj3xJ6CmPQIktjcX8cHUSdrd/B7BC/kBwhhUeKT5HfQl
 KNk75rbMY8vJy8emev72Tyi3zq3tNy7DZvZoAmX5NGua8625AQ0EU5drcAEIAKmzln4+BvCz
 CfrbQqCd/EUhmVesujmNO2lTUFL20Wv1Kq27ZFXPaWfe9+lxg9R+p1Ry4ChRk7xZ34r56t0i
 lGZKH2CIETGChBedfOoDTcgt7K9lMlIxl9QIVEt5yxaqUExN38TIeEayBdeZSbPtmWzGQGl1
 kaUHY8l8GWSVB6mJrJaEnfpxt8xTbHdCbPzRM2nf5w76IFFvIP6ojnW06fWYTSYisPuidZs/
 7r1s8GpucrveKXNpzw3li9ChzI90zTBpMl3jWtqOQE5Nn0UHpPvN2SiAJ/Gm18LRP8TCTmOU
 bpLN2UoJhUGdscyYen+ECxVEZXsQCyASJvGzcWHjQL8AEQEAAYkBHwQYAQIACQUCU5drcAIb
 DAAKCRDZxcQP2u7SWUnTCAC8GirJT3daWnIgc23Qw0caHxP9dHLNKf4Fo1bxss5n6JoZgQWt
 kvqWRBBGqHTBbVBrScH5jI7kYRXaP37Q6J4bOxi68L/NC9qY7y41M6O+EaRZ4xYR5PjXY7yu
 eEeLGk0U8L6lgOtCH53lhk0i4E5BRKvg71T0UvmJPpSmtYUo/JH0sCinJADCQx+C961yPerJ
 xOO2mNvMpvXjMSqeWzYmZ9uhvRGVfo5O9i4MdFXpSm/3a3i/bZLaxPt3tjxJu+aPKHHadKcr
 8EmSDiRrCGBbnhED/fvI/titv3qxtMBLAY++03FOh6XC93NjsRC3yCogAY7iIuWoWBmisCQ6 Kcyg
Message-ID: <7b59a2f1-0786-d24f-a653-76a60c15a8ae@broadcom.com>
Date:   Wed, 18 Dec 2019 11:37:10 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20191218120900.GA28599@bogus>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 12/18/19 7:09 AM, Sudeep Holla wrote:
> On Mon, Dec 16, 2019 at 05:15:54PM -0500, Jim Quinlan wrote:
>> From: Lukasz Luba <lukasz.luba@arm.com>
>>
>> +
>> +TRACE_EVENT(scmi_xfer_begin,
>> +	TP_PROTO(u8 id, u8 protocol_id, u16 seq, bool poll),
>> +	TP_ARGS(id, protocol_id, seq, poll),
>> +
>> +	TP_STRUCT__entry(
>> +		__field(u8, id)
>> +		__field(u8, protocol_id)
>> +		__field(u16, seq)
>> +		__field(bool, poll)
>> +	),
>> +
>> +	TP_fast_assign(
>> +		__entry->id =3D id;
>> +		__entry->protocol_id =3D protocol_id;
>> +		__entry->seq =3D seq;
>> +		__entry->poll =3D poll;
>> +	),
>> +
>> +	TP_printk("id=3D%u protocol_id=3D%u seq=3D%u poll=3D%u", __entry->id=
,
>> +		__entry->protocol_id, __entry->seq, __entry->poll)
>> +);
>> +
>> +TRACE_EVENT(scmi_xfer_end,
>> +	TP_PROTO(u8 id, u8 protocol_id, u16 seq, u32 status),
>> +	TP_ARGS(id, protocol_id, seq, status),
>> +
>> +	TP_STRUCT__entry(
>> +		__field(u8, id)
>> +		__field(u8, protocol_id)
>> +		__field(u16, seq)
>> +		__field(u32, status)
>> +	),
>> +
>> +	TP_fast_assign(
>> +		__entry->id =3D id;
>> +		__entry->protocol_id =3D protocol_id;
>> +		__entry->seq =3D seq;
>> +		__entry->status =3D status;
>> +	),
>> +
>> +	TP_printk("id=3D%u protocol_id=3D%u seq=3D%u status=3D%u", __entry->=
id,
>> +		__entry->protocol_id, __entry->seq, __entry->status)
>> +);
>>
>> Hello,
>>
>> When there are multiple messages in the mbox queue, I've found it
>> a chore matching up the 'begin' event with the 'end' event for each
>> SCMI msg.  The id (command) may not be unique, the proto_id may not be=

>> unique, and the seq may not be unique.
> I agree on id and proto_id part easily and the seq may not be unique
> if and only if the previous command has completed.
>
>> The combination of the three may not be unique.
> Not 100% sure on that. I remember one of the issue you reported where O=
S
> times out and platform may still be processing it. That's one of the
> case where seq id may get re-assigned, but now that's fixed and the
> scenario may not happen. I am trying to understand why you think it
> is not unique ?
If I submit a series of five clk_enable() calls via SCMI, and they are al=
l
executed sequentially, they will most likely have the same seq-proto-cmd =
value
-- do you agree?=C2=A0 Now typically one can match the begin tracepoint w=
ith the
end because they come in pairs.=C2=A0 But when you are using four protoco=
ls and=C2=A0
the mbox queue has more than one, it is difficult to eyeball the trace ou=
tput
and have a good idea of what is going on.=C2=A0 If one uses a post
processing script, that's another story.
>
>> Would it make sense to assign a monotonically increasing ID to each
>> msg so that one can easily match the two events for each msg?
> I am not sure if we need to maintain a tracker/counter just for trace
> purposes.
I was just suggesting this for consideration -- if you deem it not helpfu=
l,
or cannot demonstrate its usefulness, by all means do not add it.
I have an alternative method for logging SCMI events that I prefer
(see below as to why).
>
>> This id could be the result of an atomic increment and
>> could be stored in the xfer structure.  Of course, it would be one of
>> the values printed out in the events.
>>
>> Also, would you consider a third event, right after the
>> scmi_fetch_response() invocation in scmi_rx_callback()?  I've found
>> this to be insightful in situations where we were debugging a timeout.=

>>
>> I'm fine if you elect not to do the above; I just wanted to post
>> this for your consideration.
>>
> I am interested in the scenario we can make use of this and also help
> in testing it if we add this. I am not against it but I don't see the
> need for it.
I have a test driver that forks four threads, each of which indirectly
creates SCMI messages of different protocols (sensor, clk, perf, brcm).=C2=
=A0 In other
words, a stress test for the SCMI infrastructure and platform response.=C2=
=A0 I
suspect you have a similar test configuration?=C2=A0 I set this up so=C2=A0=
 we can reproduce
some problems w/o having to run the entire middleware stack.

At any rate,=C2=A0 I've tested V2, and although I get a lot of

=2E.. scmi_xfer_begin: transfer_id=3D48379 msg_id=3D7 protocol_id=3D128 s=
eq=3D0 poll=3D0
=2E.. scmi_rx_done: transfer_id=3D48379 msg_id=3D7 protocol_id=3D128 seq=3D=
0 msg_type=3D0
=2E.. scmi_xfer_end: transfer_id=3D48380 msg_id=3D8 protocol_id=3D128 seq=
=3D0 status=3D0
=2E.. scmi_xfer_begin: transfer_id=3D48381 msg_id=3D7 protocol_id=3D128 s=
eq=3D0 poll=3D0
=2E.. scmi_rx_done: transfer_id=3D48381 msg_id=3D7 protocol_id=3D128 seq=3D=
0 msg_type=3D0
=2E.. scmi_xfer_end: transfer_id=3D48381 msg_id=3D7 protocol_id=3D128 seq=
=3D0 status=3D0
=2E.. scmi_xfer_begin: transfer_id=3D48382 msg_id=3D8 protocol_id=3D128 s=
eq=3D0 poll=3D0
=2E.. scmi_rx_done: transfer_id=3D48382 msg_id=3D8 protocol_id=3D128 seq=3D=
0 msg_type=3D0
=2E.. scmi_xfer_end: transfer_id=3D48382 msg_id=3D8 protocol_id=3D128 seq=
=3D0 status=3D0
=2E.. scmi_xfer_begin: transfer_id=3D48383 msg_id=3D7 protocol_id=3D128 s=
eq=3D0 poll=3D0


I also see a stretch of over 100 (contiguous) of these

=2E.. scmi_rx_done: transfer_id=3D48321 msg_id=3D7 protocol_id=3D128 seq=3D=
0 msg_type=3D0
=2E.. scmi_rx_done: transfer_id=3D48322 msg_id=3D8 protocol_id=3D128 seq=3D=
0 msg_type=3D0
=2E.. scmi_rx_done: transfer_id=3D48323 msg_id=3D7 protocol_id=3D128 seq=3D=
0 msg_type=3D0
=2E.. scmi_rx_done: transfer_id=3D48324 msg_id=3D8 protocol_id=3D128 seq=3D=
0 msg_type=3D0

which I cannot explain -- perhaps ftrace doesn't work well in interrupt c=
ontext?
Note also that we use interrupts issued from the platform for both channe=
ls.

Regards,
Jim


>
> --
> Regards,
> Sudeep
>


