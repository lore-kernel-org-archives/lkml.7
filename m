Return-Path: <SRS0=brkd=WZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AB28C3A59F
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 19:43:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 15FA82166E
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 19:43:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728213AbfH2TnX convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Aug 2019 15:43:23 -0400
Received: from mx2.suse.de ([195.135.220.15]:43366 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727958AbfH2TnX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Aug 2019 15:43:23 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 1CF54ABE7;
        Thu, 29 Aug 2019 19:43:21 +0000 (UTC)
Date:   Thu, 29 Aug 2019 21:43:19 +0200
From:   Michal =?UTF-8?B?U3VjaMOhbmVr?= <msuchanek@suse.de>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Michael Neuling <mikey@neuling.org>,
        Allison Randal <allison@lohutok.net>,
        Nicolai Stange <nstange@suse.de>,
        David Hildenbrand <david@redhat.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Christian Brauner <christian@brauner.io>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Nicholas Piggin <npiggin@gmail.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        David Howells <dhowells@redhat.com>,
        Paul Mackerras <paulus@samba.org>,
        Joel Stanley <joel@jms.id.au>,
        Andrew Donnellan <andrew.donnellan@au1.ibm.com>,
        Breno Leitao <leitao@debian.org>,
        Firoz Khan <firoz.khan@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        Hari Bathini <hbathini@linux.ibm.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>
Subject: Re: [PATCH v4 1/4] powerpc: make llseek 32bit-only.
Message-ID: <20190829214319.498c7de2@naga>
In-Reply-To: <CAK8P3a3DHqhbVToqRYqTmfCcSdT5sXb=1SO5jY9jDONDa6ORkA@mail.gmail.com>
References: <cover.1567072270.git.msuchanek@suse.de>
        <061a0de2042156669303f95526ec13476bf490c7.1567072270.git.msuchanek@suse.de>
        <CAK8P3a1wR-jzFSzdPqgfCG4vyAi_xBPVGhc6Nn4KaXpk3cUiJw@mail.gmail.com>
        <20190829143716.6e41b10e@naga>
        <CAK8P3a2DHP+8Vbc4yjq5-wT9GpSxvndCa8gnvx0WcD8YAUAsMw@mail.gmail.com>
        <20190829161923.101ff3eb@kitsune.suse.cz>
        <CAK8P3a3DHqhbVToqRYqTmfCcSdT5sXb=1SO5jY9jDONDa6ORkA@mail.gmail.com>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-suse-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 29 Aug 2019 16:32:50 +0200
Arnd Bergmann <arnd@arndb.de> wrote:

> On Thu, Aug 29, 2019 at 4:19 PM Michal Suchánek <msuchanek@suse.de> wrote:
> > On Thu, 29 Aug 2019 14:57:39 +0200 Arnd Bergmann <arnd@arndb.de> wrote:  
> > > On Thu, Aug 29, 2019 at 2:37 PM Michal Suchánek <msuchanek@suse.de> wrote:  
> > > > On Thu, 29 Aug 2019 14:19:46 +0200 Arnd Bergmann <arnd@arndb.de> wrote:  
> > > > > On Thu, Aug 29, 2019 at 12:23 PM Michal Suchanek <msuchanek@suse.de> wrote:
> > > > > In particular, I don't see why you single out llseek here, but leave other
> > > > > syscalls that are not needed on 64-bit machines such as pread64().  
> > > >
> > > > Because llseek is not built in fs/ when building 64bit only causing a
> > > > link error.
> > > >
> > > > I initially posted patch to build it always but it was pointed out it
> > > > is not needed, and  the interface does not make sense on 64bit, and
> > > > that platforms that don't have it on 64bit now don't want that useless
> > > > code.  
> > >
> > > Ok, please put that into the changeset description then.
> > >
> > > I looked at uses of __NR__llseek in debian code search and
> > > found this one:
> > >
> > > https://codesearch.debian.net/show?file=umview_0.8.2-1.2%2Fxmview%2Fum_mmap.c&line=328
> > >
> > > It looks like this application will try to use llseek instead of lseek
> > > when built against kernel headers that define __NR_llseek.
> > >  
> >
> > The available documentation says this syscall is for 32bit only so
> > using it on 64bit is undefined. The interface is not well-defined in
> > that case either.  
> 
> That's generally not how it works. If there is an existing application
> that relies on the behavior of the system call interface, we should not
> change it in a way that breaks the application, regardless of what the
> documentation says. Presumably nobody cares about umview on
> powerpc64, but there might be other applications doing the same
> thing.

Actually the umview headers go out of their way to define the llseek
syscall as invalid on x86_64 so that the non-llseek path is taken. 
mview-os/xmview/defs_x86_64_um.h:#define __NR__llseek __NR_doesnotexist
It is probably an oversight that this is not done on non-x86. I am not
even sure this builds on non-x86 out of the box.

> It looks like sparc64 and parisc64 do the same thing as powerpc64,
> and provide llseek() calls that may or may not be used by
> applications.

And if they are supposed to build with !compat it should be removed
there as well.

> 
> I think your original approach of always building sys_llseek on
> powerpc64 is the safe choice here.

That's safe but adds junk to the kernel as pointed out in the reply to
that patch.

Thanks

Michal
