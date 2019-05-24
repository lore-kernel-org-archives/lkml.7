Return-Path: <SRS0=Z4g5=TY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EEECC072B5
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 06:10:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 07FA42175B
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 06:10:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tR+zmdMe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388485AbfEXGK5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 May 2019 02:10:57 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:46419 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387936AbfEXGK5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 May 2019 02:10:57 -0400
Received: by mail-lf1-f66.google.com with SMTP id l26so6144313lfh.13
        for <linux-kernel@vger.kernel.org>; Thu, 23 May 2019 23:10:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WODHkcAF25NHibZn5m21sZFv0u7Ed0zLwASYN+dfRH4=;
        b=tR+zmdMenZ8rl6qmmPgkcatcUU4Qm6kn/lwcJy46XmoBluFNlPq8pNmw6531qDSsS2
         tr5RytD5TiH8d7LpjcamGxH7pGVUx+bB7u2YNpJAItH4UDqcsC+m6FyVIVVoe8OEWcuj
         rfULFYmaJg+MvZDHgknevYGdVNnFwl3P3eZsMRaNA58btfrPJaa8r0Ee1eKe/WkhEIEV
         ptWcS67e1+nW9iUNJ6RNjni5jwwmWUivMaKjPWjGb21SR1Da/K6FOUaaAVEKRWDh0Zzg
         lPbx3TJ9hZx9+CHd1DXZVyZjSqketb4IsPTv1AdIyJr+OzMUWKdlSrwtPG3KMSWKbhRs
         kfAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WODHkcAF25NHibZn5m21sZFv0u7Ed0zLwASYN+dfRH4=;
        b=TF+2niFQd5rfAsFbIdEKLzA+hIaMy4xNe0v2L8M22IkpXKGIEhwnnvEPmCijP9kxTv
         vxAGNJws20bkSNXujQqmgbU50gL8bXOdMm3yWx8lEO7boEZqQ3M4MwA2+5rq7FhBu6aF
         MqLRR7hcXBxkNy8+YwPdCJIOjBsb9S6RpWOyivPLDE3Spr4OrRSmztT7/ZPUyb4Mf/oh
         OjT+QxsQtQhje8ucA0JS2edHIKSYTNOueOSAHT3aWYL9YoJD8M6ug7ShtUFv+1u01g59
         K3Y0UqDICLxCvD322elGJEa/8jWQichDARjaPCaxmmabWMxTjO5iMsws+IP/VX/sUgko
         T2Rw==
X-Gm-Message-State: APjAAAVo+8/h4vjlaWW0LLfXhm34yPm6EEX3sBcl0KjTF/qz6Bni2qb+
        +OOQzxcQIHWjC2C7XzMctg0osiOybZZu6DbDuqU=
X-Google-Smtp-Source: APXvYqzXGbJCmoJG4ZaU1NGpkE2v9aGHvIt6kkpBINLu6d/z4nqZAOnRfcsNn6sHkfMZGJeB3wCErYQ7W0D3rkG/lKI=
X-Received: by 2002:a19:4cd5:: with SMTP id z204mr4626669lfa.113.1558678255734;
 Thu, 23 May 2019 23:10:55 -0700 (PDT)
MIME-Version: 1.0
References: <1558366258-3808-1-git-send-email-jrdr.linux@gmail.com> <CANiq72nubJ6KHXROuDHV8Ap6MJQx6SDKUJCxYuN1_YDy=A_ELw@mail.gmail.com>
In-Reply-To: <CANiq72nubJ6KHXROuDHV8Ap6MJQx6SDKUJCxYuN1_YDy=A_ELw@mail.gmail.com>
From:   Souptick Joarder <jrdr.linux@gmail.com>
Date:   Fri, 24 May 2019 11:40:43 +0530
Message-ID: <CAFqt6zaAT5buz4VGzNkqKAH+r=usEU+fyK5EhgUP42Jfdy-rOw@mail.gmail.com>
Subject: Re: [PATCH 2/2] auxdisplay/ht16k33.c: Convert to use vm_map_pages_zero()
To:     Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc:     Robin van der Gracht <robin@protonic.nl>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Matthew Wilcox <willy@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 23, 2019 at 6:53 PM Miguel Ojeda
<miguel.ojeda.sandonis@gmail.com> wrote:
>
> On Mon, May 20, 2019 at 5:26 PM Souptick Joarder <jrdr.linux@gmail.com> wrote:
> >
> > While using mmap, the incorrect value of length and vm_pgoff are
> > ignored and this driver go ahead with mapping fbdev.buffer
> > to user vma.
>
> Typos: values*, goes* (same for the other patch)

Ok, will add it into v2.

>
> > Convert vm_insert_pages() to use vm_map_pages_zero(). We could later
> > "fix" these drivers to behave according to the normal vm_pgoff
> > offsetting simply by removing the _zero suffix on the function name
> > and if that causes regressions, it gives us an easy way to revert.
>
> Would it be possible to add a "Link:" to where these new functions are
> discussed/used (maybe a lore.kernel.org link?)?

This might be helpful.
https://lkml.org/lkml/2018/12/24/204

>
> Thanks for the patch!
>
> Cheers,
> Miguel
