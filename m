Return-Path: <SRS0=LehB=SZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: *
X-Spam-Status: No, score=1.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92548C10F14
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 10:32:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 60EC421773
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 10:32:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556015529;
	bh=cA3ZIDYb800C0iJLKHUTeICmaFLnxRTnqTsSa4gz03g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=TZwZ/+L07K8+BsAI95gvyysWnmLO7npUlzgob+cdG8/5FaWJcbLRf61IKH3ZIPVUj
	 0h9Jeq/D3Nw1+4v+HzFYxH6Q3UbRD+ZWiOAS2sOAuzMiWrpyfYM0agrTb1SrtV7Vjy
	 VmSLFOddjsBuSzPMNqmy05pMM1TANwd8dzrVMagY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727431AbfDWKcI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Apr 2019 06:32:08 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:39634 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726655AbfDWKcH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Apr 2019 06:32:07 -0400
Received: by mail-wm1-f66.google.com with SMTP id n25so18163734wmk.4;
        Tue, 23 Apr 2019 03:32:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=1h02xueaaJFtF8x54I3NbxfsC/y6oSLfXpoeLAVseVs=;
        b=Hw2HMstgeI19LI9vn1yVhXvGJ7k+0+Igomx//YCQQVll0cGUmx2d6afV4RtVz24sL8
         wSf12M4I35BeRxwG3QRI7GUasdX1nRG/kOyQKe1a2OvQZlYUUfmbeCDRTs05y0yK8G0F
         gRTxg6ZYMqLLO9JHjCsjoit9s5mHn/bsgN4gatuLVZbbOmRsyyI+UvyKWi0J24nL6Jbs
         6cy21eVVpeONPc8c2mxlvK9rLDdGVJSLUIHRFqxIQ16CPEeAwk+Y01nHSdl2IXJSeKcp
         4GjqSTW/JR/2Zq34NAg/DU9rbYGctiyfBqpg8bXJvn/8/ILIEtZzagHePp9+wKiXUXZd
         NQug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=1h02xueaaJFtF8x54I3NbxfsC/y6oSLfXpoeLAVseVs=;
        b=BBZszZXXL+EIYoHR3ikw5+cH4MK/YFGbN5coOJVrE3fg8Rkv4hCkf7g0WHwxzdNKuE
         tw7XeQUF8YmfCn09WonKU54cLkOvZf5XtMN/p+GjkxBcBr4kz2+At3O76XuVU0t8yTBb
         Tb2wsSPoUrmaQzIO3w5KB4d9g8nzthphIMc6GE0KVumpcRZBbSAWeXZdEAFugwWaVgEi
         zm2NBgvGv6n0Zankn8EkCvawLEjfZo4p0l2GZftPWdi0aOz2euWhJFir+L8xjWABl7/6
         IgGzxzZB0JWD3Vb9zxRBD2gwOVG7/l2eXHJmD7y38eyRifPvEqoB0x78tDXeHjWCWqYL
         U9+g==
X-Gm-Message-State: APjAAAWKJlxTrWqVURyg+j2w8WtmFPZs6plPI5G9tlfxR6lAYwTLcyOx
        UfeaAyCVKnNAjnvHk7DZEa0=
X-Google-Smtp-Source: APXvYqyuXf+4Dw8hnX2A4wTfGbWIEl15Zb7wQTdrXbdUf8DzPIPlvwbqmhTugPVgnulHkLpEVcMxfg==
X-Received: by 2002:a1c:ed12:: with SMTP id l18mr1862826wmh.13.1556015525911;
        Tue, 23 Apr 2019 03:32:05 -0700 (PDT)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id a4sm9561362wrr.39.2019.04.23.03.32.04
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 23 Apr 2019 03:32:04 -0700 (PDT)
Date:   Tue, 23 Apr 2019 12:32:02 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Mauro Carvalho Chehab <mchehab@infradead.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        Ingo Molnar <mingo@redhat.com>
Subject: Re: [PATCH v2 38/79] docs: scheduler: convert docs to ReST and
 rename to *.rst
Message-ID: <20190423103202.GA13655@gmail.com>
References: <cover.1555938375.git.mchehab+samsung@kernel.org>
 <2a3b2b06459e0134a3af4fbf3e6f62e6d42c4d26.1555938376.git.mchehab+samsung@kernel.org>
 <20190423082937.GZ11158@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190423082937.GZ11158@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Peter Zijlstra <peterz@infradead.org> wrote:

> On Mon, Apr 22, 2019 at 10:27:27AM -0300, Mauro Carvalho Chehab wrote:
> > In order to prepare to add them to the Kernel API book,
> > convert the files to ReST format.
> > 
> > The conversion is actually:
> >   - add blank lines and identation in order to identify paragraphs;
> >   - fix tables markups;
> >   - add some lists markups;
> >   - mark literal blocks;
> >   - adjust title markups.
> > 
> > At its new index.rst, let's add a :orphan: while this is not linked to
> > the main index.rst file, in order to avoid build warnings.
> 
> Well, just don't expect me to ever touch these files again.

The .rst files still read like text files, right?

So just pretend they are text files, I'll fix up any markup errors! :-)

Thanks,

	Ingo
