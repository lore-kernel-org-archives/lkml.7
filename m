Return-Path: <SRS0=P610=TX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01601C282DD
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 19:35:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CBB3121872
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 19:35:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Tssa4wzm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391924AbfEWTfL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 May 2019 15:35:11 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:41009 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387758AbfEWTfJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 May 2019 15:35:09 -0400
Received: by mail-wr1-f68.google.com with SMTP id u16so3637109wrn.8
        for <linux-kernel@vger.kernel.org>; Thu, 23 May 2019 12:35:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=LCWIRjkelIsQTcka41nOL2PfrXSiWnEkqhx7SOe+Cs8=;
        b=Tssa4wzmF60NI8v4tq2Nj7Cvxd/g2lxfLZ8wL/ksNOUR1HbDmTgJHgGW8Ps46oe7pp
         Abb3+b38WpXcJdKRWry6DBkwceX0sH2h0E3i75WsGTCpR9eNjqUqqPDzYFw0cSpnw6fr
         /898fTyD6dT53EhE2bVxrcH0VA+/4IhSjKfrGVsEjOfSZbifBGandHI/ZQCkfnA7p7ww
         l/E7jO7ns5jMClXqhHHceeabWoPCQ8fAdkK7Sf2kQF+bOvkQAoNoHV+FG9gF9RYGQshm
         mV1f+mIgXg9YOEKbCTP7O1uBRcQNBjRDT+JYCeX27835vtxIXSpz68H7yHY/DXQaaUys
         aYMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=LCWIRjkelIsQTcka41nOL2PfrXSiWnEkqhx7SOe+Cs8=;
        b=ewsyK62+uDToYTYWDM+fwhfpsD21DePbdTXgLGUtTWkZkme5GIydXQOqDTwtpEZo0P
         1qdksJFfnblHwnRlw/RNbyJ43RVlvH4l6RCeo4fcLMqAQk3pZMbTQEjlwAYK9LkMDeh8
         Cjzw/02+6a2qoZGGbj2kmbKMn1DPUjquZ6YV8ms6SHcP0rHhAMbsyuMUAHCwAip5h9Av
         sVEmjaSXJ71wg8LZNNqCILt9dw/yAL2vhFI8HUOOTyDaD/3rOGbXewy8WCMDmjORy/d3
         Im5z+pVbpwq/wRT4bNwlUnyJGyPB72aj2mFauY/Cmyo5p1h7gj3GPpRtYGNhnymGjAUO
         rPXA==
X-Gm-Message-State: APjAAAV2LFsTA2PcMspG+WQRIUSapUL4TE+z8005msPzGROklJn1ULxC
        f4x33/7uxpSACjBzfK1smVWIdhY=
X-Google-Smtp-Source: APXvYqySB9x4R1K6ByuXf9O/I9uSMXwuEj2Qdszk5SkUHXZE1V2kM7FQ0W7bFjNvqg3gxtEBR0oyOw==
X-Received: by 2002:adf:db87:: with SMTP id u7mr11184427wri.245.1558640108191;
        Thu, 23 May 2019 12:35:08 -0700 (PDT)
Received: from avx2 ([46.53.252.55])
        by smtp.gmail.com with ESMTPSA id l6sm290312wmi.24.2019.05.23.12.35.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 23 May 2019 12:35:07 -0700 (PDT)
Date:   Thu, 23 May 2019 22:35:05 +0300
From:   Alexey Dobriyan <adobriyan@gmail.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH] elf: fix "start_code" evaluation
Message-ID: <20190523193505.GA8475@avx2>
References: <20190523175736.GA6222@avx2>
 <20190523114417.f99d781754ed22950115c64a@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190523114417.f99d781754ed22950115c64a@linux-foundation.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 23, 2019 at 11:44:17AM -0700, Andrew Morton wrote:
> On Thu, 23 May 2019 20:57:36 +0300 Alexey Dobriyan <adobriyan@gmail.com> wrote:
> 
> > Only executable ELF program headers should change ->start_code.
> > 
> > ...
> >
> > --- a/fs/binfmt_elf.c
> > +++ b/fs/binfmt_elf.c
> > @@ -1026,7 +1026,7 @@ static int load_elf_binary(struct linux_binprm *bprm)
> >  			}
> >  		}
> >  		k = elf_ppnt->p_vaddr;
> > -		if (k < start_code)
> > +		if ((elf_ppnt->p_flags & PF_X) && k < start_code)
> >  			start_code = k;
> >  		if (start_data < k)
> >  			start_data = k;
> 
> What problem does this solve?

It is a bug. Look at the ->end_code update:

	if ((elf_ppnt->p_flags & PF_X) && end_code < k)
		end_code = k;

> How does it alter runtime behaviour?

It makes "VmExe" and "VmLib" accounting more accurate for common case.

> How do we know it won't break anything?

We don't. Some distros are unaffected because they ship binaries with
first PT_LOAD segment being executable (Debian 8). Some don't.

Regardless, these fields are lies: ELF binary can have multiple disjoint
PT_LOAD segments, but all those ->start and ->end fields assume everything
is mapped together.

Hopefully nobody actually uses them for anything serious.
