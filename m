Return-Path: <SRS0=FxTY=RO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A017C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 20:48:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2E4DF2064A
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 20:48:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728149AbfCKUs6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 16:48:58 -0400
Received: from mga02.intel.com ([134.134.136.20]:23401 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727883AbfCKUs5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 16:48:57 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 11 Mar 2019 13:48:56 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,468,1544515200"; 
   d="scan'208";a="306308229"
Received: from tassilo.jf.intel.com (HELO tassilo.localdomain) ([10.7.201.137])
  by orsmga005.jf.intel.com with ESMTP; 11 Mar 2019 13:48:56 -0700
Received: by tassilo.localdomain (Postfix, from userid 1000)
        id 7E6BA301E30; Mon, 11 Mar 2019 13:48:56 -0700 (PDT)
Date:   Mon, 11 Mar 2019 13:48:56 -0700
From:   Andi Kleen <ak@linux.intel.com>
To:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
Cc:     Andi Kleen <andi@firstfloor.org>, jolsa@kernel.org,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 06/10] perf, tools, report: Print better message for
 JITed code
Message-ID: <20190311204856.GD29294@tassilo.jf.intel.com>
References: <20190311202446.10210-1-andi@firstfloor.org>
 <20190311202446.10210-7-andi@firstfloor.org>
 <20190311203302.GB10690@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190311203302.GB10690@kernel.org>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 11, 2019 at 05:33:02PM -0300, Arnaldo Carvalho de Melo wrote:
> Em Mon, Mar 11, 2019 at 01:24:42PM -0700, Andi Kleen escreveu:
> > From: Andi Kleen <ak@linux.intel.com>
> > 
> > The message about missing /tmp/perf-* for JITed code is quite confusing
> > to users. Add a better error message, but only print it once.
> > 
> > Signed-off-by: Andi Kleen <ak@linux.intel.com>
> > ---
> >  tools/perf/util/map.c | 9 +++++++++
> >  1 file changed, 9 insertions(+)
> > 
> > diff --git a/tools/perf/util/map.c b/tools/perf/util/map.c
> > index fbeb0c6efaa6..d476b76abc6a 100644
> > --- a/tools/perf/util/map.c
> > +++ b/tools/perf/util/map.c
> > @@ -316,6 +316,15 @@ int map__load(struct map *map)
> >  
> >  	nr = dso__load(map->dso, map);
> >  	if (nr < 0) {
> > +		if (!strncmp(map->dso->name, "/tmp/perf-", 10)) {
> > +			static bool warned;
> > +			if (!warned) {
> > +				pr_err("Cannot find executable, JITed code present? May need agent.\n");
> > +				warned = true;
> > +			}
> 
> Please use WARN_ON_ONCE(), we have it in tools/include/asm/bug.h, just
> like the kernel.

But that prints "assertation failed". This is not a perf bug, but can happen
in normal operation.

-Andi
