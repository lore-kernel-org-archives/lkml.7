Return-Path: <SRS0=geQ9=WA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FD43C433FF
	for <linux-kernel@archiver.kernel.org>; Sun,  4 Aug 2019 17:08:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 36FAC2086D
	for <linux-kernel@archiver.kernel.org>; Sun,  4 Aug 2019 17:08:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1564938490;
	bh=McJvKzXg7EOeeoTvWtcJ97DUI77ndntXv4DbFlzZrEg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=BXm7W6x+NcNSUzHZA03kGOQN041vtFSlqlrnQ+lOLnjEyhVVBIKCEp6mKFvqwxnNK
	 1hJvI6msCl7uhmhn38xRXFghQxpTuO7SoqW7vPi8zD6eweud6Kisk2ZXM9x0rubax/
	 2VQT9wcLukDI7uKDbEfL1F1bI5R+yl/KTuCdEe7c=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726519AbfHDRHu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 4 Aug 2019 13:07:50 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:43497 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726234AbfHDRHu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Aug 2019 13:07:50 -0400
Received: by mail-lj1-f194.google.com with SMTP id y17so52667000ljk.10
        for <linux-kernel@vger.kernel.org>; Sun, 04 Aug 2019 10:07:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=CUuLjrr40eT0gT47Sq8V20yAh9inQI6F3hRPfWbEWq0=;
        b=XeKH/ON5ROKLw3AJirLwmiogg5d1JvAm75RUEeKG5SkDjhF6N0JWHG3O3I5DpwH5FA
         MK1gNT5J/NY4V4dy0S/wA+wt5FyyqfPZXGPH8ve2T2siAq/pL5Tq2KgGfuDP4X1Qeo/f
         c/lDfC0MoUMV4Sn7U2QBSmfsiRBwiKHl4fgUY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CUuLjrr40eT0gT47Sq8V20yAh9inQI6F3hRPfWbEWq0=;
        b=GEULZX0usrx6+ZMggRZAAmmp5pE+Vn7oIdW1pVtCEfZ3w490iI8NclYqG5n0sSXJ/k
         Skj2xFa3gnMtg8jeDHrltUqdNQV9In5xzve5J6AqDL/V6DIGR6hnqPLqxrYQS+lOwVOw
         aBifRhLVl/MXbSAU6rh3PV8BcUWi/bQ3X7F3WIBucrytzOOu62i5MJJkEfuMFFuY4zEK
         m+dgrMQURlHeyRl/6M7/+iyxLyd/vWPaW+BV8jKHVszl1g1GU9W9uXgY0A/ZwdLx05WY
         0/cysZpz1abJ0UFSZL+q4QrCiojzxRFomrwRDQ1DzfuV//xoW2ST8AcYC2tNRF81WEi5
         27/g==
X-Gm-Message-State: APjAAAVnM5UxiY/ea+h1IAnnB3Z6k8z+SecYQ8S5FoloRAwQPGyhgB/U
        dff9/knYNr2w+0W8NthuYWKZUyIcuPU=
X-Google-Smtp-Source: APXvYqxXwR/lINzIUn1qVXgJaJn0AdhONcY3GDKw/MSR+Bp9rI4Zy+I40JJdDyByZ4qNHorfID4cow==
X-Received: by 2002:a2e:980a:: with SMTP id a10mr77153324ljj.40.1564938467955;
        Sun, 04 Aug 2019 10:07:47 -0700 (PDT)
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com. [209.85.208.180])
        by smtp.gmail.com with ESMTPSA id v4sm16561411lji.103.2019.08.04.10.07.46
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Sun, 04 Aug 2019 10:07:46 -0700 (PDT)
Received: by mail-lj1-f180.google.com with SMTP id v24so77361663ljg.13
        for <linux-kernel@vger.kernel.org>; Sun, 04 Aug 2019 10:07:46 -0700 (PDT)
X-Received: by 2002:a2e:9b83:: with SMTP id z3mr47452082lji.84.1564938466184;
 Sun, 04 Aug 2019 10:07:46 -0700 (PDT)
MIME-Version: 1.0
References: <CAJ-EccMXEVktpuPS5BwkGqTo++dGcpHAuSUZo7WgJhAzFByz0g@mail.gmail.com>
 <CAHk-=whZzJ8WxAeHcirUghcbeOYxmpCr+XxeS9ngH3df3+=p2Q@mail.gmail.com> <CAJ-EccOqmmrf2KPb7Z7NU6bF_4W1XUawLLy=pLekCyFKqusjKQ@mail.gmail.com>
In-Reply-To: <CAJ-EccOqmmrf2KPb7Z7NU6bF_4W1XUawLLy=pLekCyFKqusjKQ@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 4 Aug 2019 10:07:30 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgTOTAW5a4AcCfzRQihd2bNWvYtnqOmXc1QLfN=ZL1fUA@mail.gmail.com>
Message-ID: <CAHk-=wgTOTAW5a4AcCfzRQihd2bNWvYtnqOmXc1QLfN=ZL1fUA@mail.gmail.com>
Subject: Re: [GIT PULL] SafeSetID MAINTAINERS file update for v5.3
To:     Micah Morton <mortonm@chromium.org>
Cc:     linux-security-module <linux-security-module@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 1, 2019 at 11:11 AM Micah Morton <mortonm@chromium.org> wrote:
>
> Add entry in MAINTAINERS file for SafeSetID LSM.

So I've pulled this now.

However, I have to say that I'm now very nervous about future pulls,
simply because the last one had basically everything that can be wrong
be wrong.

Random rebasing of existing commits, a random merge with no sane merge
message.. All complete no-no's.

So I will have to remember to be careful when pulling from you, and
you need to get into a habit of not doing those things.

One very powerful git tool is "gitk". It's just a good idea to use it
to *visualize* to yourself what it is you actually have. Do something
like

    git fetch linus   (or "upstream" or "origin" or whatever your
remote branch for my tree is called)
    gitk linus/master..

which should show you very clearly what you have that is not in my
tree, and should show any odd merges etc.

Just doing "git diff" doesn't show garbage _history_, it only shows
the differences between the two states. There can be crazy bad history
that doesn't show up in the diff, exactly because you had duplicate
commits or something like that.

             Linus
