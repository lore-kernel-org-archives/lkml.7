Return-Path: <SRS0=v0Gj=WB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71A4EC0650F
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Aug 2019 14:28:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4885D20679
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Aug 2019 14:28:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1565015284;
	bh=EFibC8nuHz8k2yU2grpf2ggs1Z3fm4CC0QMtC9RxKSo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=ANck+pqy0VH41o4QOkG+PGubdjlLk8bVnegfpovtIengoJCjCHA0EiD2iGWQMrLwW
	 O7+EDA1fMCreLH9PJIxgq1lY48v6Q2SqU4kOjilxiMAhBj1Bs1l94/r+yzWgDVQyQR
	 P7/yH2zeTTg03TIIYlOmF9Bkjt5O2kOms7xWwqLA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729558AbfHEO2D (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Aug 2019 10:28:03 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:40546 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728015AbfHEO17 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Aug 2019 10:27:59 -0400
Received: by mail-qt1-f194.google.com with SMTP id a15so81063192qtn.7
        for <linux-kernel@vger.kernel.org>; Mon, 05 Aug 2019 07:27:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=MPEMXXmCHM/Mi/52mb4NCYntDnv4EkvOmRuE01mrmhM=;
        b=LsYu/7kbcZOBmMJF2KPR0BdGTxfFG4KIPTNBXea2pkzguDONumtWEwAtUGH2h/3hHr
         AlrEx4oWTmsYDmbOCECB7IY3NUlCBLrjfKE5pSSSq5AhaeQ0Z+cTjkjdMxxFT5TxPVxM
         ICdTYMGtFfhKijP26HFPKcqWDexRxlkTDtrmQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=MPEMXXmCHM/Mi/52mb4NCYntDnv4EkvOmRuE01mrmhM=;
        b=HHGkyR4BHMAfNjjCKvnx/JuGcuO0VcbiDNji01kRQI6e2dVfFhuEFBJ9lq6dAxQXei
         CzGXqbz8ZBojjNkBvFm+9K11gFcwxYW5M7NYWN+8AxWcT5Xa308k1XpNIf34iSPaHaNW
         +G74uQ9YrKEhvoPPE7QOVeEPCKRVemy1tzrGWxCG9mDMGrbdoUdAUj1v6rtbOU2BEG7Y
         CzwcxyJSWZkUMa8hTQZQtXXByiytoLN+lbqtXlRhrRnsPZkBobcGFcO0KqxQMkYDQk0k
         j+2n4JHvnbDaP42cWcrjiYRGPTkceIPKkdPanzTJLypBGG/Y/UBaBT59ZhNZyh0Nyz8N
         Zc7A==
X-Gm-Message-State: APjAAAUlZr+yVrWLe69ksV/nq9ev5lfR4VdoM3OArgP2ZcIvPiFqUocc
        ggPrSTjc5JTKF8V/LXk5lXdkHg==
X-Google-Smtp-Source: APXvYqwNWHoP8flXC29xSNV4hE27uDEAsRgm6KXmlO41iOn5/WG4m1AQejfoVX6v04H7CdZ0ocxj9w==
X-Received: by 2002:ac8:2a88:: with SMTP id b8mr97552817qta.331.1565015278681;
        Mon, 05 Aug 2019 07:27:58 -0700 (PDT)
Received: from chatter.i7.local (192-0-228-88.cpe.teksavvy.com. [192.0.228.88])
        by smtp.gmail.com with ESMTPSA id j2sm38240945qtb.89.2019.08.05.07.27.57
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 05 Aug 2019 07:27:57 -0700 (PDT)
Date:   Mon, 5 Aug 2019 10:27:56 -0400
From:   Konstantin Ryabitsev <konstantin@linuxfoundation.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Micah Morton <mortonm@chromium.org>,
        linux-security-module <linux-security-module@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [GIT PULL] SafeSetID MAINTAINERS file update for v5.3
Message-ID: <20190805142756.GA4887@chatter.i7.local>
References: <CAJ-EccMXEVktpuPS5BwkGqTo++dGcpHAuSUZo7WgJhAzFByz0g@mail.gmail.com>
 <CAHk-=whZzJ8WxAeHcirUghcbeOYxmpCr+XxeS9ngH3df3+=p2Q@mail.gmail.com>
 <CAJ-EccOqmmrf2KPb7Z7NU6bF_4W1XUawLLy=pLekCyFKqusjKQ@mail.gmail.com>
 <CAHk-=wgT7Z3kCbKS9Q1rdA=OVxPL32CdBovX=eHvD2PppWCHpQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
In-Reply-To: <CAHk-=wgT7Z3kCbKS9Q1rdA=OVxPL32CdBovX=eHvD2PppWCHpQ@mail.gmail.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 04, 2019 at 10:47:54AM -0700, Linus Torvalds wrote:
> - maybe pr-tracker-bot ignores follow-up emails with "Re:" in the 
> subject?

Yes, this is the culprit. Here are the matching regexes:

https://git.kernel.org/pub/scm/linux/kernel/git/mricon/korg-helpers.git/tree/pr-tracker-bot.py#n41

Normally, pull requests don't come in as replies -- this is the first 
one that got missed in months, to my knowledge.

I can change it to be more permissive -- the only concern would be that 
we would be scanning more bodies, and there *might* be a chance where we 
end up tracking the wrong message if someone uses Outlook-style replies 
(fully quoted messages without '>') and those replies arrive before the 
original message. Both of these are very unlikely to happen (in fact, I 
believe using Outlook-style replies on LKML would result in mass 
outrage).

So, just let me know if you'd like me to make this change and I'll 
modify the regex to be something like '^\S*:?\s*\[GIT' that should match 
most permutations of Re/Aw/etc.

-K
