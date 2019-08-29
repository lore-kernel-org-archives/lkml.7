Return-Path: <SRS0=brkd=WZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DF8CC3A59F
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 14:33:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EA7E72342C
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 14:33:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727602AbfH2OdI convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Aug 2019 10:33:08 -0400
Received: from mail-qk1-f194.google.com ([209.85.222.194]:40404 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726283AbfH2OdH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Aug 2019 10:33:07 -0400
Received: by mail-qk1-f194.google.com with SMTP id f10so3112588qkg.7
        for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2019 07:33:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=u90BzevMbaxyx55NRwOyXEZ+TCaloyf9Ga0nSNG0ILw=;
        b=lDZKmAPiiPgIBc9Nrbmz2YRbWOcl5J0zxZRQ3eccux1CossJ3f+fQ5UYKktn+jcuNI
         Ca2Yiwni2f54VSv7Taod61UhJS+n983LaSktN8ZFde86bbAfKdPVTc0ux1BKR6XvSMom
         qZOGO8K9PFIiDW9feAsSVtvh5JU21s10zXKZhqJjQNNnqz+C9HSl60MytMSAEgjNIB7C
         0jSs82zRPRSD5MElAH+f2//QpxHP3GbyLFYgpVbTV5DvAo/0nFU6mXby7oXkroly9g8z
         XLGdO3R9Z5p3hFKxennCgmjgVAZ3z+eHNEapLoyOEEMEaO8H7MWtMSLOn9wQNPg9Xwdm
         T1nw==
X-Gm-Message-State: APjAAAWCjVyAq9T5YOKtz3yk+y05tEfZrVlkYsHDbZOtFfa6hWiKKRXv
        ZSWe5xsb8uqReFmXEwDUV7ku+URC57zcxiGouI4=
X-Google-Smtp-Source: APXvYqzK05kJtQELzAjwpofc7UfddmmDx8VQSbo2PS0jNh4V8Vc8Bi/ngrIFAioSJ4e107HuOrlcp0MS8Gpn1qE+q+w=
X-Received: by 2002:a37:4051:: with SMTP id n78mr9499689qka.138.1567089186639;
 Thu, 29 Aug 2019 07:33:06 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1567072270.git.msuchanek@suse.de> <061a0de2042156669303f95526ec13476bf490c7.1567072270.git.msuchanek@suse.de>
 <CAK8P3a1wR-jzFSzdPqgfCG4vyAi_xBPVGhc6Nn4KaXpk3cUiJw@mail.gmail.com>
 <20190829143716.6e41b10e@naga> <CAK8P3a2DHP+8Vbc4yjq5-wT9GpSxvndCa8gnvx0WcD8YAUAsMw@mail.gmail.com>
 <20190829161923.101ff3eb@kitsune.suse.cz>
In-Reply-To: <20190829161923.101ff3eb@kitsune.suse.cz>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Thu, 29 Aug 2019 16:32:50 +0200
Message-ID: <CAK8P3a3DHqhbVToqRYqTmfCcSdT5sXb=1SO5jY9jDONDa6ORkA@mail.gmail.com>
Subject: Re: [PATCH v4 1/4] powerpc: make llseek 32bit-only.
To:     =?UTF-8?Q?Michal_Such=C3=A1nek?= <msuchanek@suse.de>
Cc:     Michael Neuling <mikey@neuling.org>,
        Andrew Donnellan <andrew.donnellan@au1.ibm.com>,
        Nicolai Stange <nstange@suse.de>,
        David Hildenbrand <david@redhat.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Nicholas Piggin <npiggin@gmail.com>,
        David Howells <dhowells@redhat.com>,
        Hari Bathini <hbathini@linux.ibm.com>,
        Paul Mackerras <paulus@samba.org>,
        Joel Stanley <joel@jms.id.au>,
        Christian Brauner <christian@brauner.io>,
        Firoz Khan <firoz.khan@linaro.org>,
        Breno Leitao <leitao@debian.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        Allison Randal <allison@lohutok.net>,
        "Eric W. Biederman" <ebiederm@xmission.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 29, 2019 at 4:19 PM Michal Suchánek <msuchanek@suse.de> wrote:
> On Thu, 29 Aug 2019 14:57:39 +0200 Arnd Bergmann <arnd@arndb.de> wrote:
> > On Thu, Aug 29, 2019 at 2:37 PM Michal Suchánek <msuchanek@suse.de> wrote:
> > > On Thu, 29 Aug 2019 14:19:46 +0200 Arnd Bergmann <arnd@arndb.de> wrote:
> > > > On Thu, Aug 29, 2019 at 12:23 PM Michal Suchanek <msuchanek@suse.de> wrote:
> > > > In particular, I don't see why you single out llseek here, but leave other
> > > > syscalls that are not needed on 64-bit machines such as pread64().
> > >
> > > Because llseek is not built in fs/ when building 64bit only causing a
> > > link error.
> > >
> > > I initially posted patch to build it always but it was pointed out it
> > > is not needed, and  the interface does not make sense on 64bit, and
> > > that platforms that don't have it on 64bit now don't want that useless
> > > code.
> >
> > Ok, please put that into the changeset description then.
> >
> > I looked at uses of __NR__llseek in debian code search and
> > found this one:
> >
> > https://codesearch.debian.net/show?file=umview_0.8.2-1.2%2Fxmview%2Fum_mmap.c&line=328
> >
> > It looks like this application will try to use llseek instead of lseek
> > when built against kernel headers that define __NR_llseek.
> >
>
> The available documentation says this syscall is for 32bit only so
> using it on 64bit is undefined. The interface is not well-defined in
> that case either.

That's generally not how it works. If there is an existing application
that relies on the behavior of the system call interface, we should not
change it in a way that breaks the application, regardless of what the
documentation says. Presumably nobody cares about umview on
powerpc64, but there might be other applications doing the same
thing.

It looks like sparc64 and parisc64 do the same thing as powerpc64,
and provide llseek() calls that may or may not be used by
applications.

I think your original approach of always building sys_llseek on
powerpc64 is the safe choice here.

     Arnd
