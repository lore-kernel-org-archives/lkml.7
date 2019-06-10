Return-Path: <SRS0=f7FU=UJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: *
X-Spam-Status: No, score=1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FSL_HELO_FAKE,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	T_DKIMWL_WL_HIGH,USER_AGENT_MUTT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0378C282DD
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Jun 2019 09:42:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 95A6E2082E
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Jun 2019 09:42:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1560159750;
	bh=agt2FyPXlVOHdcV8P+krkHxqxF71sl0e1EqxW6IO0uA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Pl1WpIJA4+Lh+gCPbSo3NBFxwcWmSbWyCNkluvKYvY4bgT2epKQHOvJFsKD0l6a+u
	 tLYN1vNBbceuUVPvD6kXH+LgH73LdVW7gx2KRqfbFBvHQ1MiWVEhL8OjfjJ7+EnOma
	 lTgn5rOlT/nkjz6tel8rYojxDiT9tPcgwU1DHUv0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389023AbfFJJm3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Jun 2019 05:42:29 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:36254 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388033AbfFJJm3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jun 2019 05:42:29 -0400
Received: by mail-pf1-f196.google.com with SMTP id u22so4977208pfm.3
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jun 2019 02:42:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=fmMoFhGab8QQq+4ZFOGVd3lIsa5ObNxIXJORVfF0Hlw=;
        b=DCWBITwFEZ/nZZHhoQiGgSKqY+Bg+p9DQpXFEzfeQPUR1owHIM6Jzu8KtMzqTp4JLd
         SKNqnMWYYWBEmOYQaxgRpBF5krcBW5Lj7c/9g9SuNPHO9OFjMIrLYg8DJxdKeUciotSA
         BcoCmu930A+/EJQAwoDqicVpodwgUviIWX3jKAcqtimR8jzCYQ2eUncu8G41rLOIjxdh
         FZN4PhQNXYhuR9BaBpIY3lAytW8/PQiL8OplKLVIXHV2STSeVKw2VLz3oCKD2djfMVCy
         BSlVkKTQeKwFFyevpLCzJsdcJPlFzYs8QK8tV14/amM0DZlPvcghTnnXSPJkFlqZReBj
         sRZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=fmMoFhGab8QQq+4ZFOGVd3lIsa5ObNxIXJORVfF0Hlw=;
        b=pt+o+djq2LcBvfsgceIx+gLjJw3B93u/sEOPfzN+EET/4p5ssLIQ8X86OXx/3ZR0jv
         KFp3+gQ6N9aHPZMiNACf2McJT7QWBN4q28czBHBFFqpMX335nnECxT6Fa+OcyBJMGTlA
         ctidqWbw+IGDgwhIq0lmBCqnWQT/3+KJAQ5OAj8dHAxBxSBV4gWxWqU/EaSOaLuvrUwZ
         ceudCduFY+pCioSOkRdtpx3IEKLCo2HTqwwvI7bpUwKR06pdoZxo2Kiu8eMWqoZp/mOo
         HFwz0rWy0Wh+02lJ19cvmtoAdZ38rnhSysFPAjIjMcvRmxCXk16iNgpeGONux5i5HBHX
         1m5A==
X-Gm-Message-State: APjAAAW7TPIIdbSszdNsfUAQUuzjImkU6CbZnKkvzQRyU0Jogr2vTrQn
        Gi5SQL1pk86a5TFL1MWPrdSf/cRt
X-Google-Smtp-Source: APXvYqzLJdBS8O+tcgX/72R0zigsfon0cIQCkAY11GgyKWuOMosGl04CXHAjfRMr4sraVck30xrnnQ==
X-Received: by 2002:a65:5302:: with SMTP id m2mr14789887pgq.369.1560159747932;
        Mon, 10 Jun 2019 02:42:27 -0700 (PDT)
Received: from google.com ([2401:fa00:d:0:98f1:8b3d:1f37:3e8])
        by smtp.gmail.com with ESMTPSA id g71sm14625294pgc.41.2019.06.10.02.42.24
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 10 Jun 2019 02:42:26 -0700 (PDT)
Date:   Mon, 10 Jun 2019 18:42:22 +0900
From:   Minchan Kim <minchan@kernel.org>
To:     Michal Hocko <mhocko@kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-mm <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>, stable@kernel.org,
        Wu Fangsuo <fangsuowu@asrmicro.com>,
        Pankaj Suryawanshi <pankaj.suryawanshi@einfochips.com>
Subject: Re: [PATCH] mm: fix trying to reclaim unevicable LRU page
Message-ID: <20190610094222.GA55602@google.com>
References: <20190524071114.74202-1-minchan@kernel.org>
 <20190528151407.GE1658@dhcp22.suse.cz>
 <20190530024229.GF229459@google.com>
 <20190604122806.GH4669@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190604122806.GH4669@dhcp22.suse.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 04, 2019 at 02:28:06PM +0200, Michal Hocko wrote:
