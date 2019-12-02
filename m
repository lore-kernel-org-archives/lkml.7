Return-Path: <SRS0=LniW=ZY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3ECF8C432C0
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Dec 2019 23:22:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1160D20718
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Dec 2019 23:22:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1575328973;
	bh=vSzUO+RJmiCpSVyWW4tK/LpH0jUWkgemDgeoZdYmNyI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=gqHu7doAh4vADe0K+MtozpNAovegHSpQdHclMFoIzXnWPf4uOX4qqusIlqgR3sGNy
	 h2gqQGOSevgzkpEdca0YTUxqMrlvvHCvoEyjclJKGEAzYaO+LDQNHmi5yDZN/IwoOH
	 FaQZqz88n00bwQCJhmrJ3TYIMp5JliPDHzzsL+qI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727110AbfLBXWw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Dec 2019 18:22:52 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:45311 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727073AbfLBXWv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Dec 2019 18:22:51 -0500
Received: by mail-lj1-f194.google.com with SMTP id d20so1447716ljc.12
        for <linux-kernel@vger.kernel.org>; Mon, 02 Dec 2019 15:22:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Zivbud+uo79674awuuW6IgbOjr9ZgzEppMzA23/d+3w=;
        b=UclclWVwgV4xGQBOpFikWRYV32woYv2h8DydWQGIKKlJaO6sY8EY4nxJo08fcognZc
         deheC2mhwyio+gu1GBFlvBcudM9owVwCIU2NYoX1t4/V4gtGiLscKYRmKWNT/nimRqlH
         YMCHJCulS4nnZJ4g1AhbL0Pc9o2mOYf7lgYmQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Zivbud+uo79674awuuW6IgbOjr9ZgzEppMzA23/d+3w=;
        b=Y1BF2ond++s34gt8MyYGDQdLCbRcwpa4gHmmT492VYSr6MKlpft8KwVx1zTw/nz5hk
         HS5b9OIpvdTSvUpofue+PtImUVBDDE8TGjvfJu/GXLAh9+1bZJM8Kk/kg2xo2gj2YuG1
         ZMDWIV6reHSXWLyGIR4MXG56EknM9DEpCDecelYBRHen9AGHaQ4nRQPEH2giKAYb+Gf1
         FtCkTT/2R618Cp72EZu3Jrz3g1ylxf3os5/4lMEc78PGLP32zHFFtLEjv5btS5CbIIeM
         1b6VQbXWzjk56Xp+q9nwaV/I1lYBaCXMTJCRYjqBpGJbMbFDKtvzNX5cpPXSNGinBYXc
         qfwA==
X-Gm-Message-State: APjAAAUSu8685Jzg7sQ7KCq20NZNV/32CgkcnPO3c9KX6XL1TJSRrBbw
        +H9H3qu2epop4RW3VB/sQV4coK88kAM=
X-Google-Smtp-Source: APXvYqx+0pe4jM7LC6vcxcxGKIn2z5lc6A7A0qkQY/WpSfEQRSE4P8lObvsEVeTjDrjbYc/rMkR1Pg==
X-Received: by 2002:a2e:2e14:: with SMTP id u20mr752976lju.120.1575328969137;
        Mon, 02 Dec 2019 15:22:49 -0800 (PST)
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com. [209.85.167.42])
        by smtp.gmail.com with ESMTPSA id l7sm275156lfc.80.2019.12.02.15.22.47
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Dec 2019 15:22:48 -0800 (PST)
Received: by mail-lf1-f42.google.com with SMTP id l14so1250048lfh.10
        for <linux-kernel@vger.kernel.org>; Mon, 02 Dec 2019 15:22:47 -0800 (PST)
X-Received: by 2002:ac2:4946:: with SMTP id o6mr894542lfi.170.1575328967630;
 Mon, 02 Dec 2019 15:22:47 -0800 (PST)
MIME-Version: 1.0
References: <20191201184814.GA7335@magnolia>
In-Reply-To: <20191201184814.GA7335@magnolia>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 2 Dec 2019 15:22:31 -0800
X-Gmail-Original-Message-ID: <CAHk-=wi+0suvJAw8hxLkKJHgYwRy-0vg4-dw9_Co6nQHK-XF9Q@mail.gmail.com>
Message-ID: <CAHk-=wi+0suvJAw8hxLkKJHgYwRy-0vg4-dw9_Co6nQHK-XF9Q@mail.gmail.com>
Subject: Re: [GIT PULL] xfs: new code for 5.5
To:     "Darrick J. Wong" <djwong@kernel.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Arnd Bergmann <arnd@arndb.de>
Cc:     linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-xfs <linux-xfs@vger.kernel.org>,
        Dave Chinner <david@fromorbit.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Eric Sandeen <sandeen@sandeen.net>,
        Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 1, 2019 at 10:48 AM Darrick J. Wong <djwong@kernel.org> wrote:
>
> FYI, Stephen Rothwell reported a merge conflict with the y2038 tree at
> the end of October[1].  His resolution looked pretty straightforward,
> though the current y2038 for-next branch no longer changes fs/ioctl.c
> (and the changes that were in it are not in upstream master), so that
> may not be necessary.

The changes and conflicts are definitely still there (now upstream),
I'm not sure what made you not see them.  But thanks for the note, I
compared my end result with linux-next to verify.

My resolution is different from Stephen's. All my non-x86-64 FS_IOC_*
cases just do "goto found_handler", because the compat case is
identical for the native case outside of the special x86-64 alignment
behavior, and I think that's what Arnd meant to happen.

There was some other minor difference too, but it's also possible I
could have messed up, so cc'ing Stephen and Arnd on this just in case
they have comments.


               Linus
