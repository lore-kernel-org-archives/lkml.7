Return-Path: <SRS0=G0tX=VI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0E6CC74A42
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jul 2019 05:34:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 93777208E4
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jul 2019 05:34:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=brauner.io header.i=@brauner.io header.b="UpphnqOP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727967AbfGKFed (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Jul 2019 01:34:33 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:34740 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725963AbfGKFec (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Jul 2019 01:34:32 -0400
Received: by mail-wr1-f67.google.com with SMTP id 31so4780331wrm.1
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jul 2019 22:34:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brauner.io; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=0ARpJ/V7oPnYvJoBHI+9Ruk+sXdy3kbv33tZdnVTgxM=;
        b=UpphnqOPq3Ku0ZCUFmz9lmcfA4YjgU81oRKs2j58gnusawOayAueeiyVcl+WCLbLqx
         S6NMWqaVvplGHSo7B63jivjr8oDXs8IDdRn0wxZ1Jg7owOF4bEsALZjWQ3ALTTfuvzrD
         C73ChZLveYFqKcoIDSCd6miulT/yX/kls7w2XWqX3RNLLidmtNULEuJtLvMC+3/IxLRc
         iUiqwAKx3quscpGVWCgEWPP3txaA2zg/oLpA0M/b5oRVgM5vWMZG6jFYA/QRhFpJvCn1
         /i8QLNLDbuLKRkA0QDuIiOunJS453u1JZxLdZXa4WXQo7ENcDvOmVBe8P6e3zgUwKEOp
         muWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=0ARpJ/V7oPnYvJoBHI+9Ruk+sXdy3kbv33tZdnVTgxM=;
        b=lYXOPwgG7ogX4M15XO6wWrUyxs2LknDe072498IcYIwTqEunvW2txHDd0E48ORk5NJ
         nGss6Lie5sgJeFs9T5b+68EdeHrGW49ukkRIDQVE4sYzHBUY81Mm5E3nUbEympyInxPz
         abnzREt1n5K+IhYwypO8RmAMED3G5sNZESVmNM8FRLt1wzhSVP8U6p7zONG6azI1MHut
         iNCrLQiLmUW4By2r/ZPmlZN8mhfbagLiioXKFJ9J11RRKuC1WdN+5S0fir37v23Xzica
         AMlkZ58P9nula433IoVwwA45KjKBxjlx89hU3U7nJ+xTj7rBZ1l1L77zi+JJ6MHb91lU
         72qQ==
X-Gm-Message-State: APjAAAUzrbk1ZFqe81iYnneAvznoQGQwOJInlFGcpVCbI3ZLPE0K8jja
        r9EVIayR/Ijg7elpkNEYR9Y=
X-Google-Smtp-Source: APXvYqzRRfXuXV9/R5eyrIeytqJVsDFHv1dOUR0WPFNUItLrQSBKslM0xpblE4I7jaVNY4ktAfRLMg==
X-Received: by 2002:adf:eac4:: with SMTP id o4mr2082285wrn.290.1562823270417;
        Wed, 10 Jul 2019 22:34:30 -0700 (PDT)
Received: from brauner.io ([212.91.227.56])
        by smtp.gmail.com with ESMTPSA id c9sm3133110wml.41.2019.07.10.22.34.29
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 10 Jul 2019 22:34:29 -0700 (PDT)
Date:   Thu, 11 Jul 2019 07:34:29 +0200
From:   Christian Brauner <christian@brauner.io>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux List Kernel Mailing <linux-kernel@vger.kernel.org>
Subject: Re: [GIT PULL] clone3 for v5.3
Message-ID: <20190711053428.ofapcx7nn5xkyru4@brauner.io>
References: <20190708150042.11590-1-christian@brauner.io>
 <CAHk-=wg0jcyTO+iXgP-CpNwvJ4mTCcg3ts8dLj3R5nbbonkpyQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAHk-=wg0jcyTO+iXgP-CpNwvJ4mTCcg3ts8dLj3R5nbbonkpyQ@mail.gmail.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 10, 2019 at 10:24:26PM -0700, Linus Torvalds wrote:
> On Mon, Jul 8, 2019 at 8:05 AM Christian Brauner <christian@brauner.io> wrote:
> >
> > /* Syscall number 435 */
> > clone3() uses syscall number 435 and is coordinated with pidfd_open() which
> > uses syscall number 434. I'm not aware of any other syscall targeted for
> > 5.3 that has chosen the same number.
> 
> You say that, and 434/435 would make sense, but that's not what the
> code I see in the pull request actually does.
> 
> It seems to use syscall 436.
> 
> I think it's because openat2() is looking to use 435, but I'm a bit
> nervous about the conflict between the code and your commentary..

Sorry, that was just me being dumb and forgetting that there was
close_range() which had a chance of going through Al's tree. So I left a
hole for it.

I don't terribly mind if it's 435 or 436. People pointed out you might
even renumber yourself if something makes more sense to you.

Christian
