Return-Path: <SRS0=o7UO=TL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4295C04AB1
	for <linux-kernel@archiver.kernel.org>; Sat, 11 May 2019 18:13:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 878DF20881
	for <linux-kernel@archiver.kernel.org>; Sat, 11 May 2019 18:13:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="kyIAiixp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726272AbfEKSNX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 11 May 2019 14:13:23 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:41519 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726132AbfEKSNX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 May 2019 14:13:23 -0400
Received: by mail-lf1-f67.google.com with SMTP id d8so6291490lfb.8
        for <linux-kernel@vger.kernel.org>; Sat, 11 May 2019 11:13:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=CWP16Nyxw5qoo1hd2mChxbEzA6Fb4BMPJLsU//Q1vrc=;
        b=kyIAiixp5qZdQKPS40mqarIBWtsGQQbSIaVwYs8g9wa7xANkHruKKuaChRej94Pg/i
         nydybmuTIbEN/nIHH/fFtVf8Pwt/bwxeEFtarsy5916oxBYRM4xUagKe2FPfrzmmCLGH
         jkpUh/MuNTKlmUCyvKbTSzLysX257xss7joIwm+l64AUvzaWNgHzNDHVNk4NWYhpVGwN
         NWGtqNsbujAj0y+U7thWVn/c+tTXI5FYYRUtKUyfiD/XZEYEpqE276/Eq35y7Jeysdkx
         BfvGGfNet6SgoPfcLHe2vdT2RPuWbLXmDF69X/fnGIMk3/kSjPP+x30nFDK0HDaUHLEO
         IS+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CWP16Nyxw5qoo1hd2mChxbEzA6Fb4BMPJLsU//Q1vrc=;
        b=kKAqnppCi5ZghiAA342RJwzynK23CKC182dkvOtj20ErqEBma2zCiK7xWzHS5bWlh8
         K7v8t+Hw3caqUYMVBb4Ley29W+GILiJiD0Oim0mc6Mcyz1jf7v9ZO42CE+UFwcix32Ef
         2UH7dct3QLc6HMITOMrvVHFCt4e4SHYjpU94EQWSpJYcWNmLq2ljCk0eFZ76cT+H8Jd4
         IxHNdcKQcKomvs/gF+SFgqLbV91yjfnk3VoDLrLQld0GbIyl4izO0oLsHx2yeaiU5hbt
         GWZEOy3EcMUqsLHI3kl88qBp26nP+6wqud11CvEzh20VYzwAxyJRpz6CrOmoq2/CuBA2
         rPnA==
X-Gm-Message-State: APjAAAWxxKAFFpsqXN1kUfY0i7vXujGeycPgquVnZZwzLQhIbr8qxiEh
        SvNgGsPig386j2d5xMvBpXXQVtLKAsDH8rIRI+QP
X-Google-Smtp-Source: APXvYqyPZ06o+XO2LbPfsvUMqGLt/5r1ZRgUHok6ntDskfjhMm4IfhhujC45DdXbYCEHwKZO26Dprgpr44MS9YDq6Fk=
X-Received: by 2002:a19:760c:: with SMTP id c12mr9090091lff.105.1557598400815;
 Sat, 11 May 2019 11:13:20 -0700 (PDT)
MIME-Version: 1.0
References: <alpine.LRH.2.21.1905110801350.9392@namei.org> <CAHk-=wg8UFHD_KmTWF3LMnDf_VN7cv_pofpc4eOHmx_8kmMPWw@mail.gmail.com>
In-Reply-To: <CAHk-=wg8UFHD_KmTWF3LMnDf_VN7cv_pofpc4eOHmx_8kmMPWw@mail.gmail.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Sat, 11 May 2019 14:13:09 -0400
Message-ID: <CAHC9VhSSwYk6isqz8N3nOO_O17C30E2EyCHKf5OqsdESeMoT7g@mail.gmail.com>
Subject: Re: [GIT PULL] security subsystem: Tomoyo updates for v5.2
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        James Morris <jmorris@namei.org>
Cc:     LSM List <linux-security-module@vger.kernel.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 11, 2019 at 10:38 AM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
> On Fri, May 10, 2019 at 6:09 PM James Morris <jmorris@namei.org> wrote:
> >
> > These patches include fixes to enable fuzz testing, and a fix for
> > calculating whether a filesystem is user-modifiable.
>
> So now these have been very recently rebased (on top of a random
> merge-window "tree of the day" version) instead of having multiple
> merges.
>
> That makes the history cleaner, but has its own issues.
>
> We really need to find a different model for the security layer patches.

If it helps, the process I use for the SELinux and audit trees is
documented below.  While it's far from perfect (I still don't like
basing the -next trees on -rcX releases) it has seemed to work
reasonably well for some time now.

* https://github.com/SELinuxProject/selinux-kernel/blob/master/README.md

-- 
paul moore
www.paul-moore.com
