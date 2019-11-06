Return-Path: <SRS0=fWiu=Y6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CB66C5DF60
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Nov 2019 00:21:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 316BC214D8
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Nov 2019 00:21:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1572999681;
	bh=D8jWft4upIxpTnsIUbrtpc1F6CcEx5gqs43q8uH3YPY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=gaTDuf8CVacrJWUQFZ0oacGVAafHBPrMafydzNNMcIYxDxQwC6yPMNYIcwnV7hPaP
	 Ab2yusDabGLudoaLpVUDcKwBAz6hzLFWjuBQM1DyWHGRUIAQ+HUYee52+aHY17L09N
	 a4xkemccMIMRJ2H0dkvP+etkYgGjt84KTH3GuGwY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730210AbfKFAVU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Nov 2019 19:21:20 -0500
Received: from mail.kernel.org ([198.145.29.99]:53016 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727252AbfKFAVU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Nov 2019 19:21:20 -0500
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C1BBC21A4A
        for <linux-kernel@vger.kernel.org>; Wed,  6 Nov 2019 00:21:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572999679;
        bh=D8jWft4upIxpTnsIUbrtpc1F6CcEx5gqs43q8uH3YPY=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=jrhkL8JHR/lA6JwBfOiootbkCrQnM3+KG5k3PZllRZx1qq2bS4X3TLDCArSnIxjnu
         7Qm/b3c4CUdj1iXC4ZBA4oAdF7mkXjKTDSqpm4FU7uNqh+zgpGzdsaVUNCs2xJVB6P
         Ut0BPtGcG4Sg3FRDdflakOrK13cNO7fhIa3qayxM=
Received: by mail-wr1-f41.google.com with SMTP id w30so934166wra.0
        for <linux-kernel@vger.kernel.org>; Tue, 05 Nov 2019 16:21:18 -0800 (PST)
X-Gm-Message-State: APjAAAVbY0tyECsZdzv6C3wGBcrlODUZVtaFwyHdn1VIH3UxOZIODF5E
        09of5DZdE6QKEmQXx2RrfW43kgiKM9bFKgNEBrBGLw==
X-Google-Smtp-Source: APXvYqx1r5nhg9jjyGuZDqdY+6kzIsNz597zBvDV9yCb0FIFmWwAX2hCHlxzOJ3CTbd+p3J84OKAps5ETJLbxYihKgs=
X-Received: by 2002:a5d:51c2:: with SMTP id n2mr3207wrv.149.1572999677445;
 Tue, 05 Nov 2019 16:21:17 -0800 (PST)
MIME-Version: 1.0
References: <20190216234702.GP2217@ZenIV.linux.org.uk> <20190217034121.bs3q3sgevexmdt3d@khany>
 <20190217042201.GU2217@ZenIV.linux.org.uk> <alpine.DEB.2.21.1902181347500.1549@nanos.tec.linutronix.de>
 <CALCETrXyard2OXmOafiLks3YuyO=ObbjDXB6NJo_08rL4M6azw@mail.gmail.com>
 <20190218215150.xklqbfckwmbtdm3t@khany> <20190926095825.zkdpya55yjusvv4g@khany>
 <20190926140939.GD18383@zn.tnic> <20191010164951.kr2epy5lyywgngt6@khany>
 <20191105141112.GB28418@zn.tnic> <20191105160530.vdaii44gckfo45rw@khany>
In-Reply-To: <20191105160530.vdaii44gckfo45rw@khany>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Tue, 5 Nov 2019 16:21:06 -0800
X-Gmail-Original-Message-ID: <CALCETrXVuPWwMj9MByvdbRuerboweajaY3zT4eUaJQk4PXqnnQ@mail.gmail.com>
Message-ID: <CALCETrXVuPWwMj9MByvdbRuerboweajaY3zT4eUaJQk4PXqnnQ@mail.gmail.com>
Subject: Re: [PATCH] x86: uaccess: fix regression in unsafe_get_user
To:     Arthur Gautier <baloo@gandi.net>
Cc:     Borislav Petkov <bp@alien8.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Jann Horn <jannh@google.com>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        kernel list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 5, 2019 at 8:05 AM Arthur Gautier <baloo@gandi.net> wrote:
>
> On Tue, Nov 05, 2019 at 03:11:12PM +0100, Borislav Petkov wrote:
> > On Thu, Oct 10, 2019 at 04:49:51PM +0000, Arthur Gautier wrote:
> > > I did not receive neither the patch Andy provided, nor the comments made
> > > on it. But I'd be happy to help and/or take over to fix those if someone could
> > > send me both.
> >
> > Yes, please do, it seems Andy's busy. You can find the whole thread here:
> >
> > https://lore.kernel.org/lkml/20190215235901.23541-1-baloo@gandi.net/
> >
> > and you can download it in mbox format.
> >
> > Care to take Andy's patch, work in the comments I made to it, test it,
> > write a commit message, i.e., productize it?
> >
> > So that we get this thing moving...
> >
> > Thx.
> >
>
> Hello Boris,
>
> Thank you! But I believe this is the patch I sent, I know Andy sent a
> patchset with two patches, I believe privately (not copied to a public
> ML) to some of the recepients here. I got a copy of the second patch
> but not the first one.
>
> I believe from discussions here, that comments have been made on those
> patchset and because I was not Cc-ed on those patches, I do not have
> neither the full patchset nor the comments.
>
> I cannot take over the work, nor finish the patchset.
>
> Would anyone have a copy of the thread and could send them my way?
>

I forwarded it to you.

Here are the patches in git:

https://git.kernel.org/pub/scm/linux/kernel/git/luto/linux.git/log/?h=task_size

it's "unaligned", "fix test sparse warning", optionally
"strncpy_from_user: Zero any extra output bytes that get written",
"uaccess: Add a selftest for strncpy_from_user()", and
"strncpy_from_user: Don't overrun the input buffer onto the next page"

The basic summary is that Linus didn't like calling it bug fix, but it
might be acceptable as an improvement.  I also thought that the
KERNEL_DS oops was changed so it didn't trigger here.
