Return-Path: <SRS0=5y3R=YD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39525C4360C
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Oct 2019 08:00:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1B85A20B7C
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Oct 2019 08:00:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733132AbfJJIA4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Oct 2019 04:00:56 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44146 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732980AbfJJIAz (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Thu, 10 Oct 2019 04:00:55 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 18C0A60ACD;
        Thu, 10 Oct 2019 08:00:55 +0000 (UTC)
Received: from krava (unknown [10.40.205.67])
        by smtp.corp.redhat.com (Postfix) with SMTP id 1B1B35DA8D;
        Thu, 10 Oct 2019 08:00:52 +0000 (UTC)
Date:   Thu, 10 Oct 2019 10:00:52 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     "Jin, Yao" <yao.jin@linux.intel.com>
Cc:     Andi Kleen <ak@linux.intel.com>,
        Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
        jolsa@kernel.org, peterz@infradead.org, mingo@redhat.com,
        alexander.shishkin@linux.intel.com, Linux-kernel@vger.kernel.org,
        kan.liang@intel.com, yao.jin@intel.com
Subject: Re: [PATCH v1 0/2] perf stat: Support --all-kernel and --all-user
Message-ID: <20191010080052.GB9616@krava>
References: <20190925020218.8288-1-yao.jin@linux.intel.com>
 <20190929151022.GA16309@krava>
 <20190930182136.GD8560@tassilo.jf.intel.com>
 <20190930192800.GA13904@kernel.org>
 <20191001021755.GF8560@tassilo.jf.intel.com>
 <8a1cbcf6-2de7-3036-1c86-f3af6af077e2@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8a1cbcf6-2de7-3036-1c86-f3af6af077e2@linux.intel.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.30]); Thu, 10 Oct 2019 08:00:55 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 10, 2019 at 02:46:36PM +0800, Jin, Yao wrote:
> 
> 
> On 10/1/2019 10:17 AM, Andi Kleen wrote:
> > > > I think it's useful. Makes it easy to do kernel/user break downs.
> > > > perf record should support the same.
> > > 
> > > Don't we have this already with:
> > > 
> > > [root@quaco ~]# perf stat -e cycles:u,instructions:u,cycles:k,instructions:k -a -- sleep 1
> > 
> > This only works for simple cases. Try it for --topdown or multiple -M metrics.
> > 
> > -Andi
> > 
> 
> Hi Arnaldo, Jiri,
> 
> We think it should be very useful if --all-user / --all-kernel can be
> specified together, so that we can get a break down between user and kernel
> easily.
> 
> But yes, the patches for supporting this new semantics is much complicated
> than the patch which just follows original perf-record behavior. I fully
> understand this concern.
> 
> So if this new semantics can be accepted, that would be very good. But if
> you think the new semantics is too complicated, I'm also fine for posting a
> new patch which just follows the perf-record behavior.

I still need to think a bit more about this.. did you consider
other options like cloning of the perf_evlist/perf_evsel and
changing just the exclude* bits? might be event worse actualy ;-)

or maybe if we add modifier we could add extra events/groups
within the parser.. like:

  "{cycles,instructions}:A,{cache-misses,cache-references}:A,cycles:A"

but that might be still more complicated then what you did

also please add the perf record changes so we have same code
and logic for both if we are going to change it

jirka
