Return-Path: <SRS0=RyeP=TH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 088A6C004C9
	for <linux-kernel@archiver.kernel.org>; Tue,  7 May 2019 18:39:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D110E20675
	for <linux-kernel@archiver.kernel.org>; Tue,  7 May 2019 18:39:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1557254374;
	bh=FSY3/kqchvKx22CyZoGU3L1w1ZK66nbuC+IJH0TQFJY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=MQ+GjXNhUOfXUKSVVc1pyKUP0BPDLLIOArEPmEcB6l+L9y7jIHnMOMznsjPXuuz2+
	 O2W7FVmnteJxmWEyWSVL7WffiPr0w2t8dp/uA5Vop2idXuTQUxfB/aehkc324uOooK
	 EIONDIrzm307tO8jXS0vhERo7hnnanIIz4gQu/G8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727784AbfEGSjd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 May 2019 14:39:33 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:52104 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727023AbfEGSjd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 May 2019 14:39:33 -0400
Received: by mail-wm1-f67.google.com with SMTP id o189so10832215wmb.1
        for <linux-kernel@vger.kernel.org>; Tue, 07 May 2019 11:39:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=6ha4TvK1nBUnsPWxdsbjlDPyZh819YBxf34Nph3LP10=;
        b=m9PeB/nVcFG8IBBf2K7WNaroHWM8hSErZv+Gjf0Qelb/621k777REskBflS4n35GYJ
         IRm5yBNsX5fqiKm92io4KytZN+lGZ2e9Goo1VA9zzPQ3X9P3eNEIbnWyeRVcDwmOCt6Z
         yyZM2czZJqEzciV5K+hUF/5AZNghdu15sE98tcxqPFv+yJ0dYZiImd6+cF+ey07WfKr3
         LRw1QdkblKD8v7jhNbKMESECWVR+tcXvwEjwX32KGNSTkRsHjic26AajF5+46m1IZ+5D
         bU4Z2QJgkb2AccN5qoQxeFNnYFqSrQadWnBvKMMIPFooNgexVekcv4RUjwjQIyyLfOTa
         V6wQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=6ha4TvK1nBUnsPWxdsbjlDPyZh819YBxf34Nph3LP10=;
        b=XyiQ1GUmV3+Hp3mS9n8SGaDNEaKa4E/vHNLHNFmSXuB+IyIKZbXW10xv+WynnBxw3G
         1oyZKRZ9uzUCASgl6RCjYjA+X5f0UuP1xtIGiF7Z2fC5zl24tkeFPyF6ACrxRE9OYtdr
         FfI2xcpSy4zb2W6NmxDRrMqLiWHIqhSTM3t/lP6eZNHBTX1uodddyVYyTjzKnI2GKUmH
         jj1DEZ6QND7o6/c70DZjWcWKTHieNdTAluzmR2tXJ20ej9ktDahoCd0T7rmvADo1mlen
         j1Me3g9ls3DAp525w0rnqx0QQio3AZ4AQ7InjqInn0TVLeGGVP7qji9LJ2Jvyd1lPgbI
         +3kg==
X-Gm-Message-State: APjAAAXsogOlFoL2mgdtmVjvvcg4KRBwwRZ9Wz1KLRFSejWoSTDbqLmc
        EwEHz8Cq/nuoF4MncAIGuxg=
X-Google-Smtp-Source: APXvYqxw0+V81AiQLmC/WqdO5pmK7YDtfDkRbUqI73ZsJkOecs/aK4u6Ht3uxMvCLpqjV466DRxrEQ==
X-Received: by 2002:a1c:2d91:: with SMTP id t139mr23229494wmt.102.1557254370721;
        Tue, 07 May 2019 11:39:30 -0700 (PDT)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id f7sm6784321wrt.81.2019.05.07.11.39.29
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 07 May 2019 11:39:29 -0700 (PDT)
Date:   Tue, 7 May 2019 20:39:27 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Kairui Song <kasong@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>, Dave Young <dyoung@redhat.com>
Subject: Re: [RFC PATCH v4] perf/x86: make perf callchain work without
 CONFIG_FRAME_POINTER
Message-ID: <20190507183927.GA58030@gmail.com>
References: <20190422162652.15483-1-kasong@redhat.com>
 <20190423113501.GN11158@hirez.programming.kicks-ass.net>
 <CACPcB9f8JuALCw1i-V2N01GuTQRfjrCya6esOTM8dGwvf+oT7w@mail.gmail.com>
 <20190424125212.GN12232@hirez.programming.kicks-ass.net>
 <CAADnVQJLLCQJoV8Qg+0D4_-mE8hLmrEYz91Jy0kT2Qgkb1evtQ@mail.gmail.com>
 <20190507165743.GX2606@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190507165743.GX2606@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Peter Zijlstra <peterz@infradead.org> wrote:

> On Tue, May 07, 2019 at 09:45:47AM -0700, Alexei Starovoitov wrote:
> > On Wed, Apr 24, 2019 at 5:52 AM Peter Zijlstra <peterz@infradead.org> wrote:
> > >
> > > On Wed, Apr 24, 2019 at 08:42:40AM -0400, Kairui Song wrote:
> > >
> > > > Sure, the updated comments looks much better. Will the maintainer
> > > > squash the comment update or should I send a V5?
> > >
> > > I've squashed it, I've just not gotten around to stuffing it a git tree
> > > yet. Should happen 'soon'.
> > 
> > Was it applied and on the way to Linus yet ?
> 
> AFAICT it has already landed in Linus' tree.

Yeah, it's now the following commit upstream:

  d15d356887e7: perf/x86: Make perf callchains work without CONFIG_FRAME_POINTER

Thanks,

	Ingo
