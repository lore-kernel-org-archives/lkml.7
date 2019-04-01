Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CE0BC43381
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 12:05:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 15D4020883
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 12:05:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=brauner.io header.i=@brauner.io header.b="Ewyn7Gn5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727023AbfDAME7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 08:04:59 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:34783 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726636AbfDAME4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 08:04:56 -0400
Received: by mail-ed1-f66.google.com with SMTP id x14so7986349eds.1
        for <linux-kernel@vger.kernel.org>; Mon, 01 Apr 2019 05:04:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brauner.io; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=VPDCx0qpmBzfdZBBNDfIB9KlTh+K+UcwTE8iRSsK86c=;
        b=Ewyn7Gn5/OUE26WIXS4Zpu8bX43a/BAmveKqDubexEMOO1Tq63e7ZdjOI66/ccWXAS
         oRYxPhvCQoDKeej8+ze8TLXWj0mlRsyiNy2/Lv9pgQ6TlT2MLZ3/3uGtHowj9FxAG6tJ
         iroJfx8nsINJDvvbSRuwZM+Vgk36ntm70O5BZJb8mm0ScPQwb6GAITQcq/N4MD2aWi+n
         qltmuja/sjah1GwpjIWrCMzz8JX5LuUVgobnkJjl5eL746NoImvh5/yEDENssf2KikS3
         YGj89hwhLY2h2L+5Vdm/Utn279eYrQYgvnnPb7MC7e5tzdqcESZ0pNkio5fcVFWeQvZj
         BhgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=VPDCx0qpmBzfdZBBNDfIB9KlTh+K+UcwTE8iRSsK86c=;
        b=L6rNDf9V3T5Y/Cp0Cfhkd2l7EXvFNFI2sLXgEasvyUahFw9CbUD+XYRKKhH7cz93j2
         YpXkmz1yNOZDDnumoSi76jhAhhVkJRXUqluLJVVy6sZW1P0hGr59UjKSieQwa1PF6ESp
         /R7W19t2Ioml/sRjXwEOCbYgSlDJqoYcDs2IgAg/N7XiqghjyGruJ0zpa8aI78Zj81Y0
         VzkcAZQ+JLGMxLCqfHVScPWjPvdlhxb1C0G25qiKU/hY90PkpcsbkwkB/9eZeIvqOyRW
         v0gu/uhFcCZrHn/cIN6NqL0lkPVEg6XTCnIut/6FOkgapfLD8fHoYMTFZHS3VKBPZsbD
         A8ig==
X-Gm-Message-State: APjAAAW/GXYHMpxo82Tv9DxTI3Zs5AXhV2GfQQGLG0rkxSPF2N3TuEbV
        xb/gX39ZdjfDovWxMo4jwzb4uA==
X-Google-Smtp-Source: APXvYqwV2VwPm7cSloA/4XtPEubPwQBiAfKcqabj9rtLWJ+BqSORejh2CL5BHNCUp/RayIrU2T/r6A==
X-Received: by 2002:a50:86dc:: with SMTP id 28mr43468797edu.258.1554120294737;
        Mon, 01 Apr 2019 05:04:54 -0700 (PDT)
Received: from brauner.io (x59cc8b8e.dyn.telefonica.de. [89.204.139.142])
        by smtp.gmail.com with ESMTPSA id a25sm3170218edc.55.2019.04.01.05.04.52
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 01 Apr 2019 05:04:54 -0700 (PDT)
Date:   Mon, 1 Apr 2019 14:04:52 +0200
From:   Christian Brauner <christian@brauner.io>
To:     Andy Lutomirski <luto@amacapital.net>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Daniel Colascione <dancol@google.com>,
        Jann Horn <jannh@google.com>,
        Andrew Lutomirski <luto@kernel.org>,
        David Howells <dhowells@redhat.com>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Linux API <linux-api@vger.kernel.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Konstantin Khlebnikov <khlebnikov@yandex-team.ru>,
        Kees Cook <keescook@chromium.org>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Michael Kerrisk-manpages <mtk.manpages@gmail.com>,
        Jonathan Kowalski <bl0pbl33p@gmail.com>,
        "Dmitry V. Levin" <ldv@altlinux.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Oleg Nesterov <oleg@redhat.com>,
        Nagarathnam Muthusamy <nagarathnam.muthusamy@oracle.com>,
        Aleksa Sarai <cyphar@cyphar.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Joel Fernandes <joel@joelfernandes.org>
