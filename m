Return-Path: <SRS0=G0tX=VI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1D6EC742A2
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jul 2019 21:29:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 82494208E4
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jul 2019 21:29:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728925AbfGKV3v (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Jul 2019 17:29:51 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:42685 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726446AbfGKV3u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Jul 2019 17:29:50 -0400
Received: by mail-qt1-f194.google.com with SMTP id h18so5965749qtm.9
        for <linux-kernel@vger.kernel.org>; Thu, 11 Jul 2019 14:29:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NHMutHaC4fGAAoXqoN4lGP6bXoyG9CNIk57UiE45cmQ=;
        b=sJ2EsLMNhEHQ6sb9D10sqjCqXsgE4m9dYoqWx27BrY28u5NspsGmcbbSBpd/kDsk4/
         7zBDfTxFJrgeui7LhPG5THN+9LaMyTKAsggAbCWtaeHViqS6aVaTCzKoRQDRPx8FlTGz
         aFBnwuOIGYy0fUFRUyIXxBlcrvjvcJLgwZmmOH0Dt43Q1oYTRaMEZDmBt1zN+/EADYrh
         QBMNPQn4T7H/vQiQpy3PMxn0rTzUGA/1acZrn1faSixS+fDHJFfTT38qkeC9ebVmumM3
         LqfCwLbDZ4tLg6Dq01pWfvgFmrzG0gd5PoA9CaefpzK6rtGpORiAyc7nPiFsWLaJJ62N
         9EKQ==
X-Gm-Message-State: APjAAAXmhB2rjQsFpzxSPGjEfkV27GhCniY3C1HkQs8MPV0uLtgiOCZe
        b0diIqChkazxciGs4dZ43BuleiJ2ze9K+1uo/3yBoSK7
X-Google-Smtp-Source: APXvYqzB5hlLPNcCXYxcrUus6AxRoVtA/x9MkilQ6VfTDIssmr423e/n2jjjo21nFF8J3+lr2KKgGlkMA16uQE00okE=
X-Received: by 2002:ac8:4996:: with SMTP id f22mr3444836qtq.142.1562880589704;
 Thu, 11 Jul 2019 14:29:49 -0700 (PDT)
MIME-Version: 1.0
References: <CAK8P3a2beBPP+KX4zTfSfFPwo+7ksWZLqZzpP9BJ80iPecg3zA@mail.gmail.com>
 <20190711172621.a7ab7jorolicid3z@treble> <CAK8P3a0iOMpMW-dXUY6g75HGC4mUe3P3=gv447WZOW8jmw2Vgg@mail.gmail.com>
 <CAG48ez3ipuPHLxbqqc50=Kn4QuoNczkd7VqEoLPVd3WWLk2s+Q@mail.gmail.com>
In-Reply-To: <CAG48ez3ipuPHLxbqqc50=Kn4QuoNczkd7VqEoLPVd3WWLk2s+Q@mail.gmail.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Thu, 11 Jul 2019 23:29:32 +0200
Message-ID: <CAK8P3a2=SJQp7Jvyf+BX-7XsUr8bh6eBMo6ue2m8FW4aYf=PPw@mail.gmail.com>
Subject: Re: objtool crashes on clang output (drivers/hwmon/pmbus/adm1275.o)
To:     Jann Horn <jannh@google.com>
Cc:     Josh Poimboeuf <jpoimboe@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Nick Desaulniers <ndesaulniers@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 11, 2019 at 11:05 PM 'Jann Horn' via Clang Built Linux
<clang-built-linux@googlegroups.com> wrote:
> I was playing around with building the kernel with LLVM a few months
> ago and used this local patch, but didn't get around to submitting
> upstream because I couldn't reproduce the problem for some reason. I
> think the warnings you're getting sound like what I saw back then:
> https://gist.github.com/thejh/0434662728afb95d72455bf30ece5817
>
> Quoting the commit message from that patch:
>
> ====
> With clang from git master, code can be generated where a function contains
> two indirect jump instructions that use the same switch table. To deal with
> this case and similar ones properly, convert the switch table parsing to
> use two passes:
> ====
>
> Does that sound like what you're seeing?

Yes, that is exactly right, and your patch seems to address the problem
for the cases I tried so far (will know more after a night of randconfig
testing).

Tested-by: Arnd Bergmann <arnd@arndb.de>

      Arnd
