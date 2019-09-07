Return-Path: <SRS0=QEJJ=XC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12E73C00307
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Sep 2019 00:44:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E25262178F
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Sep 2019 00:44:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="n7/teM7m"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393551AbfIGAoB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Sep 2019 20:44:01 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:43829 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729121AbfIGAoA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Sep 2019 20:44:00 -0400
Received: by mail-pf1-f193.google.com with SMTP id d15so5651602pfo.10
        for <linux-kernel@vger.kernel.org>; Fri, 06 Sep 2019 17:44:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Qq+ViY1LzTKSZu7bhAccIqZ/Vrzl8d1032PbomfEyFI=;
        b=n7/teM7m5aZbE1shei+cdfMkg1tdBR1zKLy2TcRf4qFA/v75LU483wyCY0kuW4fasm
         bN/U3dSFZ4TbNy62Z05NOELMTUHQavfaiZqchmgH9E+RL4jPMFy2VLEkyaq9ca9pr0+a
         ZtJVrhe+xaj2XOVmemaHzu4vlvc6I5+qzRPaNW9Qn/xqDysDhAG2o452neAD5n++i5pc
         w0dokgJeE+NPPJTcIyIErlfWZTS4yYfJQuO6qj6PftV/CI8Kl2mlEh5olkp8HBhpTCP3
         QSTPAsailtOOs1KCcL1ZhUdXYh+JQanFd19NbVdG3YvcKcqKaAwZFjD7MM+IsbXn+F4i
         fkwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Qq+ViY1LzTKSZu7bhAccIqZ/Vrzl8d1032PbomfEyFI=;
        b=YmjXJTktL8AglbGiB/SI2jrCXaVa1wlLQWjVlwpo3QlRYlIa0W99jUkSwl+JmEXDyu
         +srq2/Q00zwk7GXDwkFI4t2g5j40gGcwRAwvwg8FNZqLxMWopx8qCKn5EFYDncHFO/Oq
         NrrNw+O3UI1Q+O4R2Y076Xjy70fcMeSxlEurlH3HHmFMV1ocEdOvJOhWz5o5Ih7LNIXy
         1ByVLGrkcUGRdlWjtofjKmQnKn7rMZF1spmWjaFUBITDcWiELImu23rT6ni2LOovq8Ae
         7jjlOfwpJHLDnVoGDMPv4K9EPxA0tRKlVkOHp0iIZ8F7vSEcdYHdAiFYWbqjf7ILr18D
         cjqQ==
X-Gm-Message-State: APjAAAVIwjH5ECyK3RexN7dYkUrp6fKEdMs3g5B1WhuB4gkAjk2RUyMD
        n8HAsY7KLXbIwFsNJn/SCt644nDq+lxvhzRzTMDVtQ==
X-Google-Smtp-Source: APXvYqxNP6gWOyjr1acOuCGc/GdMi0xFXjEM4HZgQ5wAy7E8EJDZcEtr9GXcq4irNMIDrGsZSm1SJQndC627Tp7FRAk=
X-Received: by 2002:a17:90a:7f01:: with SMTP id k1mr12133159pjl.84.1567817039262;
 Fri, 06 Sep 2019 17:43:59 -0700 (PDT)
MIME-Version: 1.0
References: <20190906152800.1662489-1-arnd@arndb.de> <5dfe1bfc-0236-25cf-756b-ce05f7110136@linuxfoundation.org>
 <CAK8P3a3ynubySZ3A5M7D__B6R+caMjys=v+GVjqA78rppOJQQQ@mail.gmail.com> <67f4fe26-7d6a-68f2-dc45-af358be590df@linuxfoundation.org>
In-Reply-To: <67f4fe26-7d6a-68f2-dc45-af358be590df@linuxfoundation.org>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Fri, 6 Sep 2019 17:43:48 -0700
Message-ID: <CAFd5g47uH-6Bn53Dd8VsFMVn7o26txY2rrUe_XmU3+E4VV_B=A@mail.gmail.com>
Subject: Re: [PATCH] kunit: add PRINTK dependency
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Shuah Khan <skhan@linuxfoundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Logan Gunthorpe <logang@deltatee.com>,
        Stephen Boyd <sboyd@kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>, kunit-dev@googlegroups.com,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        shuah <shuah@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 6, 2019 at 9:08 AM Shuah Khan <skhan@linuxfoundation.org> wrote:
>
> On 9/6/19 10:02 AM, Arnd Bergmann wrote:
> > On Fri, Sep 6, 2019 at 5:39 PM Shuah Khan <skhan@linuxfoundation.org> wrote:
> >
> >>>    config KUNIT
> >>>        bool "Enable support for unit tests (KUnit)"
> >>> +     depends on PRINTK
> >>>        help
> >>>          Enables support for kernel unit tests (KUnit), a lightweight unit
> >>>          testing and mocking framework for the Linux kernel. These tests are
> >>>
> >>
> >> Hi Arnd,
> >>
> >> This is found and fixed already. I am just about to apply Berndan's
> >> patch that fixes this dependency. All of this vprintk_emit() stuff
> >> is redone.
> >
> > Ok, perfect. Unfortunately I only started testing the coming
> > linux-next release after Stephen went on his break, so
> > I'm missing some updates.
> >
>
> No worries. I am pushing it now - should be there in 5-10 mins.
>
> Please use linuxk-kselftest next.
>
> Let me know if you see any issues. Thanks for testing it.

Hi Arnd, Shuah accepted my version of the fix earlier today.
Nevertheless, I really appreciate you looking into this. Sorry for
wasting your time.

Please let me know if you run into any additional issues.

Thanks!
