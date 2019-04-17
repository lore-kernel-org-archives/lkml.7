Return-Path: <SRS0=uTOJ=ST=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 528A4C282DA
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 22:46:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 15B3B217D7
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 22:46:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="bsihWc/+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733102AbfDQWqv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Apr 2019 18:46:51 -0400
Received: from mail-vs1-f68.google.com ([209.85.217.68]:36040 "EHLO
        mail-vs1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728237AbfDQWqu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Apr 2019 18:46:50 -0400
Received: by mail-vs1-f68.google.com with SMTP id n4so123441vsm.3
        for <linux-kernel@vger.kernel.org>; Wed, 17 Apr 2019 15:46:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=j20znTWXI3oHzhqLxPOntFkY2TlFZy5Qp/lJdihgGS4=;
        b=bsihWc/+YWPZ1epEyxUeZfKUZiNdf7uIVFPIQxJVnf8L0gu9JN5+Pqq4u51wBoRRqc
         yl3llFZz/g9pJP2V6Mesi8tyglicc0CsbwSBMkvbLtkZbevko9XGkZn1QZsxWCnJ9+z6
         bn2sQzRrQiDyyQwyGvvV6NZR6MQ2gN+VVU8mM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=j20znTWXI3oHzhqLxPOntFkY2TlFZy5Qp/lJdihgGS4=;
        b=QLJuB4bqWbvvA5/YcRsGQ04HJKxv2FxBzPP3C+bX/n86b7jrIxQmEwMicXJpCOj+sd
         0E7o/NfiCbaEBUjPLEd6BhUX/HV3uJQHdBUrVPdIfwDm8a7duD3fZW/Eetv0LECUIVBh
         H0gr1KjXMgiZ7VWEi/0hEmlda3FwhUeyJ5PVVQpwQ+X1h2DAP4nYySm3awoe2yYv1L5f
         w/TbUpbxGu8O9wLXYIVI+susJnHoT4SyzQotvv/apbGYAx1enQTwzD+x+eLNBvPg0ofJ
         v8f4iAvXRGKfVYLp6ZfkgHTIsa8Rj+gmadkBS8kWXNnUHE8+N6+vw+7vM55xEmqc+4wR
         jqTA==
X-Gm-Message-State: APjAAAUCux+nIUW2gTiuqlobnQLOLAML4R0HJKvYOY7qVVf3UmDYjhdN
        4ecD8PG9FPIRlWQSjnMqi+LfH+DwJ7M=
X-Google-Smtp-Source: APXvYqw3J3CySKVqfG7IzwILnp2Jn4Ho1RdihgQjsZPPvMO6PEMwb5ciI+Bo50GwfCo7F8ohFudI8Q==
X-Received: by 2002:a67:f615:: with SMTP id k21mr50131254vso.136.1555541209120;
        Wed, 17 Apr 2019 15:46:49 -0700 (PDT)
Received: from mail-ua1-f52.google.com (mail-ua1-f52.google.com. [209.85.222.52])
        by smtp.gmail.com with ESMTPSA id d134sm216328vkf.6.2019.04.17.15.46.47
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Wed, 17 Apr 2019 15:46:48 -0700 (PDT)
Received: by mail-ua1-f52.google.com with SMTP id b8so154083uaq.7
        for <linux-kernel@vger.kernel.org>; Wed, 17 Apr 2019 15:46:47 -0700 (PDT)
X-Received: by 2002:a9f:3fce:: with SMTP id m14mr48865056uaj.96.1555541207126;
 Wed, 17 Apr 2019 15:46:47 -0700 (PDT)
MIME-Version: 1.0
References: <20190417165321.61cd6380@canb.auug.org.au> <CAGXu5jKYxLe9-umda7C3iWfYFe-Thv=dL4bJQC9nU4GMGK5Wwg@mail.gmail.com>
 <CAGXu5j+9_f=5aT7x=K=Hg9LS3eQ9-dhVF18LCBfZcx+EmTO3PA@mail.gmail.com>
In-Reply-To: <CAGXu5j+9_f=5aT7x=K=Hg9LS3eQ9-dhVF18LCBfZcx+EmTO3PA@mail.gmail.com>
From:   Kees Cook <keescook@chromium.org>
Date:   Wed, 17 Apr 2019 17:46:35 -0500
X-Gmail-Original-Message-ID: <CAGXu5jJfDnSJ328iQORWFRQUB=AEP-jdBG+_ppWo5m_MJasRNw@mail.gmail.com>
Message-ID: <CAGXu5jJfDnSJ328iQORWFRQUB=AEP-jdBG+_ppWo5m_MJasRNw@mail.gmail.com>
Subject: Re: linux-next: build failure after merge of the akpm-current tree
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Alexey Dobriyan <adobriyan@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 17, 2019 at 5:28 PM Kees Cook <keescook@chromium.org> wrote:
>
> On Wed, Apr 17, 2019 at 5:22 PM Kees Cook <keescook@chromium.org> wrote:
> >
> > On Wed, Apr 17, 2019 at 1:53 AM Stephen Rothwell <sfr@canb.auug.org.au> wrote:
> > > [...]
> > > Caused by commit
> > >
> > >   3ebf0dd657ce ("fs/binfmt_elf.c: move brk out of mmap when doing direct loader exec")
> > >
> > > interacting with commit
> > >
> > >   a34f642bccf1 ("fs/binfmt_elf.c: free PT_INTERP filename ASAP")

I should read more closely! I see now this is the patch where
elf_interpreter got moved. :)

And, yes, your fix is correct. *sigh* I will go find a brown paper bag now...

-- 
Kees Cook
