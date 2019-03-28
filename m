Return-Path: <SRS0=Qu8K=R7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1412C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 02:28:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6BD9D2075C
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 02:28:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=brauner.io header.i=@brauner.io header.b="WFxko6ab"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728273AbfC1C2a (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 22:28:30 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:50503 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727675AbfC1C23 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 22:28:29 -0400
Received: by mail-wm1-f66.google.com with SMTP id z11so1959382wmi.0
        for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2019 19:28:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brauner.io; s=google;
        h=date:user-agent:in-reply-to:references:mime-version
         :content-transfer-encoding:subject:to:cc:from:message-id;
        bh=9fcSie2QCEfM/9UmY4RZHvU2oM6FNWGveHbQvi2AuQY=;
        b=WFxko6abg2ieefgl9dWJJCLXLw5FQ2lPmwF61/jK93NaFW9f2pUiv5ph/D/CpS85n+
         088gThMHvteUakhteZ4BVNC+NHkY1EoSj9PGtaiTvOkon3tv+d3JubxzRFpuqFReUENg
         vJw3LtfAE5yya1ih7rtyS2Qst3dzF/g2jXqGGFg003Uvn41bl4llnlrODSoG4XYG0KJ1
         KgV8AbQwkjo6c8kTu8eFFkiX1vbTbCG/iDhf7J44n+NuXgrMrt5VSFM9DGsc62O4v8mc
         9QKzj1k0TffDMVqEZRZGODXknojw3vbxMeHFKOxzsnscjtsjdGt4l9Xs/Dtx4+UUqSkX
         EWog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:user-agent:in-reply-to:references
         :mime-version:content-transfer-encoding:subject:to:cc:from
         :message-id;
        bh=9fcSie2QCEfM/9UmY4RZHvU2oM6FNWGveHbQvi2AuQY=;
        b=SoeBHO1YQstKdZbU+Jr9Nmz2oHzzLSu6QRv5ukhny5p8hdDLLEgzYj2QvjtLZLSnwM
         TS/AI8lptoUVHXiFkZ3ONc+XZDPnvpPsw6dvKvVTREKTTvIZAV1m5Ydaft5Wpe5zXF0H
         FrWkN91NlBsNJiG3yd82PzbYm5TZ326XdyJ9rFjHHpBjJ7ifLMyG+p7A12FgcYHPtbZ2
         3l19D+jD3fBw804jkMk5TzLMVJg2e/KDaRblgUFlZNMPqzW7HUjExMYutl54oClZnd9b
         EwO77AkTHkkADBEAtYI3b3LurC7feTEGSWf2272/FbqLDHGD1PG7wh8bYSfCkXMnFA4y
         p8xA==
X-Gm-Message-State: APjAAAWlxRVcb+yxH2IkKZK91EM6hd7A0rM0bCb5bjve74gd0y2EJ5lG
        0u0bjxzpEUv52NPTQeSwt7jbiwtdnAA=
X-Google-Smtp-Source: APXvYqyxP4p7gvlzoPRUqNfuo6G1QKTZRUnDOScfC+QojySf0dQXy++bGbF605I9CXobPG5ig/gEmg==
X-Received: by 2002:a1c:2407:: with SMTP id k7mr19976985wmk.137.1553740107795;
        Wed, 27 Mar 2019 19:28:27 -0700 (PDT)
Received: from ?IPv6:2a02:8109:b6bf:d24a:a10f:fd1c:e75:1349? ([2a02:8109:b6bf:d24a:a10f:fd1c:e75:1349])
        by smtp.gmail.com with ESMTPSA id 3sm32667034wrk.68.2019.03.27.19.28.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 27 Mar 2019 19:28:27 -0700 (PDT)
Date:   Thu, 28 Mar 2019 03:28:25 +0100
User-Agent: K-9 Mail for Android
In-Reply-To: <20190328130449.1b6334b6@canb.auug.org.au>
References: <20190328130449.1b6334b6@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: linux-next: build failure after merge of the pidfd tree
To:     Stephen Rothwell <sfr@canb.auug.org.au>
CC:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
From:   Christian Brauner <christian@brauner.io>
Message-ID: <8EB36115-C5EB-4469-94F8-1D3DF1653ADB@brauner.io>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On March 28, 2019 3:04:49 AM GMT+01:00, Stephen Rothwell <sfr@canb=2Eauug=
=2Eorg=2Eau> wrote:
>Hi Christian,
>
>After merging the pidfd tree, today's linux-next build (arm
>multi_v7_defconfig) failed like this:
>
>kernel/pid=2Ec: In function '__do_sys_pidfd_open':
>kernel/pid=2Ec:652:7: error: 'fd' redeclared as different kind of symbol
>  long fd =3D -EINVAL;
>       ^~
>In file included from kernel/pid=2Ec:40:
>kernel/pid=2Ec:649:46: note: previous definition of 'fd' was here
> SYSCALL_DEFINE4(pidfd_open, pid_t, pid, int, fd, int, pidfd,
>                                         ~~~~~^~
>include/linux/syscalls=2Eh:117:27: note: in definition of macro
>'__SC_DECL'
> #define __SC_DECL(t, a) t a
>                           ^
>include/linux/syscalls=2Eh:112:35: note: in expansion of macro '__MAP3'
> #define __MAP4(m,t,a,=2E=2E=2E) m(t,a), __MAP3(m,__VA_ARGS__)
>                                   ^~~~~~
>include/linux/syscalls=2Eh:115:22: note: in expansion of macro '__MAP4'
> #define __MAP(n,=2E=2E=2E) __MAP##n(__VA_ARGS__)
>                      ^~~~~
>include/linux/syscalls=2Eh:253:36: note: in expansion of macro '__MAP'
>  static inline long __do_sys##name(__MAP(x,__SC_DECL,__VA_ARGS__))
>                                    ^~~~~
>include/linux/syscalls=2Eh:226:2: note: in expansion of macro
>'__SYSCALL_DEFINEx'
>  __SYSCALL_DEFINEx(x, sname, __VA_ARGS__)
>  ^~~~~~~~~~~~~~~~~
>include/linux/syscalls=2Eh:218:36: note: in expansion of macro
>'SYSCALL_DEFINEx'
>#define SYSCALL_DEFINE4(name, =2E=2E=2E) SYSCALL_DEFINEx(4, _##name,
>__VA_ARGS__)
>                                    ^~~~~~~~~~~~~~~
>kernel/pid=2Ec:649:1: note: in expansion of macro 'SYSCALL_DEFINE4'
> SYSCALL_DEFINE4(pidfd_open, pid_t, pid, int, fd, int, pidfd,
> ^~~~~~~~~~~~~~~
>kernel/pid=2Ec:663:7: error: 'procfd' undeclared (first use in this
>function); did you mean 'pidfd'?
>   if (procfd !=3D -1 || pidfd !=3D -1)
>       ^~~~~~
>       pidfd
>kernel/pid=2Ec:663:7: note: each undeclared identifier is reported only
>once for each function it appears in
>
>Caused by commit
>
>  9170fba40db0 ("pid: add pidfd_open()")
>
>I have used the version of the pifd tree from next-20190327 for today=2E
>
>Please do *not* use linux-next as a development tree (I have seen
>several
>different version of this code over the past few days :-()=2E  The rules
>for linux-next included code include:
>"
>     * posted to the relevant mailing list,
>     * reviewed by you (or another maintainer of your subsystem tree),
>     * successfully unit tested, and=20
>     * destined for the current or next Linux merge window=2E
>
>Basically, this should be just what you would send to Linus (or ask him
>to fetch)=2E"

Yeah, that should not have ended up there=2E
This was caused by a faulty regex in my push script that pushes to differe=
nt servers=2E
One of them always builds a kernel and runs the tests that come with all p=
atches on the for-next and work branches=2E=20

Sorry about that=2E Should be fixed now=2E
Christian
