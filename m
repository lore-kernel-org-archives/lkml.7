Return-Path: <SRS0=Iet2=Z5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D6E9C43603
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Dec 2019 18:56:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1BDE821835
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Dec 2019 18:56:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1575744981;
	bh=ShFDiL6InTioPpsLyZuCkPwSRo+d/EbTQA/+LNaK8zI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=PL1xxdqtZgVKbUFlmrFoDxuSoOGTMng9uLk13mUospqkAKmuXzOCL8bb93izAgB2s
	 pJ3YJjDlT1qmneYOWJry/TjGGz4jxQXvo92GAs7z8wd6HylD4MC/mZ1b6eGzFoikqL
	 fEzWyaMDcajkPQ5HJkh6x7LL8vkOVn36nd9JOExE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726626AbfLGS4U (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 7 Dec 2019 13:56:20 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:40054 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726464AbfLGS4S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Dec 2019 13:56:18 -0500
Received: by mail-lj1-f196.google.com with SMTP id s22so11179359ljs.7
        for <linux-kernel@vger.kernel.org>; Sat, 07 Dec 2019 10:56:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WUXh/vHN4dqMclBZKIZwccZppvH5dwFkBq5Smb/jrgY=;
        b=Nc8nLEaa21HMhDezUfC5lwyjSyFBJ42cIMjyfxscr5tJULO4xWqy7VX3NTn0yd7MPw
         AxL9SBfD+nf5uAWF8oNP4r637mLmZVHo5Kvw9kCQuNoP3Y1qMV4sk2WoySQIvJIJtEOP
         b7tn0U1BFu5ErXk60MXKMLaTf5LMPt6v1kug4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WUXh/vHN4dqMclBZKIZwccZppvH5dwFkBq5Smb/jrgY=;
        b=YdZBdjSFvDcogAPUKbpXUJytFqzW9EimykVs/sDgTQe7nXNKGIHOXK1hUPkEvcfK9J
         1prV61Z47uVur4GswKWq0vf8ygvbiz7+HLd7a5/YPWx3Fl8KMQq4jmnt42gGD2ZlI2TA
         fe+FTErmnz+wAGugqrwwHbaV8j4UrXbkPoPmCfy8J1yfN9fSvVfdGxEHNqA5iggMOZyg
         96CZVoLtPOj8p4UphLBr3uGrdU+wucZ23p3CoLo1LsJ7tD4gWJRxU5amKrAT7Ps36dTT
         pDK0K/mbfZjpxnGeBehpBM/8NZDvAHvpNMZtF+ie5NyDMZHpUdgDqU7ozeii+TdOwbe3
         qyrw==
X-Gm-Message-State: APjAAAWUZM2IhsgXWUT7A/ql7kmVsAB8OTfxQF/WCMobA/VJMxJmTKDo
        M/OHrwtw5wJlkCEAcFVoJ6/ewBdrtjU=
X-Google-Smtp-Source: APXvYqzQdUAu8W5hvXFW7X5JLjNJVpqC6OODkIo0uuskdhi13MCHW1PuRK2EhImgNFHMmE+O6/sy/Q==
X-Received: by 2002:a05:651c:153:: with SMTP id c19mr12499994ljd.237.1575744975949;
        Sat, 07 Dec 2019 10:56:15 -0800 (PST)
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com. [209.85.208.177])
        by smtp.gmail.com with ESMTPSA id n3sm8408473lfk.61.2019.12.07.10.56.14
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 07 Dec 2019 10:56:15 -0800 (PST)
Received: by mail-lj1-f177.google.com with SMTP id k8so11172219ljh.5
        for <linux-kernel@vger.kernel.org>; Sat, 07 Dec 2019 10:56:14 -0800 (PST)
X-Received: by 2002:a2e:86c4:: with SMTP id n4mr7607919ljj.97.1575744973488;
 Sat, 07 Dec 2019 10:56:13 -0800 (PST)
MIME-Version: 1.0
References: <157566809107.17007.16619855857308884231.stgit@warthog.procyon.org.uk>
 <CAJTyqKNuv+5x7zUTT_O56h7cGOVSEergF+QDXGHCpxXygVG_CA@mail.gmail.com>
In-Reply-To: <CAJTyqKNuv+5x7zUTT_O56h7cGOVSEergF+QDXGHCpxXygVG_CA@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sat, 7 Dec 2019 10:55:57 -0800
X-Gmail-Original-Message-ID: <CAHk-=wiamjvQAw1y2ymstHbato_XtrkBeWYf1xbi1=94Zft2NA@mail.gmail.com>
Message-ID: <CAHk-=wiamjvQAw1y2ymstHbato_XtrkBeWYf1xbi1=94Zft2NA@mail.gmail.com>
Subject: Re: [PATCH] pipe: Fix iteration end check in fuse_dev_splice_write()
To:     mceier@gmail.com
Cc:     David Howells <dhowells@redhat.com>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Al Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 7, 2019 at 10:30 AM Mariusz Ceier <mceier@gmail.com> wrote:
>
> I believe it's still not complete fix for 8cefc107ca54. Loading videos
> (or streams) on youtube, twitch in firefox (71 or nightly) on kernel
> eea2d5da29e396b6cc1fb35e36bcbf5f57731015 still results in page
> rendering getting stuck (switching between tabs shows spinner instead
> of page content).

Ok, so youtube (unlike facebook), I can test in firefox. Although it's
70, not 71 or nightly. And it doesn't seem to fail for me.

Of course, maybe the reason it doesn't fail for me is that I have a
patch in my tree that may be the fix. It's a very small race in
select()/poll(), and it's small enough that I wonder if it's really
the fix for this, but hey, it might be.

It also might be that your version of firefox is different, or just
that you're hitting something else that I'm just not hitting.

But I committed my patch and pushed it out, so that you could see if
that fixes it for you.

                Linus
