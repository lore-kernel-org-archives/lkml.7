Return-Path: <SRS0=brkd=WZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8643AC3A59F
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 20:47:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4910023403
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 20:47:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="CadrU8gh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728012AbfH2UrT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Aug 2019 16:47:19 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:32992 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726619AbfH2UrT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Aug 2019 16:47:19 -0400
Received: by mail-pf1-f194.google.com with SMTP id g2so2908710pfq.0
        for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2019 13:47:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=MJayklqdWT6csEYdYMiQVvZMqRpC466630ChpVCkdxQ=;
        b=CadrU8ghFwM/MmiEU93P/EsB+k0qrlc83o+7qya6T5tZ+i7E3oeIb1GUYIzwpF1eu7
         ngEIGAi8KJbKpNuzegOuyqiN95pmVfJww9DCfNB3Ju+Bz8h1NJ7osLc+08K2rHE9HMci
         k8EWAuD9KijnDszcJUE9t6KVEx8YkAsCxW5i6CBZTGuUoka6+FvmttBS195aj3VDHZsK
         WSq0Gv6lZao/vQn8yQWEYN9kiBXoopzqku7eM5IMd5KBbYD9R8mPxZNLgx/M2KgJ36RJ
         Nc6PcwyesQg/rIYwDARgAXvbivH910n2Cn1u78p6KAITchdHsvVPe0aO3WhsNTF0MxC6
         B5Gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MJayklqdWT6csEYdYMiQVvZMqRpC466630ChpVCkdxQ=;
        b=mVOpSqY7w3T5ECiJB5qZ3kvy/C6RUa9gvAMclhy4IPOXkELPdIj2MGXkMKrV66RnBQ
         fsQppQpRusc9eiIOHawVMci7w2EtxeVkHeopCiLJhijPwyTuZTEN99w17n7L7RkaWxl4
         F8E83oWCR4Y8PpgCr/mm57tZrDVkTsgm1xzph6+IHDEOmxv2vLpqNQq0uRVPlVYx5JZc
         xtdukjTQMWtJiS6ydoeOUkB3K7AlftktfE/BDsvmc03sgjIZvc0m33dkLmm97eFDs6mb
         T6KcLo+JxgYY5nVzTvqvkybtabvtvTZM7q38ZcD1v49y12bMZcSdsyawS/GMSjQzFG7Q
         kkUA==
X-Gm-Message-State: APjAAAXcq8ByvyAPBcamVqR5cFFar1UngbxsZQPwPMbv3ZqgcPGt9fB+
        /jhsuLcoGjGcwMy4AHSKZbSGOth4ODMz/CvBBGFK4A==
X-Google-Smtp-Source: APXvYqzbv9mK6xtLscOvP00n/83YqjbqNkKSGGml7xd6V/X/DbMR9yUcaVYkok+Zm+5A9jArVW0I0nS2OLmtBjvs42o=
X-Received: by 2002:a17:90a:ac02:: with SMTP id o2mr12093307pjq.134.1567111637649;
 Thu, 29 Aug 2019 13:47:17 -0700 (PDT)
MIME-Version: 1.0
References: <20190828225535.49592-1-ndesaulniers@google.com>
 <CANiq72niUcQv-TFn=_0Ui7nEM9ESKNC7n6GPQs2AKXVsg6ZV=A@mail.gmail.com> <CA+icZUUi9Tsjha+unG+DasXZ9oBb6XcuZvj+N9h=b4XH7cHmqg@mail.gmail.com>
In-Reply-To: <CA+icZUUi9Tsjha+unG+DasXZ9oBb6XcuZvj+N9h=b4XH7cHmqg@mail.gmail.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Thu, 29 Aug 2019 13:47:06 -0700
Message-ID: <CAKwvOdmF0D0vfoXdJgUxmc_Zszuid+QPL+LT5CUiaYUSA9Lp4A@mail.gmail.com>
Subject: Re: [PATCH v3 00/14] treewide: prefer __section from compiler_attributes.h
To:     Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc:     Will Deacon <will@kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        naveen.n.rao@linux.vnet.ibm.com,
        David Miller <davem@davemloft.net>,
        Paul Burton <paul.burton@mips.com>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Sedat Dilek <sedat.dilek@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 29, 2019 at 1:37 PM Sedat Dilek <sedat.dilek@gmail.com> wrote:
>
> On Thu, Aug 29, 2019 at 10:24 PM Miguel Ojeda
> <miguel.ojeda.sandonis@gmail.com> wrote:
> >
> > On Thu, Aug 29, 2019 at 12:55 AM Nick Desaulniers
> > <ndesaulniers@google.com> wrote:
> > >
> > > Changes V2 -> V3:
> > > * s/__attribute__((__section/__attribute__((__section__ in commit
> > >   messages as per Joe.
> >
> > I have uploaded to -next v3 so that we get some feedback tomorrow
> > rather than waiting for Monday.
> >
> > I added a few changes, please take a look at the commits:
> >
> >   https://github.com/ojeda/linux/commits/compiler-attributes
> >
>
> Thanks for taking care and bringing this to linux-next asap.

LGTM, thanks Miguel, ship it!

-- 
Thanks,
~Nick Desaulniers
