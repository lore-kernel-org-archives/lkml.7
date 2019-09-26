Return-Path: <SRS0=EKka=XV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9856EC4360C
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Sep 2019 20:06:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 68D5021A4A
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Sep 2019 20:06:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1569528387;
	bh=y1cOzFYk89wZeYxpDqdE0FToKtigi4JdxDKJedDrQ3s=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=JH0PDdjHI4Jis1FkukWWeikbyC39wqnXhH4iXwcsIxi9DU1HZkt+BT5JVnSIW8ZwP
	 OvIHU+cgZRS80IUU11oLfiTp/qQxCKV+vVgPKIBLJdVPib/6hEcA5gUwkPGWV3kxKR
	 Vi7bd0vbarsWqbwEYLKzhO+o8a08o86S/9YheShA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727891AbfIZUG0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Sep 2019 16:06:26 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:39633 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727816AbfIZUG0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Sep 2019 16:06:26 -0400
Received: by mail-lj1-f194.google.com with SMTP id y3so191944ljj.6
        for <linux-kernel@vger.kernel.org>; Thu, 26 Sep 2019 13:06:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LWf8+ImT/tVOXaor+WrbCvxf0FT9hKA16QgdBRHdggA=;
        b=h3l6m2Bib1Z4sGOU5XHEFZgmzF2pvpeHtUAyqvmKxKsO3aMWTW1cJGqY368p/LuNgR
         br+ZchcbdMBFtnJqfmvWzd7hDysQk2hCkKpEhXbng8HwZaJgIqDBmpsN/5vYVM/ut9yn
         PX3wEhHlNFufIBMGXRzs1jSVs5IkZJ+/6bPa4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LWf8+ImT/tVOXaor+WrbCvxf0FT9hKA16QgdBRHdggA=;
        b=cYXcWg4AP4kdkEJ1qpgtKsyXQkLiv2ZaDLmv400lUjBu0JI9cMF6nV0pmCfhLpi2wu
         /MB0Z1QZEv2CVVhk8hK5QhL6CzShao7RynA0Rb/TCDXCUI4dHbHGvCvH040eDn0BSEv3
         DJUJ6yHAuPynPHTy+I4THLOmk1H2WOldpx9sYDe0ysB16ZkZmDaSv/rYaXkaIRx7DSM9
         8a44fZgfkKHct6xeGqpsDbS1QYVCLt05pvRUs11cLbHuD8oXVuBdJvx28AiDc3HjRdv5
         Xg1N+5LiK9Y/3sgtUKWGVRzqZFsD8NYoT2KEZvWQwkJpZwbZ/xWXCyfnUKTGVxFPRsso
         p9Qg==
X-Gm-Message-State: APjAAAVdjwQulYFs9OPktJWhHhug7PwLLYf8YJkBsDz2GTv1kzun2aMS
        rvZRoRjjB3mVUUsobOHDJASJfxDlQZk=
X-Google-Smtp-Source: APXvYqxBIMKbXypKO+EFTeeFVfuIT08bfFSOGfukBlbm0r26+NdcEpZu0lkOTyTSdG2Dt/eUETaFrw==
X-Received: by 2002:a2e:878c:: with SMTP id n12mr280699lji.175.1569528379787;
        Thu, 26 Sep 2019 13:06:19 -0700 (PDT)
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com. [209.85.167.50])
        by smtp.gmail.com with ESMTPSA id l16sm34444lja.34.2019.09.26.13.06.18
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 Sep 2019 13:06:18 -0700 (PDT)
Received: by mail-lf1-f50.google.com with SMTP id q11so123149lfc.11
        for <linux-kernel@vger.kernel.org>; Thu, 26 Sep 2019 13:06:18 -0700 (PDT)
X-Received: by 2002:a19:741a:: with SMTP id v26mr203348lfe.79.1569528377928;
 Thu, 26 Sep 2019 13:06:17 -0700 (PDT)
MIME-Version: 1.0
References: <201909261026.6E3381876C@keescook>
In-Reply-To: <201909261026.6E3381876C@keescook>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 26 Sep 2019 13:06:01 -0700
X-Gmail-Original-Message-ID: <CAHk-=wg8+eNK+SK1Ekqm0qNQHVM6e6YOdZx3yhsX6Ajo3gEupg@mail.gmail.com>
Message-ID: <CAHk-=wg8+eNK+SK1Ekqm0qNQHVM6e6YOdZx3yhsX6Ajo3gEupg@mail.gmail.com>
Subject: Re: [GIT PULL] treewide conversion to sizeof_member() for v5.4-rc1
To:     Kees Cook <keescook@chromium.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Pankaj Bharadiya <pankaj.laxminarayan.bharadiya@intel.com>,
        Joe Perches <joe@perches.com>,
        Alexey Dobriyan <adobriyan@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 26, 2019 at 10:33 AM Kees Cook <keescook@chromium.org> wrote:
>
> Please pull this mostly mechanical treewide conversion to the single and
> more accurately named sizeof_member() macro for the end of v5.4-rc1. This
> replaces 3 macros of the same behavior (FIELD_SIZEOF(), SIZEOF_FIELD(),
> and sizeof_field()). The last patch in the series has a script in the
> commit log to do the conversion, if you want to compare the results
> (they remained identical today when I checked).

Honestly, I'm not sure why "sizeof_field()" wasn't just picked when we
already had it. Making a new macro for the exact same thing seems
somewhat questionable.

Yes, yes, the C standard calls them "members". Except when it doesn't,
and they are members of a bit type, and it calls them bit-fields. And
'field' is a fairly common use outside of the standard - including
among compilers, but also in the kernel. Look at a lot of the tracing
code in the kernel, for example.,

So we did have that existing macro, with a reasonable name, and it did
have some use, and it's not hard to understand.

I also note that we don't actually use the word "member" much in the kernel:

  $ git grep -iw member | wc
     3302   25603  280767
  $ git grep -iw field | wc
    26082  213732 2253806

that's an almost order-of-magnitude vote in favor of "field" as a word, fwiw.

HOWEVER.

Another issue is that most of the patch is for the use by far is the
FIELD_SIZEOF macro.

And the issue I have there is that while I think that could have a
better name - the upper-casing doesn't match offsetof or sizeof or any
of the existing struct/union member things - the _big_ user is
networking code.

And I don't see anybody having actually talked to the networking
people whose code-base this mostly touches.

Something like 80% of the patch is to that subsystem (and it would
have been even higher, if it wasn't for the forced "member" renaming),
I'd really like to see an Ack or similar.

Maybe one was given during the discussions, but it's not visible in
the pull request or the git tree.

So

 (a) why didn't this use the already existing and well-named macro
that nobody really had issues with?

 (b) I see no sign of the networking people having been asked about
their preferences.

Hmm>

                  Linus
