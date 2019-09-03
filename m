Return-Path: <SRS0=TDKO=W6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADDB6C41514
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Sep 2019 00:01:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 87A4A21897
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Sep 2019 00:01:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727916AbfICABB convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Sep 2019 20:01:01 -0400
Received: from ozlabs.org ([203.11.71.1]:39819 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726845AbfICABB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Sep 2019 20:01:01 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 46MnCs4mlgz9s7T;
        Tue,  3 Sep 2019 10:00:57 +1000 (AEST)
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Michal =?utf-8?Q?Such=C3=A1nek?= <msuchanek@suse.de>
Cc:     linuxppc-dev@lists.ozlabs.org,
        Madhavan Srinivasan <maddy@linux.vnet.ibm.com>,
        David Hildenbrand <david@redhat.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Paul Mackerras <paulus@samba.org>,
        Breno Leitao <leitao@debian.org>,
        Michael Neuling <mikey@neuling.org>,
        Diana Craciun <diana.craciun@nxp.com>,
        Firoz Khan <firoz.khan@linaro.org>,
        Hari Bathini <hbathini@linux.ibm.com>,
        Joel Stanley <joel@jms.id.au>, Arnd Bergmann <arnd@arndb.de>,
        Nicholas Piggin <npiggin@gmail.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Thomas Gleixner <tglx@linutronix.de>,
        Allison Randal <allison@lohutok.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Andrew Donnellan <andrew.donnellan@au1.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH v7 5/6] powerpc/64: Make COMPAT user-selectable disabled on littleendian by default.
In-Reply-To: <20190902114239.32bd81f4@naga>
References: <cover.1567198491.git.msuchanek@suse.de> <c7c88e88408588fa6fcf858a5ae503b5e2f4ec0b.1567198492.git.msuchanek@suse.de> <87ftlftpy7.fsf@mpe.ellerman.id.au> <20190902114239.32bd81f4@naga>
Date:   Tue, 03 Sep 2019 10:00:57 +1000
Message-ID: <87h85us0xy.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Michal Suchánek <msuchanek@suse.de> writes:
> On Mon, 02 Sep 2019 12:03:12 +1000
> Michael Ellerman <mpe@ellerman.id.au> wrote:
>
>> Michal Suchanek <msuchanek@suse.de> writes:
>> > On bigendian ppc64 it is common to have 32bit legacy binaries but much
>> > less so on littleendian.  
>> 
>> I think the toolchain people will tell you that there is no 32-bit
>> little endian ABI defined at all, if anything works it's by accident.
>
> I have seen a piece of software that workarounds code issues on 64bit
> by always compiling 32bit code. So it does work in some way.

What software is that?

> Also it has been pointed out that you can still switch to BE even with
> the 'fast-switch' removed.

Yes we have a proper syscall for endian switching, sys_switch_endian(),
which is definitely supported.

But that *only* switches the endian-ness of the process, it does nothing
to the syscall layer. So any process that switches to the other endian
must endian flip syscall arguments (that aren't in registers), or flip
back to the native endian before calling syscalls.

>> So I think we should not make this selectable, unless someone puts their
>> hand up to say they want it and are willing to test it and keep it
>> working.
>
> I don't really care either way.

Sure. We'll see if anyone else speaks up.

cheers
