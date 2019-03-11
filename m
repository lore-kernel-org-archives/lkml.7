Return-Path: <SRS0=FxTY=RO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9BACC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 21:53:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8EF31214AE
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 21:53:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552341190;
	bh=M3kg/jdEBUe+CDQz+GMx2iZEuq1EMWCLrvE45qvukMI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=ICx7IHFymKjSaVd2UJMWR9eaGo5XlBHQOjiQrIiBw7vtQViAobReIs8tUdpr4Hif+
	 2RVap2zfXms3amvlgwC9lNMI/3b5qlNaWR8o5f85qBc0YRv83CZXHTJo4nN+O+RmEq
	 3vhv1eUmEWLn4410j/Ejnwx0SNM+iEi8uWj7RPG4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728417AbfCKVxJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 17:53:09 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:32999 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727548AbfCKVxI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 17:53:08 -0400
Received: by mail-lj1-f195.google.com with SMTP id z7so509442lji.0
        for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2019 14:53:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=72QtNwbLsdBpSZDKo9CP7eJ/scNnRHayCxjjk07ES3Y=;
        b=LA+Wfgc2lBBEL9hzQqlUJrd/usGm7EKbpwpoJMMCw+3/d0O29pB9qlN40v6A/XD+zL
         VYC+XsQUTAVToadUn1rdPJaBno60ecvk2noT50fp9cPrbFoT8PB4Ho3DaaaJL/r9N1yf
         ga8/t9Io2HVZFCHmb/5O6GF5W5HWY+ygSpF6I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=72QtNwbLsdBpSZDKo9CP7eJ/scNnRHayCxjjk07ES3Y=;
        b=E3eJZ/RmCNV33w0Vt15qhzyPUy+HajVEV4YehqB2jeXDA4inWzDz3POa4MGj/Kfum9
         W7OuJsAeemii38DQTfxvFORwnti9Cls4WxisaDzUsnnrRLalTfPpgLRGycWL1h4bbQ24
         3niwBbeusNAvlFCYdKy7J2w9zCYY3JsTNd5xhpUK/88cWvsyHTUP2Uije+Au5p8nOd9U
         vDFCAtDWC6Q7NT0BGneayxJLu8uUxGoJjZHJuGR/9Th/1l2W2FRl+DYmIEEBKFNyNfKO
         2Dv1hi8AbAvfZ9WNox72NrlzLLYJEw8Ep9dWl+5ai1k1VxJd6z6j8VX0CSZ54trrvKrz
         vH0w==
X-Gm-Message-State: APjAAAVSXqoxIJ5+XRM9MZosWXHPkHp4QcHyYOa/n5uN5iPs6w0wthu7
        IrBSAx/ZF5nVUt2SXAGb1fMuxJfJxVg=
X-Google-Smtp-Source: APXvYqxGNqErUDc/g8FweP+SUI2hzipONfJatoeY3T5215hv2XFfQYIr8AAxpLhxjn2gZ44o89QnUA==
X-Received: by 2002:a2e:2c11:: with SMTP id s17mr17678978ljs.147.1552341186035;
        Mon, 11 Mar 2019 14:53:06 -0700 (PDT)
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com. [209.85.167.44])
        by smtp.gmail.com with ESMTPSA id r11sm1100858ljb.29.2019.03.11.14.53.05
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 11 Mar 2019 14:53:05 -0700 (PDT)
Received: by mail-lf1-f44.google.com with SMTP id 197so478400lfz.3
        for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2019 14:53:05 -0700 (PDT)
X-Received: by 2002:ac2:5088:: with SMTP id f8mr18412143lfm.11.1552340743409;
 Mon, 11 Mar 2019 14:45:43 -0700 (PDT)
