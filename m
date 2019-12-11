Return-Path: <SRS0=Yvat=2B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5619AC43603
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 19:51:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0981921556
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 19:51:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="NyjiD/fA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726986AbfLKTvQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Dec 2019 14:51:16 -0500
Received: from mout.web.de ([212.227.17.12]:49595 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726242AbfLKTvQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Dec 2019 14:51:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1576093853;
        bh=hzgISNNaUu//e7yvJjxs5kVmRlCQlucX6OJJUnlXLbI=;
        h=X-UI-Sender-Class:In-Reply-To:References:Date:From:To:Cc:Subject;
        b=NyjiD/fAJzOBIDkRO65YpYt/yG5Wc6IIz2Ymp4oKyupisKqQncDsYI8q33LgmEOzS
         d/u1b4THWqULimwscB1qlThg6qJNrlDSNzLjQAHXIBq7w6QXC3zwOGdf3EoJZROvrU
         nW3LzuK2BkvasXqXsL7cPMLgW0WNQI7jWEmhI54g=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from auth1-smtp.messagingengine.com ([66.111.4.227]) by smtp.web.de
 (mrweb101 [213.165.67.124]) with ESMTPSA (Nemesis) id
 0LyUsk-1hcuPS2cII-015rca; Wed, 11 Dec 2019 20:50:52 +0100
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailauth.nyi.internal (Postfix) with ESMTP id 9C391221C2;
        Wed, 11 Dec 2019 14:50:50 -0500 (EST)
Received: from imap5 ([10.202.2.55])
  by compute3.internal (MEProxy); Wed, 11 Dec 2019 14:50:50 -0500
X-ME-Sender: <xms:mkjxXW3-UJhzF4z4diV9KCAtAaql1zZhqNm1TYLJIf-bGwDafKARig>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedufedrudelhedguddvgecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefofgggkfgjfhffhffvufgtsehttdertderreejnecuhfhrohhmpedfofgr
    lhhtvgcuufhkrghruhhpkhgvfdcuoehmrghlthgvshhkrghruhhpkhgvseifvggsrdguvg
    eqnecurfgrrhgrmhepmhgrihhlfhhrohhmpehmrghlthgvshhkrghruhhpkhgvodhmvghs
    mhhtphgruhhthhhpvghrshhonhgrlhhithihqddutddujedtfedvleeiqdduuddvgedvke
    eiledqmhgrlhhtvghskhgrrhhuphhkvgeppeifvggsrdguvgesfhgrshhtmhgrihhlrdhf
    mhenucevlhhushhtvghrufhiiigvpedt
X-ME-Proxy: <xmx:mkjxXdU3s1KDjXcxB_de3Ihd5AozaGgM0QFVvw8hwhEMpFiYmno_XQ>
    <xmx:mkjxXZ4Qfyr-TQ8qjne1d4xt4Ax2YGAOPc3qFVxTY5FRv3zFxbIchA>
    <xmx:mkjxXcIQr6XJTvetsdXLXAjIZKUVxTwBUbYAzbfNdIqMvNVqVZhTKQ>
    <xmx:mkjxXRH3IQGdkGwpQo62MQs4YelCUpxjWGq8mhQvHE_CbKg_OLnZyw>
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 1B35C5C009B; Wed, 11 Dec 2019 14:50:50 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.1.7-679-g1f7ccac-fmstable-20191210v1
Mime-Version: 1.0
Message-Id: <5c4f61c5-2b76-448e-9c64-99912f1437db@www.fastmail.com>
In-Reply-To: <20191211134446.GK2810@hirez.programming.kicks-ass.net>
References: <20191204235238.10764-1-malteskarupke@web.de>
 <20191206153129.GI2844@hirez.programming.kicks-ass.net>
 <20191206173705.GE2871@hirez.programming.kicks-ass.net>
 <81f9229b-76f8-495c-97b5-12bffee06b37@www.fastmail.com>
 <20191211134446.GK2810@hirez.programming.kicks-ass.net>
Date:   Wed, 11 Dec 2019 14:48:12 -0500
From:   "Malte Skarupke" <malteskarupke@web.de>
To:     "Peter Zijlstra" <peterz@infradead.org>
Cc:     "Thomas Gleixner" <tglx@linutronix.de>, mingo@redhat.com,
        dvhart@infradead.org, linux-kernel@vger.kernel.org,
        malteskarupke@fastmail.fm
Subject: =?UTF-8?Q?Re:_[PATCH]_futex:_Support_smaller_futexes_of_one_byte_or_two_?=
 =?UTF-8?Q?byte_size.?=
Content-Type: text/plain
X-Provags-ID: V03:K1:rdh92avsENXvBU6gqcUlNTLTJGz6SIKRqSdHGm3nxdadPOhBwWM
 ixMYFKWjMPp2PO+iY2IYNqU6494GIp2zKFfD2Bm/1+NIGLjqXOiIjNR2o52zaG4mna0B2za
 x8AJQ7zDo7Y4JBAUM+UBif+aqrdVSJEP8+vf60dssb3z08RVKp02w60InKF3HN1lEw82fdk
 vtLqOzATYfC6MwTr6yMpw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:lEjh+1KmKvo=:3tnQKxEOBOZ3IPUQEFc2vA
 6txvPNBBRWRNVuCKXr1XneuSDt+moET3gOmjYRjich8okYffQiwWQ4ANPGp5ITL8wlPIVLMgT
 B0VQhTmaSUBHRoUZNBpAPaX7tdNTCc6uxsktBpU2PXGh3UwAOBdGhHbM0FlHrpoelB165kTh8
 AYiAIaWYwyQnEa/bjKlW2peyu8IlQSt2w1JtQz9jVcVXF21aPz4UPQvnWjoOE+Cj2Wi/G9jma
 wuW2YpGu38KJ0mqvC12m2Pq43veNnDkMXZ42XrUolUWILHRA1NYCKZufTT9OVJy20ANrGwXyU
 HyQO2HPUVUeTHJAL4E6UHNI+mkPG6Dlbb0LGBv28nEVOXG2GAE4JKGs0Yx962ooRv5pyiWb24
 BC7fXzg1GeHGnCPV2sTlZpOPxdc+KFl0IRhFPDPKIu9l6wth0qoHJbHS+yh87w6fm3Xrkrpxo
 rz3RaCpdmO9B4Z/PPi0jNy0AxEwhIGPFCXhOwqP+7T2HC4xdhjByUbKOEJwDY+menYB90fsWY
 QuK8UKIoJvvoscgYVwdQEtlS9JcSrf8nYrjSaB43QMDMgx/cVZUIjGS18k5JKfVDX8Hd+QUJF
 Wdl91daAoLTfVAR2cW1hcfxbBpvAH2fNbOYTw+F0UyEf2pZi22SJEPSl+uE2vOBYpvdrKmHTf
 WzWAWxb8yzxe9cPA1KHGRa9yXF4PXI3Gp02MPPuBt5oe4ny9B0hU/6wtQdDCd75uuy0PxpGnu
 U+pAvPLD0L1vLx65TycyS9rTCpXTaHEz3lBmeMBODX0ZRkhtZWQUoXL3Kyp6Ogtd6C1AyOrv5
 j0J1fAFNADs1Np0eHlzINss88lH3pRabQGxdBpEy3y0D9FBH53N2ErLK6vX4RBveM+sbE/Rp7
 5fblAbQpJpYNxkIwkKZDAT214N9Zs2spbr5XyPsBDlo9IBcBQ+xdG32sDrB5i2RokRSk554s0
 JUJqg4r2yCij9JByOuLhcxD1ZNCNDZSiwswo69kucMh76ls/Jz/aVSbBf8CFx89jb4S5H1T46
 9XJF+dFGVJ2p7m9adEoit5yAgsec1p+sHxYI8xJTN+FjqD1I+7E7HRe6r9tano1DHqmvNlhMk
 GwhxEWF7wLGFjXYGSm0ZxutMSipVY4J5o4BR1KmFv6gNkBDAPBBytnUKUDJY6pyC1mhkgSnLE
 VUlGjCZLZfrVyjwFWZUyHAjqIOmN40p5aJZDUPtKBJ9uwlwc5Fxt6lpMcE5ugkBaL8urFniXr
 kHP08hr9LV1Wl8ei9AFSbZJsWZGhMI1v1SJIu36pTOP9Sqs7IuIGJOkBjJ7k=
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Am Mi, 11. Dez 2019, um 08:44, schrieb Peter Zijlstra:
> See, I disagree. The WAIT/WAKE pair is an implementation of the MONITOR
> pattern. Similar to x86's MONITOR/MWAIT or ARMv8's LDXR/WFE.

That is a good way of putting it. It's not the mental model I had of futex=
es,
but I can see how under that mental model a WAKE that doesn't wake an
overlapping futex is inconsistent. (my mental model was a memory compariso=
n
followed by a hashtable store. The WAKE has to pass the same hash key to
find anything)

The question of whether to pass a size to WAKE or not is not something I c=
are
about (as I said, my first version did pass a size to WAKE) so I will chan=
ge
my code to require a size in WAKE. I have my opinions about which one I pr=
efer
but if I can't convince you then that shouldn't hold back the change. But
a sized WAKE does open up a few questions:

1. It would be easy for me to verify that sizes match when the address tha=
t's
   passed in is the same address. Meaning a WAIT with 8 bits but a WAKE wi=
th
   16 bits on the same address would return -EINVAL. But it's harder to
   validate a similar mismatch on overlapping futexes. Meaning a 32 bit WA=
IT
   on @ptr and a 8 bit WAKE on @ptr+1 would just return 0.

   This might theoretically lead to problems if we ever want to have the
   semantics of MONITOR/MWAIT in the future, because I'm saying that that
   last mismatch does not wake anything and is not an error. This will mak=
e
   it hard to change the semantics in the future. Are we OK with that?

2. If we are OK with that, there are questions about what to do about weir=
d
   uses like a 8 bit WAIT and a 32 bit WAIT on the same address. An 8 bit
   WAKE on the same address should now probably just wake the 8 bit WAIT, =
but
   a second 8 bit WAKE would then return an error because there is a
   mismatching size. This is confusing so my first thought is to just disa=
llow
   all mixing of sizes, even among waiters. It seems unlikely that this wi=
ll
   ever be needed.

3. Implementing the full semantics of MONITOR/MWAIT would give obvious ans=
wers
   to both of these questions, and I think I could even do it without slow=
ing
   down futexes too much. (just use the address/4 as the hash key so that =
all
   potentially overlapping futexes hash to the same bucket) But it would a=
lso
   open up new questions. Like what happens if you call a 32 bit WAKE with
   val=3D1, meaning wake up one sleeper, but it overlaps with two 16 bit f=
utexes?
   Does it wake one sleeper in both of them? That would be consistent with
   MONITOR/MWAIT behavior, but it would contradict the current documentati=
on.
   (which might be OK because it would only do so for new behavior)


My current thinking for these is as follows, in reverse order:

3. I would not implement the full MONITOR/MWAIT behavior. It's not require=
d
for my use case, it would definitely add a small amount of overhead, and i=
t
bothers me that adjacent 8 bit futexes would hash to the same bucket. (at
least they would if I can't come up with another way of implementing it) A=
ll
I want is smaller mutexes and the behavior required by the C++ standard, s=
o I
don't need new semantics for that.

2. I will disallow all operations that pass a different size for the same
address. That includes disallowing an 8 bit WAIT followed by a 32 bit WAIT=
 on
the same address.

1. I will only verify that the size matches if the same address was passed=
.
Overlapping futexes are not detected and will not raise an error.

This will lead to an inconsistent implementation in the MONITOR/MWAIT ment=
al
model, but it leads to a consistent implementation in the comparison+hasht=
able
mental model. It will have the same behavior as my initial patch except th=
at
all operations will error out if a size mismatch is detected.

Please let me know if this is OK with you. I don't think that this gains u=
s
anything over having an unsized WAKE, but if this is what others want, I c=
an
write the code. If we instead want the full MONITOR/MWAIT semantics, I can
probably also make that happen with a very small slowdown compared to the
current code. I just need to know if that's what you want.

Thanks,

Malte

=2D-
  Malte Skarupke
  malteskarupke@web.de
