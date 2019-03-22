Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 624E8C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 17:08:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3339D21939
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 17:08:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553274532;
	bh=NPONG8wAWdU8frpkBP04ZDC1Cm0k8bBvTC60p9VG0bk=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=zwOevFU4R8Hoin7t3lsutru2ftToNTZfV+5P8W/IUVUSiN/8dL3u8AMwEBQBY6z1E
	 DZ/Sccm6H+adcLOEiTryEern6NBkNEyGYY9dDqIF53ghxf/AjCTTimJOTL+fDFkLU4
	 ugPq7/53eDvGSOR76cxwRiFtgxNTRH0OlJU+oLCE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728831AbfCVRIv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 13:08:51 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:35886 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728540AbfCVRIt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 13:08:49 -0400
Received: by mail-lj1-f193.google.com with SMTP id r24so1622510ljg.3
        for <linux-kernel@vger.kernel.org>; Fri, 22 Mar 2019 10:08:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=syf5FC/PD4cN6FgIJM2ms3RJG343jtrhSP64Oe75Sac=;
        b=IuhoI3hZaIxE4YvOC0/zFIRPXbZPqr4mch9fB87bJI50v/CesoGw5jPm0Ymj36S+8D
         SIzDojt4m/q1uwaK9P5Is2rLt7NY0cQwo3oRCrDKYwFF22+ZwEkj5rWc3XCpMkx/lh21
         i/oyaRFuahvewUzvmGuDcKpmqMK2Pff6AsG6Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=syf5FC/PD4cN6FgIJM2ms3RJG343jtrhSP64Oe75Sac=;
        b=QlE8tg8doLs057xd73LO7RGiMEMtVNb5mQDfqlTfvvO/FBuRRdS0Ewoy/tMMEQ5NvW
         qc2EJ+nEP0p10RKW4W35RGSV1mjBMeQJuvfCnV8ISubZcUr6nUutTO1vQj/tcHfMiVnc
         x3lYYoREQhcu1/XhW1+NFtzBYS4IXeGYhd+DrlvmFvANTZpHFIYnnyMI/GxI5tvi/gW6
         w1uUpMeY2DHakePsEEh8mUKfrgQf0ZlvuCwEJsj2v5Ye6zTgIQM296NFRNk+O6HWhCZM
         750bRKZ3AYjnqIQnZqZZOgJo8D90Y4xn0J66k+hYF6qYJ93LDrlLOIXLZsZavTCStRzg
         x5cQ==
X-Gm-Message-State: APjAAAWYLCHBszILu0OO12TGJaDZiLyGkJ8UABw5vNAed8fUIz6HqQpS
        nwIHzP3XgiMf9uczO4OemUG5YXpHI1A=
X-Google-Smtp-Source: APXvYqx2clUXv4fTjcaOsSbnkWoCgAi6cQW8F625CUKQQ15sCJr1XfGMqjEh0Kcnqx//2hpdhSRuew==
X-Received: by 2002:a2e:9098:: with SMTP id l24mr5237217ljg.55.1553274527290;
        Fri, 22 Mar 2019 10:08:47 -0700 (PDT)
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com. [209.85.208.175])
        by smtp.gmail.com with ESMTPSA id u19sm558985lfg.74.2019.03.22.10.08.45
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 22 Mar 2019 10:08:45 -0700 (PDT)
Received: by mail-lj1-f175.google.com with SMTP id k8so2658740lja.8
        for <linux-kernel@vger.kernel.org>; Fri, 22 Mar 2019 10:08:45 -0700 (PDT)
X-Received: by 2002:a2e:86ca:: with SMTP id n10mr5880284ljj.135.1553274524897;
 Fri, 22 Mar 2019 10:08:44 -0700 (PDT)
MIME-Version: 1.0
References: <20190322143008.21313-1-longman@redhat.com> <20190322143008.21313-4-longman@redhat.com>
In-Reply-To: <20190322143008.21313-4-longman@redhat.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 22 Mar 2019 10:08:29 -0700
X-Gmail-Original-Message-ID: <CAHk-=wi0wwmY-waC1-2SmBz4-XK-Eru2RTx6PrGzUK=P1nwexQ@mail.gmail.com>
Message-ID: <CAHk-=wi0wwmY-waC1-2SmBz4-XK-Eru2RTx6PrGzUK=P1nwexQ@mail.gmail.com>
Subject: Re: [PATCH v5 3/3] locking/rwsem: Optimize down_read_trylock()
To:     Waiman Long <longman@redhat.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Will Deacon <will.deacon@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        "linux-alpha@vger.kernel.org" <linux-alpha@vger.kernel.org>,
        "linux-alpha@vger.kernel.org" <linux-arm-kernel@lists.infradead.org>,
        linux-c6x-dev@linux-c6x.org, uclinux-h8-devel@lists.sourceforge.jp,
        linux-hexagon@vger.kernel.org, linux-ia64@vger.kernel.org,
        linux-m68k <linux-m68k@lists.linux-m68k.org>,
        linux-mips@vger.kernel.org, nios2-dev@lists.rocketboards.org,
        openrisc@lists.librecores.org, linux-parisc@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org,
        linux-s390@vger.kernel.org,
        Linux-sh list <linux-sh@vger.kernel.org>,
        sparclinux@vger.kernel.org, linux-um@lists.infradead.org,
        linux-xtensa@linux-xtensa.org,
        linux-arch <linux-arch@vger.kernel.org>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        Tim Chen <tim.c.chen@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 22, 2019 at 7:30 AM Waiman Long <longman@redhat.com> wrote:
>
> Modify __down_read_trylock() to optimize for an unlocked rwsem and make
> it generate slightly better code.

Oh, that should teach me to read all patches in the series before
starting to comment on them.

So ignore my comment on #1.

                Linus
