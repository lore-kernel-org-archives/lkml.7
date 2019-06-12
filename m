Return-Path: <SRS0=n7Fw=UL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,T_DKIMWL_WL_HIGH autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C889C31E44
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 02:08:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E857020866
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 02:08:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1560305281;
	bh=8UtWCl+qouRdxPKZ1wjZWhAx7DfmMoLDBjkFIXYvgx0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=Cg4RSApqs+MsmeNhY2go8dzQj6iHvSuHNF2r7ZzvcLNk5Emd9rIw3m33DUBoSgeG+
	 SI2E4upRxIGxMHT7xNxJY/kemYglFTWWEdZT7dDLA7+S4HrCAIT9F76k05aCb2Fyi8
	 N1WSq2FX158nCs2pFvl610odMj/P/xoQHErGVK9g=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2408315AbfFLCH7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Jun 2019 22:07:59 -0400
Received: from mail-lj1-f178.google.com ([209.85.208.178]:35197 "EHLO
        mail-lj1-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2406596AbfFLCH7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jun 2019 22:07:59 -0400
Received: by mail-lj1-f178.google.com with SMTP id x25so9007256ljh.2
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jun 2019 19:07:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zvcuGBw+4LQao88YFmzPADNOaa+2pmIz1aMFK+ndk6M=;
        b=XcZ9B2oIjVRXTLHyuEPsLajuh6i76LN69nh3G8uioz1IkqIoBNiJmqBx/YkM+zyHPY
         2G4ifYC/e/x616EYdSNIo03kIta8UGvL7gEmyY9zsCOwuEh0KIGgPW6cVGtYZOxKD6oY
         Cr+IJ89IjBKKmulpfediz94KCA9DcxQ3obwPo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zvcuGBw+4LQao88YFmzPADNOaa+2pmIz1aMFK+ndk6M=;
        b=MGd6ryUBl+jANQT/bRUnkp+U2nxi3U5y6jRMD/cWCQqTwlHeEDWvUICl2KtpkLporM
         QabZfbDdvpDFVhU/bh7ipKrnaKs5uzM6zIvMOO0lMi8CL5Iukmcxh4GXsaTLHE4GU7TZ
         BV6CY3xWhmVKvANZODAbFbxiRMDpovxCTy/gDOfVdsyKgbwo+v2KnMjzPVZAW37WhWSE
         ME1n4i6PmcQgmkEWB4vdf6YC1c8mDDHGHgzAWQUmz41gNkpO5v8zFrPlC6z/zQy6sA3a
         WNOgtuos7XoF7/JczN1AgIARJEK8ZDeJl3SrruFjDbBlqYvniZ8HvY7qzuyRxxhTN645
         aTXA==
X-Gm-Message-State: APjAAAVSjXVDkZOBm0U8phTEwyJJJx4xEoDVji7DqFKdx6YZ6CjJbYXd
        yZgZsRP33U+0hQmy0zFkIyPZYa7GZes=
X-Google-Smtp-Source: APXvYqxxzgi636gUWTt0sX4U3Yvge1rYocP1nsSO+hGTAduUdWcBEuq3XmUdXD5hqqatOXDfW9L/Dw==
X-Received: by 2002:a2e:1510:: with SMTP id s16mr13515961ljd.19.1560305277155;
        Tue, 11 Jun 2019 19:07:57 -0700 (PDT)
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com. [209.85.208.180])
        by smtp.gmail.com with ESMTPSA id n1sm543626lfk.19.2019.06.11.19.07.56
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Tue, 11 Jun 2019 19:07:56 -0700 (PDT)
Received: by mail-lj1-f180.google.com with SMTP id 16so13583863ljv.10
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jun 2019 19:07:56 -0700 (PDT)
X-Received: by 2002:a2e:9c03:: with SMTP id s3mr26468187lji.209.1560305276220;
 Tue, 11 Jun 2019 19:07:56 -0700 (PDT)
MIME-Version: 1.0
References: <20190610191420.27007-1-kent.overstreet@gmail.com>
 <CAHk-=wi0iMHcO5nsYug06fV3-8s8fz7GDQWCuanefEGq6mHH1Q@mail.gmail.com>
 <20190611041045.GA14363@dread.disaster.area> <CAHk-=whDmeozRHUO0qM+2OeGw+=dkcjwGdsvms-x5Dz4y7Tzcw@mail.gmail.com>
 <20190611071038.GC14363@dread.disaster.area>
In-Reply-To: <20190611071038.GC14363@dread.disaster.area>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 11 Jun 2019 16:07:40 -1000
X-Gmail-Original-Message-ID: <CAHk-=wgBdTUvjYXKPr_wAAe_Z-hFgM2KMHcsK+b=3w5yMSJ9zw@mail.gmail.com>
Message-ID: <CAHk-=wgBdTUvjYXKPr_wAAe_Z-hFgM2KMHcsK+b=3w5yMSJ9zw@mail.gmail.com>
Subject: Re: bcachefs status update (it's done cooking; let's get this sucker merged)
To:     Dave Chinner <david@fromorbit.com>
Cc:     Kent Overstreet <kent.overstreet@gmail.com>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-bcache@vger.kernel.org, Dave Chinner <dchinner@redhat.com>,
        "Darrick J . Wong" <darrick.wong@oracle.com>,
        Zach Brown <zach.brown@ni.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Jens Axboe <axboe@kernel.dk>,
        Josef Bacik <josef@toxicpanda.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Tejun Heo <tj@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 10, 2019 at 9:11 PM Dave Chinner <david@fromorbit.com> wrote:
>
> The same rwsem issues were seen on the mmap_sem, the shrinker rwsem,
> in a couple of device drivers, and so on. i.e. This isn't an XFS
> issue I'm raising here - I'm raising a concern about the lack of
> validation of core infrastructure and it's suitability for
> functionality extensions.

I haven't actually seen the reports.

That said, I do think this should be improving. The random
architecture-specific code is largely going away, and we'll have a
unified rwsem.

It might obviously cause some pain initially, but I think long-term we
should be much better off, at least avoiding the "on particular
configurations" issue..

              Linus