Subject: Re: [PATCH v2 0/5] pid: add pidfd_open()
Message-ID: <20190401120450.e4k2m434qyqj4yrn@brauner.io>
References: <CAHk-=whcA0kAWGqet9oJdyttjhP7J4PcU2Ly=n_Qyo6rMJNxRg@mail.gmail.com>
 <CAKOZuevv_QgvzmusA+yey76vo4hn9bEVwud2RumuOr0K4++15A@mail.gmail.com>
 <CAHk-=wj0o8BiUrYiM5ZcTS6JxBh1M60O36Ms8-EqLQ139=1L4g@mail.gmail.com>
 <20190330171215.3yrfxwodstmgzmxy@brauner.io>
 <CAHk-=whF6gnRVbJaArZna4e=tejfrzmNQtRbWjnuSSKpBn+jQg@mail.gmail.com>
 <132107F4-F56B-4D6E-9E00-A6F7C092E6BD@amacapital.net>
 <CAHk-=wiaLtH41Mc5qAjOeCWavPqV0DhS581KYa0QBt8uraTK1Q@mail.gmail.com>
 <20190331211041.vht7dnqg4e4bilr2@brauner.io>
 <CAHk-=wi3AE1-iRQ_7LOeSMNAMrGxRdC=gTjD30duVw4XRchcNQ@mail.gmail.com>
 <18C7FCB9-2CBA-4237-94BB-9C4395A2106B@amacapital.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <18C7FCB9-2CBA-4237-94BB-9C4395A2106B@amacapital.net>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 31, 2019 at 08:13:38PM -0600, Andy Lutomirski wrote:
> 
> 
> > On Mar 31, 2019, at 3:17 PM, Linus Torvalds <torvalds@linux-foundation.org> wrote:
> > 
> >> On Sun, Mar 31, 2019 at 2:10 PM Christian Brauner <christian@brauner.io> wrote:
> >> 
> >> I don't think that we want or can make them equivalent since that would
> >> mean we depend on procfs.
> > 
> > Sure we can.
> > 
> > If /proc is enabled, then you always do that dance YOU ALREADY WROTE
> > THE CODE FOR to do the stupid ioctl.
> > 
> > And if /procfs isn't enabled, then you don't do that.
> > 
> > Ta-daa. Done. No stupid ioctl, and now /proc and pidfd_open() return
> > the same damn thing.
> > 
> > And guess what? If /proc isn't enabled, then obviously pidfd_open()
> > gives you the /proc-less thing, but at least there is no crazy "two
> > different file descriptors for the same thing" situation, because then
> > the /proc one doesn't exist.
> > 
> 
> I wish we could do this, and, in a clean design, it would be a no-brainer.  But /proc has too much baggage.  Just to mention two such things, there’s “net” and “../sys”.  This crud is why we have all kinds of crazy rules that prevent programs in sandboxes from making a new mounts and mounting /proc in it.  If we make it possible to clone a new process and this access /proc without having /proc mounted, we’ll open up a big can of worms.
> 
> Maybe we could have a sanitized view of /proc and make a pidfd be a directory fd pointing at that.

We can also just create something like an internal bind-mount without a
parent, i.e. similar to

open_tree(<internal-procfs-mount>, "<pid>", OPEN_TREE_CLONE);

on a clone(CLONE_PIDFD);

that would block any openat(fd, "..");
