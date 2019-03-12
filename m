Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44C09C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 08:31:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 13C5C214AF
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 08:31:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727544AbfCLIbw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Mar 2019 04:31:52 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:45707 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727173AbfCLIbw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Mar 2019 04:31:52 -0400
Received: by mail-qt1-f195.google.com with SMTP id v20so1541788qtv.12;
        Tue, 12 Mar 2019 01:31:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gRrxWa8mE/4cLAC9TYkbasvGEZoyt+PHOVMX973fV90=;
        b=RRIUXbqwDpajrNk77Mw0UY3+gWjbjcOWngBB8Z6mwl14os1v/ouvQIjqjLjc+2P7mR
         C7qyrxcuz8Ld7hktvSDPyeW9r1SUMF2Mn01Fe6FQBj56mDjJhm4FwvKUEQ5uBr1Y7UJp
         7zw32i9z2Y+aJ9BiVNWRHNHjBcpu1yxmiltKpQqNovKBjAesBlDy6RO+sHA6i/lXTJIV
         tJ3GESXyYjqsmbTY4SksAG0Y265PhjT4IgHiqNuT+NKC5/XUWRp7S5w/j0zlLsYAqhmL
         NtqL5bi3nVu2CWMwN4uWEm6EnT3SKXy4/3ZPw81xeRhakIchDgjzwjUrOH2UBuXd1gxg
         xN9w==
X-Gm-Message-State: APjAAAU4g+XkNbZ3TYz1dwzGoJ4zDOL1NP4G0LpJJdI0A9SV1NUpBRhg
        QGKyruvTiWwGzuXugSnGnOdaNAV+sesuaq6YVCJ/iQ==
X-Google-Smtp-Source: APXvYqz2clLOIKD5q4WQ81EPj9ed8rcuvzHlKzv++xUA2AmqxyP/J7BltzFdKDIS66kJnOI/uCxGfuT8j3xNAKnO8dM=
X-Received: by 2002:ac8:1e17:: with SMTP id n23mr7095886qtl.152.1552379511299;
 Tue, 12 Mar 2019 01:31:51 -0700 (PDT)
MIME-Version: 1.0
References: <20190122141027.70cd9166@canb.auug.org.au> <20190213162212.500a7cd5@canb.auug.org.au>
 <CAK8P3a1hw03ik+tZSG8PnP7Rd=Pzwbo7n59HLJW04ncndyqzsg@mail.gmail.com>
 <CAMuHMdUmPBeQ=jcDufVBDEGiO1Yk4bWWBSg488Jm_wwAuySHBQ@mail.gmail.com>
 <CAK8P3a1zHm-WjYjEA65PomrKe7+5Sd110KbXv13=wiMVpxyuaQ@mail.gmail.com> <20190311214307.domy6azaoi4ggtiu@brauner.io>
In-Reply-To: <20190311214307.domy6azaoi4ggtiu@brauner.io>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Tue, 12 Mar 2019 09:31:33 +0100
Message-ID: <CAK8P3a0iW-bhfiLY2po4cwaG0f-S+Xdoowrj0A6CwaY4VHgdWA@mail.gmail.com>
Subject: Re: New syscalls (was: Re: linux-next: manual merge of the pidfd tree
 with the y2038 tree (now block and tip trees))
To:     Christian Brauner <christian@brauner.io>
Cc:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Jens Axboe <axboe@kernel.dk>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@elte.hu>, "H. Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux-Arch <linux-arch@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 11, 2019 at 10:43 PM Christian Brauner <christian@brauner.io> wrote:
> On Mon, Mar 11, 2019 at 10:38:07PM +0100, Arnd Bergmann wrote:
> > On Mon, Mar 11, 2019 at 9:36 AM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> > >
> > > Shall each architcture maintainer take care of this hxxself, or will
> > > this be done in
> > > a coordinated way?
> >
> > I was planning to send a patch for all architectures this time
> > (after all three sets are merged, which is now), and ask future
>
> Just to clarify, are you referring to your sets? I think Linus hasn't
> gotten around to reviewing the PR for pidfd_send_signal() yet. :)

Ah, I thought he had already merged both, the confusion was on
my end.

      Arnd
