Return-Path: <SRS0=brkd=WZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC079C3A5A3
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 12:57:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A8708233FF
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 12:57:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727315AbfH2M55 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Aug 2019 08:57:57 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:34438 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726637AbfH2M54 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Aug 2019 08:57:56 -0400
Received: by mail-qt1-f194.google.com with SMTP id a13so3547879qtj.1
        for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2019 05:57:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=eBPBkBKyWo1gxv5n6v6wKh2d1Kik1L8vXbkWwc2K3bs=;
        b=UjE/x8ChOsxzteKI/pRBMu3LB7l20zkbHDbzysZAfaskhAQissgM5kKPEYDodLd8pf
         ahaLIO3F7W8GeUjaRXg6JkdYKkn2EY4bidCAJJi+LM3TaoFG0Vyv/j8+0t273dEX3ecH
         rrtjudrOnjjeJUGQ/oJQPByC/930c7KjlSudROiqnD+iABun7Cz1F6NFI87M+fw9oM28
         m+FsdJN4Hap5LR0GlGviXh8YDLg0bK4JH9O/NzRHilabrsAr8Qn7zpnI7VQS03SLLLeg
         uxiUNXeUd9ecROeYn1rC6ARxHTLhBn5j0Amx363TMcLmUPFRqxGidgPOKtmz/OmD8C+9
         kxlQ==
X-Gm-Message-State: APjAAAXxMgXoqfXd3gqCKaVcqtusYe0W0t6klYINYMUcA5YWwGxejpVa
        AzDcG8RTH6HyH62txP+F74l1Q/LuLJI6V3d2968=
X-Google-Smtp-Source: APXvYqwY3WgtxDzkiHef+9HQh/ay0Es1FEwtogifyQxitHWZN7yE+/+41B7zXg5JPfw7deyTXnwsCWcNTDVb6Yevmn4=
X-Received: by 2002:ac8:239d:: with SMTP id q29mr9597999qtq.304.1567083475450;
 Thu, 29 Aug 2019 05:57:55 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1567072270.git.msuchanek@suse.de> <061a0de2042156669303f95526ec13476bf490c7.1567072270.git.msuchanek@suse.de>
 <CAK8P3a1wR-jzFSzdPqgfCG4vyAi_xBPVGhc6Nn4KaXpk3cUiJw@mail.gmail.com> <20190829143716.6e41b10e@naga>
In-Reply-To: <20190829143716.6e41b10e@naga>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Thu, 29 Aug 2019 14:57:39 +0200
Message-ID: <CAK8P3a2DHP+8Vbc4yjq5-wT9GpSxvndCa8gnvx0WcD8YAUAsMw@mail.gmail.com>
Subject: Re: [PATCH v4 1/4] powerpc: make llseek 32bit-only.
To:     =?UTF-8?Q?Michal_Such=C3=A1nek?= <msuchanek@suse.de>
Cc:     David Hildenbrand <david@redhat.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        David Howells <dhowells@redhat.com>,
        Paul Mackerras <paulus@samba.org>,
        Breno Leitao <leitao@debian.org>,
        Michael Neuling <mikey@neuling.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Allison Randal <allison@lohutok.net>,
        Firoz Khan <firoz.khan@linaro.org>,
        Joel Stanley <joel@jms.id.au>,
        Nicolai Stange <nstange@suse.de>,
        Nicholas Piggin <npiggin@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Christian Brauner <christian@brauner.io>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Andrew Donnellan <andrew.donnellan@au1.ibm.com>,
        Hari Bathini <hbathini@linux.ibm.com>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 29, 2019 at 2:37 PM Michal Suchánek <msuchanek@suse.de> wrote:
> On Thu, 29 Aug 2019 14:19:46 +0200 Arnd Bergmann <arnd@arndb.de> wrote:
> > On Thu, Aug 29, 2019 at 12:23 PM Michal Suchanek <msuchanek@suse.de> wrote:
> > In particular, I don't see why you single out llseek here, but leave other
> > syscalls that are not needed on 64-bit machines such as pread64().
>
> Because llseek is not built in fs/ when building 64bit only causing a
> link error.
>
> I initially posted patch to build it always but it was pointed out it
> is not needed, and  the interface does not make sense on 64bit, and
> that platforms that don't have it on 64bit now don't want that useless
> code.

Ok, please put that into the changeset description then.

I looked at uses of __NR__llseek in debian code search and
found this one:

https://codesearch.debian.net/show?file=umview_0.8.2-1.2%2Fxmview%2Fum_mmap.c&line=328

It looks like this application will try to use llseek instead of lseek
when built against kernel headers that define __NR_llseek.

Changing the powerpc kernel not to provide that to user
space may break it unless the program gets recompiled against
the latest headers.

      Arnd
