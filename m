Return-Path: <SRS0=kYop=UV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3E74C43613
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Jun 2019 01:03:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E93920881
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Jun 2019 01:03:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=valvesoftware.com header.i=@valvesoftware.com header.b="IhcDZi8P"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726447AbfFVBDf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Jun 2019 21:03:35 -0400
Received: from us-smtp-delivery-172.mimecast.com ([216.205.24.172]:23931 "EHLO
        us-smtp-delivery-172.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726052AbfFVBDe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jun 2019 21:03:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valvesoftware.com;
        s=mc20150811; t=1561165413;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8T/ERB8E1LibLg93LolKTUL8QwTL40Jai0YiV5j2f+M=;
        b=IhcDZi8PO/jrXAeNqSCJAkSZeVQax67YUsR4tY3pxpghO+vnR5uneAWUshS/WA0FzrD4L1
        B0QsCu5FkqdyZ5qIJVwCXSBR28hW49vUvwWcJXmiNWxFN3q3C3ywdmtFHYL58HrwJIGztM
        6yXthMxau2rfSdCAVrWKf+By741KI3U=
Received: from smtp01.valvesoftware.com (smtp01.valvesoftware.com
 [208.64.203.181]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-79-0tQdWoNqOoyH0Az5YJiF6w-1; Fri, 21 Jun 2019 21:03:32 -0400
Received: from [172.16.1.107] (helo=antispam.valve.org)
        by smtp01.valvesoftware.com with esmtp (Exim 4.86_2)
        (envelope-from <pgriffais@valvesoftware.com>)
        id 1heUdq-0006rI-Il
        for linux-kernel@vger.kernel.org; Fri, 21 Jun 2019 18:16:30 -0700
Received: from antispam.valve.org (127.0.0.1) id h1lv660171s1 for <linux-kernel@vger.kernel.org>; Fri, 21 Jun 2019 18:03:31 -0700 (envelope-from <pgriffais@valvesoftware.com>)
Received: from mail1.valvemail.org ([172.16.144.22])
        by antispam.valve.org ([172.16.1.107]) (SonicWALL 9.0.5.2081 )
        with ESMTP id o201906220103310000288-5; Fri, 21 Jun 2019 18:03:31 -0700
Received: from [172.18.41.51] (172.18.41.51) by mail1.valvemail.org
 (172.16.144.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1415.2; Fri, 21 Jun
 2019 18:02:25 -0700
From:   "Pierre-Loup A. Griffais" <pgriffais@valvesoftware.com>
Subject: Re: Steam is broken on new kernels
To:     Eric Dumazet <edumazet@google.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
CC:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        lkml <linux-kernel@vger.kernel.org>
References: <a624ec85-ea21-c72e-f997-06273d9b9f9e@valvesoftware.com>
 <20190621214139.GA31034@kroah.com>
 <CAHk-=wgXoBMWdBahuQR9e75ri6oeVBBjoVEnk0rN1QXfSKK2Eg@mail.gmail.com>
 <CANn89iL5+x3n9H9v4O6y39W=jvQs=uuXbzOvN5mBbcj0t+wdeg@mail.gmail.com>
 <CAHk-=wjZ=8VSjWuqeG6JJv4dQfK6M0Jgckq5-6=SJa25aku-vQ@mail.gmail.com>
 <CANn89iLU+NNy7QDPNLYPxNWMx5cXuhziOT7TX2uYt42uUJcNVg@mail.gmail.com>
Message-ID: <b72599d1-b5d5-1c23-15fc-8e2f9454af05@valvesoftware.com>
Date:   Fri, 21 Jun 2019 18:01:44 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <CANn89iLU+NNy7QDPNLYPxNWMx5cXuhziOT7TX2uYt42uUJcNVg@mail.gmail.com>
Content-Language: en-US
X-ClientProxiedBy: mail1.valvemail.org (172.16.144.22) To mail1.valvemail.org
 (172.16.144.22)
X-EXCLAIMER-MD-CONFIG: fe5cb8ea-1338-4c54-81e0-ad323678e037
X-Mlf-CnxnMgmt-Allow: 172.16.144.22
X-Mlf-Version: 9.0.5.2081
X-Mlf-License: BSVKCAP__
X-Mlf-UniqueId: o201906220103310000288
X-MC-Unique: 0tQdWoNqOoyH0Az5YJiF6w-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 6/21/19 5:19 PM, Eric Dumazet wrote:
> On Fri, Jun 21, 2019 at 7:54 PM Linus Torvalds
> <torvalds@linux-foundation.org> wrote:
>>
>> Eric is talking about this patch, I think:
>>
>>     https://patchwork.ozlabs.org/patch/1120222/
>>
>=20
> That  is correct.
>=20
> I am about to take a flight from Boston to Paris, so I can not really
> follow discussions/tests for the following hours.

I built the tip of linux-5.1.y and reproduced the issue while trying to=20
log out and back into Steam; it exhibited this symptom as well:

pgriffais@pgriffais:~$ nstat -az | grep -i wqueue
TcpExtTCPWqueueTooBig           31                 0.0

I applied Eric's path to the tip of the branch and ran that kernel and=20
the bug didn't occur through several logout / login cycles, so things=20
look good at first glance. I'll keep running that kernel and report back=20
if anything crops up in the future, but I believe we're good, beyond=20
getting distros to ship this additional fix.

Thanks,
  - Pierre-Loup

>=20
> Thanks.
>=20
>> I guess I'll ask people on the github thread to test that too.
>>
>>                    Linus
>>
>> On Fri, Jun 21, 2019 at 3:38 PM Eric Dumazet <edumazet@google.com> wrote=
:
>>>
>>> Please look at my recent patch.
>>>   Sorry I am travelling....
>>>
>>> On Fri, Jun 21, 2019, 6:19 PM Linus Torvalds <torvalds@linux-foundation=
.org> wrote:
>>>>
>>>> On Fri, Jun 21, 2019 at 2:41 PM Greg Kroah-Hartman
>>>> <gregkh@linuxfoundation.org> wrote:
>>>>>
>>>>> What specific commit caused the breakage?
>>>>
>>>> Both on reddit and on github there seems to be confusion about whether
>>>> it's a problem or not. Some people have it working with the exact same
>>>> kernel that breaks for others.
>>>>
>>>> And then some people seem to say it works intermittently for them,
>>>> which seems to indicate a timing issue.
>>>>
>>>> Looking at the SACK patches (assuming it's one of them), I'd suspect
>>>> the "tcp: tcp_fragment() should apply sane memory limits".
>>>>
>>>> Eric, that one does
>>>>
>>>>         if (unlikely((sk->sk_wmem_queued >> 1) > sk->sk_sndbuf)) {
>>>>                 NET_INC_STATS(sock_net(sk), LINUX_MIB_TCPWQUEUETOOBIG)=
;
>>>>                 return -ENOMEM;
>>>>         }
>>>>
>>>> but I think it's *normal* for "sk_wmem_queued >> 1" to be around the
>>>> same size as sk_sndbuf. So if there is some fragmentation, and we add
>>>> more skb's to it, that would seem to trigger fairly easily.
>>>> Particularly since this is all in "truesize" units, which can be a lot
>>>> bigger than the packets themselves.
>>>>
>>>> I don't know the code, so I may be out to lunch and barking up
>>>> completely the wrong tree, but that particular check does seem like it
>>>> might trigger much more easily than I think the code _intended_ it to
>>>> trigger?
>>>>
>>>> Pierre-Loup - do you guys have a test-case inside of valve? Or is this
>>>> purely "we see some people with problems"?
>>>>
>>>>                 Linus
>=20

