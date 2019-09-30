Return-Path: <SRS0=rUXN=XZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9D62C4360C
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Sep 2019 02:59:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B045D2086A
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Sep 2019 02:59:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1569812380;
	bh=JV3Yyv2vKbQfyl+c6wyBYlHwi45J+/QmwVrUq/F5V/A=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=jQEWJRBx+4fgcozzxfuOMAQfq+dbaX+ffrGGQQbjGCszynTtj1jldk6CQyu/4xChG
	 BPsDhP38t5CzYpxmuIw/r2THBWi0DBbblLpktrcpytuRLJ6ZCTLWMDqgcl3YT+HY7L
	 WJyf6WrvlC9sgruUaNqhmT3dzRbYzAjy8WCZ5cYA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729431AbfI3C7j (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 29 Sep 2019 22:59:39 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:46097 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729141AbfI3C7j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Sep 2019 22:59:39 -0400
Received: by mail-lf1-f65.google.com with SMTP id t8so5783154lfc.13
        for <linux-kernel@vger.kernel.org>; Sun, 29 Sep 2019 19:59:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=P8sBoP646L1OEWcvnWkJGgkenZ+dxhfC8IlHdOgrXJk=;
        b=Q6O+OiLBGvkUpVfSHAOaI856ArlcP9Ce7NvnGxWdYO5zwayQO/aRldolp2suqmlATi
         hPK7V/N3Bf2jevq0x3LUQe83o7ZVBaUYhlpcY6VttoyD3M/og5J0Pr2s6S92MmFz/VoW
         FoONXg9Y5/CBZjNaUOFcsm4fHC7qeNiQz3iaU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=P8sBoP646L1OEWcvnWkJGgkenZ+dxhfC8IlHdOgrXJk=;
        b=qkAbiSeP25MO44z+QEy3MFwzIYcic/xX6022VjgwDSqld1PxjNJv3Rv12MWascWL8j
         Pm8q8nlRURC1pU6ANPsYn4CcpjGDpchcXgFP+QVBtH3pYpIFkWd4AINe/vGIUT4xzq1o
         HxDywvRoUnsJzno2bHBICSVFRx1u6nY8wWNNg6XfSe+NHYAm+C9o/rfBB4kGclmc6bZZ
         ymzl7H4xXewxINdG7wlqKXDGnEqDlcsQpUOUwmRZtGr1uKfUCWCv4JdIeW7MeY3yC2eV
         ZyB8K0U/mWZJUG9tt+OTnXfiKCac8Q3JhWb0EbUvut76kpvqV8lpupkHiWyD8aZHlCDE
         8zjw==
X-Gm-Message-State: APjAAAVt7nuTMKw2xLbNMptOFCqeGN/yY6p22XzO1iXbt2wz4p5Et1xL
        2eLFQJ97pbGw4LwU5QP4kWJWGeLZyfI=
X-Google-Smtp-Source: APXvYqzvOcK5rucAPUUrXQPLEErQbR0GhJ1Tw/oN35g4308G8IlXZBGjXoVKVSm0cO/7jPVN9svvig==
X-Received: by 2002:ac2:4552:: with SMTP id j18mr1180299lfm.120.1569812376962;
        Sun, 29 Sep 2019 19:59:36 -0700 (PDT)
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com. [209.85.208.176])
        by smtp.gmail.com with ESMTPSA id z72sm2755149ljb.98.2019.09.29.19.59.36
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 29 Sep 2019 19:59:36 -0700 (PDT)
Received: by mail-lj1-f176.google.com with SMTP id m13so7746769ljj.11
        for <linux-kernel@vger.kernel.org>; Sun, 29 Sep 2019 19:59:36 -0700 (PDT)
X-Received: by 2002:a2e:2c02:: with SMTP id s2mr10635284ljs.156.1569812375672;
 Sun, 29 Sep 2019 19:59:35 -0700 (PDT)
MIME-Version: 1.0
References: <alpine.DEB.2.21.1909290010500.2636@nanos.tec.linutronix.de>
 <CAHk-=wgjC01UaoV35PZvGPnrQ812SRGPoV7Xp63BBFxAsJjvrg@mail.gmail.com> <CAHk-=wi0vxLmwEBn2Xgu7hZ0U8z2kN4sgCax+57ZJMVo3huDaQ@mail.gmail.com>
In-Reply-To: <CAHk-=wi0vxLmwEBn2Xgu7hZ0U8z2kN4sgCax+57ZJMVo3huDaQ@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 29 Sep 2019 19:59:19 -0700
X-Gmail-Original-Message-ID: <CAHk-=whKhD-GniDqpRhhF=V2cSxThX56NAdkAUoBkbp0mW5=LA@mail.gmail.com>
Message-ID: <CAHk-=whKhD-GniDqpRhhF=V2cSxThX56NAdkAUoBkbp0mW5=LA@mail.gmail.com>
Subject: Re: x86/random: Speculation to the rescue
To:     Thomas Gleixner <tglx@linutronix.de>,
        "Ahmed S. Darwish" <darwish.07@gmail.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        "Theodore Ts'o" <tytso@mit.edu>,
        Nicholas Mc Guire <hofrat@opentech.at>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Kees Cook <keescook@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 29, 2019 at 6:16 PM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> But I've committed that patch and the revert of the ext4 revert to a
> local branch, I'll do some basic testing of it (which honestly on my
> machines are kind of pointless, since all of them support rdrand), but
> assuming it passes the basic smoke tests - and I expect it to - I'll
> merge it for rc1.

All my smoke testing looked fine - I disabled trusting the CPU, I
increased the required entropy a lot, and to actually trigger the
lockup issue without the broken user space, I made /dev/urandom do
that "wait for entropy" thing too.

It all looked sane to me, and the urandom part also had the side
effect of then silencing all the "reading urandom without entropy"
warning cases as expected.

So it's merged.

Note that what I merged did _not_ contain the urandom changes, that
was purely for my testing. But it might well be a reasonable thing to
do at some point.

Of course, whether this jitter-entropy approach is reasonable in the
first place ends up likely being debated, but it does seem to be the
simplest way forward.

           Linus
