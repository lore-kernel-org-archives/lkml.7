Return-Path: <SRS0=8hmg=W5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04E3FC3A59E
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Sep 2019 17:46:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D006321897
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Sep 2019 17:46:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726651AbfIBRqf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Sep 2019 13:46:35 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47694 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725988AbfIBRqe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Sep 2019 13:46:34 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 5AF3F307D853;
        Mon,  2 Sep 2019 17:46:34 +0000 (UTC)
Received: from krava (ovpn-204-59.brq.redhat.com [10.40.204.59])
        by smtp.corp.redhat.com (Postfix) with SMTP id 2E2EC196AE;
        Mon,  2 Sep 2019 17:46:30 +0000 (UTC)
Date:   Mon, 2 Sep 2019 19:46:30 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Alexey Budankov <alexey.budankov@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Michael Petlan <mpetlan@redhat.com>,
        Joe Mario <jmario@redhat.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>
Subject: Re: [PATCH 3/3] perf stat: Add --per-numa agregation support
Message-ID: <20190902174630.GF19702@krava>
References: <20190902121255.536-1-jolsa@kernel.org>
 <20190902121255.536-4-jolsa@kernel.org>
 <bdf81661-4c70-797f-51f2-726f4458d812@linux.intel.com>
 <20190902154329.GE8396@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190902154329.GE8396@kernel.org>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.48]); Mon, 02 Sep 2019 17:46:34 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 02, 2019 at 12:43:29PM -0300, Arnaldo Carvalho de Melo wrote:
> Em Mon, Sep 02, 2019 at 06:13:17PM +0300, Alexey Budankov escreveu:
> > 
> > On 02.09.2019 15:12, Jiri Olsa wrote:
> > > Adding new --per-numa option to aggregate counts per NUMA
> > > nodes for system-wide mode measurements.
> > > 
> > > You can specify --per-numa in live mode:
> > > 
> > >   # perf stat  -a -I 1000 -e cycles --per-numa
> > >   #           time numa   cpus             counts unit events
> > 
> > It might probably better have 'node' instead of 'numa' as in the 
> > option name '--per-node' as in the table header, like this:
> 
> Agreed

ok, will change

jirka

> 
> > 
> >     #           time node     cpus             counts unit events
> >          1.000542550 0        20          6,202,097      cycles
> >          1.000542550 1        20            639,559      cycles
> >          2.002040063 0        20          7,412,495      cycles
> >          2.002040063 1        20          2,185,577      cycles
> >          3.003451699 0        20          6,508,917      cycles
> >          3.003451699 1        20            765,607      cycles
> >    ...
> > 
> > BR,
> > Alexey
> 
> -- 
> 
> - Arnaldo
