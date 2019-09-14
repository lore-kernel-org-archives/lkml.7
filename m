Return-Path: <SRS0=tewG=XJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEFB5C4CEC7
	for <linux-kernel@archiver.kernel.org>; Sat, 14 Sep 2019 10:22:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A565A20717
	for <linux-kernel@archiver.kernel.org>; Sat, 14 Sep 2019 10:22:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728803AbfINKWJ convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 14 Sep 2019 06:22:09 -0400
Received: from mx2.suse.de ([195.135.220.15]:48768 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726313AbfINKWJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Sep 2019 06:22:09 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id CD0AAB012;
        Sat, 14 Sep 2019 10:22:06 +0000 (UTC)
Date:   Sat, 14 Sep 2019 12:22:02 +0200
From:   Michal =?UTF-8?B?U3VjaMOhbmVr?= <msuchanek@suse.de>
To:     Michael Ellerman <mpe@ellerman.id.au>
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
Subject: Re: [PATCH v7 5/6] powerpc/64: Make COMPAT user-selectable disabled
 on littleendian by default.
Message-ID: <20190914122202.307707c0@naga>
In-Reply-To: <87h85us0xy.fsf@mpe.ellerman.id.au>
References: <cover.1567198491.git.msuchanek@suse.de>
        <c7c88e88408588fa6fcf858a5ae503b5e2f4ec0b.1567198492.git.msuchanek@suse.de>
        <87ftlftpy7.fsf@mpe.ellerman.id.au>
        <20190902114239.32bd81f4@naga>
        <87h85us0xy.fsf@mpe.ellerman.id.au>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-suse-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 03 Sep 2019 10:00:57 +1000
Michael Ellerman <mpe@ellerman.id.au> wrote:

> Michal Suchánek <msuchanek@suse.de> writes:
> > On Mon, 02 Sep 2019 12:03:12 +1000
> > Michael Ellerman <mpe@ellerman.id.au> wrote:
> >  
> >> Michal Suchanek <msuchanek@suse.de> writes:  
> >> > On bigendian ppc64 it is common to have 32bit legacy binaries but much
> >> > less so on littleendian.    
> >> 
> >> I think the toolchain people will tell you that there is no 32-bit
> >> little endian ABI defined at all, if anything works it's by accident.  
> >
> > I have seen a piece of software that workarounds code issues on 64bit
> > by always compiling 32bit code. So it does work in some way.  
> 
> What software is that?

The only one I have seen is stockfish (v9)

> 
> > Also it has been pointed out that you can still switch to BE even with
> > the 'fast-switch' removed.  
> 
> Yes we have a proper syscall for endian switching, sys_switch_endian(),
> which is definitely supported.
> 
> But that *only* switches the endian-ness of the process, it does nothing
> to the syscall layer. So any process that switches to the other endian
> must endian flip syscall arguments (that aren't in registers), or flip
> back to the native endian before calling syscalls.

In other words just installing a chroot of binaries built for the other
endian won't work. You need something like qemu to do the syscall
translation or run full VM with a kernel that has the swapped endian
syscall ABI.

Thanks

Michal
