Return-Path: <SRS0=RGqN=Z6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EFE6C43603
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Dec 2019 22:19:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F300B206D5
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Dec 2019 22:19:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="mB5LzuHw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726801AbfLHWT2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 8 Dec 2019 17:19:28 -0500
Received: from mout.web.de ([212.227.17.11]:41723 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726626AbfLHWT2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Dec 2019 17:19:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1575843543;
        bh=1nXGgZvTqipCBHE913SO2FBurSIXZRZgP2BTF5onnho=;
        h=X-UI-Sender-Class:In-Reply-To:References:Date:From:To:Cc:Subject;
        b=mB5LzuHwziej2OrSiB3LA76k0vA1dYi2qsI3k2OyE9LGzOxmbLC/Kn9gDPTr7k4tt
         svnZGZwWFG3rVlwvqsbRr4/Uu4M8Ev+SdBWOidPw7B0hc3K6EOtMHtQ0luOMuKia5N
         g6Gfnc1gRu9oZl3impcAvJ68RQNT5Q/T663fIleQ=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from auth2-smtp.messagingengine.com ([66.111.4.228]) by smtp.web.de
 (mrweb102 [213.165.67.124]) with ESMTPSA (Nemesis) id
 0LtWsC-1hdPYx0Tcy-010tTh; Sun, 08 Dec 2019 23:19:03 +0100
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailauth.nyi.internal (Postfix) with ESMTP id B970D22879;
        Sun,  8 Dec 2019 17:19:00 -0500 (EST)
Received: from imap5 ([10.202.2.55])
  by compute3.internal (MEProxy); Sun, 08 Dec 2019 17:19:00 -0500
X-ME-Sender: <xms:03btXfBEQs4K51bnlKSUsES6skIT0ikLOAyM_Aw5iONYvONVPqFAHg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedufedrudekjedgudeiudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefofgggkfgjfhffhffvufgtsehttdertderreejnecuhfhrohhmpedfofgr
    lhhtvgcuufhkrghruhhpkhgvfdcuoehmrghlthgvshhkrghruhhpkhgvseifvggsrdguvg
    eqnecurfgrrhgrmhepmhgrihhlfhhrohhmpehmrghlthgvshhkrghruhhpkhgvodhmvghs
    mhhtphgruhhthhhpvghrshhonhgrlhhithihqddutddujedtfedvleeiqdduuddvgedvke
    eiledqmhgrlhhtvghskhgrrhhuphhkvgeppeifvggsrdguvgesfhgrshhtmhgrihhlrdhf
    mhenucevlhhushhtvghrufhiiigvpedt
X-ME-Proxy: <xmx:03btXcdXSh5ukxS6lEPa_n0n0iNIGgsPFnUvSTq5ykcJ2DR9_6fhyg>
    <xmx:03btXfp759936CsVSleiJSo974N3OSrCoM4SraGZcukA90X18RtNiw>
    <xmx:03btXY6dIIpHhrsnrKQq2cZ6xxrCl6eAH9eyUjttbg4Ax1h0xvCrRg>
    <xmx:1HbtXXgjDNsXuwc05AHftcalL9ddwSZ3qjmxKCABRQYFwOzSSMSSeQ>
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id A78635C0099; Sun,  8 Dec 2019 17:18:59 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.1.7-612-g13027cc-fmstable-20191203v1
Mime-Version: 1.0
Message-Id: <81f9229b-76f8-495c-97b5-12bffee06b37@www.fastmail.com>
In-Reply-To: <20191206173705.GE2871@hirez.programming.kicks-ass.net>
References: <20191204235238.10764-1-malteskarupke@web.de>
 <20191206153129.GI2844@hirez.programming.kicks-ass.net>
 <20191206173705.GE2871@hirez.programming.kicks-ass.net>
Date:   Sun, 08 Dec 2019 17:18:12 -0500
From:   "Malte Skarupke" <malteskarupke@web.de>
To:     "Peter Zijlstra" <peterz@infradead.org>
Cc:     tglx@linutronix.de, mingo@redhat.com, dvhart@infradead.org,
        linux-kernel@vger.kernel.org, malteskarupke@fastmail.fm
Subject: =?UTF-8?Q?Re:_[PATCH]_futex:_Support_smaller_futexes_of_one_byte_or_two_?=
 =?UTF-8?Q?byte_size.?=
Content-Type: text/plain
X-Provags-ID: V03:K1:DnMgyW7rDXYIduijKtSbAY/bRs5cgG29P9/1wHSV44FXcXZbc5M
 Ez0eiwRMS86Z2pUUxm0B4GWEdlDM11bvCelP0cU5LGJ+25/TCVpC8934FQr1d1lasKTtKce
 HR8u0qvzPzLu/vg1o9KeJkY9z/DpNlPKdXvoDnFYtKI1svBfdlciYo0ONEOLKVKG2gdk/7l
 mz9iXULbkyfzwb7Y+01PQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:dIImTWJlHWE=:1ZyC6Zk8kkfRUKhJMNGUAj
 sS62vNCH9RXuYRX7WwKHKDbYA2NYCIsZ4PUox3IMfem5x1PXEQ8/7+B6Pe7PSghl3Kjdwo98W
 587KbP6sKyM2uzOw3YkLc3AWlW9EoHydEvhGmT1TjiT+h4Qz76uWQD8pmxkbcn00gjBtnSBo6
 zo3UNF9ln0rEv9cT8U7NqmfXeAsCNccnbXam80eTM0QfudWeRBjzyBCNMmSmeRT72I760nh9+
 b9tE1Q/HlIHrQl9AvmGlPyzsTkGDSqHMldGnQazonMeO0YrtwB8IzDlUJ61NtwL6D/7QXIRIu
 tsl6SMrRWGHzVwzetKZBa7SQDTHHFpUXyQ048DTVfdnDVdq7qmztlphvZtL/z87XV8ide/xNi
 w7mIe23msgjnXcX8EAoKcy3MicFuTVzt7+ktGmhpQy2yxRhmjBKhwOQCYVBmP9M1Lznyuhala
 igFaemJE2JSmpw73AwR5Er9E5Oxh1lr+r50frCLb0oQpEEgJ5rk7OEkRTu7wo7db7L7zAkgl8
 tpVH+UJDT5Xlo7WvgrDu/sutq6wXKbExkpUSvhhRt07p52zIotGi3u60unMLjPhRAvZ+RgG0R
 lHVNRIz5YLbJfz62zqHRFsqPBq1wicJJF+6ZEadFwBvRgKRSyts9hr591soVCrJwulT7RaWal
 Tyh5caJD9aNsUvAuFv5xxIUbZyMF3uFLbbZAQAhUek102zIBpZh2+FdsvJMYEAV6rPtxO+geF
 EZXrMcm+bj/9dBsI7qQk8k410nSbVVso9bQAQHLLexYqmHVYx0THKi+mR5nD09iFqYJ1PxiVh
 /gpbHavsQOb/MgzlWfPC75sWQH8GjQsj4UFM8h9xjieOBONpLzKbEz90h2f4/7bu3BGQ9aJ5p
 AjIZlrB6jVZwMgao/kks6PG0Fz9QN7iUhyBm8XI8D2u+ztLkxVblDC0mr3WhX5hJnZYui4U9Z
 TDV3AS0WSVgyYiWO35nSNf7fD7LhVIhs6j5VzDf9X2fmqg0HWrpn9Fgdbds+Mv8nJwdWxPJIZ
 63PtvECh1U787EAOQ3kOofVzmMmdeGPdJzJ0sO9/NLL7xpp5ZfsHbmwR6bb5wkwO/EkK14RtY
 6QYOGm3PZHS/aztdeqIa0i8eD9dR7ChyGqaVXqY2FXYRE4IznBl2/AO9JakOiDzMLdn79IG21
 avS8yebJR7nTrRhcxkEJCV/0XltmC00PW9AaN3AdJkuKa1kSjaSmv/WbUPV7t0eNJcJT48ElJ
 c2jHHzglyq78U0E9qRkngqvtaRTbM9ah9f/DHk4ibwyplA0KYgEbgcEATeMw=
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In my first version WAKE also took a size parameter, however I chose to no=
t send that version because there are two problems with that. You already =
noticed the first problem: we would have to store the size and verify that=
 it matches on WAKE.

The second problem is with REQUEUE and CMP_REQUEUE: The usual case there w=
ill be that you have a mutex that's 8 bits in size, but the condition vari=
able is harder to fit into 8 bits and will be larger. So you would need to=
 pass in two different size flags. But REQUEUE doesn't actually care what =
the size is at all. It just moves waiters around. CMP_REQUEUE does care, b=
ut only for one of the arguments. So it works out perfectly that there is =
one flag for the size.

Those two cases really helped me clarify what the size argument actually i=
s needed for. It's only needed for the "compare" part of CMP_REQUEUE. Simi=
larly WAIT could have also been named CMP_WAIT and if it was named that, i=
t would also be obvious that the size argument is only needed for the "com=
pare" part of WAIT. All the other work that WAIT does doesn't actually car=
e about the memory behind the pointer at all. It only cares about the addr=
ess.

That also illustrates what should happen if we splice a futex and call WAI=
T on @ptr and WAKE on @ptr+1: If I understand you correctly, (and correct =
me if I'm wrong here) your point is that there would be an inconsistency i=
n the API there. You say it would be inconsistent for a size-less WAKE to =
not wake a futex that it's pointing in the middle of.

But with the above thoughts, we realize that since those are two different=
 addresses, they refer to two different futexes. It doesn't matter that th=
e WAIT was for a four byte futex. That information was only relevant for t=
he "compare" part of WAIT. It's not relevant for anything else, and theref=
ore it's not relevant for the identity of the futex. So the fact that spli=
cing a futex doesn't work (and can't easily be made to work) does not poin=
t at an inconsistency in the API.

Taking all that into account, I believe there are two possible consistent =
implementations for sized futexes. One of them is the one you're asking fo=
r, where the size is always passed and always verified to be correct. The =
other one is the one I'm proposing, where the size argument only applies t=
o the "compare" part of WAIT and CMP_REQUEUE, and all the other work of fu=
texes is size-less and only works on the address. (and I think similar rea=
soning will work for the operations that are not supported yet)

I believe that between those two consistent implementations, the one with =
size-less WAKE and REQUEUE is preferable. REQUEUE in particular makes clea=
r how we really don't care about the size in these operations. There is no=
 difference in behavior when moving between futexes of different sizes or =
the same size. It just doesn't matter. But if REQUEUE is size-less, it wou=
ld be inconsistent for WAKE to require a size since REQUEUE is just a WAKE=
 with extra features.

The other downside of the version that checks the size is that we, well, h=
ave to check the size. That's extra work we have to do and extra data we h=
ave to store, and I can't come up with any case where a user would actuall=
y benefit from us doing that extra work.

All that being said I agree with your other comments (renaming FUTEX_NO_RE=
AD_WRITE to FUTEX_NONE, and introducing a futex_size() function to simplif=
y some of the code). I'll change the code and send a new patch.

Meanwhile let me know what you would like to do about passing a size to WA=
KE or not.

=2D-
  Malte Skarupke
  malteskarupke@web.de

Am Fr, 6. Dez 2019, um 12:37, schrieb Peter Zijlstra:
> On Fri, Dec 06, 2019 at 04:31:29PM +0100, Peter Zijlstra wrote:
> > > +		case FUTEX_WAKE:
> > > +		case FUTEX_REQUEUE:
> > > +			/*
> > > +			 * these instructions work with sized mutexes, but you
> > > +			 * don't need to pass the size. we could silently
> > > +			 * ignore the size argument, but the code won't verify
> > > +			 * that the correct size is used, so it's preferable
> > > +			 * to make that clear to the caller.
> > > +			 *
> > > +			 * for requeue the meaning would also be ambiguous: do
> > > +			 * both of them have to be the same size or not? they
> > > +			 * don't, and that's clearer when you just don't pass
> > > +			 * a size argument.
> > > +			 */
> > > +			return -EINVAL;
> >
> > Took me a while to figure out this relies on FUTEX_NONE to avoid the
> > alignment tests.
>
> And thikning more on that, I really _realy_ hate this.
>
> You're basically saying WAKE is size-less, but that means we must
> consider what it means to have a u32 WAIT on @ptr, and a u8 WAKE on
> @ptr+1. If the wake really is size-less that should match.
>
> I'd be much happier with requiring strict sizing. Because conversely,
> what happens if you have a u32-WAIT at @ptr paired with a u8-WAKE at
> @ptr? If we demand strict size we can say that should not match. This
> does however mean we should include the size in the hash-match function.
>
> Your Changelog did not consider these implications at all.
>
