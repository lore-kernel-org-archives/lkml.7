Return-Path: <SRS0=zem1=X3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66FD5ECE58A
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Oct 2019 18:52:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 451C521D82
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Oct 2019 18:52:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="TpyYBW2h"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728918AbfJBSwh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Oct 2019 14:52:37 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:45254 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726708AbfJBSwh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Oct 2019 14:52:37 -0400
Received: by mail-ed1-f66.google.com with SMTP id h33so75649edh.12
        for <linux-kernel@vger.kernel.org>; Wed, 02 Oct 2019 11:52:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=yVl3DvwCADMp64mcvKATV/e92AOrRf7vvTQmwDnOrvk=;
        b=TpyYBW2hiIXk1ZFCht2y3HJcPbCcRo2CDLEfs0/Sn6IRUDFDzcztEQ5+OP3uhfds3p
         HISNhssIt/0eInvtS1j1l6xoQDFrD9bOvfNWs6uSmd5j9jULKw+LfxVH7cawMse67ooU
         4/LWsuWbBUEhe3ALND6duir5F1uMOa9p92Dn0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=yVl3DvwCADMp64mcvKATV/e92AOrRf7vvTQmwDnOrvk=;
        b=d46qgxsLSdFw/wXPYXfLf+92ptNwQwXozstluvD6262siLrMGbk8bPqOM7YswbFSRw
         BIqtu6hJWW5LkeCQvyBMsO6SV/AzSaSsV3E6Mdak7Rwa0DEzOSJgFkBEpWPXfQJT7geW
         95pV01Jj64AY5VacDxGd7ft20swaES4OYGvXyP9PzLEIPebHHubyiSaoOYeavAY/Mjyi
         AhNxeTWv3Y+Jqerj0dROZXcE3usmo/EYS5/klGGlatUx2OsFd8NK4CHam0hK+oYxjH7b
         TwtNOzwyJBu0tPowtowSz1T3I4oiPjbajRU5AogKsRs3LH3hXz/hxwUi1y8gN0t2BJHV
         FTLg==
X-Gm-Message-State: APjAAAUcnRPrjg3ixxE07KdiVYsoDb3Z+9+yp5hvSnbLnC5uR3JGw26R
        s/U8O96WO+HCNvdlX7XxvcOfgQ==
X-Google-Smtp-Source: APXvYqy4nAcB23b6wdIF3ZqiDW0mlD3bK7ADCQW7GZ2ZJE4qpYFJuX+RzPLqxNkLw/iuPYQ1CM6/6Q==
X-Received: by 2002:a17:906:2ccc:: with SMTP id r12mr4383114ejr.219.1570042355474;
        Wed, 02 Oct 2019 11:52:35 -0700 (PDT)
Received: from chromium.org (77-56-209-237.dclient.hispeed.ch. [77.56.209.237])
        by smtp.gmail.com with ESMTPSA id os27sm2352181ejb.18.2019.10.02.11.52.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Oct 2019 11:52:34 -0700 (PDT)
From:   KP Singh <kpsingh@chromium.org>
X-Google-Original-From: KP Singh <kpsingh>
Date:   Wed, 2 Oct 2019 20:52:33 +0200
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
        Florent Revest <revest@google.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        Florent Revest <revest@chromium.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: Re: [PATCH] samples/bpf: Fix broken samples.
Message-ID: <20191002185233.GA3650@chromium.org>
References: <20191002174632.28610-1-kpsingh@chromium.org>
 <20191002184506.iauttcpgyzcplope@ast-mbp.dhcp.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191002184506.iauttcpgyzcplope@ast-mbp.dhcp.thefacebook.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02-Okt 11:45, Alexei Starovoitov wrote:
> On Wed, Oct 02, 2019 at 07:46:32PM +0200, KP Singh wrote:
> > From: KP Singh <kpsingh@google.com>
> > 
> > Rename asm_goto_workaround.h to asm_workaround.h and add a
> > workaround for the newly added "asm_inline" in:
> > 
> >   commit eb111869301e ("compiler-types.h: add asm_inline definition")
> > 
> > Add missing include for <linux/perf_event.h> which was removed from
> > perf-sys.h in:
> > 
> >   commit 91854f9a077e ("perf tools: Move everything related to
> > 	               sys_perf_event_open() to perf-sys.h")
> > 

I see this is already fixed in a patch that was sent yesterday and has
been Acked.

  https://lore.kernel.org/bpf/20191001112249.27341-1-bjorn.topel@gmail.com/

I will drop this change from my patch.

> > Co-developed-by: Florent Revest <revest@google.com>
> > Signed-off-by: Florent Revest <revest@google.com>
> > Signed-off-by: KP Singh <kpsingh@google.com>
> > ---
> >  samples/bpf/Makefile                            |  2 +-
> >  .../{asm_goto_workaround.h => asm_workaround.h} | 17 ++++++++++++++---
> >  samples/bpf/task_fd_query_user.c                |  1 +
> >  3 files changed, 16 insertions(+), 4 deletions(-)
> >  rename samples/bpf/{asm_goto_workaround.h => asm_workaround.h} (46%)
> > 
> > diff --git a/samples/bpf/Makefile b/samples/bpf/Makefile
> > index 42b571cde177..ab2b4d7ecb4b 100644
> > --- a/samples/bpf/Makefile
> > +++ b/samples/bpf/Makefile
> > @@ -289,7 +289,7 @@ $(obj)/%.o: $(src)/%.c
> >  		-Wno-gnu-variable-sized-type-not-at-end \
> >  		-Wno-address-of-packed-member -Wno-tautological-compare \
> >  		-Wno-unknown-warning-option $(CLANG_ARCH_ARGS) \
> > -		-I$(srctree)/samples/bpf/ -include asm_goto_workaround.h \
> > +		-I$(srctree)/samples/bpf/ -include asm_workaround.h \
> >  		-O2 -emit-llvm -c $< -o -| $(LLC) -march=bpf $(LLC_FLAGS) -filetype=obj -o $@
> >  ifeq ($(DWARF2BTF),y)
> >  	$(BTF_PAHOLE) -J $@
> > diff --git a/samples/bpf/asm_goto_workaround.h b/samples/bpf/asm_workaround.h
> > similarity index 46%
> > rename from samples/bpf/asm_goto_workaround.h
> > rename to samples/bpf/asm_workaround.h
> > index 7409722727ca..7c99ea6ae98c 100644
> > --- a/samples/bpf/asm_goto_workaround.h
> > +++ b/samples/bpf/asm_workaround.h
> > @@ -1,9 +1,10 @@
> >  /* SPDX-License-Identifier: GPL-2.0 */
> >  /* Copyright (c) 2019 Facebook */
> > -#ifndef __ASM_GOTO_WORKAROUND_H
> > -#define __ASM_GOTO_WORKAROUND_H
> > +#ifndef __ASM_WORKAROUND_H
> > +#define __ASM_WORKAROUND_H
> 
> I don't think rename is necessary.
> This file already has a hack for volatile().
> Just add asm_inline hack to it.

Thanks, will send an update the patch to reflect this.

- KP

> 
