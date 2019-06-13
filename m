Return-Path: <SRS0=5wok=UM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20D65C31E45
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 16:06:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EBAB620679
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 16:06:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=globallogic.com header.i=@globallogic.com header.b="OhQ1gd9h"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391256AbfFMQF5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Jun 2019 12:05:57 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:36000 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391035AbfFMQFw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jun 2019 12:05:52 -0400
Received: by mail-ed1-f66.google.com with SMTP id k21so28615271edq.3
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jun 2019 09:05:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=globallogic.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mLABAOBxUi7apPgtRPROSyumsCPedDiB3eVS3aen4Uc=;
        b=OhQ1gd9hI7gUmtNiW/OqjsHiQzwW6iZW8IGNtHnPK8zug5HhC3kYfdVVJXheeoRaC6
         tbmDhYFOS083pJUz6jcfjmqIHLpaa597AhPSvEEAQBLMcwwRZdZ9O7lGn8Jrx1FkCvdA
         RfoNRWL1Q1taE5K1YXiR/zwm5WR9EoJjDgXouRhoyKnyxhNXGKOCVqG682PKrplC0mP1
         Qpfiw8SI/tUrfiIzQe/qG1BF+PWPkB7bpYVgOpQ13Zx0Rbd4MCnxbKjoLNKRwofxot0+
         wUn9KJjxcqacAAr3a+vEKvbp/n79eMo2Fiugl2fTd1aDgFw1RPt3MF66M1s1hvXWy13C
         7JuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mLABAOBxUi7apPgtRPROSyumsCPedDiB3eVS3aen4Uc=;
        b=s0e/Ci0MhSoV4RmEyZfb8bFmJ7Y0LBWOGtVMXOoyYc7WDk1vD7oCtJmjNGh8zoXccb
         0hQptiPw8zXvi8scIZTKI+jHysEuO08xVbD93p0EbBWzAeSEfIBOMq5GsJJkHdYzuRZC
         bBjMo0KIuDpUpUuzH2fE7U+nL1B9iIO0BKNgZaDb+dgInxzPHSfqUowJEH63TJ2W14Dz
         4lcwdCdT0MVIytAiO+MW9JAbN+Axl+yC1lFtUoQaTgM0fSf7CLwAhQOSxMfUcgXe5uxN
         E5xDrWQtFqPhIkW7W9EfIFZXC0mgpZFifufWg+a3BXnEaexuHmyNIcFnLv+h2SpMr2x/
         829w==
X-Gm-Message-State: APjAAAWXipI0K31XCKTuSOl+tBLJLWbL3+ZTmcXTWlAm3blSiEd18fjs
        8DXMxlETTkumuIA5wWwLHOAQAOpC5WNiQySwKP06GQ==
X-Google-Smtp-Source: APXvYqw9eTL1smFdgM5CBMWe55qQwq7Ixm6mxLmSKQlk/U+TTmtbbBQA33hoHb3lK2Sjp3Q8KGTRfudgroyIOzz5krs=
X-Received: by 2002:a50:9918:: with SMTP id k24mr47972367edb.173.1560441949919;
 Thu, 13 Jun 2019 09:05:49 -0700 (PDT)
MIME-Version: 1.0
References: <20190612163144.18486-1-roman.stratiienko@globallogic.com>
 <20190612163144.18486-2-roman.stratiienko@globallogic.com>
 <20190613135241.aghcrrz7rg2au3bw@MacBook-Pro-91.local> <CAODwZ7v=RSsmVj5GjcvGn2dn+ejLRBHZ79x-+S9DrX4GoXuVaQ@mail.gmail.com>
 <adc59944-7654-ea38-8dfc-f91361a80987@redhat.com>
In-Reply-To: <adc59944-7654-ea38-8dfc-f91361a80987@redhat.com>
From:   Roman Stratiienko <roman.stratiienko@globallogic.com>
Date:   Thu, 13 Jun 2019 19:05:38 +0300
Message-ID: <CAODwZ7u+f9vco8h1ZAwwoCefB6kM9gi4L_Mc7muLXYkwHRVc8Q@mail.gmail.com>
Subject: Re: [PATCH 2/2] nbd: add support for nbd as root device
To:     Eric Blake <eblake@redhat.com>
Cc:     Josef Bacik <josef@toxicpanda.com>, linux-kernel@vger.kernel.org,
        nbd@other.debian.org,
        Aleksandr Bulyshchenko <A.Bulyshchenko@globallogic.com>,
        linux-block@vger.kernel.org, axboe@kernel.dkn.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 13, 2019 at 6:14 PM Eric Blake <eblake@redhat.com> wrote:
>
> On 6/13/19 9:45 AM, Roman Stratiienko wrote:
>
> >>
> >> Just throw nbd-client in your initramfs.  Every nbd server has it's own
> >> handshake protocol, embedding one particular servers handshake protocol into the
> >> kernel isn't the answer here.  Thanks,
>
> The handshake protocol is well-specified:
> https://github.com/NetworkBlockDevice/nbd/blob/cdb0bc57f3faefd7a5562d57ad57cd990781c415/doc/proto.md
>
> All servers implement various subsets of that document for the handshake.
>
> > Also, as far as I know mainline nbd-server daemon have only 2
> > handshake protocols. So called OLD-STYLE and NEW-STYLE. And OLD-STYLE
> > is no longer supported. So it should not be a problem, or please fix
> > me if I'm wrong.
>
> You are correct that oldstyle is no longer recommended. However, the
> current NBD specification states that newstyle has two different
> flavors, NBD_OPT_EXPORT_NAME (which you used, but is also old) and
> NBD_OPT_GO (which is newer, but is more likely to encounter differences
> where not all servers support it).
>
> The NBD specification includes a compatibility baseline:
> https://github.com/NetworkBlockDevice/nbd/blob/cdb0bc57f3faefd7a5562d57ad57cd990781c415/doc/proto.md#compatibility-and-interoperability
>
> and right now, NBD_OPT_GO (and _not_ NBD_OPT_EXPORT_NAME) is the
> preferred way forward.  As long as your handshake implementation
> complies with the baseline documented there, you'll have maximum
> portability to the largest number of servers that also support the
> baseline - but not all servers are up to that baseline yet.
>
> So, this becomes a question of how much are you reinventing baseline
> portability handshake concerns in the kernel, vs. in initramfs.
>
> --
> Eric Blake, Principal Software Engineer
> Red Hat, Inc.           +1-919-301-3226
> Virtualization:  qemu.org | libvirt.org
>

Thank you for the review comments, I will address them in v2.

--
Regards,
Roman
