Return-Path: <SRS0=7lyw=2D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAB65C43603
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Dec 2019 09:15:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 511CF2077B
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Dec 2019 09:15:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="bqf2gMqM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726487AbfLMJPP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Dec 2019 04:15:15 -0500
Received: from mail-il1-f194.google.com ([209.85.166.194]:40024 "EHLO
        mail-il1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725980AbfLMJPP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Dec 2019 04:15:15 -0500
Received: by mail-il1-f194.google.com with SMTP id b15so1490036ila.7
        for <linux-kernel@vger.kernel.org>; Fri, 13 Dec 2019 01:15:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lhhQ4tcwmeQStYaNHbNoHSE/s07Lkdx+vy7ZqDxz9/I=;
        b=bqf2gMqMPcj2CdLdx4/7z4SGPeOe16t3NFwPGyEqAuIo3bArzFCAnXojgo9vOKILnZ
         X2SbwaIsIiPqYIwIin/JpANpYMRTtnqS8wQpGLp6fm5GFyV21XYAouJ3KIFZDZIJAPCK
         5Z5iqD+pbjGRfNLbDhwMl2nHCWEw66RArAP2w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lhhQ4tcwmeQStYaNHbNoHSE/s07Lkdx+vy7ZqDxz9/I=;
        b=EvKAlPuZyE4Tp1B/RHSwJnoH0Pv0w0D1xDEm9Bro9nlNT9VUPUL+SbD1GghChZ4LkC
         ifs47EcvJjkWnPCxshsb8XG84iMxvsdgBTRLxxNS6pgtEgzeLKtj1XcaSTNdzV15fx7I
         /i+MxQKvtMaioZmgItkdSCBEFh/OtCoFvc95zq1SpeojykVqAeJFkpJ08kgA9WOn/ewA
         GzcCsyMrTpUPkd/QYHoLjC4JWPIP+gTv/KpbnewHGQAHcekhOzxjPka3DL5Gro5sLzTK
         4dXvW39zDP7mwtnAEbb+rpN1OhLcT+VyrWvioyALdROxI5+u/sUJKVKuuUQSpxXyvDsK
         XHtA==
X-Gm-Message-State: APjAAAVJDiq5pmn7FcdvH/eGx/NuGbkHm/bfPdXqsGhct+iG51nvb8/e
        P/K/IKEg/xZllULlCPd47qcxyI7GRjcsdM3MGxP3QA==
X-Google-Smtp-Source: APXvYqwWPwRORxqG4jy2Iy3LqhdqK/zZxkzDePZJrGA2tnSIAnlzo3+Euo5zMkZtXDIoAuSp7VdGG5IShMEUKkrcE/c=
X-Received: by 2002:a92:89c2:: with SMTP id w63mr12345010ilk.252.1576228514214;
 Fri, 13 Dec 2019 01:15:14 -0800 (PST)
MIME-Version: 1.0
References: <20191212145042.12694-1-labbott@redhat.com> <CAOi1vP9E2yLeFptg7o99usEi=x3kf=NnHYdURXPhX4vTXKCTCQ@mail.gmail.com>
 <fbe90a0b-cf24-8c0c-48eb-6183852dfbf1@redhat.com> <CAHk-=wh7Wuk9QCP6oH5Qc1a89_X6H1CHRK_OyB4NLmX7nRYJeA@mail.gmail.com>
 <cf4c9634-1503-d182-cb12-810fb969bc96@redhat.com> <20191212213609.GK4203@ZenIV.linux.org.uk>
In-Reply-To: <20191212213609.GK4203@ZenIV.linux.org.uk>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Fri, 13 Dec 2019 10:15:03 +0100
Message-ID: <CAJfpegv_zY6w6=pOL0x=sjuQmGae0ymOafZXjyAdNEHj+EKyNA@mail.gmail.com>
Subject: Re: [PATCH] vfs: Don't reject unknown parameters
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Laura Abbott <labbott@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Ilya Dryomov <idryomov@gmail.com>,
        David Howells <dhowells@redhat.com>,
        Jeremi Piotrowski <jeremi.piotrowski@gmail.com>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        Phillip Lougher <phillip@squashfs.org.uk>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 12, 2019 at 10:36 PM Al Viro <viro@zeniv.linux.org.uk> wrote:

> So you could bloody well just leave recognition (and handling) of "source"
> to the caller, leaving you with just this:
>
>         if (strcmp(param->key, "source") == 0)
>                 return -ENOPARAM;
>         /* Just log an error for backwards compatibility */
>         errorf(fc, "%s: Unknown parameter '%s'", fc->fs_type->name, param->key);
>         return 0;

Which is fine for the old mount(2) interface.

But we have a brand new API as well; do we really need to carry these
backward compatibility issues forward?  I mean checking if a
param/flag is supported or not *is* useful and lacking that check is
the source of numerous headaches in legacy interfaces (just take the
open(2) example and the introduction of O_TMPFILE).

Just need a flag in fc indicating if this option comes from the old interface:

         if (strcmp(param->key, "source") == 0)
                 return -ENOPARAM;
         /* Just log an error for backwards compatibility */
         errorf(fc, "%s: Unknown parameter '%s'", fc->fs_type->name,
param->key);
         return fc->legacy ? 0 : -ENOPARAM;

And TBH, I think that logic applies to the common flags as well.  Some
of these simply make no sense on the new interface ("silent",
"posixacl") and some are ignored for lots of filesystems ("sync",
"dirsync", "mand", "lazytime").  It would also be nice to reject "rw"
for read-only filesystems.

I have sent patches for the above numerous times, all been ignored by
DavidH and Al.  While this seems minor now, I think getting this
interface into a better shape as early as possible may save lots more
headaches later...

Thanks,
Miklos
