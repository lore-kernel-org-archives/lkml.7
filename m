Return-Path: <SRS0=pFUE=23=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A44DC33C9B
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jan 2020 09:03:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0DB1120848
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jan 2020 09:03:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="XA+w1MAQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726358AbgAFJDR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Jan 2020 04:03:17 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:41865 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725446AbgAFJDR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jan 2020 04:03:17 -0500
Received: by mail-lj1-f195.google.com with SMTP id h23so50188327ljc.8
        for <linux-kernel@vger.kernel.org>; Mon, 06 Jan 2020 01:03:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=CeH+kQ0Qe8jVFl0FEZFj+JiqWbIaJiNDGyhGbyxRwj4=;
        b=XA+w1MAQwy4oE7FoGRn4Ac2fYBZydctJDh5Jb7kz7jErQaINP0+KvyQ50gqNwiZyCS
         4YWjZcvg4tZpWZSwHneQMGnBfazen79DSAkgN8eyiVAY1xjN/hjh4bFDoEpLfHO+gOGz
         quWftU/KkRI78okF7/BNkniOzH0hjILfz5N6n1REhnkiI5Z7wygjilreH3MnhSZ7UIbo
         Sgdh+tmW1HQ+8KHtC7At5UNSnfI6RJgid3CQK8W4VdCWnulJMI8QdwTgaf8JnWZGls3z
         HiY0N45FGP3rvfektTexAH91mLX6eOivmLwuMjVfBEXsoV9eZfhkqWQEhhmamw/VwonI
         uY/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CeH+kQ0Qe8jVFl0FEZFj+JiqWbIaJiNDGyhGbyxRwj4=;
        b=oKWqwBXxDHVpKeqs2Ylhkm1/o/3JihR9Z0vzC6UKmfVBDp4aFmRizN+VRrbhmuLZrC
         5YsatvVideEBxFIYQfJgqgqstNg+xohoNTc35lL5EaikT+vyXkHipCSieLrHipSQ5WBv
         mdqiZU44IhcN8g85Ga8eD6H7CTX5VohpuOQXJRUPqkAzrTUtnehjHoOgCeR7y6EHgRIT
         67HyPg3fD/wEinzQ+IWQGbq2MWMmTz/ssufytJgLIIAgrgXcpT5EIHx/0rLbBbLHjazd
         PXr+VP73UPotbryTQuSwcsC+73nDIzZ5TwA8M1kLGDIwGxZQEdYl4qI5+2EsWU+E28Ra
         RqcQ==
X-Gm-Message-State: APjAAAXAhXEY50HDtOO/sTxTmTGLMLx+ILVpGyGRjLu9XIr+xbf/dJcG
        hVjKMouJQg3j/5QZvqBDqr+l7umIA8m4zbyJSC5Asg==
X-Google-Smtp-Source: APXvYqyyYyXfN4bIo8fVghXO5BARXcu9jDvUQwl48nA0BGLXNo7fhOgd419s0X2DFiqJLbTMsn07A84oMJZGJ0aGPVk=
X-Received: by 2002:a2e:5357:: with SMTP id t23mr60119946ljd.227.1578301394444;
 Mon, 06 Jan 2020 01:03:14 -0800 (PST)
MIME-Version: 1.0
References: <20200102215829.911231638@linuxfoundation.org> <CA+G9fYuPkOGKbeQ0FKKx4H0Bs-nRHALsFtwyRw0Rt5DoOCvRHg@mail.gmail.com>
 <CAK8P3a1+Srey_7cUd0xfaO8HdMv5tkUcs6DeDXzcUKkUD-DnGQ@mail.gmail.com>
 <CAK8P3a24EkUXTu-K2c-5B3w-LZwY7zNcX0dZixb3gd59vRw_Kw@mail.gmail.com>
 <20200103154518.GB1064304@kroah.com> <CAK8P3a00SpVfSE5oL8_F_8jHdg_8A5fyEKH_DWNyPToxack=zA@mail.gmail.com>
 <a2fc8b36-c512-b6dd-7349-dfb551e348b6@oracle.com> <8283b231-f6e8-876f-7094-d3265096ab9a@oracle.com>
 <CAHk-=wjvWTFn=C3mT5wA=mtOwXw44U+OHLVxk5DCe4v+7nOvKg@mail.gmail.com>
In-Reply-To: <CAHk-=wjvWTFn=C3mT5wA=mtOwXw44U+OHLVxk5DCe4v+7nOvKg@mail.gmail.com>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Mon, 6 Jan 2020 14:33:02 +0530
Message-ID: <CA+G9fYvzkPz6Ewm00ie+HqBpfQHFuRGn694Av-gj8Pt8iKrDQg@mail.gmail.com>
Subject: Re: [PATCH 5.4 000/191] 5.4.8-stable review
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Mike Kravetz <mike.kravetz@oracle.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        open list <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Shuah Khan <shuah@kernel.org>, patches@kernelci.org,
        Ben Hutchings <ben.hutchings@codethink.co.uk>,
        lkft-triage@lists.linaro.org,
        linux- stable <stable@vger.kernel.org>,
        Chengguang Xu <cgxu519@mykernel.net>,
        David Howells <dhowells@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Sasha Levin <sashal@kernel.org>, LTP List <ltp@lists.linux.it>,
        Jan Stancek <jstancek@redhat.com>,
        John Stultz <john.stultz@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 4 Jan 2020 at 00:10, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> On Fri, Jan 3, 2020 at 9:59 AM Mike Kravetz <mike.kravetz@oracle.com> wrote:
> >
> > Before I started investigating, Jan Stancek found and fixed the issue.
> >
> > http://lkml.kernel.org/r/a14b944b6e5e207d2f84f43227c98ed1f68290a2.1578072927.git.jstancek@redhat.com
>
> Applied upstream as commit 15f0ec941f4f ("mm/hugetlbfs: fix
> for_each_hstate() loop in init_hugetlbfs_fs()").

After applying above patch.
LTP test case memfd_create04 getting PASS on mainline Linus's tree
from Jan 3rd onwards.

ref link,
https://qa-reports.linaro.org/lkft/linux-mainline-oe/tests/ltp-syscalls-tests/memfd_create04

- Naresh Kamboju
