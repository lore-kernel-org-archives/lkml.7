Return-Path: <SRS0=xYIU=RV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A3C6C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 22:23:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3F9592171F
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 22:23:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="S5qn+oAu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727540AbfCRWXg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Mar 2019 18:23:36 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:36894 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726743AbfCRWXf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Mar 2019 18:23:35 -0400
Received: by mail-pf1-f196.google.com with SMTP id 8so8830001pfr.4
        for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2019 15:23:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hPvuijIMtfvjLFQQ6GUWblK04RcVuWtqzWn4PIpDMvM=;
        b=S5qn+oAuWHyEyFn1XqZEUmq9jL5T+Kl3uLm1UxxkagluDLi9k2Oy/r4NufpOIsKrL4
         ruqL8SR5z9+uJHmVS3cxy5JS4RfPm+yk07QWEmNlikGwIz8VnhRiDjgRDusOVyQDVUf0
         jdU8JRtPQMgWrKZChjmHE5rtcdRfy9h+QhvGk05X9QvGFGfEDk9sfjN1/aeRSW6IGzMc
         zPF0LiNSbLWkiVHMZjRIVk53X/+Xio5dH4VtjBDi09w8ee3QBXblqTB1mnL11oT5fOle
         OILO7OdeJa1KxiG4S/kLpEcN/rxZ2l4v2bEYOLfUwFOvYOg2fmAZu1yy8LFkDVQnUwYG
         WBEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hPvuijIMtfvjLFQQ6GUWblK04RcVuWtqzWn4PIpDMvM=;
        b=pNYsv0XhFyTWkpf9rG88rR/SFas6QXmMHUOX2r2HFJEfs64qNl0evPTHdpMie61hMw
         3XETI94M0b3oDshPJ6sSwLWEt4oXj/MYgwA+kjEYU9Yez3qjIgcU0f+gLYLWM4LIZZEc
         78HJMwS3g6nCcf7Q5k0CF0UFrGTeo6hOAVWnw92LEKgQsKQ71KNb1Sdj8mM7AmuoZ2ST
         wc5vhAavf8DtT4IUhgf3HoMe+sJ7+pZWafDx5MMJ6OochhFaUG006yhED7m3cfb6mA03
         x/GfRPa6lW4xDkC7eNGskS1eJlokQLpjpCPuKV1Ppw3aym9U443kCjgjhbSSHCHohQhP
         oXYA==
X-Gm-Message-State: APjAAAVWc5kfrke9FjIAfHs4tQwX42MzVXa1TcSFK2TkjTdRCEGiyNqJ
        JlzWDDp3S7wCUJgqoKFxAI3mjadI8XOF4kq9rHdALA==
X-Google-Smtp-Source: APXvYqwbvGICKqKzgqEfwgraNd5MPcK93Bp/bl4camdoFlGeMbgV6TTwgvedI7UPlxHgvH5qZQzwUNWJmXY+Ba8d8j8=
X-Received: by 2002:a62:7603:: with SMTP id r3mr7602250pfc.32.1552947814673;
 Mon, 18 Mar 2019 15:23:34 -0700 (PDT)
MIME-Version: 1.0
References: <CAG5bF+RvumzKK0E-GAT223jnBvkRe1RN_0J9cGpfPOqCBvfWyw@mail.gmail.com>
 <CAKwvOdnms16AC3jPcc_7MXD7QF43dKvHsi+aqmsz0wX-u1GTpA@mail.gmail.com>
 <20190318215605.GJ112750@google.com> <0275C6DD-7F77-4D51-9C35-B25ECF61EB0F@zytor.com>
In-Reply-To: <0275C6DD-7F77-4D51-9C35-B25ECF61EB0F@zytor.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Mon, 18 Mar 2019 15:23:23 -0700
Message-ID: <CAKwvOd=yefHpPryGsZX3s6SFzmMt9kX6TqoGfp6-5A-KoZsy4Q@mail.gmail.com>
Subject: Re: [PATCH] Revert "kbuild: use -Oz instead of -Os when using clang"
To:     "H. Peter Anvin" <hpa@zytor.com>
Cc:     Matthias Kaehlcke <mka@chromium.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Michal Marek <michal.lkml@markovi.net>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Behan Webster <behanw@converseincode.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Manoj Gupta <manojgupta@chromium.org>,
        Tiancong Wang <tcwang@chromium.org>,
        Stephen Hines <srhines@google.com>,
        clang-built-linux@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 18, 2019 at 3:07 PM <hpa@zytor.com> wrote:
>
> On March 18, 2019 2:56:05 PM PDT, Matthias Kaehlcke <mka@chromium.org> wrote:
> >> >  KBUILD_CFLAGS  += $(call cc-disable-warning, int-in-bool-context)
> >> >
> >> >  ifdef CONFIG_CC_OPTIMIZE_FOR_SIZE
> >> > -KBUILD_CFLAGS  += $(call cc-option,-Oz,-Os)
> >> > +KBUILD_CFLAGS  += -Os
> >> >  else
> >> >  KBUILD_CFLAGS   += -O2
> >> >  endif
>
> Would be nice, still, to have -Ok.

April fools *is* coming up. 0:-)
-- 
Thanks,
~Nick Desaulniers
