Return-Path: <SRS0=qJmF=WX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.3 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A9BEC41514
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 21:27:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6A54120656
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 21:27:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="nlkQCqlr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730257AbfH0V1T (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Aug 2019 17:27:19 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:37612 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726871AbfH0V1T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Aug 2019 17:27:19 -0400
Received: by mail-pf1-f194.google.com with SMTP id y9so228473pfl.4
        for <linux-kernel@vger.kernel.org>; Tue, 27 Aug 2019 14:27:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dORKsa24CPlzONt8GkpEJmy5cgog5+v4B7b48TayOmE=;
        b=nlkQCqlrck9aDbUTfU3CWlCdu6TLRNvsh6KR2X92W6GvTwR6AqAinXCIHSB/UnnGrY
         SajnEjW0Tqve6lhnOdFa7OmT77RqUHoR3wCizuIHkWEqX2Zeo5GrV8nfKkzDr5pIV2NQ
         I/u7CLOKjWvEzDKRiqf244odsk1Wk1txvu+pClpOoD/WVwg95z5zckHo2tT84zGTo5Gg
         iBQr442MHY57rvvFnhoY5hPjaIh4hmgg3rCecQTiZaT6npNhGIy1qPZiu+Z0j/KnjqyU
         4/wdx6qjtdWPYY6QC2fyxg3tKFqsjA9iAlojGPL/San5FlIV6cCMHq9271ZuTWgrcKTS
         6ZDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dORKsa24CPlzONt8GkpEJmy5cgog5+v4B7b48TayOmE=;
        b=e3gtsbhyJMw2QMSAKp+i6/DXd06ATtZ811EOEz35cXmuvYTCuwqvRDhYoR7ym8Z1tw
         dK2ab+13H8mAwE1pgsLVPdquGe2VoNLP/h3UMyEixiMu5BpA+ItY9tfdOk3olkRPALAr
         eNM9dYVxDjDEpUUVmbQ7smsDN7PENZOVDtZjF3wuROOEWKTYgOTV/LP26h1+A7Dho+mk
         L0r2J5VrgX/elaF5SRfDoX69G/s56AkZ1EEAEwcTBhZv29vSBN/xw4neKKoZtmgtbZ+L
         FBceN8/HGzfvuEpkkdtp6y3Wz7eJNsOhNTvJ7ghySW0gOEMz9XnJGdRMpal+QPLtn4G+
         Xu7A==
X-Gm-Message-State: APjAAAUmXx8AtHajyuqGUbWc2erZMo0BtZagZIG2xE+BzDNnv1THyqq6
        PmX0V1/ckC3m2qJZ940KvTXTLqvh7E8siQ1Qk9bdUA==
X-Google-Smtp-Source: APXvYqzG090bvyFL/VemnFAypRwAgpOeNcqIVdhr0dWYTGUxFKJSzWYN8aOqtHpECNarsykUq6u7+WhmUbnbVtmXcJA=
X-Received: by 2002:a63:60a:: with SMTP id 10mr432471pgg.381.1566941237865;
 Tue, 27 Aug 2019 14:27:17 -0700 (PDT)
MIME-Version: 1.0
References: <20190711133915.GA25807@ziepe.ca> <CAKwvOdnHz3uH4ZM20LGQJ3FYhLQQUYn4Lg0B-YMr7Y1L66TAsA@mail.gmail.com>
 <20190711171808.GF25807@ziepe.ca> <20190711173030.GA844@archlinux-threadripper>
 <20190823142427.GD12968@ziepe.ca> <20190826153800.GA4752@archlinux-threadripper>
 <20190826154228.GE27349@ziepe.ca> <20190826233829.GA36284@archlinux-threadripper>
 <20190827150830.brsvsoopxut2od66@treble> <20190827170018.GA4725@mtr-leonro.mtl.com>
 <20190827192344.tcrzolbshwdsosl2@treble>
In-Reply-To: <20190827192344.tcrzolbshwdsosl2@treble>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Tue, 27 Aug 2019 14:27:06 -0700
Message-ID: <CAKwvOdk3UTT5jUTuG_wRizdpUtgv3qFB3w3NCtJ7ub5DnptYRA@mail.gmail.com>
Subject: Re: [PATCH] rdma/siw: Use proper enumerated type in map_cqe_status
To:     Josh Poimboeuf <jpoimboe@redhat.com>
Cc:     Leon Romanovsky <leon@kernel.org>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Bernard Metzler <BMT@zurich.ibm.com>,
        Doug Ledford <dledford@redhat.com>, linux-rdma@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Peter Zijlstra <peterz@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 27, 2019 at 12:23 PM Josh Poimboeuf <jpoimboe@redhat.com> wrote:
>
> On Tue, Aug 27, 2019 at 08:00:18PM +0300, Leon Romanovsky wrote:
> > On Tue, Aug 27, 2019 at 10:08:30AM -0500, Josh Poimboeuf wrote:
> > > On Mon, Aug 26, 2019 at 04:38:29PM -0700, Nathan Chancellor wrote:
> > > > Looks like that comes from tune_qsfp, which gets inlined into
> > > > tune_serdes but I am far from an objtool expert so I am not
> > > > really sure what kind of issues I am looking for. Adding Josh
> > > > and Peter for a little more visibility.
> > > >
> > > > Here is the original .o file as well:
> > > >
> > > > https://github.com/nathanchance/creduce-files/raw/4e252c0ca19742c90be1445e6c722a43ae561144/rdma-objtool/platform.o.orig
> > >
> > >      574:       0f 87 00 0c 00 00       ja     117a <tune_serdes+0xdfa>
> > >
> > > It's jumping to la-la-land past the end of the function.
> >
> > How is it possible?
>
> Looks like a compiler bug.

Nathan,
Thanks for the reduced test case.  I modified it slightly:
https://godbolt.org/z/15xejg

You can see that the label LBB0_5 seemingly points off into space.
Let me play with this one more a bit, then I will file a bug and
report back.
-- 
Thanks,
~Nick Desaulniers
