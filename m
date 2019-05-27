Return-Path: <SRS0=8QAT=T3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 561F8C04AB3
	for <linux-kernel@archiver.kernel.org>; Mon, 27 May 2019 15:49:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 12B6920815
	for <linux-kernel@archiver.kernel.org>; Mon, 27 May 2019 15:49:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="NxY0TLbp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726741AbfE0Pt6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 May 2019 11:49:58 -0400
Received: from frisell.zx2c4.com ([192.95.5.64]:59553 "EHLO frisell.zx2c4.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726397AbfE0Pt5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 May 2019 11:49:57 -0400
X-Greylist: delayed 400 seconds by postgrey-1.27 at vger.kernel.org; Mon, 27 May 2019 11:49:57 EDT
Received: by frisell.zx2c4.com (ZX2C4 Mail Server) with ESMTP id c250ad4e
        for <linux-kernel@vger.kernel.org>;
        Mon, 27 May 2019 15:13:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=zx2c4.com; h=mime-version
        :references:in-reply-to:from:date:message-id:subject:to
        :content-type; s=mail; bh=kHnd1JT4Od4VGrch3hXC3ov+0w0=; b=NxY0TL
        bp41+jikqYCnnvfJIM0H3C0IWxgq34zh+7u8JzbUxtFOpb9kmLnV9G8GKLSt47DL
        gEIkvNdzeivnmhkoesK0hMVjisqQxnzZ0t6n5z1kaKOx3q+a0upmIC6bqLAvmDRS
        UZNPWDPf+bd+947NHWhokQlJIeg/WE8ccaHiuszl3duwj7HEhLZmjAh+lndaXfRU
        JCnddj09t+ctMWeq4KJ676sAfufeDoQXQfnlPXCcfioOHo0I7zKkGPdV5XRNrKDe
        RiIQVNw7MN+WSKYKgVB24VqgoIHjAoJEV9ZIhBrPCCvB3UCatCVaHXPcimHaH60Q
        a1N6cDJ16oa/qrhw==
Received: by frisell.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id eb96b252 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256:NO)
        for <linux-kernel@vger.kernel.org>;
        Mon, 27 May 2019 15:13:03 +0000 (UTC)
Received: by mail-ot1-f45.google.com with SMTP id l25so15139803otp.8
        for <linux-kernel@vger.kernel.org>; Mon, 27 May 2019 08:43:16 -0700 (PDT)
X-Gm-Message-State: APjAAAUxFZgQCndf7Yekm5NN8KTa80ma5ECIwwRsM2O1chn6yVH4ebSb
        lbDDpltxFDbGn6QL5/xt1felTgDSnxHvV1aRWQI=
X-Google-Smtp-Source: APXvYqwSkmBzEbx09qA71YbHv3/5khjCRUWXKEIgS3R2RImfzEbI5tP1NgdUDTf8hdqtX5DV5A4t0ZmrX6RWqYONAko=
X-Received: by 2002:a9d:7154:: with SMTP id y20mr5894480otj.369.1558971794577;
 Mon, 27 May 2019 08:43:14 -0700 (PDT)
MIME-Version: 1.0
References: <20190527122627.GA15618@u> <20190527140643.GB8585@mit.edu>
In-Reply-To: <20190527140643.GB8585@mit.edu>
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
Date:   Mon, 27 May 2019 17:43:03 +0200
X-Gmail-Original-Message-ID: <CAHmME9qvdKy6zCHQEUp1zp-dL0Sco1Ujtn7jXK=EFde_yDx8wA@mail.gmail.com>
Message-ID: <CAHmME9qvdKy6zCHQEUp1zp-dL0Sco1Ujtn7jXK=EFde_yDx8wA@mail.gmail.com>
Subject: Re: [PATCH] random: urandom reads block when CRNG is not initialized.
To:     "Theodore Ts'o" <tytso@mit.edu>,
        Naveen Nathan <naveen@lastninja.net>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Kevin Easton <kevin@guarana.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 27, 2019 at 4:07 PM Theodore Ts'o <tytso@mit.edu> wrote:
>
> This is guaranteed to cause the system to fail for systems using
> systemd.  (Unless you are running an x86 with random.trust_cpu=1 ---
> in which case, this patch/config is pointless.)  And many embedded
> systems *do* use systemd.  I know lots of people like to wish that
> systemd doesn't exist, but we need to face reality.
>
> *Seriously,* if this is something the system builder should be using,
> they should be fixing userspace.  And if they care enough that they
> would want to enable this patch, they could just scan dmesg looking
> for the warnings from the kernel.

Really, it's a chicken & egg thing. If people who make userspaces
never have an option to design around the correct behavior, they'll
continue to rely on the broken behavior. But if we give them a way to
compile their kernels with the correct behavior, eventually some
userspaces will run fine with it. "But they should just use
getrandom()!" you shout. Yes, and maybe the code most userspace
builders provide does do this. But people like to plug-in plenty of
third party things into their userspaces, and I think there's some
value in a userspace being able to say, "we've dealt with the
/dev/urandom situation, and we now do the right thing, so we can
enable this option, and now the code you run on our userspace will
give good randomness."

More concretely, distros might ship an init system that allows
enabling this option without creating issues. Systemd might improve.
OpenRC and runit-based distros appear to exist. Some folks do very
custom stuff. If they manage to make it work with the correct urandom
behavior, then that's a good situation for everything else to build
on, and for providing better guarantees for third party software that
runs on that distro. But none of this is possible without the ability
to compile the kernel with the correct behavior.
