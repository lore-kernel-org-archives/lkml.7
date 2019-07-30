Return-Path: <SRS0=Iew4=V3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62074C433FF
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 09:16:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2703520665
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 09:16:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JbqA+AlT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730388AbfG3JQ4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jul 2019 05:16:56 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:34939 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727317AbfG3JQz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jul 2019 05:16:55 -0400
Received: by mail-io1-f66.google.com with SMTP id m24so126512149ioo.2
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2019 02:16:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8hoEmfigp9ygbOEfI9QiraZHR/SZ40vPRaaSFbyaBes=;
        b=JbqA+AlT1qb/0bCrA/oKdW5wmCjrTbpaeKB+PKSRKP2Fh4cNKNCXeJvMII9mtX0Qmf
         k9p2kowjwtLwsflKcOJsI7tkvGBtPU8LDqi/nZuQa4wUqbY8wMjwwjMl+TXTgs0O3d0b
         HfNZu3Wq3N6SbsrtmCzB/gj6Q6TCXAXwhfAOWTOOUPy38yl+AB+S3otN2XJnqg85Z4dO
         aZc7VzMy98ItGMAzuhDGl/KbqIES0OlYtc8B79qwZZCyb0IjGcL/M85iPDTAWaRW5pBT
         gGQz0yFCi17D1Vjw0kO9FaRm1QSAvHiyQbZgn7mhslDbYCpJcMGmNiMO2YcXLwRNZh25
         w5ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8hoEmfigp9ygbOEfI9QiraZHR/SZ40vPRaaSFbyaBes=;
        b=UArmMCnT6RwOtwJSzeViI57u/EDfMyOkExzv7bIPK0F6w38Crez8CPxaKa4ojRdjg/
         3iM0DEIw28MLlFudF9fGDTqeklNnaLmPc/0q0d6vkxho3myEWWorknM8R9XEJMf6zbmR
         nlBF+mde1fJXH2yylb2hh8mhsZ81OmzJZlNDWVeO1SGeFFx8+p13Sv2EgFVmfjHB5Wol
         XVKmiZzi6+J08iswiZIc2pdT7RkU4XkFxPCSipENjyYYyMvl+1ZL3uWrd+0FzqaLFMpy
         GbLOs9lQJhOg6Er2DIc+fAIlqYAhgBNsXxTD9KPpf/8rDDY8ySHF9CPv1/Ieg65cnrcD
         HOMA==
X-Gm-Message-State: APjAAAVO2aJXj8EHhuoypFwRIDwL9+1qpOilxbAL+8jqxUJIfWST9TgT
        jNyqb79pa6toJ0EXsrveeDdidIZpaW2DMtkihERvgg==
X-Google-Smtp-Source: APXvYqxieDFXnqU6U75u7jANuVEvk58nHg1/NSVBtmUUBJazeojb7zc0qCMbAL8CXZ8E3neVGbHW4tRVcc1H+lyh7A4=
X-Received: by 2002:a05:6638:303:: with SMTP id w3mr63198021jap.103.1564478214407;
 Tue, 30 Jul 2019 02:16:54 -0700 (PDT)
MIME-Version: 1.0
References: <CACT4Y+Y3nN=nLEkHXLFcX7vxp_vs1JrD=8auJ3cX9we6TQHO+w@mail.gmail.com>
 <CACT4Y+YXQBF1QQwEPEkR3b3-RoeZw_We5B-o_71xxc9HMSyTdw@mail.gmail.com> <20190729133618.GG2368@arrakis.emea.arm.com>
In-Reply-To: <20190729133618.GG2368@arrakis.emea.arm.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Tue, 30 Jul 2019 11:16:43 +0200
Message-ID: <CACT4Y+bDD8s1cbMOad_S=8f=MAMagiOpZJZnQTNwBU5skm3ycQ@mail.gmail.com>
Subject: Re: syzbot bisection analysis
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     syzkaller <syzkaller@googlegroups.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Eric Biggers <ebiggers@google.com>,
        Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 29, 2019 at 3:36 PM Catalin Marinas <catalin.marinas@arm.com> wrote:
>
> Hi Dmitry,
>
> On Mon, Jul 29, 2019 at 01:08:16PM +0200, Dmitry Vyukov wrote:
> > The remaining 10 were all diverged due to other unrelated memory leaks
> > and other non-leak bugs. It seems the main 2 reasons for this:
> > 1. Lots of leaks are old (kernel is under-tested with KMEMLEAK).
> > 2. Lots of unrelated bugs.
> > It's unclear how much KMEMLEAK potential for false positives is in
> > play. For example, lots of bisections are diverged by "memory leak in
> > batadv_tvlv_handler_register", but this is a true bug reported at:
> > https://syzkaller.appspot.com/bug?id=0654529ad3cc1d67a6d9812d8b75489c03dfb983
> > However, some are diverged by e.g. "memory leak in __neigh_create" and
> > "memory leak in copy_process" and these were not reported as separate
> > leaks, so either false positives or true leaks fixed in previous
> > releases.
>
> Out of curiosity, when the tool tries to bisect a memory leak, does it
> check for precisely that leak (e.g. by function name, object size) or
> any other unrelated leak can confuse the bisection?

Bisection of leaks uses the common scheme which is just "crashed"/"not
crashed" (black/white, no further classification) for reasons outlined
here:
https://groups.google.com/forum/#!msg/syzkaller/sR8aAXaWEF4/tTWYRgvmAwAJ
Consider object size changes across revisions, or the function is
renamed, or code changes. Even if we take just leaks, I am not sure if
it's possible to understand if it's the same leak or not.
