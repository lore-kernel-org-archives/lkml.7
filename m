Return-Path: <SRS0=NvuC=VQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45C71C7618F
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jul 2019 22:02:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 08C852084D
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jul 2019 22:02:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="RjE4L66s"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728210AbfGSWCf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jul 2019 18:02:35 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:46833 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727344AbfGSWCf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jul 2019 18:02:35 -0400
Received: by mail-ot1-f68.google.com with SMTP id z23so5946516ote.13
        for <linux-kernel@vger.kernel.org>; Fri, 19 Jul 2019 15:02:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Jx4yhUvPBKHsl++YmIn4y1fcGXT76Rdy1djlt2TCCQY=;
        b=RjE4L66sYc+NMzCQFFVfPUhmUWN85j6ovEu8c9MJf0fFIzI6GyBuWOwKXnU3AtWSlm
         J168tNpvDkVwGE3jPaRSA4jqHvx+rGD2JMuOAX3ZBBfXaIrpnPFz+i1m2BtoZQNYgDcV
         LZ9iNumPX644pyo8Vp1/meQ0qhOAxaF33jD+c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Jx4yhUvPBKHsl++YmIn4y1fcGXT76Rdy1djlt2TCCQY=;
        b=T/B92q/cv1gObkaeV5SqA9fnHMZ2zRFahooFEBwtsj2yd5ry8Z3PndQImYbZIrkvY7
         mnjqPw/IFpqk3hHsPXYCqWI9ekEAl1DD6Pqi7qzKFtBgoymEqx+DFi77QE5WWZH6E7cL
         lmgj+SSfCAP1rw2nFkij9Fwe3YWDEahDUIaa9k8/5z/3b6S1U8HuSt9tKpcks/uEUNCQ
         7geeGhIv62K+Uj6ZcfpVWjDbacdgGQ1CEAHZBZ4csMsMR2X2fAqd3ASD24pN2t9TCaqN
         h17mSEsVhwCYtVQDKFCp9Nx4z9SBE+dGQ65BkKr9eRu23lctuyfQDToN4G0aqMfvD09a
         k0WQ==
X-Gm-Message-State: APjAAAX0r3+e1HKEE7r8AdQgX0CTLJJyYnYg2SXXffTvd7QpBKIeQG2d
        wZc9ApzKUR6psjz77GVUGRMYLhPoi99pveRIXFQ=
X-Google-Smtp-Source: APXvYqxDy1QQ0T9FGaRvQj38gbynWb2tzNmx4Xaahh1Kabkr0QTkkfMgmCRA+1gPiNWyA+sVVAqkJsLXTH0IQyXpu10=
X-Received: by 2002:a05:6830:ce:: with SMTP id x14mr22274334oto.188.1563573754597;
 Fri, 19 Jul 2019 15:02:34 -0700 (PDT)
MIME-Version: 1.0
References: <20190719154207.GA9708@phenom.ffwll.local> <CAHk-=wjEE4KGcyL0AJ6YxYvjPHUm9bn_7pZBCmqb-i3+j8p49Q@mail.gmail.com>
In-Reply-To: <CAHk-=wjEE4KGcyL0AJ6YxYvjPHUm9bn_7pZBCmqb-i3+j8p49Q@mail.gmail.com>
From:   Daniel Vetter <daniel@ffwll.ch>
Date:   Sat, 20 Jul 2019 00:02:22 +0200
Message-ID: <CAKMK7uHjw8_7u=zyF8KavjhYaMYwvqknScZiQwL592cTi6twZg@mail.gmail.com>
Subject: Re: [PULL] drm-next fixes for -rc1
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        DRI Development <dri-devel@lists.freedesktop.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 19, 2019 at 9:40 PM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> On Fri, Jul 19, 2019 at 8:43 AM Daniel Vetter <daniel.vetter@ffwll.ch> wrote:
> >
> > drm fixes for -rc1:
> >
> > nouveau:
> > - bugfixes + TU116 enabling (minor iteration):w
>
> Asking the important question:
>
>  - WTH is that ":w" thing?
>
> I have a theory that it's just a "I'm confused by 'vi'" marker.  Very
> understandable.
>
> But I'm also entertaining the possibility that it's a new "whistling
> guy" emoticon. Or maybe a "hungry baby bird face" emoticon.
>
> Admittedly not a _great_ new addition to the emoticons I've seen, but
> hey, I'm not judging. Much.
>
> I left it in the merge message for posterity, regardless.

*grabs brown paper bag*

I still can't vim, despite years. And only noticed after the tag was
signed already, so figured I don't redo it and leave the amusement in.
I fixed it for the mail (the script we have copies the tag into the
mail template).

I guess "can't vi" might call for some funky new emoji or whatever ...

Cheers, Daniel
--
Daniel Vetter
Software Engineer, Intel Corporation
+41 (0) 79 365 57 48 - http://blog.ffwll.ch
