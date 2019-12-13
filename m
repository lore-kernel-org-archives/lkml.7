Return-Path: <SRS0=7lyw=2D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FB18C2D0C9
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Dec 2019 09:10:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DB3A12077B
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Dec 2019 09:10:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="m2P/fTdP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726741AbfLMJKj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Dec 2019 04:10:39 -0500
Received: from mail-qk1-f193.google.com ([209.85.222.193]:45216 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726029AbfLMJKi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Dec 2019 04:10:38 -0500
Received: by mail-qk1-f193.google.com with SMTP id x1so1115218qkl.12
        for <linux-kernel@vger.kernel.org>; Fri, 13 Dec 2019 01:10:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=IRrlF5i6RzeEP3R8jYIvjzfeXuLk/3e9WVAuPgf3JD4=;
        b=m2P/fTdPZDE36Gl1QUxcld1M9ENmXLASB/UHiDi/p1jULoWLSQEpWj8kgr962N0jZb
         YxLy6VOit02AXdcfCHYv4EhefIbArcRDF78qV6X7NuV7cv6n6rf6pn/TCh9WAqixMoRK
         CLxHsMVVkrg6oa1Db0e5SlEe0Q3m1xRHrX9rpKoFktKeVLaPIXcd8AoijuthOkg4KqEd
         4TNez3GN9cJhh1QaGcKSWh22yEppCUQZ/sCQEYS2gdb/YNY78zh9KNUJ07KVDgPVrSfy
         i+miyT3wOlEfo6z3m3Tnt1gbqmbyrvgHDD3zykbHQ1Eig4nP7TNv4KJqeSL0yhmxoF1r
         oNCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=IRrlF5i6RzeEP3R8jYIvjzfeXuLk/3e9WVAuPgf3JD4=;
        b=Su0qUz7Gw+ILGiqLNR0wv2mDK8q6qjrhzvil5/wCAatNfrZfWZwIoeCd1t8hnNUo+T
         qKIdbBZ4d/v1iRK1OcdFWwFJjdna3KM7xvbmwBbZzidoKuoG0M4XOSbfU0xJ4CxknVz6
         eMH6/CTahIlNcms0qDiOV/ChC/cCqF8pcPRJXGHnuhQW/+gL/lvNm5oG/A9wlZwm2VSp
         Qe1a0w052ugUYbKruHvBIivHYe3AQj1OkFhUCw4ww5VekMM9aeF4gNreksPIK/IpY0dp
         lx6bc7rLt5jbn4HPHqE6pznkt9BzJpYd/ahuD1zCZguiTeQArRJhZwmil7MU2VLF2qIu
         RRoA==
X-Gm-Message-State: APjAAAUk0jhPJSrRpDorM3xu3Ibqb5hhCXYmGc1LwoOSexGQMg8sggZ5
        xhecHiWLYfFW7RJlrB5I+M77T6D8wi8c69yKDitQ1umX3TM=
X-Google-Smtp-Source: APXvYqyV30Kw+lK3xmCJOnsR4jDPKsnw36yVIx2tuAmpLnwb+nvNvQD6S+pkIJd6+XrkgxslVm9LjJsyHkumifUSt4o=
X-Received: by 2002:a05:620a:1136:: with SMTP id p22mr11527564qkk.8.1576228237173;
 Fri, 13 Dec 2019 01:10:37 -0800 (PST)
MIME-Version: 1.0
References: <000000000000b6b03205997b71cf@google.com> <20191212061206.GE4203@ZenIV.linux.org.uk>
 <CACT4Y+YJuV8EGSx8K_5Qd0f+fUz8MHb1awyJ78Jf8zrNmKokrA@mail.gmail.com>
 <20191212133844.GG4203@ZenIV.linux.org.uk> <CACT4Y+ZQ6C07TcuAHwc-T+Lb2ZkigkqW32d=TF054RuPwUFimw@mail.gmail.com>
 <20191212183443.GH4203@ZenIV.linux.org.uk>
In-Reply-To: <20191212183443.GH4203@ZenIV.linux.org.uk>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Fri, 13 Dec 2019 10:10:25 +0100
Message-ID: <CACT4Y+b7hZuNuc4sRnhFkpCw+xQg2hzX1WuD__rejigxzBpXBg@mail.gmail.com>
Subject: Re: BUG: corrupted list in __dentry_kill (2)
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     syzbot <syzbot+31043da7725b6ec210f1@syzkaller.appspotmail.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 12, 2019 at 7:34 PM Al Viro <viro@zeniv.linux.org.uk> wrote:
>
> On Thu, Dec 12, 2019 at 04:57:14PM +0100, Dmitry Vyukov wrote:
>
> > > Speaking of bisect hazards, I'd recommend to check how your bisect
> > > went - the bug is definitely local to this commit and I really
> > > wonder what had caused the bisect to go wrong in this particular
> > > case.
> >
> > I did not get the relation of folding to bisection. Or you mean these
> > are just separate things?
>
> Suppose instead of folding the fix in I would've done a followup commit
> just with the fix.  And left the branch in that form, eventually getting
> it pulled into mainline.  From that point on, *ANY* bisect stepping into
> the first commit would've been thrown off.  For ever and ever, since
> once it's in mainline, it really won't go away.
>
> That's what folding avoids - accumulation of scar tissue, if you will.
> Sure, there's enough cases when bug is found too late - it's already
> in mainline or pulled into net-next or some other branch with similar
> "no rebase, no reorder" policy.  But if you look at the patchsets posted
> on the lists and watch them from iteration to iteration, you'll see
> a _lot_ of fix-folding.  IME (both by my own practice and by watching
> the patchsets posted by others) it outnumbers the cases when fix can't
> be folded by quite a factor.  I wouldn't be surprised if it was an
> order of magnitude...
>
> Strict "never fold fixes" policy would've accelerated the accumulation
> of bisect hazards in the mainline.  And while useful bisect may be a lost
> cause for CI bots, it isn't that for intelligent developers.  Anything
> that makes it more painful is not going to be welcome.


Ah, I see. Yes, folding will help future bisections. In fact, an
unfolded bug somewhere in kernel history is exactly what caused wrong
result on bisection for this bug.
Just in case, I did not propose to not do folding here (or anywhere
else as far as I remember). Handling of folded fixes is documented in
syzbot docs:
https://goo.gl/tpsmEJ#rebuilt-treesamended-patches
