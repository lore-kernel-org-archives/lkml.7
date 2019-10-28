Return-Path: <SRS0=HHJ+=YV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1D0BCA9EC1
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Oct 2019 12:57:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 777C0214D9
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Oct 2019 12:57:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov-name.20150623.gappssmtp.com header.i=@shutemov-name.20150623.gappssmtp.com header.b="srML+4c4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729147AbfJ1M5D (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Oct 2019 08:57:03 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:38909 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728269AbfJ1M5D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Oct 2019 08:57:03 -0400
Received: by mail-lj1-f193.google.com with SMTP id q78so11235811lje.5
        for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2019 05:57:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=0z8rcnJQ2Ztw3XS+4jmpXqQHR2gbd+xnEDMVQdJ2PKg=;
        b=srML+4c4W5XX21msxWpc4UTlLGRvocfhX+m8lvWZmTqWJ5JCiI2mfWZTnHxVqaYfjb
         RZj0UT8eW/naYqmghTosmknDZj7Xpio4LxUzGrGSO3//giGKDQmYVrnZ/paCFuFAQcsB
         V7znTFFwZzkN0gTbaEAl9TrDNfH1cG7W0wF73Ynd7rAmULk2w/g74sEdzHqe4AhDJ+3H
         vPLMBrEepytPqjx0ZwiWK8rMJ4d7YqC1t7Ci1xJs9k1l4TphNVHkdFQ5/Xx3FdjDjY1D
         qJp1PdMkWXv1nkI0LJwRV0l4SfjCylX+qDHekhf7ufySNb4+QR/AwOoYHWdrxpSqs3Sq
         uUiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=0z8rcnJQ2Ztw3XS+4jmpXqQHR2gbd+xnEDMVQdJ2PKg=;
        b=LxYKsdO2+wfDG0pUGoos3gQcY4Km7jA85CtBCCq8GTB1daGUoRK/pCmKIUU/352v3Q
         UvXpWDifaLib+Gq4LzdYLeFdM2v5ENb5YZZQnEmNujYJIj4hQxLaFIZIEnlGJaEIn3/t
         +wfsWXN/K030WEEio/Rm4bhXvF7kT0hcIMsNRk3eIXh7pImKElmkzi+Sed0Qh4VjpA3O
         qA5iBYl6voGdcbLEv8lTds73qYtiHiyOfugHhuX0bdxhNH4IVTgKK+d9+ZP7H+Wb7S5j
         rU5gb0iBi7g9MUJa4+MltQQqVG/1Hgy1EyBGjtR1MG220TZ70mH8NOGTRA+biYTJmTZ2
         JWFQ==
X-Gm-Message-State: APjAAAWsNpFSGf75AD/DsVRlgIYYxKUN8xSS6rndmmF/zSWs89agxDOD
        hrBocMFOaBxl3Ferz2moZTvKVEYEMn0=
X-Google-Smtp-Source: APXvYqxnZmY+iQCpMLmbeFZh5dem+tdNcGHC4iY1KE4BMNoGuCBgfBV/T08SYVaI0ko2KXi+altLhA==
X-Received: by 2002:a2e:9759:: with SMTP id f25mr175210ljj.173.1572267421409;
        Mon, 28 Oct 2019 05:57:01 -0700 (PDT)
Received: from box.localdomain ([86.57.175.117])
        by smtp.gmail.com with ESMTPSA id a11sm5241245ljp.97.2019.10.28.05.57.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Oct 2019 05:57:00 -0700 (PDT)
Received: by box.localdomain (Postfix, from userid 1000)
        id C0662100242; Mon, 28 Oct 2019 15:57:02 +0300 (+03)
Date:   Mon, 28 Oct 2019 15:57:02 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Konstantin Khlebnikov <khlebnikov@yandex-team.ru>,
        Linux-MM <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Steven Whitehouse <swhiteho@redhat.com>
Subject: Re: [PATCH] mm/filemap: do not allocate cache pages beyond end of
 file at read
Message-ID: <20191028125702.xdfbs7rqhm3wer5t@box>
References: <157225677483.3442.4227193290486305330.stgit@buzz>
 <20191028124222.ld6u3dhhujfqcn7w@box>
 <CAHk-=wgQ-Dcs2keNJPovTb4gG33M81yANH6KZM9d5NLUb-cJ1g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wgQ-Dcs2keNJPovTb4gG33M81yANH6KZM9d5NLUb-cJ1g@mail.gmail.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 28, 2019 at 01:47:16PM +0100, Linus Torvalds wrote:
> On Mon, Oct 28, 2019 at 1:42 PM Kirill A. Shutemov <kirill@shutemov.name> wrote:
> >
> > I've tried something of this sort back in 2013:
> >
> > http://lore.kernel.org/r/1377099441-2224-1-git-send-email-kirill.shutemov@linux.intel.com
> >
> > and I've got push back.
> >
> > Apparently, some filesystems may not have valid i_size before >readpage().
> > Not sure if it's still the case...
> 
> Well, I agree that there might be some network filesystem that might
> have inode sizes that are stale, but if that's the case then I don't
> think your previous patch works either.
> 
> It too will avoid the readpage() if the read position is beyond i_size.
> 
> No?

Yes. That's the reason the patch was rejected back then.

My point is that we need to make sure that this patch not break anything.

-- 
 Kirill A. Shutemov
