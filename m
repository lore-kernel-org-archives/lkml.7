Return-Path: <SRS0=P610=TX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BD3FC282E1
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 12:59:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1B98921019
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 12:59:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SyfqgaQv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730828AbfEWM7L (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 May 2019 08:59:11 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:44035 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730495AbfEWM7K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 May 2019 08:59:10 -0400
Received: by mail-lj1-f193.google.com with SMTP id e13so5344264ljl.11
        for <linux-kernel@vger.kernel.org>; Thu, 23 May 2019 05:59:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=AIHtdpz8zuPAe1w5Wj0qD8ztjrVfXmUXjGesLzTIxWg=;
        b=SyfqgaQvyX9AF92ypS8wsVUTibefaicVMjStGpBVJbOAZBkTf3H4oVOuN7aiIDeqee
         VO9xAbEo90mh6A5I/g0kTHnaF4aqDpuXZbaM5Wkaa7gboy6jKIxQBiERs4ri4fDZv/SU
         mVb/JQ4GzjVfgwH/x9srvFWh2Mj4XsfNhdVhen3iWJPxOSv7RpUY8egSrZQ1ypjIei3n
         NioV09IYq/vH6KlC6RZQHphLrr9mKJqhj5jfwQSaWEn6TCK/EzQ7NDfhzk0Y+0dSHq4I
         Wxh/roOaQBbHuBUK1NswKxEBv1IoRYB3NLE9NpPMcGaR9tYNIxV6drm3UWMf4nZfe1EU
         Ucyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AIHtdpz8zuPAe1w5Wj0qD8ztjrVfXmUXjGesLzTIxWg=;
        b=mGI3wytQgRdt5h0lkF0UshEeksNVNm7iu1qStj9jNRr/jowonTEhHAfrckqnr9V9pX
         Hu3cYIlVdGJgP+v+aEBWBz8tV/q4fzBXZdlgCRSEzyTBgffcFvUBn2DWL2uEahUkgc1N
         2hn5L68Ykh2sgIYditcvqKCFC9E4Gt9f0q8uZYvSRBCjo1S4aJRlc560cadnYdC1crVQ
         xsh/UU7Vgp8E6Up4XIGnU1USBOkrVKSTCCOBZWZfwdUZLrCl8Rf6PpPA5SwqN/2WVzgk
         LwGylpyrs4dFxXb6xhMMtdA/rk9kPbndOBwD5KJnhQFD8T2oz+s13wEtQfd9JGG160iw
         RxxQ==
X-Gm-Message-State: APjAAAWog+pjJcumgcdicW2LGVQo7hmJP4jAwo2Mw3VrMGFTv4TS+5nL
        LcqnPstSaBu51GFBkHT/RlGczmjhQmcj7RfK3hE=
X-Google-Smtp-Source: APXvYqx2qrmzWKtgtLqQMvsgBSHb2XTW+QUl+4a3JiYs6jd/oSSyZLGs7uxf++Hx84lummDmUkuDwUUHacb+WJRJ830=
X-Received: by 2002:a2e:9a4f:: with SMTP id k15mr41998151ljj.159.1558616348807;
 Thu, 23 May 2019 05:59:08 -0700 (PDT)
MIME-Version: 1.0
References: <1558366258-3808-1-git-send-email-jrdr.linux@gmail.com>
 <20190521085547.58e1650c@erd987> <CAFqt6zZA32QA-6VtaKcrEtq=qkoGLHpirSvXb5wt7-wd_-74hQ@mail.gmail.com>
In-Reply-To: <CAFqt6zZA32QA-6VtaKcrEtq=qkoGLHpirSvXb5wt7-wd_-74hQ@mail.gmail.com>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Thu, 23 May 2019 14:58:57 +0200
Message-ID: <CANiq72nd5i4ADU1GbEt1Dkhp-5YkC9ip-h4a0G64oN+b95wAXA@mail.gmail.com>
Subject: Re: [PATCH 2/2] auxdisplay/ht16k33.c: Convert to use vm_map_pages_zero()
To:     Souptick Joarder <jrdr.linux@gmail.com>
Cc:     Robin van der Gracht <robin@protonic.nl>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Matthew Wilcox <willy@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 23, 2019 at 10:18 AM Souptick Joarder <jrdr.linux@gmail.com> wrote:
>
> Miguel, Ack from Robin is missing in linux-next-20190523 when applied.

Thanks for the warning! I wanted to review first but didn't get to it yet.

Taking a quick look now, by the way, why does vm_map_pages_zero() (and
__vm_map_pages() etc.) get a pointer to an array instead of a pointer
to the first element?

Cheers,
Miguel