MIME-Version: 1.0
References: <CAG48ez1RVd5mQ_Pb6eygQESaZhpQz765OAZYSoPE0kPqfZEXQg@mail.gmail.com>
 <20190305091904.GB8256@zn.tnic> <20190305122218.GD13380@bombadil.infradead.org>
 <20190305134347.4be2449c@alans-desktop> <20190305145717.GD8256@zn.tnic>
 <CAHk-=wi2E4kugAW7BQwNSVwYHOr=B_9EgzBRMpQ2+1dxAqydDg@mail.gmail.com>
 <20190305173134.GE8256@zn.tnic> <CAHk-=wg0bY=RFhD4NW9x++fC0bME=_-9xM3kexGGM3gefHQTyQ@mail.gmail.com>
 <20190305181138.GG8256@zn.tnic> <20190305181808.GH8256@zn.tnic>
 <CAEdQ38G5M3vq9pGBV1iyEViO7JhFuXk5g+VCs-vUH+Z62kNqgQ@mail.gmail.com>
 <CAHk-=wgt7M6yA5BJCJo0nF22WgPJnN8CvViL9CAJmd+S+Civ6w@mail.gmail.com>
 <yw1xa7i14btw.fsf@mansr.com> <CAHk-=whD1SumZUBQeuMT-GcciwPxg_jW_TsPAmokYp3sGGCGhA@mail.gmail.com>
 <yw1x5zsp473a.fsf@mansr.com> <CAHk-=wiU7xacTqDfm-x29-meyJWNd_X95K0T8FQMcDgy-yo3Qw@mail.gmail.com>
 <yw1x1s3d42ia.fsf@mansr.com> <CAK8P3a031d9mSOxVmCAGcrbdaCE8N3R4e2Smtxp-Z+cautTAvg@mail.gmail.com>
In-Reply-To: <CAK8P3a031d9mSOxVmCAGcrbdaCE8N3R4e2Smtxp-Z+cautTAvg@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 11 Mar 2019 14:45:27 -0700
X-Gmail-Original-Message-ID: <CAHk-=wj3v41CWH+3ry3+vrkjAEcyGojtevpsZDbiXVvpv1nTkA@mail.gmail.com>
Message-ID: <CAHk-=wj3v41CWH+3ry3+vrkjAEcyGojtevpsZDbiXVvpv1nTkA@mail.gmail.com>
Subject: Re: [PATCH] x86: Deprecate a.out support
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     =?UTF-8?B?TcOlbnMgUnVsbGfDpXJk?= <mans@mansr.com>,
        Matt Turner <mattst88@gmail.com>,
        Borislav Petkov <bp@alien8.de>,
        Alan Cox <gnomes@lxorguk.ukuu.org.uk>,
        Matthew Wilcox <willy@infradead.org>,
        Jann Horn <jannh@google.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Thomas Gleixner <tglx@linutronix.de>,
        kernel list <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Richard Weinberger <richard@nod.at>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        linux-alpha <linux-alpha@vger.kernel.org>,
        linux-m68k <linux-m68k@lists.linux-m68k.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 11, 2019 at 2:34 PM Arnd Bergmann <arnd@arndb.de> wrote:
>
> The main historic use case I've heard of was running Netscape
> Navigator on Alpha Linux, before there was an open source version.
> Doing this today to connect to the open internet is probably
> a bit pointless, but there may be other use cases.

The _really_ main version was that I decided to make my life easier
for the initial alpha port by trying to run basic (tested) OSF/1
binaries directly.

Netscape may have been one of the binaries people actually ended up
using, but it's probably not a reason any more, since the internet has
moved past that anyway.

> Looking at the system call table in the kernel
> (arch/alpha/kernel/syscalls/syscall.tbl), we seem to support a
> specific subset that was required for a set of applications, and
> not much more.

Yeah, it never supported arbitrary binaries, particularly since
there's often lots of other issues too with running things like that
(ie filesystem layout etc). It worked for normal fairly well behaved
stuff, but wasn't ever a full OSF/1 emulation environment.

I _suspect_ nobody actually runs any OSF/1 binaries any more, but it
would obviously be good to verify that. Your argument that timeval
handling was broken _may_ be an indication of that (or may just mean
very few apps care).

I think we should try the a.out removal and see if anybody notices.

                    Linus
