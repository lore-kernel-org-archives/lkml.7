Return-Path: <SRS0=xYIU=RV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF773C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 20:44:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9314120872
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 20:44:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="XkZcuK+T"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727532AbfCRUoh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Mar 2019 16:44:37 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:37987 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726980AbfCRUoh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Mar 2019 16:44:37 -0400
Received: by mail-pg1-f193.google.com with SMTP id v1so7501831pgi.5
        for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2019 13:44:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=QEM+jCPNC49PZRZiVaqYm+WpQE4LEimTilZJ8sg1mCo=;
        b=XkZcuK+TrDAQ6JZobv7wI/S52f//O3rCkNQBr+RBTF5xqnDdvn/2hwqs6qMVXb1vQq
         qhC+CFKfYx2VlteH7Fzi66bY1+2YlWp0Ib/8SkvKNsmI9TZ+dEHWG7LnRwBLPCBLSuwi
         bVwVdWplrbzBfxEHKq6OEbdh5ZOQnCZif6LQg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=QEM+jCPNC49PZRZiVaqYm+WpQE4LEimTilZJ8sg1mCo=;
        b=F00VGjwnsl2NWoaU0sEHf+iRV/gEBqTgr3RkNfDXiCRnpMCeBhdkAxxouo3QIJo7dR
         4BmV0euf6pMgCVoJMDVdprulGA47kogWzu2IbdKgEMZW38GJQODHxaLKzVtBhGVW/0zI
         MekUWEu/ABfKt0GjF3mRlzF0roDJiptcVuzr7iBZOh/LRQJyLzESXg5TNxPnI0oQ6hGX
         pzpqTeL39NHZtFscAcJRjkb/rGi8RVecHGLsCRLCKwEChqLKXB+SYqckZF/LsSrDQAHK
         /YacO4FsjerII8aQ9OA99DYcwXNLDnmW0ql7NUx/w1WR3z74lYlydbQHuNa69lNy17vN
         ZxZw==
X-Gm-Message-State: APjAAAW6t4i91VWVFALcrhp/96IHbJdAF4S+SFvC5EzUiZkUyHR6pMwu
        29loedL8lLmJeMCjVgeSbP4LhQ==
X-Google-Smtp-Source: APXvYqzyy50/RWGfFpYtsg/UBI40gLYbjjenhyM3c+gsa8SzTwXAnit8wTXUlP9dmbpKKVXjj0iM4w==
X-Received: by 2002:aa7:8d01:: with SMTP id j1mr21567197pfe.122.1552941876424;
        Mon, 18 Mar 2019 13:44:36 -0700 (PDT)
Received: from localhost ([2620:15c:202:1:75a:3f6e:21d:9374])
        by smtp.gmail.com with ESMTPSA id e184sm16593470pfc.143.2019.03.18.13.44.35
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 18 Mar 2019 13:44:35 -0700 (PDT)
Date:   Mon, 18 Mar 2019 13:44:35 -0700
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        Manoj Gupta <manojgupta@chromium.org>,
        Tiancong Wang <tcwang@chromium.org>,
        Stephen Hines <srhines@google.com>,
        clang-built-linux@googlegroups.com,
        Masahiro Yamada <yamada.masahiro@socionext.com>
Subject: Re: [PATCH] x86/vdso: include generic __lshrdi3 in 32-bit vDSO
Message-ID: <20190318204435.GH112750@google.com>
References: <CAG5bF+SSMTvkgnQwHC1gx0pzysXhmMJ_+hUci_SJDPSteL4BcQ@mail.gmail.com>
 <CAKwvOd=aqWvjzC1ZF5_pXx2VutAX0dneDPxU_=jroqHUGw-X6g@mail.gmail.com>
 <20190315222906.GC112750@google.com>
 <CAKwvOdkXobdu74Fo0fiS4xkikqZdKS=gWN61pVAFBbXRPoenRw@mail.gmail.com>
 <20190318171604.GU6058@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190318171604.GU6058@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Peter,

On Mon, Mar 18, 2019 at 06:16:04PM +0100, Peter Zijlstra wrote:
> On Mon, Mar 18, 2019 at 10:09:37AM -0700, Nick Desaulniers wrote:
> > On Fri, Mar 15, 2019 at 3:29 PM Matthias Kaehlcke <mka@chromium.org> wrote:
> > > On Fri, Mar 15, 2019 at 02:31:09PM -0700, 'Nick Desaulniers' via Clang Built Linux wrote:
> > > > Is there a config I can set to reproduce this, in order to help
> > > > test?
> > >
> > > I encountered it with a Chrome OS specific configuration, but a
> > > defconfig should do.
> > 
> > defconfig selects CONFIG_OPTIMIZE_FOR_PERFORMANCE=y.  I needed to
> > select CONFIG_CC_OPTIMIZE_FOR_SIZE=y to repro.  My CI is simply
> > running defconfigs, which is why I didn't catch this.
> 
> I suspect the right fix is to make clang use -Os and abolish that -Oz
> madness.

You have a point, enabling -Oz (aggressive optimization for size)
doesn't seem a good choice for the entire kernel.

I'll send a patch to change it (back) to -Os.

Matthias
