Return-Path: <SRS0=s1fu=UU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1A53C43613
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Jun 2019 23:06:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 78C782084E
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Jun 2019 23:06:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=valvesoftware.com header.i=@valvesoftware.com header.b="FcaK3FfI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726097AbfFUXGi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Jun 2019 19:06:38 -0400
Received: from us-smtp-delivery-172.mimecast.com ([216.205.24.172]:49944 "EHLO
        us-smtp-delivery-172.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726043AbfFUXGi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jun 2019 19:06:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valvesoftware.com;
        s=mc20150811; t=1561158397;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=khi2c0Mqdj4DIYyZy9yeSvJob6ynT2A1OvkIW1E3kOk=;
        b=FcaK3FfIXyLNYE7a87qqWPpbni1bbsj34X1uzrwdgtrkbBzPqPriY+Y+ZWCzBA261RLjKz
        85zIEBrgZtyiwwCLSccYpC0gnDkegFmYr97Eole5XsgFze+5Ky9/dYWVcf1uJCB4C/k4Vc
        J1QD6JHxyHaAB++8xztOdx/6HtIQbCU=
Received: from smtp01.valvesoftware.com (smtp01.valvesoftware.com
 [208.64.203.181]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-255-vbkk5ZaEPA-NkLbcxy1jLA-1; Fri, 21 Jun 2019 19:06:36 -0400
Received: from [172.16.1.107] (helo=antispam.valve.org)
        by smtp01.valvesoftware.com with esmtp (Exim 4.86_2)
        (envelope-from <pgriffais@valvesoftware.com>)
        id 1heSoh-0001Oq-3s
        for linux-kernel@vger.kernel.org; Fri, 21 Jun 2019 16:19:35 -0700
Received: from antispam.valve.org (127.0.0.1) id h1lhfm0171sm for <linux-kernel@vger.kernel.org>; Fri, 21 Jun 2019 16:06:35 -0700 (envelope-from <pgriffais@valvesoftware.com>)
Received: from mail1.valvemail.org ([172.16.144.22])
        by antispam.valve.org ([172.16.1.107]) (SonicWALL 9.0.5.2081 )
        with ESMTP id o201906212306350015820-5; Fri, 21 Jun 2019 16:06:35 -0700
Received: from [172.18.41.51] (172.18.41.51) by mail1.valvemail.org
 (172.16.144.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1415.2; Fri, 21 Jun
 2019 16:05:30 -0700
Subject: Re: Steam is broken on new kernels
To:     Eric Dumazet <edumazet@google.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
CC:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        lkml <linux-kernel@vger.kernel.org>
References: <a624ec85-ea21-c72e-f997-06273d9b9f9e@valvesoftware.com>
 <20190621214139.GA31034@kroah.com>
 <CAHk-=wgXoBMWdBahuQR9e75ri6oeVBBjoVEnk0rN1QXfSKK2Eg@mail.gmail.com>
 <CANn89iL5+x3n9H9v4O6y39W=jvQs=uuXbzOvN5mBbcj0t+wdeg@mail.gmail.com>
From:   "Pierre-Loup A. Griffais" <pgriffais@valvesoftware.com>
Message-ID: <5a012e7c-cbed-c3a9-8d84-851de34630d8@valvesoftware.com>
Date:   Fri, 21 Jun 2019 16:04:57 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <CANn89iL5+x3n9H9v4O6y39W=jvQs=uuXbzOvN5mBbcj0t+wdeg@mail.gmail.com>
Content-Language: en-US
X-ClientProxiedBy: mail1.valvemail.org (172.16.144.22) To mail1.valvemail.org
 (172.16.144.22)
X-EXCLAIMER-MD-CONFIG: fe5cb8ea-1338-4c54-81e0-ad323678e037
X-Mlf-CnxnMgmt-Allow: 172.16.144.22
X-Mlf-Version: 9.0.5.2081
X-Mlf-License: BSVKCAP__
X-Mlf-UniqueId: o201906212306350015820
X-MC-Unique: vbkk5ZaEPA-NkLbcxy1jLA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 6/21/19 3:38 PM, Eric Dumazet wrote:
> Please look at my recent patch.
>  =C2=A0Sorry I am travelling....
>=20
> On Fri, Jun 21, 2019, 6:19 PM Linus Torvalds=20
> <torvalds@linux-foundation.org <mailto:torvalds@linux-foundation.org>>=20
> wrote:
>=20
>     On Fri, Jun 21, 2019 at 2:41 PM Greg Kroah-Hartman
>     <gregkh@linuxfoundation.org <mailto:gregkh@linuxfoundation.org>> wrot=
e:
>      >
>      > What specific commit caused the breakage?
>=20
>     Both on reddit and on github there seems to be confusion about whethe=
r
>     it's a problem or not. Some people have it working with the exact sam=
e
>     kernel that breaks for others.
>=20
>     And then some people seem to say it works intermittently for them,
>     which seems to indicate a timing issue.
>=20
>     Looking at the SACK patches (assuming it's one of them), I'd suspect
>     the "tcp: tcp_fragment() should apply sane memory limits".
>=20
>     Eric, that one does
>=20
>      =C2=A0 =C2=A0 =C2=A0 =C2=A0if (unlikely((sk->sk_wmem_queued >> 1) > =
sk->sk_sndbuf)) {
>      =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0NET_INC_STATS=
(sock_net(sk), LINUX_MIB_TCPWQUEUETOOBIG);
>      =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return -ENOME=
M;
>      =C2=A0 =C2=A0 =C2=A0 =C2=A0}
>=20
>     but I think it's *normal* for "sk_wmem_queued >> 1" to be around the
>     same size as sk_sndbuf. So if there is some fragmentation, and we add
>     more skb's to it, that would seem to trigger fairly easily.
>     Particularly since this is all in "truesize" units, which can be a lo=
t
>     bigger than the packets themselves.
>=20
>     I don't know the code, so I may be out to lunch and barking up
>     completely the wrong tree, but that particular check does seem like i=
t
>     might trigger much more easily than I think the code _intended_ it to
>     trigger?
>=20
>     Pierre-Loup - do you guys have a test-case inside of valve? Or is thi=
s
>     purely "we see some people with problems"?

Definitely the latter, although the volume of complaints clearly points=20
to a real problem from our experience. Reproducing locally, bisecting=20
and testing possible fixes is just now starting on our end.

I agree not all users seem affected; most affected people report success=20
by using -tcp to launch Steam, which makes it use direct TCP instead of=20
WebSockets, our current default connection method for Linux.

Thanks,
  - Pierre-Loup

>=20
>      =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0Linus
>=20

