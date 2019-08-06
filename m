Return-Path: <SRS0=vI2Y=WC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: *
X-Spam-Status: No, score=1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FAKE_REPLY_A1,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E042C433FF
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Aug 2019 08:57:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4D81F208C3
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Aug 2019 08:57:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="RRIbm8c6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732397AbfHFI5N (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Aug 2019 04:57:13 -0400
Received: from mout.gmx.net ([212.227.17.22]:49421 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732189AbfHFI5M (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Aug 2019 04:57:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1565081830;
        bh=YRhwcRqtz0+hjZKr/yIcADg6NXp62e+D0fDzWHf5Qb0=;
        h=X-UI-Sender-Class:To:From:Subject:Date;
        b=RRIbm8c6V0rBAQL9WpT1b/myRgySZGJTb5GwiOo+xdpfuGrgGHlC99EZ5oJ7/94dj
         9ULs6/Q2oINWhWo71A15ElcDypvQPFA9G5r7q0ETi0xJQewzaOmuByo85LaXbvvhsl
         YTHjK9Bt/aWXEDXmPooiHuxgnBtDOjEkYNSfR+ME=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.67.1] ([130.183.139.50]) by mail.gmx.com (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MKbkC-1hcATR46cW-00KuiC for
 <linux-kernel@vger.kernel.org>; Tue, 06 Aug 2019 10:57:10 +0200
To:     linux-kernel@vger.kernel.org
From:   Johannes Buchner <buchner.johannes@gmx.at>
Openpgp: preference=signencrypt
Autocrypt: addr=buchner.johannes@gmx.at; prefer-encrypt=mutual; keydata=
 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
 QTJHXxIR5MY1CRKGV2gvcu9ESQ==
Subject: Re: Let's talk about the elephant in the room - the Linux kernel's
 inability to gracefully handle low memory pressure
Message-ID: <5a42d32d-df03-85ae-d487-3faaa9f1fd9a@gmx.at>
Date:   Tue, 6 Aug 2019 10:57:06 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="7RHlYysSiI4Yzcz7rPizndaIgSy3EOI76"
X-Provags-ID: V03:K1:C0LzDOxTLbksA7v0Kz1aWeNyY0k7y6NEOF5GSsYWEQgeoYtk4j5
 GjEhVfd0nXS05ZJhr6+aQOrTJuYI/3g1OGnrnwKwiC1hABmcUx+nDIdZBZ32MUJHj85NYRQ
 OLZbJfChEP0KjowSRp71fMcEe37jaTQS0XkFOqoJqcN2S22c9Ep45wMjPOsMbSRpWd1yBYJ
 BUhcsrN5/ZaJE3McYB0rA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:0IGSdv+uSdY=:brdxfhx5h6EyrJcSz8HUDE
 2tU0CQaKspSYGtqijNl8C9QcS11HUVLcFN/tunU99xWNfb5NuFpY5GG7qlWrp5Txtnz0eDnuR
 XRk7hN5mHOyBjHrwT14RFI6OXkp/fSpeoT4pabb7NC3b0sB8pp1WdiJ8c50+01zw2HNusHm7m
 ItCI70DFum4Kuu8IqQx0jLqk4Fi4qLLilXwHQV3kuBTU3xYGIrTfKqZC0KcIjqld/GtRc4FL9
 2hSlSD2GFtFnQnOFAW+Bgh3PgL4DVmRzlOmAkXt+f7GSoDxl7FpPL46XxC1XezWLsRVleGwHt
 Kq2b700mE0djOWu3jByth0aXskOPAZJ+dUr5TqCPjXdAq0m0xuFmbyvr5tkKoAYn8XQQ89ytc
 OsEQLhld/WolUeosJPur4nBPgcPOJiMA2frhfuPPJK1ZZSHrxpidwTQ77PQUs3v4Zd2cqi8T1
 lJ6xP6hRG/yTDprLUJrqM1KJudcAjg3hCJ4mmIBvBxMPObYzNYSQ2mHe3i2n06ct9V4pATbMC
 velFfJEyqp+MPpCzC8dr5Y35hITNGc2Kd43vhEHFtHDeEuWJSrKzROep9bvuuJ9mZI08zi6X2
 k0ADj/YqA9IIkfClPNIEtw3HnsLAdp6smHuiUyzw8vTu5+luhhxA0ByxsW4ffuDHJUwhy762z
 TXZTwKLOB9ZkG3CF2BvxfM1QU65ftjErkYBlIRsUSoGKxHkZq7PYebwECLlbI/wNHccLoHLiQ
 vJ7yNyEi2rI8wrrW3L1Q6uuoeptQoZol9Z1fXJ/bXK8M2B8+YmalBnlEmJgbNmndIAbVcr+JA
 epmNOjvlZGnDr8w957kCVjZkhWA5RdYkMeo47zaYUI9UUvFFxat7jZCb5OpZxWeXIWGEPUwjD
 0X2/idG8KOrNJ9ixg2tDkfRdrs7N0oOUC8J2uKF5ktwE19GHiGhxbu84DscQR/3XTafeyV8Oc
 jpvede3Y5tANz0AcgV9qQzVnkj/2ISi98mUXZBrPsQEao2RlclyxVRHozsJuF2RrllqpDlFit
 xNq3cZCUIkE76ER6bHiUP3EWXJ+ZzwlXxLH647nIqKMMd88jwFJOruEY8iUJtgcVmjUCwNdoE
 nKHFvMHB/jbxgQqkPrU3vRzR3Xt4DHWC5VvzRp6R4LlDT19nqvj+AKmLQ==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--7RHlYysSiI4Yzcz7rPizndaIgSy3EOI76
Content-Type: multipart/mixed; boundary="jABzv2lUedKk5GgH6kKF4W1GLbrqqMzVJ";
 protected-headers="v1"
From: Johannes Buchner <buchner.johannes@gmx.at>
To: linux-kernel@vger.kernel.org
Message-ID: <5a42d32d-df03-85ae-d487-3faaa9f1fd9a@gmx.at>
Subject: Re: Let's talk about the elephant in the room - the Linux kernel's
 inability to gracefully handle low memory pressure

--jABzv2lUedKk5GgH6kKF4W1GLbrqqMzVJ
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

> On Mon, Aug 5, 2019 at 12:31 PM Johannes Weiner <hannes@cmpxchg.org> wr=
ote:
>>
>> On Mon, Aug 05, 2019 at 02:13:16PM +0200, Vlastimil Babka wrote:
>> > On 8/4/19 11:23 AM, Artem S. Tashkinov wrote:
>> > > Hello,
>> > >
>> > > There's this bug which has been bugging many people for many years=

>> > > already and which is reproducible in less than a few minutes under=
 the
>> > > latest and greatest kernel, 5.2.6. All the kernel parameters are s=
et to
>> > > defaults.
>> > >
>> > > Steps to reproduce:
>> > >
>> > > 1) Boot with mem=3D4G
>> > > 2) Disable swap to make everything faster (sudo swapoff -a)
>> > > 3) Launch a web browser, e.g. Chrome/Chromium or/and Firefox
>> > > 4) Start opening tabs in either of them and watch your free RAM de=
crease
>> > >
>> > > Once you hit a situation when opening a new tab requires more RAM =
than
>> > > is currently available, the system will stall hard. You will barel=
y  be
>> > > able to move the mouse pointer. Your disk LED will be flashing
>> > > incessantly (I'm not entirely sure why). You will not be able to r=
un new
>> > > applications or close currently running ones.
>> >
>> > > This little crisis may continue for minutes or even longer. I thin=
k
>> > > that's not how the system should behave in this situation. I belie=
ve
>> > > something must be done about that to avoid this stall.
>> >
>> > Yeah that's a known problem, made worse SSD's in fact, as they are a=
ble
>> > to keep refaulting the last remaining file pages fast enough, so the=
re
>> > is still apparent progress in reclaim and OOM doesn't kick in.
>> >
>> > At this point, the likely solution will be probably based on pressur=
e
>> > stall monitoring (PSI). I don't know how far we are from a built-in
>> > monitor with reasonable defaults for a desktop workload, so CCing
>> > relevant folks.
>>
>> Yes, psi was specifically developed to address this problem. Before
>> it, the kernel had to make all decisions based on relative event rates=

>> but had no notion of time. Whereas to the user, time is clearly an
>> issue, and in fact makes all the difference. So psi quantifies the
>> time the workload spends executing vs. spinning its wheels.
>>
>> But choosing a universal cutoff for killing is not possible, since it
>> depends on the workload and the user's expectation: GUI and other
>> latency-sensitive applications care way before a compile job or video
>> encoding would care.
>>
>> Because of that, there are things like oomd and lmkd as mentioned, to
>> leave the exact policy decision to userspace.
>>
>> That being said, I think we should be able to provide a bare minimum
>> inside the kernel to avoid complete livelocks where the user does not
>> believe the machine would be able to recover without a reboot.
>>
>> The goal wouldn't be a glitch-free user experience - the kernel does
>> not know enough about the applications to even attempt that. It should=

>> just not hang indefinitely. Maybe similar to the hung task detector.
>>
>> How about something like the below patch? With that, the kernel
>> catches excessive thrashing that happens before reclaim fails:
>>
>> [snip]
>>
>> +
>> +#define OOM_PRESSURE_LEVEL     80
>> +#define OOM_PRESSURE_PERIOD    (10 * NSEC_PER_SEC)
>=20
> 80% of the last 10 seconds spent in full stall would definitely be a
> problem. If the system was already low on memory (which it probably
> is, or we would not be reclaiming so hard and registering such a big
> stall) then oom-killer would probably kill something before 8 seconds
> are passed. If my line of thinking is correct, then do we really
> benefit from such additional protection mechanism? I might be wrong
> here because my experience is limited to embedded systems with
> relatively small amounts of memory.

When one or more processes fight for memory, much of the time spent
stalling. Would an acceptable alternative strategy be, instead of
killing a process, to hold processes proportional to their stall time
and memory usage? By stop I mean delay their scheduling (akin to kill
-STOP/sleep/kill -CONT), or interleave the scheduling of
large-memory-using processes so they do not have to fight against each
other.

Cheers,
       Johannes




--jABzv2lUedKk5GgH6kKF4W1GLbrqqMzVJ--

--7RHlYysSiI4Yzcz7rPizndaIgSy3EOI76
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEbdoov/dOgEsqgdIL8lwWoLvWQvgFAl1JQOIACgkQ8lwWoLvW
QvguCQ//e3sYFB+SrxA/wdnbovl5u1IoOUrNDXOQTNc5l4ff5ynceH1OOxea1FLv
9BsiLb0AHo1TNSANfmmT63OJzjDa76oPbiX/DVVlghQF8Xc/+Hp8kdQK5aTwIpbd
f/KT9hul/72+WJjP34/SuKhoD3w8bE8ovWel7V90scl+8VYpqn1D9UK2FzQpmS5r
xc7TJqY3hJr/xVV1U70sNNN3JSVjSp0QxtUmtx/hEmHBC2nTXegEvXDyKcEQSpAW
3dyCe0oXfBDgyNxfqcHI05nzZa5EKJznKjLP7/5F8XEhrVET74qNCsudTC7dy4lF
eNZdUZpVrSbdYcAV+jECmlxA0u5bF+ByPpeTT5OeporFJazgJDdeuxWsDA0OJnFD
xwlkNTQNQT8Ueyzl+vBnZCyDXEGm2K2LIdJ2rVuGVJvCH4ylLTh4XPm+g46kcF5x
ctieRj1ZdSKL4+66mj4EsmrDzz3OKHf97rhOd0x5JInQAbn6BBNrJkddkphZzpwX
NbXH7GxuLPx8qJsSY+QTzJdovLtMwh4DtOoaSMk7zECOwbGB+N1wsUFBJ+uktvyM
rk2hGFzjXtMGe7E7006cu1fBsj/KpUmiS7Gy2HIZ5mnwGVLGauLrIhYhknirz9GX
IKU3x4g4/QYJh998DdlVK03sZ9WanoIJwoGRntARMj1X98/jpuE=
=bmWE
-----END PGP SIGNATURE-----

--7RHlYysSiI4Yzcz7rPizndaIgSy3EOI76--
