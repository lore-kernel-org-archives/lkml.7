Return-Path: <SRS0=gj9M=VG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 996B4C73C53
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jul 2019 21:26:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6D1E72073D
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jul 2019 21:26:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1562707598;
	bh=5oiHL/zybxuTOL+hFDeQHU1e2n2sfRw43cxTgikYVDc=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=d0KqkTjx8KMKHcdNE/09rE/FVoDZHtGVmmM7EFjpaaImN1dHQHAE/EWanxfkwGttf
	 1uJwzrGzLP/50ri72OxCO2I3Q/bzTW/iKJkZ56ICyA3XWvD1SaPFq4mbZgU3RzNZUU
	 hKz7Imnj0j2r65LVHXLZl1ypw8AZskUj22ZB/eEA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729021AbfGIV0h (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Jul 2019 17:26:37 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:46977 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726428AbfGIV0h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jul 2019 17:26:37 -0400
Received: by mail-lf1-f68.google.com with SMTP id z15so36038lfh.13
        for <linux-kernel@vger.kernel.org>; Tue, 09 Jul 2019 14:26:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HikX0hweJiTkXFbzUjjscG9RpigQeVtbSYgusA894Nc=;
        b=F1m3EOkwP/i0ZAC6bYA9/ln5Q3QMQvMkvlSpCl24qapl5AQfPxGjpv7Giy2GsIq4R3
         8soUERVngU+SIKcyZzmsCulDy/1HqOKRVYF7/AEoGaLDy03I/J83aGdfnbYOZS+M9lUE
         Ov5yDc4sCdJba43CcioIo8SMGBD0dsx/FyD2g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HikX0hweJiTkXFbzUjjscG9RpigQeVtbSYgusA894Nc=;
        b=HljGfQlVMa6rkAIMTOXEuKSSYR3xfOtcf9wgHaUZuCIm2htV0EBTvXaSz3ass7MSFJ
         hFo9dMVbzqsRcYTvx0TYtq4So0cy1r9I3syC1QwssEi4yp2M8lmxU2UxFJYXBUgnDtEZ
         op+ANXcIZkfC9mQTmHKfz+KnIjqjgCcoP8GQIhhCpp1h/6nT4PxSeZ8eWv4QMfi5FCRc
         7Q0qU4ao5K9WBzUy01ebYOWcOSHitlx+iG52O+xC16YJGRk5PvV+n5duQs2qRp669pwt
         zaTo8mbxSyvvAg8PuuCfFMydFuqDqfEsV/Kwb/ajFzJnBePv/6qLHqyyI4lMOI3bJF8e
         mPRQ==
X-Gm-Message-State: APjAAAXYv/7ZblqVH5VpF/DYueFSj8rpDS+tGPZI4B9inAwXUzeFp1a/
        Rh6YhVoZiVgwPuLcK91AhSUBZLJ/Gd0=
X-Google-Smtp-Source: APXvYqwn3k9FqGP6q8gx7qkf3NuwZ14GJjMecBq6ZXXq/pGRlwA8XvT6shj+O8xB7+Lt6zvA8KZ7Dg==
X-Received: by 2002:ac2:51a3:: with SMTP id f3mr2003773lfk.94.1562707594672;
        Tue, 09 Jul 2019 14:26:34 -0700 (PDT)
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com. [209.85.167.49])
        by smtp.gmail.com with ESMTPSA id s20sm10293lfb.95.2019.07.09.14.26.33
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Tue, 09 Jul 2019 14:26:33 -0700 (PDT)
Received: by mail-lf1-f49.google.com with SMTP id 62so54217lfa.8
        for <linux-kernel@vger.kernel.org>; Tue, 09 Jul 2019 14:26:33 -0700 (PDT)
X-Received: by 2002:ac2:4839:: with SMTP id 25mr12673730lft.79.1562707593352;
 Tue, 09 Jul 2019 14:26:33 -0700 (PDT)
MIME-Version: 1.0
References: <20190708162756.GA69120@gmail.com> <CAHk-=wigbHd6wXcrpH+6jnDe=e+OHFy6-KdVSUP2yU5aip-UAg@mail.gmail.com>
In-Reply-To: <CAHk-=wigbHd6wXcrpH+6jnDe=e+OHFy6-KdVSUP2yU5aip-UAg@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 9 Jul 2019 14:26:17 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgkWTtW-JWVAO0Y6s=dRgZGAaTWAsOuYaTFNJzkF+Z_Jg@mail.gmail.com>
Message-ID: <CAHk-=wgkWTtW-JWVAO0Y6s=dRgZGAaTWAsOuYaTFNJzkF+Z_Jg@mail.gmail.com>
Subject: Re: [GIT PULL] x86/topology changes for v5.3
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>, Len Brown <lenb@kernel.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 9, 2019 at 2:20 PM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> Will keep you updated as bisection narrows it down.

Hmm. Already narrowed down to either of

    Pull x86 asm updates from Ingo Molnar:
    Pull scheduler updates from Ingo Molnar:

but still bisecting to pinpoint the exact thing.

               Linus