> On Thu 30-05-19 11:42:29, Minchan Kim wrote:
> > On Tue, May 28, 2019 at 05:14:07PM +0200, Michal Hocko wrote:
> > > [Cc Pankaj Suryawanshi who has reported a similar problem
> > > http://lkml.kernel.org/r/SG2PR02MB309806967AE91179CAFEC34BE84B0@SG2PR02MB3098.apcprd02.prod.outlook.com]
> > > 
> > > On Fri 24-05-19 16:11:14, Minchan Kim wrote:
> > > > There was below bugreport from Wu Fangsuo.
> > > > 
> > > > 7200 [  680.491097] c4 7125 (syz-executor) page:ffffffbf02f33b40 count:86 mapcount:84 mapping:ffffffc08fa7a810 index:0x24
> > > > 7201 [  680.531186] c4 7125 (syz-executor) flags: 0x19040c(referenced|uptodate|arch_1|mappedtodisk|unevictable|mlocked)
> > > > 7202 [  680.544987] c0 7125 (syz-executor) raw: 000000000019040c ffffffc08fa7a810 0000000000000024 0000005600000053
> > > > 7203 [  680.556162] c0 7125 (syz-executor) raw: ffffffc009b05b20 ffffffc009b05b20 0000000000000000 ffffffc09bf3ee80
> > > > 7204 [  680.566860] c0 7125 (syz-executor) page dumped because: VM_BUG_ON_PAGE(PageLRU(page) || PageUnevictable(page))
> > > > 7205 [  680.578038] c0 7125 (syz-executor) page->mem_cgroup:ffffffc09bf3ee80
> > > > 7206 [  680.585467] c0 7125 (syz-executor) ------------[ cut here ]------------
> > > > 7207 [  680.592466] c0 7125 (syz-executor) kernel BUG at /home/build/farmland/adroid9.0/kernel/linux/mm/vmscan.c:1350!
> > > > 7223 [  680.603663] c0 7125 (syz-executor) Internal error: Oops - BUG: 0 [#1] PREEMPT SMP
> > > > 7224 [  680.611436] c0 7125 (syz-executor) Modules linked in:
> > > > 7225 [  680.616769] c0 7125 (syz-executor) CPU: 0 PID: 7125 Comm: syz-executor Tainted: G S              4.14.81 #3
> > > > 7226 [  680.626826] c0 7125 (syz-executor) Hardware name: ASR AQUILAC EVB (DT)
> > > > 7227 [  680.633623] c0 7125 (syz-executor) task: ffffffc00a54cd00 task.stack: ffffffc009b00000
> > > > 7228 [  680.641917] c0 7125 (syz-executor) PC is at shrink_page_list+0x1998/0x3240
> > > > 7229 [  680.649144] c0 7125 (syz-executor) LR is at shrink_page_list+0x1998/0x3240
> > > > 7230 [  680.656303] c0 7125 (syz-executor) pc : [<ffffff90083a2158>] lr : [<ffffff90083a2158>] pstate: 60400045
> > > > 7231 [  680.666086] c0 7125 (syz-executor) sp : ffffffc009b05940
> > > > ..
> > > > 7342 [  681.671308] c0 7125 (syz-executor) [<ffffff90083a2158>] shrink_page_list+0x1998/0x3240
> > > > 7343 [  681.679567] c0 7125 (syz-executor) [<ffffff90083a3dc0>] reclaim_clean_pages_from_list+0x3c0/0x4f0
> > > > 7344 [  681.688793] c0 7125 (syz-executor) [<ffffff900837ed64>] alloc_contig_range+0x3bc/0x650
> > > > 7347 [  681.717421] c0 7125 (syz-executor) [<ffffff90084925cc>] cma_alloc+0x214/0x668
> > > > 7348 [  681.724892] c0 7125 (syz-executor) [<ffffff90091e4d78>] ion_cma_allocate+0x98/0x1d8
> > > > 7349 [  681.732872] c0 7125 (syz-executor) [<ffffff90091e0b20>] ion_alloc+0x200/0x7e0
> > > > 7350 [  681.740302] c0 7125 (syz-executor) [<ffffff90091e154c>] ion_ioctl+0x18c/0x378
> > > > 7351 [  681.747738] c0 7125 (syz-executor) [<ffffff90084c6824>] do_vfs_ioctl+0x17c/0x1780
> > > > 7352 [  681.755514] c0 7125 (syz-executor) [<ffffff90084c7ed4>] SyS_ioctl+0xac/0xc0
> > > > 
> > > > Wu found it's due to [1]. Before that, unevictable page goes to cull_mlocked
> > > > routine so that it couldn't reach the VM_BUG_ON_PAGE line.
> > > > 
> > > > To fix the issue, this patch filter out unevictable LRU pages
> > > > from the reclaim_clean_pages_from_list in CMA.
> > > 
> > > The changelog is rather modest on details and I have to confess I have
> > > little bit hard time to understand it. E.g. why do not we need to handle
> > > the regular reclaim path?
> > 
> > No need to pass unevictable pages into regular reclaim patch if we are
> > able to know in advance.
> 
> I am sorry to be dense here. So what is the difference in the CMA path?
> Am I right that the pfn walk (CMA) rather than LRU isolation (reclaim)
> is the key differentiator?

Yes.
We could isolate unevictable LRU pages from the pfn waker to migrate and
could discard clean file-backed pages to reduce migration latency in CMA
path.

