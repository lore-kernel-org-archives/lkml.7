Return-Path: <SRS0=8QAT=T3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FSL_HELO_FAKE,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0B03C04AB3
	for <linux-kernel@archiver.kernel.org>; Mon, 27 May 2019 15:15:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 96F68217F4
	for <linux-kernel@archiver.kernel.org>; Mon, 27 May 2019 15:15:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1558970147;
	bh=Y6b6yXZeAA+FdgwDFhKqXFsnsp5c8eQj28czjzKl+4A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=oz944T/l3D8gn4dlnlTp2ehCfsZzawot8ydhS8hWES7s3KEAJi4FgcdwykOf3HNTD
	 3o/lkeo/9Yg/IdgcSbWbFudqKP0yxlbNd15juXecBeG/E1FbE64w5QfDOHydVomcha
	 vkY+Extfh/3h5MaoaDkbRb9k/N2ZX+T52atgF/sw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726820AbfE0PPq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 May 2019 11:15:46 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:39268 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726724AbfE0PPq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 May 2019 11:15:46 -0400
Received: by mail-wr1-f67.google.com with SMTP id e2so8461486wrv.6
        for <linux-kernel@vger.kernel.org>; Mon, 27 May 2019 08:15:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ZvBkGkdv93OLV3PxeAwTBouJeavwlksVk4ko4oJUjlE=;
        b=EVERUS3LT6+s6DOCsWlPCyKQqFBuatmfKHPeEB3J+cNgNZ0VR1WelMarDl9oLYQ+Go
         35Wf7axiwr9dmWLH5Ksl2qIqWuiF/dtXqebrIK8WikY0KTtoK79ke52gpf0NRC4z8LEN
         6qIGDuXWj2MTmLLBnnVWNNztusr1YHR1+WWOibhxun0BMwhbcr196w3HzLoHkmA+7Z0u
         HVcHpMlkffFLZLNodI+19vlX0uEMmxOuG/B0VXc6b3mhincbI9AjMj6DXRU1VdBLL3aa
         DtbL/73WrU/MDosOLQ1qLtEqcaGqFcx6PmgVlJtKU9YJ0WJqU8XWKNXzkGcd0w0SoWRk
         BPvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=ZvBkGkdv93OLV3PxeAwTBouJeavwlksVk4ko4oJUjlE=;
        b=I4kajtiiNPmEF8ylrWudIT+qB2CofykehrjEbuMspoPE5NBi29Ogpu3PpgN0kZ01k2
         /ANx5kWA8ETRljkqVYWCB+l2tOe/mkzE004Rm8dvf3QnEN9OJ+PJCgTl9seTkuQ92qFg
         X0khSTcjJ6S8iUQtTBGZdlPTghKWBHVDWqtvRVLzL36z99TdUghSTpuxLA7jQhID8ffB
         +ExNMlgPte/zJm5JmVl6/+Nn5CanFM/DDWVNBBxZecuoVFMxN+E+LMtlLgZuPlpjMQ+A
         txKL8tiFMLwa01UkcUAvcjhQ/BHbJhdR+t6/PDnm905iGjQMgiW9SrbGljKFOGFGV/Dc
         q+Fw==
X-Gm-Message-State: APjAAAUC+lokYo5zdTFWTygEJoQ5rpx9zM+KfV4S2AUY9YdrQ+7APQJs
        04VIunE8KMppI1F7cgy1QJ4=
X-Google-Smtp-Source: APXvYqwm4m1VNjorZKiow2jM2FH4Yo4j4UGowhzlvbKTNSmzuYuxz92MkNJVW/M7b5D9BfkS6cCnRw==
X-Received: by 2002:adf:dccf:: with SMTP id x15mr28442650wrm.139.1558970145081;
        Mon, 27 May 2019 08:15:45 -0700 (PDT)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id i32sm2968415wri.23.2019.05.27.08.15.43
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 27 May 2019 08:15:44 -0700 (PDT)
Date:   Mon, 27 May 2019 17:15:42 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Jiri Kosina <trivial@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] [trivial] perf: Spelling s/EACCESS/EACCES/
Message-ID: <20190527151542.GA50924@gmail.com>
References: <20190527122309.5840-1-geert+renesas@glider.be>
 <20190527141201.GA1537@gmail.com>
 <CAMuHMdV5TB4DRPuKkczYgCJ7+-yzEbnYp=TQydnK+3qmkPT4Tg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMuHMdV5TB4DRPuKkczYgCJ7+-yzEbnYp=TQydnK+3qmkPT4Tg@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Geert Uytterhoeven <geert@linux-m68k.org> wrote:

> Hi Ingo,
> 
> On Mon, May 27, 2019 at 4:12 PM Ingo Molnar <mingo@kernel.org> wrote:
> > * Geert Uytterhoeven <geert+renesas@glider.be> wrote:
> > > The correct spelling is EACCES:
> > >
> > > include/uapi/asm-generic/errno-base.h:#define EACCES 13 /* Permission denied */
> > >
> > > Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> 
> > > --- a/include/linux/perf_event.h
> > > +++ b/include/linux/perf_event.h
> > > @@ -289,7 +289,7 @@ struct pmu {
> > >        *  -EBUSY      -- @event is for this PMU but PMU temporarily unavailable
> > >        *  -EINVAL     -- @event is for this PMU but @event is not valid
> > >        *  -EOPNOTSUPP -- @event is for this PMU, @event is valid, but not supported
> > > -      *  -EACCESS    -- @event is for this PMU, @event is valid, but no privilidges
> > > +      *  -EACCES     -- @event is for this PMU, @event is valid, but no privilidges
> > >        *
> > >        *  0           -- @event is for this PMU and valid
> > >        *
> >
> >
> > Actually, -EACCES got typoed itself and survived due to historic reasons.
> 
> Quite possible... Someone pointed out a while ago it is part of POSIX,
> hence it cannot be changed.
> 
> Probably we can do "#define EACCESS EACCES"?

Don't think that's a good idea, nor is it necessary: it's only a comment, 
right? But yeah, I guess we can do.

> > I think we can tolerate the 'typo' fixed in documentation, can we?
> 
> IMHO we cannot, as e.g. "git grep -w" won't match both.
> Do you really want the documentation to differ from the implementation?
> 
> > Also, the *far* bigger typo is, in the same line:
> >
> > s/privilidges
> >  /privileges
> 
> Thanks, that one didn't show up with "git grep -w EACCESS" ;-)
> Will send v2...

:-)

Thanks,

	Ingo
