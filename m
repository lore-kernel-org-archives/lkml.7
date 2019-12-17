Return-Path: <SRS0=vnTL=2H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3204EC43603
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Dec 2019 18:05:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 06239206EC
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Dec 2019 18:05:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PPQjasbU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728146AbfLQSFL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Dec 2019 13:05:11 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:37470 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727960AbfLQSFL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Dec 2019 13:05:11 -0500
Received: by mail-pg1-f195.google.com with SMTP id q127so6091383pga.4
        for <linux-kernel@vger.kernel.org>; Tue, 17 Dec 2019 10:05:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lPAy70hTSI9Lb0VV9YnF+9CtMVWnLmyoDgtChgI4SY4=;
        b=PPQjasbUCMRl055Ng7oDvDaeh+x6kObw4Pq1XbNGO+KuZMP3yl+cRuzmu334l+WCcH
         sV5O1gDjSxd6k6G4wQBcaqzne7oP48wM1n26Fee1SZ1zykdYEDaC9s7oq705tu++Rms9
         bvHynv3ZP70pSTLapzGookdjtgVsM/l5GmyQeaMSWCzYgwFTzelFt3Qngmw28Ko3zeh+
         ZFdjypV4WFZ3ggjjupzf3uzeL4NPuXnnczRIlQDxKfP+5B4JOZyVH/cMBsrUEnmXcCWv
         82jZK3T/GEVf0QjsjugH6g+6W0BJw9F2VbWqiL6EAyTgCvGIooZ1KEx76g+FTjO+4LF5
         T+wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lPAy70hTSI9Lb0VV9YnF+9CtMVWnLmyoDgtChgI4SY4=;
        b=s9cnqcVJNfffyRShtVZdqETOgV1EyHVqc5fxh10Br1kM/V5UK3RYfaNeLGWI+smfRs
         pgUuYmXdn8IqdyrFgzP293buDpMmyv3hXcQgaJJ/FKk9HwwXb/VOqSf7th+xAzzUOZWG
         2FPdVmvD1ouqPutSUTxWB5FEyto6t454kFNOE+xdYw36F0mxkcowKYDERIvzp4R1I9m3
         S50zE8NTvNDs5JML/zn99k4GwoEBjpfgtv/lHy2KecZNcIXy05IYz28yehJSISdoBIDk
         RwHOznOS1YCUNFj9BtW+obRpMcZ3mEAeAffe8xrmkWFBUVY9w+lr8fBWlg4kir/9y1AD
         faxQ==
X-Gm-Message-State: APjAAAV1bUxJym4Im7oZ5/thBHHJ9O6EJRaaDhj/j6mx/3KsbDNeOzNg
        /BjYliLa+IAZ65Z5s2oUt5Cp9Rp/gqZCVyNZ6mBB0Q==
X-Google-Smtp-Source: APXvYqxLsiOH6O5Jewzw5yW/Kve7RYtAg0bnR4XPIVJYL6wkUZ/TTrfBrfD8KCfAMIesKCU7tXRVLtAk13tPRim22yc=
X-Received: by 2002:a63:f24b:: with SMTP id d11mr15607650pgk.381.1576605910555;
 Tue, 17 Dec 2019 10:05:10 -0800 (PST)
MIME-Version: 1.0
References: <20191212135724.331342-4-linux@dominikbrodowski.net>
 <20191216211228.153485-1-ndesaulniers@google.com> <20191217063846.GA3247@light.dominikbrodowski.net>
In-Reply-To: <20191217063846.GA3247@light.dominikbrodowski.net>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Tue, 17 Dec 2019 10:04:59 -0800
Message-ID: <CAKwvOd=p6aMDYLpq3g47JrmnwtZCHV=-CcBoamQAu2hk_aJcMg@mail.gmail.com>
Subject: Re: [PATCH 3/3] init: use do_mount() instead of ksys_mount()
To:     Dominik Brodowski <linux@dominikbrodowski.net>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>, rafael@kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        clang-built-linux <clang-built-linux@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 16, 2019 at 10:43 PM Dominik Brodowski
<linux@dominikbrodowski.net> wrote:
>
> On Mon, Dec 16, 2019 at 01:12:28PM -0800, Nick Desaulniers wrote:
> > Shouldn't patches bake for a while in -next? (That way we catch regressions
> > before they hit mainline?)
> >
> > This lit up our CI this morning.
> >
> > https://travis-ci.com/ClangBuiltLinux/continuous-integration/builds
> >
> > (Apologies for missing context, replying via lore.kernel.org directions.)
> > https://lore.kernel.org/lkml/20191212135724.331342-4-linux@dominikbrodowski.net/
>
> A fix for this issue is already upstream, 7de7de7ca0ae .

I appreciate that.  I was just surprised to have no advanced notice;
-next is our "canary in the coalmine."  Mainline is usually pretty
stable; if it goes red then we're missing testing coverage somewhere.
For mainline to break suddenly implies that either a pull was merged
from a branch that wasn't flowing into -next, or someone got [un]lucky
with the merge window, or something worse.  I saw -next failed the
same day as mainline for the same reason, so I'm going to give you the
benefit of the doubt and chalk it up to luck with timing of the merge
window.

In the future, please give patches more time to soak in -next. We
expect -next to be noisy, mainline not so much.
-- 
Thanks,
~Nick Desaulniers
