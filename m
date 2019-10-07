Return-Path: <SRS0=z8wE=YA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 294DFECE58B
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 03:12:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F0BE62080F
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 03:12:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570417924;
	bh=zX/6vODovD6UtTatzS6XU0AWV2zyD6/JIEk1D6k0VHY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=jFLiexDi+6794s8+4y+NdMjTwNtDutdQHwQi4RZ/oVNeZ5oq0w/jIKBmcLrIsRuwy
	 59WJTaUhvaUS/FhMpEoKEma4Zqn38X4XYwXD+WYBFWJ+9nzzqziT1Rwk48bNL9Attm
	 NET/Gtf1ceKNIWT0m+qLD0e1CmE8SttNWyQVBNcM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727010AbfJGDMD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 6 Oct 2019 23:12:03 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:45334 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726797AbfJGDMC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Oct 2019 23:12:02 -0400
Received: by mail-lj1-f195.google.com with SMTP id q64so11945307ljb.12
        for <linux-kernel@vger.kernel.org>; Sun, 06 Oct 2019 20:12:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YDcKffdvuqawza0UsRIeKoMOjxaGrHiLDaMxMP7R+Og=;
        b=TzkUcPe3jgWRh63W6pegVfsKQkTjDOVY+VCfmpEGgY5jThNrnZLxkzh36wG3e9K0PT
         UVSwX/FKj0M3kXvbCaiJ0Era2CeA3A+JZE6Tnc3rENEv3b79wlor4kWQoydgdwj/K0Wp
         DhxQAvxugbDUkuztHE62XrzM6B3I9zvnIS6Gk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YDcKffdvuqawza0UsRIeKoMOjxaGrHiLDaMxMP7R+Og=;
        b=b1PDEWUAKsNuILafFu4WGdHz9ew0789/Id39dV9C6826FDcU1GQQGy8nlq03ZoXsiW
         bfBapq4GSs1iiMHTu96c/etZT8v9lmFdwUAH510eQVXWnUKfBN3HKdS6oRL82BmXP2Jc
         vZYFvStQrDsBnHd0hS1d/QA5o3bivEvlxPr7l9HTjmtzhF34fA9LRsqnhjKl22okdIQY
         zH45Y1Aw5XPQqscMVP4/a3nStsQ7eASVPmbDV7NzwlghlFYOGWIDfgUEENaf3suEuTsm
         pcN9HreWo1Hy79A3Hud7+yZyRAYddcVUdCG2iXFh5xkxloRCrqX9ZePGJaJHPTTycfy6
         VR4w==
X-Gm-Message-State: APjAAAV8kzo12m4swEVgASHuflsyKl/s/RnjFT3wGy57EI2c3FKrz6F8
        MOhPjA7HWdRTy4QN3Ilfd1vaOWx680w=
X-Google-Smtp-Source: APXvYqyjeC0hXSVB2zftOrYekwWwuXxlCUbik8rbEUhW65Zw+n0PuoF8BCsTwyqSnGhg3ZlCPFHAmg==
X-Received: by 2002:a2e:252:: with SMTP id 79mr16396965ljc.188.1570417920124;
        Sun, 06 Oct 2019 20:12:00 -0700 (PDT)
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com. [209.85.208.172])
        by smtp.gmail.com with ESMTPSA id l7sm2806448lji.46.2019.10.06.20.11.58
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 06 Oct 2019 20:11:59 -0700 (PDT)
Received: by mail-lj1-f172.google.com with SMTP id f5so11954333ljg.8
        for <linux-kernel@vger.kernel.org>; Sun, 06 Oct 2019 20:11:58 -0700 (PDT)
X-Received: by 2002:a2e:86d5:: with SMTP id n21mr16761156ljj.1.1570417918300;
 Sun, 06 Oct 2019 20:11:58 -0700 (PDT)
MIME-Version: 1.0
References: <20191006222046.GA18027@roeck-us.net> <CAHk-=wgrqwuZJmwbrjhjCFeSUu2i57unaGOnP4qZAmSyuGwMZA@mail.gmail.com>
 <CAHk-=wjRPerXedTDoBbJL=tHBpH+=sP6pX_9NfgWxpnmHC5RtQ@mail.gmail.com>
 <5f06c138-d59a-d811-c886-9e73ce51924c@roeck-us.net> <CAHk-=whAQWEMADgxb_qAw=nEY4OnuDn6HU4UCSDMNT5ULKvg3g@mail.gmail.com>
 <20191007012437.GK26530@ZenIV.linux.org.uk> <CAHk-=whKJfX579+2f-CHc4_YmEmwvMe_Csr0+CPfLAsSAdfDoA@mail.gmail.com>
 <20191007025046.GL26530@ZenIV.linux.org.uk>
In-Reply-To: <20191007025046.GL26530@ZenIV.linux.org.uk>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 6 Oct 2019 20:11:42 -0700
X-Gmail-Original-Message-ID: <CAHk-=whraNSys_Lj=Ut1EA=CJEfw2Uothh+5-WL+7nDJBegWcQ@mail.gmail.com>
Message-ID: <CAHk-=whraNSys_Lj=Ut1EA=CJEfw2Uothh+5-WL+7nDJBegWcQ@mail.gmail.com>
Subject: Re: [PATCH] Convert filldir[64]() from __put_user() to unsafe_put_user()
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Guenter Roeck <linux@roeck-us.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 6, 2019 at 7:50 PM Al Viro <viro@zeniv.linux.org.uk> wrote:
>
> Out of those, only __copy_to_user_inatomic(), __copy_to_user(),
> _copy_to_user() and iov_iter.c:copyout() can be called on
> any architecture.
>
> The last two should just do user_access_begin()/user_access_end()
> instead of access_ok().  __copy_to_user_inatomic() has very few callers as well:

Yeah, good points.

It looks like it would be better to just change over semantics
entirely to the unsafe_copy_user() model.

> So few, in fact, that I wonder if we want to keep it at all; the only
> thing stopping me from "let's remove it" is that I don't understand
> the i915 side of things.  Where does it do an equivalent of access_ok()?

Honestly, if you have to ask, I think the answer is: just add one.

Every single time we've had people who optimized things to try to
avoid the access_ok(), they just caused bugs and problems.

In this case, I think it's done a few callers up in i915_gem_pread_ioctl():

        if (!access_ok(u64_to_user_ptr(args->data_ptr),
                       args->size))
                return -EFAULT;

but honestly, trying to optimize away another "access_ok()" is just
not worth it. I'd rather have an extra one than miss one.

> And mm/maccess.c one is __probe_kernel_write(), so presumably we don't
> want stac/clac there at all...

Yup.

> So do we want to bother with separation between raw_copy_to_user() and
> unsafe_copy_to_user()?  After all, __copy_to_user() also has only few
> callers, most of them in arch/*

No, you're right. Just switch over.

> I'll take a look into that tomorrow - half-asleep right now...

Thanks. No huge hurry.

             Linus
