Return-Path: <SRS0=LLNM=ZF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14D0DC432C3
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Nov 2019 21:20:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DDF95206E3
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Nov 2019 21:20:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573680004;
	bh=L+TN6BUp/T/t1la8WXfMtze08wb7dU95r8CNi1MLDrA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=WUh7dX1oRjr7RkvS2Xty3n3FtljSW8P0d2nouIMPeKcFyz7an2QVj9R8TLJE/joJX
	 PoqBUBOUnCNNPexoMUxkzHLlVF8GPgN1eiU70b6Yvhh9KFjlvZa/Y8XLm6F1jPKk0V
	 jIEHJxzQfhX8gnWG188aRcO1crCoZStCQPRoK8Bc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726923AbfKMVUC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Nov 2019 16:20:02 -0500
Received: from mail-lf1-f66.google.com ([209.85.167.66]:40742 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726189AbfKMVUC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Nov 2019 16:20:02 -0500
Received: by mail-lf1-f66.google.com with SMTP id j26so3155495lfh.7
        for <linux-kernel@vger.kernel.org>; Wed, 13 Nov 2019 13:20:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=v8ORmxzsuP2C1Sn3+5NftPa+AfiyXCDEczRveJww11Y=;
        b=SOIRxj3b+5OtovTjGW3LO4LFdC6Bt+5P06OtuzUqFvJUI0G5M19Cp7lObrME6gAsTm
         iFg8wUHbOUp5NhyCAEY4N3PZL/rNF9PTGbYzXV75MgiLgLvVNkrA0U+CJa41F7CWdLUM
         7nm8PbxakjFOrafO8gPm1BxTZ8yhbvbP8XmJM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=v8ORmxzsuP2C1Sn3+5NftPa+AfiyXCDEczRveJww11Y=;
        b=SFtT+GvjhsZUNPROw4ZeFqxXW1KcFyndVXWOGWQo3YsnMZ+KXi96Wm1kPHvd3twrxm
         K1RLxD9hYnUl3LiMCgcSUy8479Jk63OVEB4NRVjxzDjdqOwWspfMHHNcAa9M9ge3ruX3
         lGmP4z3molvAhLEcG7Y1GvfJMelZ0svC9TMs/vc+EpfR7nzOSygrnz6RAixcq0UXaY3M
         fKOrXiJXLVOpKe/BsaCJCY5uWF3y4qum+Aefg+7Y28hDzhYz11/soQBXGsd+4NZzghUJ
         C8ngguyxQVrRY+hFEmqeLConvNuadYJUTTvRgNCoxOQgXHl9vBoSr98XFh5JKYi5vjwA
         vt/g==
X-Gm-Message-State: APjAAAWyBvENF3TEIyqWkHU6hrsOVAFXVa/KoFIRyvasztGDg+e2mqiX
        OSlRNhNh+e/jWhegNrR8X1Iq5A/Notk=
X-Google-Smtp-Source: APXvYqyOnxhCd2uJ87CjFpkS0m8uYRjLAjOPXqjVXem8PkW9YdP8qpTumUepRiM9GAZKmkKkS1zJ0w==
X-Received: by 2002:a19:ee17:: with SMTP id g23mr4112992lfb.121.1573680000065;
        Wed, 13 Nov 2019 13:20:00 -0800 (PST)
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com. [209.85.167.42])
        by smtp.gmail.com with ESMTPSA id u12sm1517161lje.1.2019.11.13.13.19.58
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Nov 2019 13:19:59 -0800 (PST)
Received: by mail-lf1-f42.google.com with SMTP id d6so3180425lfc.0
        for <linux-kernel@vger.kernel.org>; Wed, 13 Nov 2019 13:19:58 -0800 (PST)
X-Received: by 2002:ac2:498a:: with SMTP id f10mr4156804lfl.170.1573679998700;
 Wed, 13 Nov 2019 13:19:58 -0800 (PST)
MIME-Version: 1.0
References: <20191113204240.767922595@linutronix.de> <20191113210104.882617091@linutronix.de>
In-Reply-To: <20191113210104.882617091@linutronix.de>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 13 Nov 2019 13:19:42 -0800
X-Gmail-Original-Message-ID: <CAHk-=wh9BdH5DLjfv72LOWSb6P1jMwO0TYraS1gnYZDdTCi+rQ@mail.gmail.com>
Message-ID: <CAHk-=wh9BdH5DLjfv72LOWSb6P1jMwO0TYraS1gnYZDdTCi+rQ@mail.gmail.com>
Subject: Re: [patch V3 12/20] x86/ioperm: Move TSS bitmap update to exit to
 user work
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Stephen Hemminger <stephen@networkplumber.org>,
        Willy Tarreau <w@1wt.eu>, Juergen Gross <jgross@suse.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 13, 2019 at 1:02 PM Thomas Gleixner <tglx@linutronix.de> wrote:
>
> From: Thomas Gleixner <tglx@linutronix.de>
>
> There is no point to update the TSS bitmap for tasks which use I/O bitmaps
> on every context switch. It's enough to update it right before exiting to
> user space.

Hmm.

I wonder if it might make sense to delay it even more: just always
invalidate the bitmap on task switch, and leave it at that.

And then on GP fault, just add trivial logic like

     if (I_have_an_io_bitmap && it_isnt_installed) {
          install_io_bitmap();
          return;
     }

and now you do get that extra GP fault if you actually use IO
accesses, but the normal case has zero overhead.

Even processes that do ioperm may not be *using* it all the time.

               Linus
