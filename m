Return-Path: <SRS0=gp+X=WL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B91F4C3A589
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Aug 2019 20:49:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 85AB82173B
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Aug 2019 20:49:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="YIJ7YIpM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732667AbfHOUto (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Aug 2019 16:49:44 -0400
Received: from mail-oi1-f195.google.com ([209.85.167.195]:34341 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730540AbfHOUto (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Aug 2019 16:49:44 -0400
Received: by mail-oi1-f195.google.com with SMTP id l12so3271681oil.1
        for <linux-kernel@vger.kernel.org>; Thu, 15 Aug 2019 13:49:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lgnLIsY3NAF2I8cARaxRotDmNV7GudD+acm8febioSE=;
        b=YIJ7YIpMxznBPHgTdpSwquDHILTgLsnpo12EU8rkd+AHKFJZ5ZwqKoIwrRqaFSFR8y
         OSm/+kJt94YLyv2W7RB5Syzoulous/GPdyhQE4c6S/acM0xv4AIF2T1fqDaLkhBzGFIm
         8xguUk+swY546hiuNvL1kRCs6fhSMGv4cUMt8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lgnLIsY3NAF2I8cARaxRotDmNV7GudD+acm8febioSE=;
        b=O/N57L+yU54H45dwsxKDPkzetnFuDtTfo1s9q2L9WSnHtl+zNl/MvrhE8IHP1ri2U4
         f3WMOeJU67dw8t2I82zIqiZN+AF87Ix5Sx54oWNSJtO6yUPIBOSLbs9BmASG45qscIHn
         CnDcFCo11hL8mobY7QJAiu8ogcgUMV9OqmRmZA7nwohNwu/gKgf9A9psWWZNJ7OttkW7
         r+kV8uqLjyYv3kA1h3f+Hj682G27j/1y0svu9encN/S39s2/DXqxmFBLH3eisYGZrYNq
         A5ZjC349Cu0dGRWRkROIKMMC2ZoeevtLOshSWIvFYgZJxyJbJnL1WmEN41ilsU6TjjCO
         ndwg==
X-Gm-Message-State: APjAAAWtSPO7gfazr8YZYo+v1PqczmjAN2O7Y0Zy6bz/g3px8DeE7aM8
        4TNbAlsBJp7PmBZTisZXyr1fzkfKHECrE2ghpEDUiw==
X-Google-Smtp-Source: APXvYqwzZ/kApGN6PiSs4Jakj+3xLiJKsdwsUzoZ79QigfmdRjFBzCS/DYJGNsj8cG6QhlWGKnUS/ZCe5UFKl5trWe8=
X-Received: by 2002:aca:4994:: with SMTP id w142mr2705861oia.132.1565902183316;
 Thu, 15 Aug 2019 13:49:43 -0700 (PDT)
MIME-Version: 1.0
References: <20190815132127.GI9477@dhcp22.suse.cz> <20190815141219.GF21596@ziepe.ca>
 <20190815155950.GN9477@dhcp22.suse.cz> <20190815165631.GK21596@ziepe.ca>
 <20190815174207.GR9477@dhcp22.suse.cz> <20190815182448.GP21596@ziepe.ca>
 <20190815190525.GS9477@dhcp22.suse.cz> <20190815191810.GR21596@ziepe.ca>
 <20190815193526.GT9477@dhcp22.suse.cz> <CAKMK7uH42EgdxL18yce-7yay=x=Gb21nBs3nY7RA92Nsd-HCNA@mail.gmail.com>
 <20190815202721.GV21596@ziepe.ca>
In-Reply-To: <20190815202721.GV21596@ziepe.ca>
From:   Daniel Vetter <daniel@ffwll.ch>
Date:   Thu, 15 Aug 2019 22:49:31 +0200
Message-ID: <CAKMK7uER0u1TqeJBXarKakphnyZTHOmedOfXXqLGVDE2mE-mAQ@mail.gmail.com>
Subject: Re: [Intel-gfx] [PATCH 2/5] kernel.h: Add non_block_start/end()
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     Michal Hocko <mhocko@kernel.org>, Feng Tang <feng.tang@intel.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Kees Cook <keescook@chromium.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Intel Graphics Development <intel-gfx@lists.freedesktop.org>,
        Jann Horn <jannh@google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        Linux MM <linux-mm@kvack.org>,
        =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>,
        Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        David Rientjes <rientjes@google.com>,
        Wei Wang <wvw@google.com>,
        Daniel Vetter <daniel.vetter@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 15, 2019 at 10:27 PM Jason Gunthorpe <jgg@ziepe.ca> wrote:
> On Thu, Aug 15, 2019 at 10:16:43PM +0200, Daniel Vetter wrote:
> > So if someone can explain to me how that works with lockdep I can of
> > course implement it. But afaics that doesn't exist (I tried to explain
> > that somewhere else already), and I'm no really looking forward to
> > hacking also on lockdep for this little series.
>
> Hmm, kind of looks like it is done by calling preempt_disable()

Yup. That was v1, then came the suggestion that disabling preemption
is maybe not the best thing (the oom reaper could still run for a long
time comparatively, if it's cleaning out gigabytes of process memory
or what not, hence this dedicated debug infrastructure).

> Probably the debug option is CONFIG_DEBUG_PREEMPT, not lockdep?

CONFIG_DEBUG_ATOMIC_SLEEP. Like in my patch.
-Daniel
-- 
Daniel Vetter
Software Engineer, Intel Corporation
+41 (0) 79 365 57 48 - http://blog.ffwll.ch
