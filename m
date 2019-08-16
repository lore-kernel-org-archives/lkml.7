Return-Path: <SRS0=MEBR=WM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FA42C3A589
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Aug 2019 02:04:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 334E82064A
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Aug 2019 02:04:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ZQOEKNXR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726415AbfHPCEx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Aug 2019 22:04:53 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:41134 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726215AbfHPCEw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Aug 2019 22:04:52 -0400
Received: by mail-ot1-f66.google.com with SMTP id o101so8249996ota.8
        for <linux-kernel@vger.kernel.org>; Thu, 15 Aug 2019 19:04:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6pfybPHYgQpVnLP31HUT6Rq04rce/4KRW2qmC2QL+zw=;
        b=ZQOEKNXRhZo9Y4S1z9YzupCiWd8wCHyjva9WWCpYVGxSWXgmhUX/PgczqLUjfQAz8I
         fa5yB9DzjRrzGZ/2oE31G9bhzfR38WrRiF6yv1CtLG4oqV4c0zUOBCAc7U/ZT0O9Ilrl
         /15sJJC+2aovaMGtM+jpZMFcyOuX7EWX1OFr4XgXyIwDFhlDkOkgGnzv6AAlqx1D5FKw
         8ycYSSoLLLjiXdz4vHgG074h6mTgN8HANJ3ARLkjJyXBsWL/vDYyRYMI8CqdeMRFUtxn
         XkZyTb9hNn4V284yXUPS+Lqfyu1BofbuLb0dayf+DYtzjQEjn1gnRutY3aLqKKkT0LXn
         0sxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6pfybPHYgQpVnLP31HUT6Rq04rce/4KRW2qmC2QL+zw=;
        b=ZNJp3OXnERE0KN2DcgjtjAWhUl0rNgW+KrlxLt1kWydIn53v9VbaulZtI+g/bbaqV7
         w/7m5Dx0bMjNooastUbg4QRjYg/FgfXAnXhlujfKwoPU2PJAX2GyVLm1svwUbSEn5U5/
         gT2sH83OwZ1ESdqnchGexx7SF4OprLqTf3SboDLSpItvI5wktSTtcOEqYh9XS3ltwfLG
         cYahp56Ot6sd28Yn3lxWoIXQGPX8E0kisivYB2aDgitDFsxv/NVeSShJY5QfDPzU8CJh
         DkDMQ65RBprp294ZLXPRWIH22bU6jgyaZKsUXQlJIp3RqtdYtQ9HO8Zux2MtED0GjW7V
         N4VA==
X-Gm-Message-State: APjAAAXRfn1+LcsZ9K4mMhsDF7T3w5lisiZIx1+BYfw5P4MjkMwdkg3g
        nWRZmRzq3dPc+4/SvTFG+HqHEPNzYTuRBKBp8Orpxw==
X-Google-Smtp-Source: APXvYqwuILMgx6RAYZp8/lXzEQQH9dExGmGGIjywFZyq1MtjF7y+Jdoz2WbmvtTdoPvkM9TgVowsk0UXBREVo/Xstt8=
X-Received: by 2002:a9d:6b1a:: with SMTP id g26mr5980166otp.195.1565921091613;
 Thu, 15 Aug 2019 19:04:51 -0700 (PDT)
MIME-Version: 1.0
References: <20190806192654.138605-1-saravanak@google.com> <20190806192654.138605-2-saravanak@google.com>
 <CAL_Jsq+BwHSj1XUNp_eY362XnNoOqVTNHqAkvnbgece8ZQE3Qw@mail.gmail.com>
 <CAGETcx8+EETv6nSu+BEBStKvbmBs+tZZgo1u_Pw8SNu+7Urq1Q@mail.gmail.com> <CAL_JsqLdcn5aZdenLs3RSVCOE1PRNK_qYNmQR=fXPV+ZOQ9+PQ@mail.gmail.com>
In-Reply-To: <CAL_JsqLdcn5aZdenLs3RSVCOE1PRNK_qYNmQR=fXPV+ZOQ9+PQ@mail.gmail.com>
From:   Saravana Kannan <saravanak@google.com>
Date:   Thu, 15 Aug 2019 19:04:15 -0700
Message-ID: <CAGETcx8K2Ob7f7wchP6Z7Y=XGgX3h535ty62x6b-13-giGyZgA@mail.gmail.com>
Subject: Re: [PATCH 2/2] of/platform: Disable generic device linking code for PowerPC
To:     Rob Herring <robh+dt@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Android Kernel Team <kernel-team@android.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 14, 2019 at 4:41 PM Rob Herring <robh+dt@kernel.org> wrote:
>
> On Tue, Aug 6, 2019 at 4:04 PM Saravana Kannan <saravanak@google.com> wrote:
> >
> > On Tue, Aug 6, 2019 at 2:27 PM Rob Herring <robh+dt@kernel.org> wrote:
> > >
> > > On Tue, Aug 6, 2019 at 1:27 PM Saravana Kannan <saravanak@google.com> wrote:
> > > >
> > > > PowerPC platforms don't use the generic of/platform code to populate the
> > > > devices from DT.
> > >
> > > Yes, they do.
> >
> > No they don't. My wording could be better, but they don't use
> > of_platform_default_populate_init()
> > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/of/platform.c#n511
>
> Right, but the rest of the of/platform code is used (guess where it
> got moved here from?).
>
> > > > Therefore the generic device linking code is never used
> > > > in PowerPC.  Compile it out to avoid warning about unused functions.
> > >
> > > I'd prefer this get disabled on PPC using 'if (IS_ENABLED(CONFIG_PPC))
> > > return' rather than #ifdefs.
> >
> > I'm just moving the existing ifndef some lines above. I don't want to
> > go change existing #ifndef in this patch. Maybe that should be a
> > separate patch series that goes and fixes all such code in drivers/of/
> > or driver/
>
> So the initcall was originally just supposed to call
> of_platform_default_populate(), but it's grown beyond that. That could
> make things fragile as it is possible for platforms to call
> of_platform_populate() (directly or indirectly) before
> of_platform_default_populate_init(). That was supposed to work, but
> now I think it's getting more fragile.

Can you clarify what's wrong with of_platfrom_populate() being called
before of_platform_default_populate_init()? If that's what a platform
wants to do, they can do it? I have some thoughts of my own, but I
want to hear yours.
In any case, I'd be happy to help  clean up this initcall if you can
give me a direction to take it in.

> Anyways, I guess this patch is fine for now.

Thanks.

-Saravana
