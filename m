Return-Path: <SRS0=Ecng=WJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B124EC32750
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Aug 2019 15:40:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8735C205F4
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Aug 2019 15:40:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="fS3U3jOS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730037AbfHMPkh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Aug 2019 11:40:37 -0400
Received: from conssluserg-02.nifty.com ([210.131.2.81]:29463 "EHLO
        conssluserg-02.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727621AbfHMPkg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Aug 2019 11:40:36 -0400
Received: from mail-vs1-f54.google.com (mail-vs1-f54.google.com [209.85.217.54]) (authenticated)
        by conssluserg-02.nifty.com with ESMTP id x7DFeQ5w005841;
        Wed, 14 Aug 2019 00:40:27 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-02.nifty.com x7DFeQ5w005841
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1565710828;
        bh=ElgNfXZMZzYFscddYTl+FYacj4IXIUchdgbey1VuLfw=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=fS3U3jOSG7dwaDYA52RwclcEno7uqObhkwNM5vFQCNE9fL+9THmJTsiOv4otdiNXx
         r1YkUrYo7IjdvjyVye+mj3A8lsMd872/vUofk+UUPmMCx4GyNzwdW+c9J7XV5SmMGL
         0Dvd3Ma965z2cLNKQRY2E/kK6AOz5PfbCVh84m9nbrROg+C2jLA9XxLl8ddlR+GUBc
         63vyTMapM1A4+L62k3TVzZlIVW/3Nli6BCoPFZu3kxNlugDN7yqFO34pZKDmFDlUzd
         qqjLp25o5e5P0EucOanhPk4Io/563nM9SpzcC9SAkNKtQt4hMzemsWMYZO0rdBqS/4
         Rv8ZulzcGzxVA==
X-Nifty-SrcIP: [209.85.217.54]
Received: by mail-vs1-f54.google.com with SMTP id h28so72445840vsl.12;
        Tue, 13 Aug 2019 08:40:27 -0700 (PDT)
X-Gm-Message-State: APjAAAVqEJOFkx7YUOFn9b3ihr9WFdWqD9N1O0S0VKsQquqWtImtww35
        rr9LtzMuqNAWSzgkrqyqDZ3ppXkhvaaDEKXoVEQ=
X-Google-Smtp-Source: APXvYqzDfb3tt9uOK5+h3fNDEOYwsyCDk8YG0KWh0aHzIws4fAq70hMHyJRviwu5syYZ0xlSUQLOA7eJMmT3ySydOyI=
X-Received: by 2002:a67:8a83:: with SMTP id m125mr6418101vsd.181.1565710826239;
 Tue, 13 Aug 2019 08:40:26 -0700 (PDT)
MIME-Version: 1.0
References: <201908130812.45DE9AE8@keescook>
In-Reply-To: <201908130812.45DE9AE8@keescook>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Wed, 14 Aug 2019 00:39:50 +0900
X-Gmail-Original-Message-ID: <CAK7LNAS5g6VXK8AunXbuMizjW2hs7tU8W-uuN4FwR9EYJgCy7Q@mail.gmail.com>
Message-ID: <CAK7LNAS5g6VXK8AunXbuMizjW2hs7tU8W-uuN4FwR9EYJgCy7Q@mail.gmail.com>
Subject: Re: [PATCH v2] kbuild: Parameterize kallsyms generation and correct reporting
To:     Kees Cook <keescook@chromium.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 14, 2019 at 12:15 AM Kees Cook <keescook@chromium.org> wrote:
>
> When kallsyms generation happens, temporary vmlinux outputs are linked
> but the quiet make output didn't report it, giving the impression that
> the prior command is taking longer than expected.
>
> Instead, report the linking step explicitly. While at it, this
> consolidates the repeated "kallsyms generation step" into a single
> function and removes the existing copy/pasting.
>
> Signed-off-by: Kees Cook <keescook@chromium.org>
> ---
> v2:
> - rename $kallsymso_previous to $kallsymso_prev (Masahiro)
> - move location of kallsyms_step() (Masahiro)
> - report linking step instead of folding it into KSYM (Masahiro)

Applied to linux-kbuild.
Thanks!



-- 
Best Regards
Masahiro Yamada
