Return-Path: <SRS0=AnJR=XA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA3E7C3A5A5
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Sep 2019 06:23:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B90BC217D7
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Sep 2019 06:23:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DrmC8F3y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731478AbfIEGX6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Sep 2019 02:23:58 -0400
Received: from mail-lj1-f177.google.com ([209.85.208.177]:42394 "EHLO
        mail-lj1-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731293AbfIEGX6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Sep 2019 02:23:58 -0400
Received: by mail-lj1-f177.google.com with SMTP id y23so1112350lje.9
        for <linux-kernel@vger.kernel.org>; Wed, 04 Sep 2019 23:23:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=uQ5B0SOMWjcZt28lsTs/E8qAiAYYVgJARQcUjO5TKBM=;
        b=DrmC8F3yi2lHHuP8as/6D3dAKoQREbL9E2VKcGgAozVIA4JT7BikvLkVCWwLvs4FuV
         KxXdLonPWcr16xzEvwTUf5ryJDh6a1lTkVfHS+S7tluKj2DOEpLDZ+lmClLlRo0Uk4lN
         g/R2vvfUCiMS93C5yKFmAYq6mJ56NqtlpStUYc6uOflRzs9tLnN27GaZOXDdXWjLH5Tf
         dCL92feFvhlqmFUzzLHtpVOzP4AKOuBl9j2g19FYgtlvatnVlBATwFiVaO2tErFA8KB2
         lzeeR8zoh/lrhMI/+AgbFWEnsRygdIfwyDNWfWdOGba6XqwjAvTm76xpyJcBCD+HsPQJ
         NwAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uQ5B0SOMWjcZt28lsTs/E8qAiAYYVgJARQcUjO5TKBM=;
        b=M4vWXeFpSmMHJsyP0MgarD5X047meZkMoc5HVURhMBxBpDHe8egJ+v9Ct9FDsJTTy9
         FksrRP5zWsaYnUQwQmDoJrgBEJ331rmBQy7QxF8DIcB5Dj7c35LZVykDTK6xVK8qUY8G
         0OXnoihVx5dq4g8J0VRYCSc3fFb12iaxSzLT3VWfz6efFJB9SwBTro7pS7S4bkuYMxpS
         rNebVZFxMl1snkgqHe/NfmXs17qwdfmX/oKpB4CFc6F76KdMDrxFoCeE5ilTdMawTrU6
         yZxTFEKfEZ0wyqqFRpQzhJScppzOiQ/OVyHJ+RF/6sv82QjLmkk4EuSJVuoIFYtxz1L6
         ofAw==
X-Gm-Message-State: APjAAAWvSdJcwo+2TbS8IsSgpFnsdC7z4cPVv/MPXGoriO8KgB0l+IEp
        NcUVIJDSeECwz4A2ZloClRKTqQcT0LAoJWi+onw=
X-Google-Smtp-Source: APXvYqxhB09PqX92csonV9YtKIw4/QYf3ZUpwYPeiLnKXhngzH+Grf1+6N5nXnLs0f6ATlOX1LNMzPaQBxcX+BnpoLA=
X-Received: by 2002:a2e:3a13:: with SMTP id h19mr868106lja.220.1567664636414;
 Wed, 04 Sep 2019 23:23:56 -0700 (PDT)
MIME-Version: 1.0
References: <20190904181740.GA19688@gmail.com>
In-Reply-To: <20190904181740.GA19688@gmail.com>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Thu, 5 Sep 2019 08:23:45 +0200
Message-ID: <CANiq72mJiBQXM4o9CahODLwQfNXfQdE_fE2bmPJFHq7Qep3rHQ@mail.gmail.com>
Subject: Re: [GIT PULL] compiler-attributes for v5.3-rc8
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        Will Deacon <will@kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>,
        "David S. Miller" <davem@davemloft.net>,
        Paul Burton <paul.burton@mips.com>,
        Sedat Dilek <sedat.dilek@gmail.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 4, 2019 at 8:18 PM Miguel Ojeda
<miguel.ojeda.sandonis@gmail.com> wrote:
>
> I was going to send this for 5.4 since it is not that trivial, but since
> you are doing an -rc8, and it fixes an oops, please consider pulling it.

By the way, if you choose to pick it for 5.4 instead, I will take the
chance to improve a few things (fix a whitespace/style issue in the
arm patch, improve a few commit messages/typos, maybe get a few extra
Acks for arches that don't have it). However, the Clang team would
like to have this for 5.3 if possible, so I didn't want to delay
sending it.

Cheers,
Miguel
