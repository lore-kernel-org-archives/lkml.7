Return-Path: <SRS0=wo+8=V5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F712C433FF
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 01:52:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 42ADC214DA
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 01:52:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=valvesoftware.com header.i=@valvesoftware.com header.b="jrFKxKzi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729396AbfHABvG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Jul 2019 21:51:06 -0400
Received: from us-smtp-delivery-172.mimecast.com ([216.205.24.172]:42799 "EHLO
        us-smtp-delivery-172.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726514AbfHABvG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jul 2019 21:51:06 -0400
X-Greylist: delayed 384 seconds by postgrey-1.27 at vger.kernel.org; Wed, 31 Jul 2019 21:51:04 EDT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valvesoftware.com;
        s=mc20150811; t=1564624264;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ktBWQ7Dg2JkWHb4Wr0QSz+YEpRPFJ5RhEadMppEErJo=;
        b=jrFKxKziF85H+lYERHXD33SZb7nLufuK4+GCMS15hFO38tkMYQ2REP/E30lqfDTlh0JfhK
        D87N1PZE+tBvkytr4IWzhcVFTO3xZ+PbZQQ4ei2b24jbv3eDYtLhKmO7/kuRBod+SYujx2
        C9op+zia+Pv6sG8xTXxNeY3v0Vhlv/U=
Received: from smtp01.valvesoftware.com (smtp01.valvesoftware.com
 [208.64.203.181]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-217-1Hghwc2rOtKf844kNt_97g-1; Wed, 31 Jul 2019 21:44:38 -0400
Received: from [172.16.1.107] (helo=antispam.valve.org)
        by smtp01.valvesoftware.com with esmtp (Exim 4.86_2)
        (envelope-from <pgriffais@valvesoftware.com>)
        id 1ht0ME-0004X6-PO
        for linux-kernel@vger.kernel.org; Wed, 31 Jul 2019 18:58:18 -0700
Received: from antispam.valve.org (127.0.0.1) id h8920a0171s3 for <linux-kernel@vger.kernel.org>; Wed, 31 Jul 2019 18:44:37 -0700 (envelope-from <pgriffais@valvesoftware.com>)
Received: from mail1.valvemail.org ([172.16.144.22])
        by antispam.valve.org ([172.16.1.107]) (SonicWALL 9.0.5.2081 )
        with ESMTP id o201908010144370011552-5; Wed, 31 Jul 2019 18:44:37 -0700
Received: from [172.18.23.31] (172.18.23.31) by mail1.valvemail.org
 (172.16.144.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1415.2; Wed, 31 Jul
 2019 18:43:32 -0700
Subject: Re: [PATCH RFC 2/2] futex: Implement mechanism to wait on any of
 several futexes
To:     Zebediah Figura <z.figura12@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Gabriel Krisman Bertazi <krisman@collabora.com>
CC:     <mingo@redhat.com>, <peterz@infradead.org>, <dvhart@infradead.org>,
        <linux-kernel@vger.kernel.org>, <kernel@collabora.com>,
        Steven Noonan <steven@valvesoftware.com>
References: <20190730220602.28781-1-krisman@collabora.com>
 <20190730220602.28781-2-krisman@collabora.com>
 <alpine.DEB.2.21.1908010039470.1788@nanos.tec.linutronix.de>
 <31ad0ada-ecc7-60b3-e204-898460254be3@gmail.com>
 <a7b54799-2fda-2e7b-821a-1ec9652e9596@gmail.com>
From:   "Pierre-Loup A. Griffais" <pgriffais@valvesoftware.com>
Message-ID: <3af1586a-f5b8-9728-d140-4fc4709ba49c@valvesoftware.com>
Date:   Wed, 31 Jul 2019 18:42:38 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <a7b54799-2fda-2e7b-821a-1ec9652e9596@gmail.com>
Content-Language: en-US
X-ClientProxiedBy: mail1.valvemail.org (172.16.144.22) To mail1.valvemail.org
 (172.16.144.22)
X-EXCLAIMER-MD-CONFIG: fe5cb8ea-1338-4c54-81e0-ad323678e037
X-Mlf-CnxnMgmt-Allow: 172.16.144.22
X-Mlf-Version: 9.0.5.2081
X-Mlf-License: BSVKCAP__
X-Mlf-UniqueId: o201908010144370011552
X-MC-Unique: 1Hghwc2rOtKf844kNt_97g-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/31/19 6:32 PM, Zebediah Figura wrote:
> On 7/31/19 8:22 PM, Zebediah Figura wrote:
>> On 7/31/19 7:45 PM, Thomas Gleixner wrote:
>>> If I assume a maximum of 65 futexes which got mentioned in one of the
>>> replies then this will allocate 7280 bytes alone for the futex_q=20
>>> array with
>>> a stock debian config which has no debug options enabled which would=20
>>> bloat
>>> the struct. Adding the futex_wait_block array into the same allocation
>>> becomes larger than 8K which already exceeds thelimit of SLUB kmem
>>> caches and forces the whole thing into the page allocator directly.
>>>
>>> This sucks.
>>>
>>> Also I'm confused about the 64 maximum resulting in 65 futexes=20
>>> comment in
>>> one of the mails.
>>>
>>> Can you please explain what you are trying to do exatly on the user=20
>>> space
>>> side?
>>
>> The extra futex comes from the fact that there are a couple of, as it
>> were, out-of-band ways to wake up a thread on Windows. [Specifically, a
>> thread can enter an "alertable" wait in which case it will be woken up
>> by a request from another thread to execute an "asynchronous procedure
>> call".] It's easiest for us to just add another futex to the list in
>> that case.
>=20
> To be clear, the 64/65 distinction is an implementation detail that's=20
> pretty much outside the scope of this discussion. I should have just=20
> said 65 directly. Sorry about that.
>=20
>>
>> I'd also point out, for whatever it's worth, that while 64 is a hard
>> limit, real applications almost never go nearly that high. By far the
>> most common number of primitives to select on is one.
>> Performance-critical code never tends to wait on more than three. The
>> most I've ever seen is twelve.
>>
>> If you'd like to see the user-side source, most of the relevant code is
>> at [1], in particular the functions __fsync_wait_objects() [line 712]
>> and do_single_wait [line 655]. Please feel free to ask for further
>> clarification.
>>
>> [1]
>> https://github.com/ValveSoftware/wine/blob/proton_4.11/dlls/ntdll/fsync.=
c

In addition, here's an example of how I think it might be useful to=20
expose it to apps at large in a way that's compatible with existing=20
pthread mutexes:

https://github.com/Plagman/glibc/commit/3b01145fa25987f2f93e7eda7f3e7d0f2f7=
7b290

This patch hasn't received nearly as much testing as the Wine fsync code=20
path, but that functionality would provide more CPU-efficient ways for=20
thread pool code to sleep in our game engine. We also use eventfd today.

For this, I think the expected upper bound for the per-op futex count=20
would be in the same order of magnitude as the logical CPU count on the=20
target machine, similar as the Wine use-case.

Thanks,
  - Pierre-Loup

>>
>>
>>
>>>
>>> Thanks,
>>>
>>> =C2=A0=C2=A0=C2=A0=C2=A0tglx
>>>
>>
>=20

