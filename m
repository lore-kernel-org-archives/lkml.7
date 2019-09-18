Return-Path: <SRS0=HfRD=XN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85E9FC4CEC4
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Sep 2019 05:36:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5939A218AE
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Sep 2019 05:36:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b="plu+urg0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727880AbfIRFgd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Sep 2019 01:36:33 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:56433 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727315AbfIRFgd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Sep 2019 01:36:33 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 46Y7y126Fcz9sN1;
        Wed, 18 Sep 2019 15:36:25 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ellerman.id.au;
        s=201909; t=1568784990;
        bh=XONv0lmG8SzM9FYRLrJsQD1RWVI126tcLqZ1byAJHws=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=plu+urg0VZ0Mvxe/kzzACLhTWIu/yacBrbgF6h8XwV4W3Eu80JC8VZaX4tN2DZvRl
         HFlUbyF/1YVvgnNFss0LDm4/t/t28cVnVJP4hGvyTFWTDYRI4XyKEaRJT7LKZlbxoe
         +apQCBJWfl67rVEEB7YTQO1u/vtW8ldL0BxL6YpOKLqum288PgU1S2LomvuUXoI5kZ
         AY7D2YbK+AReYVsv5PgY7LbvVGKsP1kTlFHKdh/3i03tAJXNWBaQZiDZTLnOlpTw25
         U8+8YivAYeKtK0zjGqPQyPaiGyisMgyetsYGXxBpHj4NQboRZlJPTW4qBQWeOylzqr
         QL0eLF2Lm2vuA==
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Michal =?utf-8?Q?Such=C3=A1nek?= <msuchanek@suse.de>
Cc:     Michael Neuling <mikey@neuling.org>,
        Madhavan Srinivasan <maddy@linux.vnet.ibm.com>,
        Andrew Donnellan <andrew.donnellan@au1.ibm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        David Hildenbrand <david@redhat.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        linux-kernel@vger.kernel.org, Nicholas Piggin <npiggin@gmail.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Diana Craciun <diana.craciun@nxp.com>,
        Paul Mackerras <paulus@samba.org>,
        Joel Stanley <joel@jms.id.au>,
        Allison Randal <allison@lohutok.net>,
        Breno Leitao <leitao@debian.org>,
        Firoz Khan <firoz.khan@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linuxppc-dev@lists.ozlabs.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Hari Bathini <hbathini@linux.ibm.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>
Subject: Re: [PATCH v7 5/6] powerpc/64: Make COMPAT user-selectable disabled on littleendian by default.
In-Reply-To: <20190914122202.307707c0@naga>
References: <cover.1567198491.git.msuchanek@suse.de> <c7c88e88408588fa6fcf858a5ae503b5e2f4ec0b.1567198492.git.msuchanek@suse.de> <87ftlftpy7.fsf@mpe.ellerman.id.au> <20190902114239.32bd81f4@naga> <87h85us0xy.fsf@mpe.ellerman.id.au> <20190914122202.307707c0@naga>
Date:   Wed, 18 Sep 2019 15:36:24 +1000
Message-ID: <87k1a6w4h3.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Michal Such=C3=A1nek <msuchanek@suse.de> writes:
> On Tue, 03 Sep 2019 10:00:57 +1000
> Michael Ellerman <mpe@ellerman.id.au> wrote:
>> Michal Such=C3=A1nek <msuchanek@suse.de> writes:
>> > On Mon, 02 Sep 2019 12:03:12 +1000
>> > Michael Ellerman <mpe@ellerman.id.au> wrote:
>> >=20=20
>> >> Michal Suchanek <msuchanek@suse.de> writes:=20=20
>> >> > On bigendian ppc64 it is common to have 32bit legacy binaries but m=
uch
>> >> > less so on littleendian.=20=20=20=20
>> >>=20
>> >> I think the toolchain people will tell you that there is no 32-bit
>> >> little endian ABI defined at all, if anything works it's by accident.=
=20=20
>> >
>> > I have seen a piece of software that workarounds code issues on 64bit
>> > by always compiling 32bit code. So it does work in some way.=20=20
>>=20
>> What software is that?
>
> The only one I have seen is stockfish (v9)

OK, not sure how many people are testing that on powerpc :)

>> > Also it has been pointed out that you can still switch to BE even with
>> > the 'fast-switch' removed.=20=20
>>=20
>> Yes we have a proper syscall for endian switching, sys_switch_endian(),
>> which is definitely supported.
>>=20
>> But that *only* switches the endian-ness of the process, it does nothing
>> to the syscall layer. So any process that switches to the other endian
>> must endian flip syscall arguments (that aren't in registers), or flip
>> back to the native endian before calling syscalls.
>
> In other words just installing a chroot of binaries built for the other
> endian won't work. You need something like qemu to do the syscall
> translation or run full VM with a kernel that has the swapped endian
> syscall ABI.

Yes that's right.

cheers
