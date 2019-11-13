Return-Path: <SRS0=LLNM=ZF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 916FDC432C3
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Nov 2019 21:21:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6A36A206E3
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Nov 2019 21:21:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573680087;
	bh=QCnDRQ7DaMoIhjEkWQDYoULwSnBenDn50OnlPgLmQJQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=t8iY3BYM+SVSry/dpmpj9stn90CDweLutOidflnZ3cnOBi67NsLM5xrLnUyweeASb
	 piiJNKgc8n0WdxbkOCVpuueRvkRgYg4yb1MixxJIcIIN76CA99ZGh0qTrWLEhLAvPB
	 6cUphv3RLq+IWJg+TgSzFgtXc8+s3IIzudOYYeh8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726962AbfKMVVY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Nov 2019 16:21:24 -0500
Received: from mail-il1-f196.google.com ([209.85.166.196]:34440 "EHLO
        mail-il1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726291AbfKMVVX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Nov 2019 16:21:23 -0500
Received: by mail-il1-f196.google.com with SMTP id p6so3206330ilp.1
        for <linux-kernel@vger.kernel.org>; Wed, 13 Nov 2019 13:21:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ipLY1M1D6ikWjl2rcpB26ePklwIbYUz7Y+DBcvUypi4=;
        b=P4m2DwneMkW9qy/B4Wh2CaWbS1W07T3XiUxsGHqX5E1O+u8ZuHTysWPwzFWsC37TJ1
         JihC6AOA0CING2JTOQ50SrJ5OyYy2kUcTzRDlCr7jygBh+bk87nZJt3aL3B33DuC4c5s
         BRaBh9E39OFiXQ1anV6/7Wld5LNQ1oRiolIlA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ipLY1M1D6ikWjl2rcpB26ePklwIbYUz7Y+DBcvUypi4=;
        b=ixAmzs21LZaPS3KwaS2WXG2iy7TEL2OHljrIVGD3L3wIRzeHdDvShtu7hwBX/3OwcL
         F77KluXdqx4PUeHylXk6X1X5Hsecwaqq7Igwi73RXAKlYoJKHnxgIjTIMFWDRbT9g5gF
         Pg1SqimHYglO6OhEZpW5av4y4wsoDAkddjHqGI4skcbEN+bEiELDqrla4RUgtFFPBCPZ
         yjnssUiLbKmRi0dJMdyZltmkdUAdt0nZ93b4MvTsXYjdGhdoIC3AArx0xvbA0jPyj5/t
         o3f/1EfiuCPwKJ6mTckK9V5TE7KfMf1wSq6Tle83cICKE2zSE+dfpnWrGMbpa1wlGH0b
         Z+7Q==
X-Gm-Message-State: APjAAAXKENko8bhlXEqZBw5IXE6NjAMeBZcie7uWzJbuEGbv3Oe6v7k2
        Y6BeAGjTnhsxt0RO96i0dKUludtzeiMh02QgPJuIkA==
X-Google-Smtp-Source: APXvYqyYXdWjXpeh2GFyglVo9DPN8ElwDuFN9pANgbDpCk7yGxh1ZCW5V1D6mDR9r0nSNIwfWgK9dhK4C4KiMjabXvw=
X-Received: by 2002:a92:1d52:: with SMTP id d79mr6036405ild.185.1573680082857;
 Wed, 13 Nov 2019 13:21:22 -0800 (PST)
MIME-Version: 1.0
References: <20191113204240.767922595@linutronix.de> <20191113210104.882617091@linutronix.de>
 <CAHk-=wh9BdH5DLjfv72LOWSb6P1jMwO0TYraS1gnYZDdTCi+rQ@mail.gmail.com>
In-Reply-To: <CAHk-=wh9BdH5DLjfv72LOWSb6P1jMwO0TYraS1gnYZDdTCi+rQ@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 13 Nov 2019 13:21:12 -0800
Message-ID: <CAADWXX8Rf5jGNw3=A44GtzZd875bL9s2DV4R3nUorU9FJECMcw@mail.gmail.com>
Subject: Re: [patch V3 12/20] x86/ioperm: Move TSS bitmap update to exit to
 user work
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Stephen Hemminger <stephen@networkplumber.org>,
        Willy Tarreau <w@1wt.eu>, Juergen Gross <jgross@suse.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 13, 2019 at 1:19 PM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> I wonder if it might make sense to delay it even more: [..]

Btw, don't take that as a suggestion to make further changes. It was
more of an idle observation, and it probably doesn't matter one whit.

              Linus
