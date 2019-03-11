Return-Path: <SRS0=FxTY=RO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D60B9C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 21:43:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9EE1E2147C
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 21:43:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=brauner.io header.i=@brauner.io header.b="CW8eUKFT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728433AbfCKVnN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 17:43:13 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:36122 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727993AbfCKVnM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 17:43:12 -0400
Received: by mail-ed1-f65.google.com with SMTP id e4so580499edi.3
        for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2019 14:43:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brauner.io; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=5kt/pwg90CF9A/mrkUA0j+JHoGAcsD1eR/v0ILTa7Vw=;
        b=CW8eUKFTRQJYnZOvkyLrWGib3k6E2VtnLyAj02r9Sms9YqSQRa/uE8S1jPDIRQGQ0o
         yu4TvaqSKxvw8hBGyG2UAFhG2eVYBLtCA5eC1ieGhI/c9efUAMsH4jFYOlFNCU6kOLuD
         CHkv+AbcMlU1HzhLToBwfyKe9OQpzBgzQx25RuErGsZdmfKEEf9Jt/xD7ODFcrbSofuh
         rB+qVi1GB0jMXEO5utl1PzTkEvefaH2lK7AfnYt+hxXvU42+q5tjYscsfXPsuZ76+81X
         Rxlj+28NQ+dcwv8J7/Hb2hrEaJm//LTqBIvdijHLWSEZF6/34NetOaojFnHt0fzkRIZS
         XocQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=5kt/pwg90CF9A/mrkUA0j+JHoGAcsD1eR/v0ILTa7Vw=;
        b=Y9egOg0atCNzjjSAXMzfzfHIa42cZSWk9ybOaJCfarvz5gV249vhFofktXrPNnHkXM
         xPXzFEzywLcnPIPRa+o2KUwRYe2gcxWwLPN5PNjY/O59YIvFCtoFebKpGngXhuMsFmpt
         fxCIm99BqkxJWj74KHEWsxXoDwUB/jkBGYdEGSWHrZ8YmwskrHGkBss1ZdcpDIOXueqs
         02paxoEq9ex5Pf9V5X1l9ryGUKoN6LyG3C6g1gCz9Xdh+9Q8A+JafDUEWIIBN8bV4ONi
         4fa5HeKuhcuVI6GK6YWZhzxAf086A0WCZn1r/avDBUowpxTaple9TxXiUThRAUBIExXq
         WMFg==
X-Gm-Message-State: APjAAAWI8F6mCntEywtmfrdNDDxMbjbjpgCsBjfA1pUs/ag1MeFBnQtt
        LsZry3W/pxqXTs7zSr9BjEEreg==
X-Google-Smtp-Source: APXvYqwk3FFQFsAq39qdLupilWCfMOa23g4WznVaWOP55weLAT0+Zj99rJqdmO4hOOdRWP77J7ZPBg==
X-Received: by 2002:a17:906:5846:: with SMTP id h6mr3826688ejs.125.1552340590422;
        Mon, 11 Mar 2019 14:43:10 -0700 (PDT)
Received: from brauner.io ([2a02:8109:b6c0:76e:dd26:cbb7:1dbc:50af])
        by smtp.gmail.com with ESMTPSA id p3sm754958eds.58.2019.03.11.14.43.09
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 11 Mar 2019 14:43:09 -0700 (PDT)
Date:   Mon, 11 Mar 2019 22:43:08 +0100
From:   Christian Brauner <christian@brauner.io>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Jens Axboe <axboe@kernel.dk>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@elte.hu>, "H. Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux-Arch <linux-arch@vger.kernel.org>
Subject: Re: New syscalls (was: Re: linux-next: manual merge of the pidfd
 tree with the y2038 tree (now block and tip trees))
Message-ID: <20190311214307.domy6azaoi4ggtiu@brauner.io>
References: <20190122141027.70cd9166@canb.auug.org.au>
 <20190213162212.500a7cd5@canb.auug.org.au>
 <CAK8P3a1hw03ik+tZSG8PnP7Rd=Pzwbo7n59HLJW04ncndyqzsg@mail.gmail.com>
 <CAMuHMdUmPBeQ=jcDufVBDEGiO1Yk4bWWBSg488Jm_wwAuySHBQ@mail.gmail.com>
 <CAK8P3a1zHm-WjYjEA65PomrKe7+5Sd110KbXv13=wiMVpxyuaQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAK8P3a1zHm-WjYjEA65PomrKe7+5Sd110KbXv13=wiMVpxyuaQ@mail.gmail.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 11, 2019 at 10:38:07PM +0100, Arnd Bergmann wrote:
> On Mon, Mar 11, 2019 at 9:36 AM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> > On Wed, Feb 13, 2019 at 3:22 PM Arnd Bergmann <arnd@arndb.de> wrote:
> > > On Wed, Feb 13, 2019 at 6:22 AM Stephen Rothwell <sfr@canb.auug.org.au> wrote:
> > > > On Tue, 22 Jan 2019 14:10:27 +1100 Stephen Rothwell <sfr@canb.auug.org.au> wrote:
> > > > > Today's linux-next merge of the pidfd tree got conflicts in:
> > > > >
> > > > >   arch/x86/entry/syscalls/syscall_32.tbl
> > > > >   arch/x86/entry/syscalls/syscall_64.tbl
> > > > >   include/uapi/asm-generic/unistd.h
> > > > >
> > > > > between commits:
> > > > >
> > > > >   63a96220ad45 ("arch: add split IPC system calls where needed")
> > > > >   0bd4bb9c5612 ("y2038: add 64-bit time_t syscalls to all 32-bit architectures")
> > > > >
> > > > > from the y2038 tree and commit:
> > > > >
> > > > >   3d2991bc7a67 ("signal: add pidfd_send_signal() syscall")
> > > > >
> > > > > from the pidfd tree.
> > > >
> > > > This is now a conflict between the block, tip and pidfd trees.  The
> > > > resolution now looks like below.
> > >
> > > Checked it again, still looks good. Thanks,
> >
> > What's the plan with adding new syscalls to all architectures?
> >
> >   + <stdin>: warning: #warning syscall io_uring_enter not implemented
> > [-Wcpp]:  => 1481:2
> >   + <stdin>: warning: #warning syscall io_uring_register not
> > implemented [-Wcpp]:  => 1484:2
> >   + <stdin>: warning: #warning syscall io_uring_setup not implemented
> > [-Wcpp]:  => 1478:2
> >
> > and more seem to be planned for this merge window.
> >
> > Shall each architcture maintainer take care of this hxxself, or will
> > this be done in
> > a coordinated way?
> 
> I was planning to send a patch for all architectures this time
> (after all three sets are merged, which is now), and ask future

Just to clarify, are you referring to your sets? I think Linus hasn't
gotten around to reviewing the PR for pidfd_send_signal() yet. :)

Christian

> submitters to do it themselves when first adding a new system
> call.
> 
>        Arnd
