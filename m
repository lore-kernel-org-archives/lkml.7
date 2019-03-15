Return-Path: <SRS0=8sqo=RS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 050B3C4360F
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 22:01:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BEC1C218D3
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 22:01:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XKfcF8EQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726853AbfCOWBe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Mar 2019 18:01:34 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:42247 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726782AbfCOWBa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Mar 2019 18:01:30 -0400
Received: by mail-wr1-f67.google.com with SMTP id n9so6988497wrr.9
        for <linux-kernel@vger.kernel.org>; Fri, 15 Mar 2019 15:01:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NL3yBXOJlwZiVPBnELR5uPXxXUCxO87ilzyR2tp9CDE=;
        b=XKfcF8EQW5Rk/KKoGI2R496gtY4aNKYgfkAiA5htB99+q/1CEEzwbSfmTaGHqwJnvW
         juHbYPtSXwHa45k0PD3NFtIA8aadJEDwnx8xR3Q/sxBJzWkF4jH2daR1bBS5uy86FhQs
         tonlNprmHcYaK05iZU6FbdjEMMlT3k/E0YNwX7rDK69MDdapIIvynwvYgOqet+xfN+99
         dhFyiC7bABFOKhZItETI4mW4DdgJkG6d9lznBjD7q3fYHylO8wRas/5qp9wl+Pxi7PqW
         +nAhgawKVkH8sJTeFf/I0yZqc75P3lc8LA4jrWk4AdAFJYQFsD6eFf6q3p4nkgDcIsLy
         uLtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NL3yBXOJlwZiVPBnELR5uPXxXUCxO87ilzyR2tp9CDE=;
        b=NtjxP8pD9Ha+Fk9FGxyy6f4LByKMimWiwgUh2AiDED4Qp84i03xxCnnibhkoVsF306
         HGdUNc4jr9D9XbagRb442mmv7h0SR2QWyRFxLrhfgYHbA+gJGBvSHlaJAHYHdriouZSV
         fvnqw4JlrL6mkegS1+Bbm0mO+ME2/VNxI/NtFv/e9TUXG3VM3I+jLNxPillnCSaML5IQ
         vFN5f3YdUvh0uBE7YFih9k2xUl/dSS84sw3WGj2jaEmEkAzKsnQvbTtYKDf9S/B4NkbA
         zopdHNARY6pDWPz/YRk+qiMgcByiB7t1YEmH1FFqp0FZOyfOQQ2Mu8L5zT/ExET6QO+3
         NFwQ==
X-Gm-Message-State: APjAAAVVSblVkb3amYAdNtgnDlYnBLb8SgTgb3qeJ361oBIV3NUY3Lva
        og8bKSALlRb1Zd1nJkm0Rej4o7cJD9G0uYczJYwdUQ==
X-Google-Smtp-Source: APXvYqxm1OB+AgppMYkw4PmSzavT9iGHVH3XqedxABY7HM9dNqW9gSS8utA25iriWQQzQ8no+MtJ3pW17x2IxAm26nM=
X-Received: by 2002:adf:ec49:: with SMTP id w9mr3742884wrn.296.1552687288789;
 Fri, 15 Mar 2019 15:01:28 -0700 (PDT)
MIME-Version: 1.0
References: <31705653.NnsrL61LRB@blindfold>
In-Reply-To: <31705653.NnsrL61LRB@blindfold>
From:   Richard Weinberger <richard.weinberger@gmail.com>
Date:   Fri, 15 Mar 2019 23:01:16 +0100
Message-ID: <CAFLxGvy54Fa0Dr9jbqvv2utSi3WvCusAHbYreJ1C=wg2bWtPRg@mail.gmail.com>
Subject: Re: [GIT PULL] UML updates for 5.1-rc1
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-um@lists.infradead.org, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 12, 2019 at 4:14 PM Richard Weinberger <richard@nod.at> wrote:
>
> Linus,
>
> The following changes since commit 1c163f4c7b3f621efff9b28a47abb36f7378d783:
>
>   Linux 5.0 (2019-03-03 15:21:29 -0800)
>
> are available in the Git repository at:
>
>   git://git.kernel.org/pub/scm/linux/kernel/git/rw/uml.git for-linus-5.1-rc1
>
> for you to fetch changes up to aea05eb56e47046de1e5b508d40931dca969f1e5:
>
>   um: Fix for a possible OOPS in ubd initialization (2019-03-06 22:39:18 +0100)
>
> ----------------------------------------------------------------
> This pull request contains updates for UML:
>
> - Bugfix for the UML block device driver
>
> ----------------------------------------------------------------
> Anton Ivanov (1):
>       um: Fix for a possible OOPS in ubd initialization
>
> YueHaibing (1):
>       um: Remove duplicated include from vector_user.c
>
>  arch/um/drivers/ubd_kern.c    | 6 +++---
>  arch/um/drivers/vector_user.c | 3 ---
>  2 files changed, 3 insertions(+), 6 deletions(-)

*kind ping* to make sure this PR is not lost. :-)
I guess you skipped this one too after the git.infradead.org outage.

-- 
Thanks,
//richard
