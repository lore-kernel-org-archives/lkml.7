Return-Path: <SRS0=K12x=T4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_HIGH
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74C55C04AB6
	for <linux-kernel@archiver.kernel.org>; Tue, 28 May 2019 14:15:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4E0DA214D8
	for <linux-kernel@archiver.kernel.org>; Tue, 28 May 2019 14:15:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1559052952;
	bh=ShG2/A4FhAdJT2qz7S9PLDbLpRAkQ9u+na8LsK0DQiE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=oMltWsIDoOS5k9hQZk7ByA8rmyGIdzrbuLgU3EyMruD+nivggxfxsRKDNls8jQKp/
	 kroSOKf1Iga3L401uuyggS/6xe+mny8hQlGQGneE1j3RAZDxhrMC0kIAgLudXFk4oh
	 9SD3VboA9SDjjHAOSiU0Qrf09tFsxF9g2Vx5unPs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727521AbfE1OPv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 May 2019 10:15:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:51910 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726609AbfE1OPu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 May 2019 10:15:50 -0400
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0A6E12166E
        for <linux-kernel@vger.kernel.org>; Tue, 28 May 2019 14:15:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559052950;
        bh=ShG2/A4FhAdJT2qz7S9PLDbLpRAkQ9u+na8LsK0DQiE=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=GJTKDDF+J9W2jQ2ltlRcnLaUPQBFyjPwO/wr2Qa6Cg1D4D57zmpvMKE0Q3SX0g2f9
         CJch0bUCjsjTxpk4vqRWfTIgc3alFotcKHDW7HbtxNKu2jvuXsvJL2yliaes0/tXCW
         XTI9+oTumWtnhio02F73CPayKYzg6wuCRL+xR/yM=
Received: by mail-wm1-f42.google.com with SMTP id i3so3138567wml.4
        for <linux-kernel@vger.kernel.org>; Tue, 28 May 2019 07:15:49 -0700 (PDT)
X-Gm-Message-State: APjAAAVKXzW8GFbo5e7LxEiw3Zg7M8wEszZSdF83KyDWJI8gNwMrot5Q
        6VTBQovflaSZXHAM3+5GR4/7yeoPv4tiqHF8vcdH1w==
X-Google-Smtp-Source: APXvYqzHYVceZheAVerV2ekvUbJezegITYz8MIBHeHUVXV67u+i/W2eLkCxvOK/ZV7DgVAnNqs9uOhjrd4aEQEwLE7E=
X-Received: by 2002:a1c:d10e:: with SMTP id i14mr3649123wmg.161.1559052948518;
 Tue, 28 May 2019 07:15:48 -0700 (PDT)
MIME-Version: 1.0
References: <20190526102612.6970-1-christian@brauner.io> <CAHk-=wieuV4hGwznPsX-8E0G2FKhx3NjZ9X3dTKh5zKd+iqOBw@mail.gmail.com>
 <20190527104239.fbnjzfyxa4y4acpf@brauner.io> <CAHk-=wjnbK5ob9JE0H1Ge_R4BL6D0ztsAvrM6DN+S+zyDWE=7A@mail.gmail.com>
 <20190528100802.sdfqtwrowrmulpml@brauner.io>
In-Reply-To: <20190528100802.sdfqtwrowrmulpml@brauner.io>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Tue, 28 May 2019 07:15:37 -0700
X-Gmail-Original-Message-ID: <CALCETrU0wXuefHFzRNrQjQ+xgTz6tbPa-sLcBV=dV58QEcA6HQ@mail.gmail.com>
Message-ID: <CALCETrU0wXuefHFzRNrQjQ+xgTz6tbPa-sLcBV=dV58QEcA6HQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] fork: add clone6
To:     Christian Brauner <christian@brauner.io>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        Jann Horn <jannh@google.com>,
        Florian Weimer <fweimer@redhat.com>,
        Oleg Nesterov <oleg@redhat.com>, Arnd Bergmann <arnd@arndb.de>,
        David Howells <dhowells@redhat.com>,
        Pavel Emelyanov <xemul@virtuozzo.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Adrian Reber <adrian@lisas.de>,
        Andrei Vagin <avagin@gmail.com>,
        Linux API <linux-api@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 28, 2019 at 3:08 AM Christian Brauner <christian@brauner.io> wrote:
>
> On Mon, May 27, 2019 at 12:27:08PM -0700, Linus Torvalds wrote:
> > On Mon, May 27, 2019 at 3:42 AM Christian Brauner <christian@brauner.io> wrote:
> > >
> > > Hm, still pondering whether having one unsigned int argument passed
> > > through registers that captures all the flags from the old clone() would
> > > be a good idea.
> >
> > That sounds like a reasonable thing to do.
> >
> > Maybe we could continue to call the old flags CLONE_XYZ and continue
> > to pass them in as "flags" argument, and then we have CLONE_EXT_XYZ
> > flags for a new 64-bit flag field that comes in through memory in the
> > new clone_args thing?
>
> Hm. I think I'll try a first version without an additional register
> flags argument. And here's why: I'm not sure it buys us a lot especially
> if we're giving up on making this convenient for seccomp anyway.
> And with that out of the way (at least for the moment) I would really
> like to make this interface consistent. But we can revisit this when I
> have the code.
>

Seems reasonable.  Once the interface is nailed down, we can see if it
makes sense to break out some flags into a register.  I would guess
that all the unsharing flags are a good candidate.
