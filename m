Return-Path: <SRS0=TvG7=UK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,T_DKIMWL_WL_HIGH autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F577C43218
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 04:55:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F394F2086D
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 04:55:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1560228938;
	bh=VdGa6wSoL+22BZ+sm2TYAjWTOA+mGM3ZjWBOrVYWcmU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=rmVyD0KE3A0E/WL9ZYRabYX7o+R0G55SFsx+5E7Q9agELg7MBw85MT7tDlOU48aSc
	 BikFMPzC8i6WuNTuHCfhDzrA0foIzDG9SRNFCgcShCdktreQW/9NF5lTys8WaRGd4G
	 uixC7PdH8aw/WcOKa4Cu04bCok4bRMcsDa1UM6rU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391133AbfFKEzg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Jun 2019 00:55:36 -0400
Received: from mail-lj1-f174.google.com ([209.85.208.174]:36357 "EHLO
        mail-lj1-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390081AbfFKEzg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jun 2019 00:55:36 -0400
Received: by mail-lj1-f174.google.com with SMTP id i21so10167949ljj.3
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jun 2019 21:55:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+0NVFIKvZo+cTD+d9Ui7mDkyi5Oxsx4RGqTwt9X3ykk=;
        b=J42kFBk4S2k8nsKBY9fwhx/vZSEYU/OLrOlYGuYtsIl7R1OW7G6cP1AqGwj2+yGLg2
         EYdlAVSm3K888i1Z/0BN2vG2wscFrXTIpee8gDD08eNXZ7Iutd7Co9x7wrC2XzSTo6Wr
         D0e1tE4Z4fwwQjCOh4OvXBe5BDfZKYbAU0USA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+0NVFIKvZo+cTD+d9Ui7mDkyi5Oxsx4RGqTwt9X3ykk=;
        b=NCQNep3gNqDa/EZUXUvgPh+B3aQ/ShnI0FzforyY8VAUcNAEIB8Vz71PdfeffPnLSh
         /K8P+5c4Z7VlZ9HE7CYeQfCtfuXM/dUEk5Ni3WHBR02sExvgdgNAyT5OaYnAv0ZnfVmP
         Egef4SXeydORuVS1JxR4FUwDoI6ouR/L+quXYgvd32/j3/0JzNYk3oWz64qXW7e3eeR5
         Qj9VepEjmWnu0IUTlVkqwSelWjFB8kH6oiTDK8oTgjanGEFzeLulWvt3xONwED7zW9F/
         Go7OK/IYuhuWBgCLR6vPcC1VphQ7unoN9fyCZIRXBUjOkjyEUoslEDha+ZwtTaD8nvIo
         4v/A==
X-Gm-Message-State: APjAAAUHe3+2nlAEUR1pP4hDUVDJoYDr8gmKKWBMpTNQFwTLUjRG5d/R
        a6IPobouYbIXjqs2EWq8LrtpCkis2+U=
X-Google-Smtp-Source: APXvYqw6DmkKRlHEEnUb6GqwZZ2McFPYhd4mbhzN4FL/NRtbmmIzImjVPONuG+tzrCxyZ3IgtGMR1Q==
X-Received: by 2002:a2e:9dca:: with SMTP id x10mr7195153ljj.17.1560228933691;
        Mon, 10 Jun 2019 21:55:33 -0700 (PDT)
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com. [209.85.208.182])
        by smtp.gmail.com with ESMTPSA id s20sm2297017lfb.95.2019.06.10.21.55.32
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Mon, 10 Jun 2019 21:55:32 -0700 (PDT)
Received: by mail-lj1-f182.google.com with SMTP id s21so10171516lji.8
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jun 2019 21:55:32 -0700 (PDT)
X-Received: by 2002:a2e:9c03:: with SMTP id s3mr23108926lji.209.1560228931996;
 Mon, 10 Jun 2019 21:55:31 -0700 (PDT)
MIME-Version: 1.0
References: <20190610191420.27007-1-kent.overstreet@gmail.com>
 <CAHk-=wi0iMHcO5nsYug06fV3-8s8fz7GDQWCuanefEGq6mHH1Q@mail.gmail.com> <20190611011737.GA28701@kmo-pixel>
In-Reply-To: <20190611011737.GA28701@kmo-pixel>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 10 Jun 2019 18:55:15 -1000
X-Gmail-Original-Message-ID: <CAHk-=wizTF+NbMrSRG-bc-LyuT7PUJ1QRAR8q_anOd6mY+9Z4A@mail.gmail.com>
Message-ID: <CAHk-=wizTF+NbMrSRG-bc-LyuT7PUJ1QRAR8q_anOd6mY+9Z4A@mail.gmail.com>
Subject: Re: bcachefs status update (it's done cooking; let's get this sucker merged)
To:     Kent Overstreet <kent.overstreet@gmail.com>
Cc:     Dave Chinner <dchinner@redhat.com>,
        Waiman Long <longman@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-bcache@vger.kernel.org,
        "Darrick J . Wong" <darrick.wong@oracle.com>,
        Zach Brown <zach.brown@ni.com>, Jens Axboe <axboe@kernel.dk>,
        Josef Bacik <josef@toxicpanda.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Tejun Heo <tj@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 10, 2019 at 3:17 PM Kent Overstreet
<kent.overstreet@gmail.com> wrote:
>
>
> > Why does the regular page lock (at a finer granularity) not suffice?
>
> Because the lock needs to prevent pages from being _added_ to the page cache -
> to do it with a page granularity lock it'd have to be part of the radix tree,

No, I understand that part, but I still think we should be able to do
the locking per-page rather than over the whole mapping.

When doing dio, you need to iterate over old existing pages anyway in
that range (otherwise the "no _new_ pages" part is kind of pointless
when there are old pages there), so my gut feel is that you might as
well at that point also "poison" the range you are doin dio on. With
the xarray changes, we might be better at handling ranges. That was
one of the arguments for the xarrays over the old radix tree model,
after all.

And I think the dio code would ideally want to have a range-based lock
anyway, rather than one global one. No?

Anyway, don't get me wrong. I'm not entirely against a "stop adding
pages" model per-mapping if it's just fundamentally simpler and nobody
wants anything fancier. So I'm certainly open to it, assuming it
doesn't add any real overhead to the normal case.

But I *am* against it when it has ad-hoc locking and random
anti-recursion things.

So I'm with Dave on the "I hope we can avoid the recursive hacks" by
making better rules. Even if I disagree with him on the locking thing
- I'd rather put _more_stress on the standard locking and make sure it
really works, over having multiple similar locking models because they
don't trust each other.

               Linus
