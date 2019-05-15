Return-Path: <SRS0=AMXA=TQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 437D0C04E53
	for <linux-kernel@archiver.kernel.org>; Thu, 16 May 2019 01:50:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 15A972087E
	for <linux-kernel@archiver.kernel.org>; Thu, 16 May 2019 01:50:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1557971402;
	bh=JXxjRrjGw+vkXpAOIY1GSENUSzQWMmiEK2lHtje3JY0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=irOvSci64uQl+t7mkihM68X/OZtsYIK5JlwPk0aPAf6OJE7GeHkxwALM0iuhOcE/X
	 umfch2yQameJEnPFEJeEiSGWi88HPfx7CWsxdcLrV2gS+toT0IC6x/CdwRANNC7dfL
	 /CsURJhWvf2DtraBx7cufDnD81YxQW2qGswJRgeA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727168AbfEPBqX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 May 2019 21:46:23 -0400
Received: from mail-lj1-f174.google.com ([209.85.208.174]:33326 "EHLO
        mail-lj1-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726427AbfEOXpv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 May 2019 19:45:51 -0400
Received: by mail-lj1-f174.google.com with SMTP id w1so1407042ljw.0
        for <linux-kernel@vger.kernel.org>; Wed, 15 May 2019 16:45:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XvNT9HlDb1U3GFh1Fv/LSA0RjY1svVk5+rl3ZUL9cA0=;
        b=d4uPRGGPWp4sUCTPgCXRTo/SOy5wf3Fv3B24MNLSC/6oIZK+kGJ5H/g6Cy5bu0jwtC
         t12fdaj6McFSwM/i/4KHSkKe8Vk/GTvEffEy8RfjMxOfX6JTSsWMg0lOIBFg3sVIn4rh
         /wYdFilszy8spI2+EvIEbchFFAUvwvDelxLGw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XvNT9HlDb1U3GFh1Fv/LSA0RjY1svVk5+rl3ZUL9cA0=;
        b=UJDjvLk4lJf4BcgrxtyQpVBWb1aCFpudLi018E7rhGcLgl7DtdS4/1HzUpVvas9lDa
         fAP6MC224WjgACFKxz+VAF+4iKqSHvZG9OxYRlGtNQEitmcsRykdGAP4mqq6sGJDeroP
         /DdVfcuSflp7y0G/H2/s0iTERqdAx4MQGxR5kA3C/d2TB8sDr2m6wEVCZuSblVirDN0m
         yEVhwqQTR7L7Yb4mU66sxP8RFG0G9lS0FLWYF+Uzxmk3gfg8jZWCzSYYPxidwvshXDkp
         jtEnR4kTSjw7Xkx94NuT3f/yN13ehYyelFZ+tnCL7Q/0JWemBy0BaYZLHq+B9Fj4Uxmr
         bqxg==
X-Gm-Message-State: APjAAAWsAaunSoDAna0NbtZS/DYTYMGCRxKvpOkVIpCvCElUh+hrSbGq
        9ps2uCO0L1ZvAzN+04kMBJ+wLD15yJg=
X-Google-Smtp-Source: APXvYqyBGMxn4xej32gAKM4it4HZ+Ql9l49Zm893cbejpovwYvBjbLtFGZsYh9Q9m/pg/5ukVZzvJw==
X-Received: by 2002:a2e:5d49:: with SMTP id r70mr23441189ljb.102.1557963949035;
        Wed, 15 May 2019 16:45:49 -0700 (PDT)
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com. [209.85.208.169])
        by smtp.gmail.com with ESMTPSA id e14sm652965ljk.45.2019.05.15.16.45.47
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 15 May 2019 16:45:47 -0700 (PDT)
Received: by mail-lj1-f169.google.com with SMTP id a10so1367010ljf.6
        for <linux-kernel@vger.kernel.org>; Wed, 15 May 2019 16:45:47 -0700 (PDT)
X-Received: by 2002:a2e:9a94:: with SMTP id p20mr11981537lji.2.1557963947423;
 Wed, 15 May 2019 16:45:47 -0700 (PDT)
MIME-Version: 1.0
References: <20190515135602.2a6e6012@oasis.local.home>
In-Reply-To: <20190515135602.2a6e6012@oasis.local.home>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 15 May 2019 16:45:31 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjbT4ZsWM=Rmz40+_umLmKz70ksEMnEOhLWJzQWudyNUA@mail.gmail.com>
Message-ID: <CAHk-=wjbT4ZsWM=Rmz40+_umLmKz70ksEMnEOhLWJzQWudyNUA@mail.gmail.com>
Subject: Re: [GIT PULL] ktest: Updates for 5.2
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        John Warthog9 Hawley <warthog9@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 15, 2019 at 10:56 AM Steven Rostedt <rostedt@goodmis.org> wrote:
>
> Updates to ktest.pl

Your pull request is showing stale data.

>  - Handle meta data in GRUB_MENU
>
>  - Add variable to cusomize what return value the reboot code should return.

These were already long merged, from your first pull request last Monday.

See

  68253e718c27 ("Merge tag 'ktest-v5.1' of
git://git.kernel.org/pub/scm/linux/kernel/git/rostedt/linux-ktest")

and your own pull request

  Message-ID: <20190506133837.55832171@gandalf.local.home>

Hmm?

                Linus
