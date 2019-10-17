Return-Path: <SRS0=WVJ0=YK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6E04ECE599
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Oct 2019 02:03:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 77DBE2082C
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Oct 2019 02:03:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="n3W5e19M"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2395386AbfJQCDZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Oct 2019 22:03:25 -0400
Received: from conssluserg-01.nifty.com ([210.131.2.80]:61428 "EHLO
        conssluserg-01.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729268AbfJQCDY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Oct 2019 22:03:24 -0400
Received: from mail-ua1-f50.google.com (mail-ua1-f50.google.com [209.85.222.50]) (authenticated)
        by conssluserg-01.nifty.com with ESMTP id x9H23H7l000536
        for <linux-kernel@vger.kernel.org>; Thu, 17 Oct 2019 11:03:18 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-01.nifty.com x9H23H7l000536
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1571277798;
        bh=5W3OY67om9EG9vb/EYg6ImNL7BEojMB8tQN+Mmn7vbA=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=n3W5e19MVEMy9zpWEjk6gEoYsVrPHBjkQmgEjEJdVzbv+yeYo6ImlbW4mmcyajGKK
         qWkQB7V35OVxzuBejYBzRb3JlwGy2fVgzIDbGRDHnd6iZ+q2fR3ehpUho+N11f8MAs
         kYox4BuTcw4uEejecY8Q0mPCNH7JgXSa9+NDdabMq77xtTnFioW6lrNvAUTt5WY4mE
         1f+YRGt8pbKuQcbZjGnx7hPNeEEx3B2TDF6bBWcNwP2p29ENy3EXNe/qCNRlOCn5he
         C8n/WtHu7BuRofXwGitL2wquDXqQ3C/Myd/cB5e2qvm9J+riWQ35wA9zDlIsSMqH3D
         wgLXqLEkz6EDw==
X-Nifty-SrcIP: [209.85.222.50]
Received: by mail-ua1-f50.google.com with SMTP id 107so173398uau.5
        for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2019 19:03:18 -0700 (PDT)
X-Gm-Message-State: APjAAAUoNML63EheeU+6j/22ukLHMqEQ/zyJl/cfFd7TWdKbwmyFi6Sn
        2n1huUIHA23o6NEryyKIkBla6WcGXTTZ1ugnv90=
X-Google-Smtp-Source: APXvYqwVi9fheo89aPS+Im48AXwrQ+Tr537NUnrtk8ITq15E6fveU7Boo8f24hAbeAVpt/n8y/Z2Bhq+qfFe2xkBKr8=
X-Received: by 2002:ab0:59ed:: with SMTP id k42mr907181uad.25.1571277796854;
 Wed, 16 Oct 2019 19:03:16 -0700 (PDT)
MIME-Version: 1.0
References: <oZ31wh8h96sDGJ_uQWJbvFDzh4-ByMMeoyOhTLmfdf5B5T0KWgLhhNbC49J6EM_Nlgo_zH-bUScrWxYTgP9eNNMF1D5AbpcbIHbBuzbS_44=@protonmail.ch>
 <20191014134037.GA79684@google.com>
In-Reply-To: <20191014134037.GA79684@google.com>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Thu, 17 Oct 2019 11:02:41 +0900
X-Gmail-Original-Message-ID: <CAK7LNAQDBg6r8OnZWDQqwXrQmD7jEi3R9igTi6jQC32sU3rMBg@mail.gmail.com>
Message-ID: <CAK7LNAQDBg6r8OnZWDQqwXrQmD7jEi3R9igTi6jQC32sU3rMBg@mail.gmail.com>
Subject: Re: [PATCH] kheaders: substituting --sort in archive creation
To:     Quentin Perret <qperret@google.com>
Cc:     Dmitry Goldin <dgoldin@protonmail.ch>,
        Andreas Schwab <schwab@linux-m68k.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        "linux-kernel\\\\\\\\@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "joel\\\\\\\\@joelfernandes.org" <joel@joelfernandes.org>,
        Ben Hutchings <ben@decadent.org.uk>, adelva@google.com,
        Nathan Chancellor <natechancellor@gmail.com>,
        Matthias Maennich <maennich@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 14, 2019 at 10:40 PM Quentin Perret <qperret@google.com> wrote:
>
> Hi Dmitry,
>
> On Wednesday 09 Oct 2019 at 13:42:14 (+0000), Dmitry Goldin wrote:
> > From: Dmitry Goldin <dgoldin+lkml@protonmail.ch>
> >
> > The option --sort=ORDER was only introduced in tar 1.28 (2014), which
> > is rather new and might not be available in some setups.
> >
> > This patch tries to replicate the previous behaviour as closely as possible
> > to fix the kheaders build for older environments. It does not produce identical
> > archives compared to the previous version due to minor sorting
> > differences but produces reproducible results itself in my tests.
> >
> > Signed-off-by: Dmitry Goldin <dgoldin+lkml@protonmail.ch>
> > ---
> >  kernel/gen_kheaders.sh | 11 +++++++----
> >  1 file changed, 7 insertions(+), 4 deletions(-)
> >
> > diff --git a/kernel/gen_kheaders.sh b/kernel/gen_kheaders.sh
> > index aff79e461fc9..5a0fc0b0403a 100755
> > --- a/kernel/gen_kheaders.sh
> > +++ b/kernel/gen_kheaders.sh
> > @@ -71,10 +71,13 @@ done | cpio --quiet -pd $cpio_dir >/dev/null 2>&1
> >  find $cpio_dir -type f -print0 |
> >       xargs -0 -P8 -n1 perl -pi -e 'BEGIN {undef $/;}; s/\/\*((?!SPDX).)*?\*\///smg;'
> >
> > -# Create archive and try to normalize metadata for reproducibility
> > -tar "${KBUILD_BUILD_TIMESTAMP:+--mtime=$KBUILD_BUILD_TIMESTAMP}" \
> > -    --owner=0 --group=0 --sort=name --numeric-owner \
> > -    -Jcf $tarfile -C $cpio_dir/ . > /dev/null
> > +# Create archive and try to normalize metadata for reproducibility.
> > +# For compatibility with older versions of tar, files are fed to tar
> > +# pre-sorted, as --sort=name might not be available.
> > +find $cpio_dir -printf "./%P\n" | LC_ALL=C sort | \
> > +    tar "${KBUILD_BUILD_TIMESTAMP:+--mtime=$KBUILD_BUILD_TIMESTAMP}" \
> > +    --owner=0 --group=0 --numeric-owner --no-recursion \
> > +    -Jcf $tarfile -C $cpio_dir/ -T - > /dev/null
> >
> >  echo "$src_files_md5" >  kernel/kheaders.md5
> >  echo "$obj_files_md5" >> kernel/kheaders.md5
> > --
> > 2.23.0
>
> FWIW:
>
>   Tested-by: Quentin Perret <qperret@google.com>
>
> It turns out this issue broke something in our CI, could this patch be
> queued as a -rc4 fix ?


Applied to linux-kbuild/fixes. Thanks.

I will send a pull request for -rc4.



-- 
Best Regards
Masahiro Yamada
