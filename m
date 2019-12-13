Return-Path: <SRS0=7lyw=2D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92141C43603
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Dec 2019 09:30:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A5CC32077B
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Dec 2019 09:30:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="AZz89pad"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726646AbfLMJa0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Dec 2019 04:30:26 -0500
Received: from mail-io1-f68.google.com ([209.85.166.68]:43638 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725890AbfLMJa0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Dec 2019 04:30:26 -0500
Received: by mail-io1-f68.google.com with SMTP id s2so1676219iog.10
        for <linux-kernel@vger.kernel.org>; Fri, 13 Dec 2019 01:30:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VbLwtEEii+eZr02TAunYp0r9vwXzyFh2PvhryUpIvu0=;
        b=AZz89padS3ilULxI3+ozr300rmWfzzY1kN8fVffLYF4fQ5tWQXv8YlmkSnJ48Xmya4
         45uwmFCQHFOSWHVRCRVGXS90qtIHSfbfPZF/PIMUQwY6QJnniGpn3Smza5HPBVWcvGje
         9yz7fNP6u3GFZji5pYEWMCuwskl2FiPYRj0+Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VbLwtEEii+eZr02TAunYp0r9vwXzyFh2PvhryUpIvu0=;
        b=F5W0scpT9xuBk2gbk+3R+4lfjhI9gQB3T0ibYxufawR/0fNf5G10uv2r752qSAxA5t
         kgG7VSjCzHXpjIx5FgHzIQmWgUsUN+k7RCkxMSeQ8vAVVF/lUUeEPzBvd8484zYUpiFy
         jX6hp3XOdXFp/ttfhbqsBQSzZq0636ffxdWMmSHVNJ6hWAbJCjwES8L+lnDFwfbJxPX4
         n+CbpMyM+1wyBOjmp6T4tRerbzuqqEg8zJ1Qnns+OjBua9y2qV8BqjpazhUbjTkVekPI
         QFXcs44+MSi7DyZqeuCxx8H22jcM9pUr0T43sqRuSPBanU7dCzDQq8Pa1D60puPy3zqd
         GTTw==
X-Gm-Message-State: APjAAAVt765osYcoss13pUYixIh0+0qHt1y+HNIZkCTBeWgw68cm7St/
        65gSV5G/UQaqAmpqtDcYqlAZdt5d9SWjZuPmhojUlg==
X-Google-Smtp-Source: APXvYqzwM8OVdjfc6nPVJOOHNFpeyNvYtMcf+cL5pDaYSQBuwa61eiV16PuC1ggtwJieCU4wJrSqxFkFc28L62I7NLM=
X-Received: by 2002:a5d:8846:: with SMTP id t6mr5453453ios.63.1576229425684;
 Fri, 13 Dec 2019 01:30:25 -0800 (PST)
MIME-Version: 1.0
References: <20191212145042.12694-1-labbott@redhat.com> <CAOi1vP9E2yLeFptg7o99usEi=x3kf=NnHYdURXPhX4vTXKCTCQ@mail.gmail.com>
 <fbe90a0b-cf24-8c0c-48eb-6183852dfbf1@redhat.com> <CAHk-=wh7Wuk9QCP6oH5Qc1a89_X6H1CHRK_OyB4NLmX7nRYJeA@mail.gmail.com>
 <cf4c9634-1503-d182-cb12-810fb969bc96@redhat.com> <20191212213609.GK4203@ZenIV.linux.org.uk>
 <CAJfpegv_zY6w6=pOL0x=sjuQmGae0ymOafZXjyAdNEHj+EKyNA@mail.gmail.com>
In-Reply-To: <CAJfpegv_zY6w6=pOL0x=sjuQmGae0ymOafZXjyAdNEHj+EKyNA@mail.gmail.com>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Fri, 13 Dec 2019 10:30:14 +0100
Message-ID: <CAJfpegu+mMVm8vNMZhUVveWKRz4VgcMip7vC4iBhZahWbk=qPw@mail.gmail.com>
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

On Fri, Dec 13, 2019 at 10:15 AM Miklos Szeredi <miklos@szeredi.hu> wrote:

> I have sent patches for the above numerous times, all been ignored by
> DavidH and Al.  While this seems minor now, I think getting this
> interface into a better shape as early as possible may save lots more
> headaches later...

Refs:

https://lore.kernel.org/linux-fsdevel/20191128155940.17530-12-mszeredi@redhat.com/
https://lore.kernel.org/linux-fsdevel/20191128155940.17530-13-mszeredi@redhat.com/
https://lore.kernel.org/linux-fsdevel/20190619123019.30032-7-mszeredi@redhat.com/
etc...

Thanks,
Miklos
