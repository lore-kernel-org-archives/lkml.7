Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 660DDC10F13
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 23:45:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2A7B020880
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 23:45:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555458328;
	bh=jm52RjcZVwFOzVh/0Gd9yqEVQ6b4gd/Ml76gquOU3IM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=06MgobV9LNN/YhoJBQkpGMxZFlIPr+LIoFpmbTiMscXiE9LK+10X/0IZrc+ejj1l0
	 gCCw3Sr1pUily6yjCEAy8NhQZOfXFlXBiS7kIk3sjeVxUWx4s1wBRiQsKFtUzyBbhP
	 Xcz1nsBXtuB5ubZLy3CSKSsJ1b1rhYMIqjQSIxOA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730730AbfDPXp0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 19:45:26 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:41058 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729291AbfDPXp0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 19:45:26 -0400
Received: from akpm3.svl.corp.google.com (unknown [104.133.8.65])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 897ACE2C;
        Tue, 16 Apr 2019 23:45:25 +0000 (UTC)
Date:   Tue, 16 Apr 2019 16:45:24 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Kees Cook <keescook@chromium.org>
Cc:     Matteo Croce <mcroce@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Alexey Dobriyan <adobriyan@gmail.com>
Subject: Re: [PATCH 2/2] kernel: use sysctl shared variables for range check
Message-Id: <20190416164524.ac661d71f22e0126da31ef98@linux-foundation.org>
In-Reply-To: <CAGXu5j+2CLGmx_Sd+r-GXxPcCg3PfyQDU8ohJfCzxFku5_WzvQ@mail.gmail.com>
References: <20190408220925.13077-1-mcroce@redhat.com>
        <20190408220925.13077-3-mcroce@redhat.com>
        <CAGXu5jKc2q3gnBrJ5JowDvOC_tSR5o9iKuF+JVKMJYWAPOZANQ@mail.gmail.com>
        <CAGnkfhwZEqX03H7PqsSTa=GVwZXX127hQO5YHzJasAEYtpLMZw@mail.gmail.com>
        <CAGXu5j+0sAc2fHTuYwYTLoHPDbnfxYuAEJ+tRfgc2Z5DDqp9Jg@mail.gmail.com>
        <CAGnkfhxPZJXmnPJ+k8nGPCBNeDBM_=rN+kEea-Uyq0zfCt0MXg@mail.gmail.com>
        <CAGXu5jKf8ezMOxMn3P8DW+0GQrdkmno8_qxgQtxBD98cP3MRKA@mail.gmail.com>
        <CAGnkfhyeUdN+H4g9Lx4X2ae9k3crLrZQjQYZVjNE4ZyM8ziY9g@mail.gmail.com>
        <CAGXu5j+2CLGmx_Sd+r-GXxPcCg3PfyQDU8ohJfCzxFku5_WzvQ@mail.gmail.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 10 Apr 2019 15:59:55 -0700 Kees Cook <keescook@chromium.org> wrote:

> On Wed, Apr 10, 2019 at 3:54 PM Matteo Croce <mcroce@redhat.com> wrote:
> >
> > On Thu, Apr 11, 2019 at 12:34 AM Kees Cook <keescook@chromium.org> wrote:
> > >
> > > On Wed, Apr 10, 2019 at 3:30 PM Matteo Croce <mcroce@redhat.com> wrote:
> > > >
> > > > FYI, this are the stats from my local repo, just to let you the size
> > > > of a series with all the changes in it:
> > > >
> > > > $ git --no-pager log --stat --oneline linus/master
> > > >  2 files changed, 4 insertions(+), 9 deletions(-)
> > > >  2 files changed, 7 insertions(+), 14 deletions(-)
> > > >  6 files changed, 15 insertions(+), 30 deletions(-)
> > > >  1 file changed, 16 insertions(+), 19 deletions(-)
> > > >  1 file changed, 3 insertions(+), 5 deletions(-)
> > > >  3 files changed, 15 insertions(+), 20 deletions(-)
> > > >  12 files changed, 93 insertions(+), 116 deletions(-)
> > > >  3 files changed, 98 insertions(+), 104 deletions(-)
> > > >  2 files changed, 9 insertions(+)
> > >
> > > Tiny! :) Seriously, though, I think this should be fine to take
> > > directly to Linus after patch 1 lands, or see if akpm wants to carry
> > > it directly.
> > >
> > > --
> > > Kees Cook
> >
> > Nice. Still as an 8 patches series, or squashed into a bigger one?
> 
> I suspect a single patch would be fine, but let's wait to hear from akpm.

Bring it!
