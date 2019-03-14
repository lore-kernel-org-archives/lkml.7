Return-Path: <SRS0=GgR0=RR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 175C0C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 05:30:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D41E32087C
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 05:30:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Mu9FlgAe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726653AbfCNFaR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Mar 2019 01:30:17 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:35255 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726130AbfCNFaQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Mar 2019 01:30:16 -0400
Received: by mail-lf1-f68.google.com with SMTP id h6so3240318lfc.2
        for <linux-kernel@vger.kernel.org>; Wed, 13 Mar 2019 22:30:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=l2VRXzebQq3qBUiOtsrnX5b+iukGPh2SG17hH96CLTc=;
        b=Mu9FlgAeN3q+ft0Xgg3bwn1z0JBH2GvpvRGZ/xRrUoDAMpacHj4QYf07rM7/gf4Zfz
         oBUTvlwR19yBpDlv9/QP8roBKqdJd+FXo7iYPkt8FqaRuZKg3DI/xFRbmbVd0R67jDLW
         jLyp9KnAFWwPMTtNxw112Q8hgJHLQISrMQLWn4XLGbuPSsjMDZbQ8tRrGZ35cr8iS4+M
         z/fQMDQ37stobiGV6qSDsHga3F8ChcC02A1tTV9e0v3GFLpDqlKO+ZQ6K+nJzeWDPpN/
         B4IZZ5LdtyW2kEPDEeimoYY9VcUdhw/Erf+KIRfryrL9WdpUlpNe+NFunkkgnB9rtsmc
         U4aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=l2VRXzebQq3qBUiOtsrnX5b+iukGPh2SG17hH96CLTc=;
        b=lcIjAYcwtjEICnZU6KVz2DNJOV7IBlGIwndUIRp07XXHrUPQsJnp7UMPrhfavJ7zLe
         anTxta7dlq3swqI/mSVIHdV0/5gk7nnx7jjmVFI8IxMrhsJ5AHA3QONUuJE5wxU7D3b8
         J1ykTg1Cn0o3sedkXCtCnQKgx0Leu1hDEf2J0HQHF+0S7YXe+jvPf4Sh/JzHp8ycd3we
         fpBhDjDe9DpFVidBZMRpb4knmCVfkAcHhvY1sAqMci0ZdHdpaqwkCIWilGOZ6Wt1ZZjg
         RA4/r4l+VzD7vOxC+YQWphrBpLuQnlxu5/s1w2JWB93ydTyr4tCsAn0bBDxcZBD+U5zG
         u3OQ==
X-Gm-Message-State: APjAAAVq4DLrw8t/QyVB4Me0rs2KVJqoqmcDPlzIRUYjA7lSaXZucuvv
        MeyxS8G8jpfI9pX1YFMKLX/EuD2Wm9dkwf3Xl70=
X-Google-Smtp-Source: APXvYqwZ5u87x7Cknvgxnj4SBGiRf+zKR91qLSxF5DhT7jcC3F9MzHj2QoRx0JrniBnJohctye6O+IsMZ1pEUkgrQyQ=
X-Received: by 2002:a19:520e:: with SMTP id m14mr25761697lfb.64.1552541414511;
 Wed, 13 Mar 2019 22:30:14 -0700 (PDT)
MIME-Version: 1.0
References: <20190218165620.383905466@infradead.org> <CAHk-=wh32Zgp+bN7G1KH7SuCiY1YSJ41Y-_eWpfWubGjqq2_dw@mail.gmail.com>
 <20190222124544.GY9565@techsingularity.net> <14a9adf7-9b50-1dfa-0c35-d04e976081c2@oracle.com>
 <CAERHkru9DzvszvdGHWp8PhEAqeUc-wVR1Gey-KtQ6aMRLx68bQ@mail.gmail.com>
 <19d5d492-a4c1-b3c8-cae4-da2fdfcb872b@oracle.com> <ac10b8fd-da1a-2cc2-afee-4e2b9b4278ee@oracle.com>
 <CAERHkrvjOfVz9xGWZOTGvcUcMETyBdQ2NPj-0USQNU1QTDXR3Q@mail.gmail.com>
 <CAERHkrvgMNf2rmQ_pF5S7Wq64fnkW4HzP_VYPL4vQWyKgHPgxA@mail.gmail.com> <8098aac2-60f7-6fe9-2a3a-2fe2e1b49bde@linux.intel.com>
In-Reply-To: <8098aac2-60f7-6fe9-2a3a-2fe2e1b49bde@linux.intel.com>
From:   Aubrey Li <aubrey.intel@gmail.com>
Date:   Thu, 14 Mar 2019 13:30:03 +0800
Message-ID: <CAERHkrvFe-s=_SD2WO0yuYiQ3JxY22=pSrM4UE-BWpbPD8iiCA@mail.gmail.com>
Subject: Re: [RFC][PATCH 00/16] sched: Core scheduling
To:     Tim Chen <tim.c.chen@linux.intel.com>
Cc:     Subhra Mazumdar <subhra.mazumdar@oracle.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Paul Turner <pjt@google.com>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        "Fr?d?ric Weisbecker" <fweisbec@gmail.com>,
        Kees Cook <keescook@chromium.org>,
        Greg Kerr <kerrnel@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 14, 2019 at 8:35 AM Tim Chen <tim.c.chen@linux.intel.com> wrote:
> >>
> >> One more NULL pointer dereference:
> >>
> >> Mar 12 02:24:46 aubrey-ivb kernel: [  201.916741] core sched enabled
> >> [  201.950203] BUG: unable to handle kernel NULL pointer dereference
> >> at 0000000000000008
> >> [  201.950254] ------------[ cut here ]------------
> >> [  201.959045] #PF error: [normal kernel read fault]
> >> [  201.964272] !se->on_rq
> >> [  201.964287] WARNING: CPU: 22 PID: 2965 at kernel/sched/fair.c:6849
> >> set_next_buddy+0x52/0x70
> >
> Shouldn't the for_each_sched_entity(se) skip the code block for !se case
> have avoided null pointer access of se?
>
> Since
> #define for_each_sched_entity(se) \
>                 for (; se; se = se->parent)
>
> Scratching my head a bit here on how your changes would have made
> a difference.

This NULL pointer dereference is not replicable, which makes me thought the
change works...

>
> In your original log, I wonder if the !se->on_rq warning on CPU 22 is mixed with the actual OOPs?
> Saw also in your original log rb_insert_color.  Wonder if that
> was actually the source of the Oops?

No chance to figure this out, I only saw this once, lockup occurs more
frequently.

Thanks,
-Aubrey
