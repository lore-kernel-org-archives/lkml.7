Return-Path: <SRS0=FxTY=RO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3115C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 09:23:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8F4802084D
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 09:23:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552296239;
	bh=wqr0DOE2dYhynUpnvl/mAO5sUxj/gcT6HDi7o/HHhE0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=Zb+XppyRRtYO33X6+FJR1vTyT4K8MjK51b8WR3i57g9DYlALiy8gcQmPKQdrUNoRU
	 iQlIXcZlObb1omyReFOH9xyjcCj0jjPBJlkyEB5XTEaSLsUkiRw8FyGGBALOUw35Ac
	 rdfPf8MRk8uDI8WyHrOyCbUD8GDkz9dZAjXQ7gDo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727046AbfCKJX6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 05:23:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:57590 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726969AbfCKJX5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 05:23:57 -0400
Received: from devnote2 (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 80A9420657;
        Mon, 11 Mar 2019 09:23:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552296237;
        bh=wqr0DOE2dYhynUpnvl/mAO5sUxj/gcT6HDi7o/HHhE0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=101HA0ac8cpCxRGGIw/+RTdnBHGAItBe6ADytebtHiT1+ylhCDPzjwRZrnhIgcYWY
         X4r045lXjLfCl5m433gsIEjyjqzF+Kd+KOkXFHwhTObWJO3W9w4utNd5qjNWlnxWDX
         1R22PJEDPf7GwYuN+89fTEvjNYhqOODXKSGe3/ho=
Date:   Mon, 11 Mar 2019 18:23:51 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Joseph Qi <joseph.qi@linux.alibaba.com>,
        Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        luto@kernel.org, Jiufei Xue <jiufei.xue@linux.alibaba.com>,
        Xu Yu <xuyu@linux.alibaba.com>, peterz@infradead.org,
        mingo@redhat.com
Subject: Re: [PATCH] perf probe: Fix getting the kernel map
Message-Id: <20190311182351.3eb55d624bed0e7893af8862@kernel.org>
In-Reply-To: <20190308143926.GB19877@kernel.org>
References: <1a4240a8-288b-45d0-073d-d5cb8f0c63eb@linux.alibaba.com>
        <20190226090505.GA24409@kroah.com>
        <c7ccd9cb-3a66-98a9-faa1-7ee5ed20ff88@linux.alibaba.com>
        <20190226130802.GA10343@kroah.com>
        <20190226142009.GC26786@kernel.org>
        <3b233ff2-e87a-1c61-d516-6c4cdecb4f01@intel.com>
        <8e798942-0e71-c88f-866f-88e55177e286@linux.alibaba.com>
        <fea29ce5-b410-27cc-045e-feeecbc4a7f5@intel.com>
        <ab136937-2af8-d3bc-634a-17d06c42a5c7@linux.alibaba.com>
        <2ed432de-e904-85d2-5c36-5897ddc5b23b@intel.com>
        <20190308143926.GB19877@kernel.org>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 8 Mar 2019 11:39:26 -0300
Arnaldo Carvalho de Melo <acme@kernel.org> wrote:

> Em Mon, Mar 04, 2019 at 03:13:21PM +0200, Adrian Hunter escreveu:
> > Since commit 4d99e4136580 ("perf machine: Workaround missing maps for x86
> > PTI entry trampolines"), perf tools has been creating more than one kernel
> > map, however 'perf probe' assumed there could be only one.
> > 
> > Fix by using machine__kernel_map() to get the main kernel map.
> 
> Masami, can I get your Acked-by?

Yes, this looks good to me :)

Acked-by: Masami Hiramatsu <mhiramat@kernel.org>

Thank you Adrian!

> 
> - Arnaldo
>  
> > Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
> > Fixes: 4d99e4136580 ("perf machine: Workaround missing maps for x86 PTI entry trampolines")
> > Fixes: d83212d5dd67 ("kallsyms, x86: Export addresses of PTI entry trampolines")
> > Tested-by: Joseph Qi <joseph.qi@linux.alibaba.com>
> > Cc: stable@vger.kernel.org
> > ---
> >  tools/perf/util/probe-event.c | 6 ++++--
> >  1 file changed, 4 insertions(+), 2 deletions(-)
> > 
> > diff --git a/tools/perf/util/probe-event.c b/tools/perf/util/probe-event.c
> > index e86f8be89157..6cd96f9b346d 100644
> > --- a/tools/perf/util/probe-event.c
> > +++ b/tools/perf/util/probe-event.c
> > @@ -157,8 +157,10 @@ static struct map *kernel_get_module_map(const char *module)
> >  	if (module && strchr(module, '/'))
> >  		return dso__new_map(module);
> >  
> > -	if (!module)
> > -		module = "kernel";
> > +	if (!module) {
> > +		pos = machine__kernel_map(host_machine);
> > +		return map__get(pos);
> > +	}
> >  
> >  	for (pos = maps__first(maps); pos; pos = map__next(pos)) {
> >  		/* short_name is "[module]" */
> > -- 
> > 2.19.1
> 
> -- 
> 
> - Arnaldo


-- 
Masami Hiramatsu <mhiramat@kernel.org>
