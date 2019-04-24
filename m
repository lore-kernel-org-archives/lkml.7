Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25B83C10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 19:02:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DD6C220835
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 19:02:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="TtWGV6qx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388813AbfDXTCV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 15:02:21 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:42491 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728284AbfDXTCV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 15:02:21 -0400
Received: by mail-pg1-f194.google.com with SMTP id p6so9830461pgh.9
        for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2019 12:02:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=OhwSMH0wxuQpV1X/4MkvHMgeY7b/3Sp0UK9Vj8kRMhk=;
        b=TtWGV6qxmQAKhL3dCiXTEpzlw8cZXqYLY0E6nclcXoeXFELpXJ6DlRVHd8cT94gvYP
         OsXAFi6Qf7Ko9YNLLg4Y1gX9wDVv0sp90PkQvVbNAGxzEiUMReWH9QsxN8BjPoPnUVQI
         /bCsEeBsLnQiyU3Cj4i+dMloQ16qHEt/7PwiFMB8+W3BzXW4GwheN9XNiHE6DSbCh1RU
         Xf9EMcQWGEMgmrfhsCkMdVhPbSgmZTe+TuaPnTIKimOVIfsr0BpAIoDj+jCDbhKPqvI8
         7VtNzGH8gKUUriI5e1Cb0WMcWcGwgbV15Tshj9VhyEyaWi1NKmoAtW/3QScICx742L9N
         qVdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OhwSMH0wxuQpV1X/4MkvHMgeY7b/3Sp0UK9Vj8kRMhk=;
        b=Q9c//5hScxmuwBDMNaMUzBZj4uQ0GCVHZ1P0XbnqfVWhGiMsTb9VdOxayD+Q5k8AOz
         43BkN9ZWW09ycgHMXO2NfgZvQzlZfqXYXe00mByzFFt5f8coi+I92lGvcdzgHDwQlohC
         oCNmcZZKLTLvWTNbCrjnIQ9rRZVvZ75HEiAPtFvC2ilW0CWo6H6Qe5lWm+FB/ZZus+fo
         HLxguKgEorFLYGu+zigrG8JVP/TErhJ0fK66VQKu+7+MchCdgNIQGaYD3aw1Evr/OZp+
         np8l7vIYw5iL/RM0W6ttaSqmjvR3uTEE9eSrlDuiwYnrIadE30bW/JeEqCebD1kHTvxi
         Rprg==
X-Gm-Message-State: APjAAAUxmTi6eep6mgTnMfblGOM+8oHtOm+1IpylOvqH8t81knRThr7R
        KQ0Mvhbr2La3S6LrMHpiT8ST4JRjG6EaBcsqFgDgpTuFaQU=
X-Google-Smtp-Source: APXvYqzfNT2FeRRiF7g9fDxXsL7cpmN91xeCv08Jbz7fuCpp/C+sTQ7sDZpd/aUfTyP6uTrkuO+P5ggH9Yg2wGNpV3k=
X-Received: by 2002:a63:d713:: with SMTP id d19mr32673978pgg.145.1556132540133;
 Wed, 24 Apr 2019 12:02:20 -0700 (PDT)
MIME-Version: 1.0
References: <20190424183413.13854-1-natechancellor@gmail.com>
 <CAKwvOdkHiBhFsgEvLrr6oD84GKetDFV2b=n1DYDewCUyHWf7oA@mail.gmail.com> <20190424190005.GA9406@archlinux-i9>
In-Reply-To: <20190424190005.GA9406@archlinux-i9>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Wed, 24 Apr 2019 12:02:09 -0700
Message-ID: <CAKwvOd=xDJCzf0sgQKLvQH0Vh_jM=70LJ40wmp9qeyXGqa_cTA@mail.gmail.com>
Subject: Re: [PATCH] thunderbolt: Make priority unsigned in struct tb_path
To:     Nathan Chancellor <natechancellor@gmail.com>
Cc:     Andreas Noever <andreas.noever@gmail.com>,
        Michael Jamet <michael.jamet@intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Yehezkel Bernat <YehezkelShB@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        clang-built-linux@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 24, 2019 at 12:00 PM Nathan Chancellor
<natechancellor@gmail.com> wrote:
> > > Furthmore, that value is only assigned to an unsigned integer in
>
> Although apparently I can't spell... should be "Furthermore".

:set spell

there's probably a way to autoset this for commit messages.
-- 
Thanks,
~Nick Desaulniers
