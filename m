Return-Path: <SRS0=8t7v=ZS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C12EC432C0
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Nov 2019 03:35:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 49A29206F4
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Nov 2019 03:35:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574739310;
	bh=sitL2YUUfgp8T2XIkMioXQxBojLRzd++dJKNSqPdmRw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=zb+kETjyVAnjmAHmzeszTH4rlEfC3/79sYleoYgHNhOHc5HdgiltvFGJg4DMqFLyq
	 bQB5+VEpSg+NSVbGekPAgZeM83ALoLq1uAfZ0kAtl9WoVdb6mdf9Chq1uqzPoY8AAD
	 TCPcyEg/WzDuN6AMlzwiFeSLUC9dFeWQ56crvw/E=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727286AbfKZDfJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Nov 2019 22:35:09 -0500
Received: from mail-lf1-f65.google.com ([209.85.167.65]:44233 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726962AbfKZDfI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Nov 2019 22:35:08 -0500
Received: by mail-lf1-f65.google.com with SMTP id v201so11757746lfa.11
        for <linux-kernel@vger.kernel.org>; Mon, 25 Nov 2019 19:35:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=QAsbatHetIYu7IpZnpElY/9AbQdSftUbSJrBDOCvXM0=;
        b=DG7G+WpYZwC1Yf9w/IXlwSm2PXKyPA9N12zDYr5fhKCt8mjbpZ7lRFkRwWkjNxnP3A
         rOb0Os3jYSFZkHLA35waGuSmCQJ1fZ34rjluiQU0RLmnsPtpVB53yJV3TyeapjGgRFBT
         4Uew/6e3ELQfD63IoD7aqKY4BS2r2CL8sTrxY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QAsbatHetIYu7IpZnpElY/9AbQdSftUbSJrBDOCvXM0=;
        b=o3rrfP6k+lTQk3qyY61GvL1FRF1oQWm2MEigR0NOeqKrriqmLYDnFJyAf1iT5N3jBd
         XMxcuKo7fHnn5mwX80NLLQIEB20fUPSU30Jrnl1AVnRHDijKAV3Xa+p6Ot16i2+Ut2Xw
         emT668krTI0M3eFFPZzRxzxfbmo9+IWZ5ZZpfAeN61BxDFqUFBcpMHP3ViqtLmGfJFqs
         N7xRJ/9xtcleyMHEX0oGDteaoxs5Y4B9hD61OpAgqTjypyC3x1prpx9ODtfisDuIdKC1
         3nSJ2jt33Vhm0BdXT2m931hi97UEuMJtHM5lGXhbQi1xVWpEBlaHsnzkd/9KD/V4PiFb
         mFOA==
X-Gm-Message-State: APjAAAW018VnBmkXG0ByN8ubjLIY/sBnetRwhKExZ7RrHNEHvQAogedL
        SdIDs65O3TbKC9Rao14aUsarBokQcu4=
X-Google-Smtp-Source: APXvYqzpb6xW3oEXRZy+g9U4vznEzV2DwFs9S/ksE/CyltyQQm63Dx5Py3BpmMZEb7PKkmd7rbeesg==
X-Received: by 2002:a05:6512:4db:: with SMTP id w27mr22967600lfq.4.1574739306304;
        Mon, 25 Nov 2019 19:35:06 -0800 (PST)
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com. [209.85.208.176])
        by smtp.gmail.com with ESMTPSA id y6sm4731207ljm.95.2019.11.25.19.35.04
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 Nov 2019 19:35:05 -0800 (PST)
Received: by mail-lj1-f176.google.com with SMTP id y23so18389235ljh.10
        for <linux-kernel@vger.kernel.org>; Mon, 25 Nov 2019 19:35:04 -0800 (PST)
X-Received: by 2002:a05:651c:331:: with SMTP id b17mr24854198ljp.133.1574739304698;
 Mon, 25 Nov 2019 19:35:04 -0800 (PST)
MIME-Version: 1.0
References: <alpine.DEB.2.21.1911251322160.2408@hp-x360n> <CAHk-=wj_nbDN3piDJBEteUrjyrZCTA+CCk15NfV=5D2xFfGJGw@mail.gmail.com>
 <CAHk-=whn2Dp44tjUpLo9ogs=p-v-Vn7c2Xdo4p+2V=d1hTaiuA@mail.gmail.com> <CAHk-=wj3YSFT+C3n=7CTsB-8U0NUpTpT3xEH866H4-1qbQGw7Q@mail.gmail.com>
In-Reply-To: <CAHk-=wj3YSFT+C3n=7CTsB-8U0NUpTpT3xEH866H4-1qbQGw7Q@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 25 Nov 2019 19:34:48 -0800
X-Gmail-Original-Message-ID: <CAHk-=wjc8ri9Y2hkirG9XjiVNaaq4jyxdpD15SJC2ur4GVCotA@mail.gmail.com>
Message-ID: <CAHk-=wjc8ri9Y2hkirG9XjiVNaaq4jyxdpD15SJC2ur4GVCotA@mail.gmail.com>
Subject: Re: Commit 0be0ee71 ("fs: properly and reliably lock f_pos in
 fdget_pos()") breaking userspace
To:     "Kenneth R. Crudup" <kenny@panix.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Kirill Smelkov <kirr@nexedi.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 25, 2019 at 7:21 PM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> Anyway, I think the thing to do (for now) is to just say "character
> devices are FMODE_STREAM files if they have no llseek operations".
> That should take care of both tty's and the sound devices.

A cleaner thing might be to add an explicit field to 'struct
file_operations' to show that it is a stream operation. That would
make it much easier for drivers to say "mark me as a stream" without
having to change their open routines (not all cases might even have
open routines).

The file operations already have a history of this kind of "this is
what I support" flags with the "mmap_supported_flags" mask, which is a
different (but at the same time somewhat similar) set of "this is the
set of operations I support" thing. FMODE_STREAM wouldn't be that
different.

Anyway, I was clearly too optimistic as to how painless this would be.
I tested it on my desktop and laptop, but they have very similar
setups other than their form factor, so the fact that neither showed
any issues was perhaps not all that meaningful.

              Linus
