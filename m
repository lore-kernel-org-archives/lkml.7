Return-Path: <SRS0=GGWy=XB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 978BBC00307
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Sep 2019 15:40:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6ACE82173B
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Sep 2019 15:40:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="X+TZLFq+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405820AbfIFPkM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Sep 2019 11:40:12 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:35424 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404493AbfIFPkL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Sep 2019 11:40:11 -0400
Received: by mail-ed1-f66.google.com with SMTP id t50so6711680edd.2
        for <linux-kernel@vger.kernel.org>; Fri, 06 Sep 2019 08:40:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=CjF3fwI23SGTIbsZbebpupUjHvggvSShXHb+f7gohRg=;
        b=X+TZLFq+/8fiOOZaSxM4o7weyYJJYjKBVTcRCZfcxr2IxHAce/BmJfEXlo+kHisHhF
         mlpMhUTxWtcXV/LgdZFzuY7qNCrZaKMw8ItKcgilp5WTkQNFuCtZgPd4jGMxpgeusHKy
         +ahYXFtlTF+mSXTcvIEKTHM34JZSa4gUxMyQbY9ovXkeE1DqzeHziy0kVUOT9HDoGgh+
         86qEcJGuBwvEp64MJNk43vufsS6oXhTwJOTInG+rMeHXceUdYHOhY8j0CA+yEADsDreV
         fxhYTUKSD4lXhNC87Jhmdi20O2F9lotiaxFikDlzOtV2OTRHPhktK0wYcLrfjjdxvON+
         FoEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CjF3fwI23SGTIbsZbebpupUjHvggvSShXHb+f7gohRg=;
        b=MEuKYa10ME8h2mfEWqrWHOfquGwVB7YSuhMlvmz1tcbGnFLXEfCEkUlkxBrvp+7rPs
         vlRdsalSSZnOEaaM5WRfcLGEgNXEN8n7+0JUV72MVRssYYS/ZFkMQdrVCD3qxYMHKo8K
         OQdLO8st8Fxu8uNMiBb2HlCT2kqKq7O3NSsEvX7vNP97S8osVBzkGs3xyUzUhwsMO4DY
         64V7sU+Cx6NMjnqWlZJmhDpy3d0jSU/qeSSRCmkh+eBGKtvPDnjmqvI3M85likfEOkjH
         OFomDxTPaWZLas1Gf/M3GEA+QObb5GN1A6Gi4JyuMfRWIYFZcWAi3R2IbkOvqfDVb9z0
         tzhw==
X-Gm-Message-State: APjAAAUIPaSiZNUYT0SeTWdUSMnHsT8akzD2pvoTRxWS9/9FtbLb/lMw
        qpmZh4V16Q5pxUeanjXhdNvH7UfmfN8pEtitr1VewA==
X-Google-Smtp-Source: APXvYqwgWEKdsXXZDKUgZfHTTS/3PBS/mpsvU7NBgD+cDEAZM2KkwC32Gcr7KkyJWBr9wuGwTdTO2+WUmBcm/dqbcb4=
X-Received: by 2002:aa7:dd17:: with SMTP id i23mr10239139edv.124.1567784409076;
 Fri, 06 Sep 2019 08:40:09 -0700 (PDT)
MIME-Version: 1.0
References: <20190821183204.23576-1-pasha.tatashin@soleen.com>
 <20190821183204.23576-3-pasha.tatashin@soleen.com> <dc6506a0-9b66-f633-8319-9c8a9dc93d4f@arm.com>
In-Reply-To: <dc6506a0-9b66-f633-8319-9c8a9dc93d4f@arm.com>
From:   Pavel Tatashin <pasha.tatashin@soleen.com>
Date:   Fri, 6 Sep 2019 11:39:58 -0400
Message-ID: <CA+CK2bBgUH8v_bYEyJKPsLZFDxse6xYRwGR8KN=SzgHnrR9yhA@mail.gmail.com>
Subject: Re: [PATCH v3 02/17] arm64, hibernate: use get_safe_page directly
To:     James Morse <james.morse@arm.com>
Cc:     James Morris <jmorris@namei.org>, Sasha Levin <sashal@kernel.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        kexec mailing list <kexec@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Catalin Marinas <catalin.marinas@arm.com>, will@kernel.org,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Vladimir Murzin <vladimir.murzin@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Bhupesh Sharma <bhsharma@redhat.com>,
        linux-mm <linux-mm@kvack.org>,
        Mark Rutland <mark.rutland@arm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 6, 2019 at 11:17 AM James Morse <james.morse@arm.com> wrote:
>
> Hi Pavel,
>
> Nit: The pattern for the subject prefix should be "arm64: hibernate:"..
> Its usually possible to spot the pattern from "git log --oneline $file".

Sure, I will change here and in other places to "arm64: hibernate:"

>
> On 21/08/2019 19:31, Pavel Tatashin wrote:
> > create_safe_exec_page is a local function that uses the
> > get_safe_page() to allocate page table and pages and one pages
> > that is getting mapped.
>
> I can't parse this.
>
> create_safe_exec_page() uses hibernate's allocator to create a set of page table to map a
> single page that will contain the relocation code.

Thanks I will rephrase it with your suggestion.

>
>
> > Remove the allocator related arguments, and use get_safe_page
> > directly, as it is done in other local functions in this
> > file.
> ... because kexec can't use this as it doesn't have a working allocator.
> Removing this function pointer makes it easier to refactor the code later.

Thanks, I will add it to the description.

>
> (this thing is only a function pointer so kexec could use it too ... It looks like you're
> creating extra work. Patch 7 moves these new calls out to a new file... presumably so
> another patch can remove them again)
>
> As stand-alone cleanup the patch looks fine, but you probably don't need to do this.

Without this clean-up moving to common code becomes messier. So, I
would like to keep this change.

Thank you,
Pasha
