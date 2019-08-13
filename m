Return-Path: <SRS0=Ecng=WJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF0B8C32750
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Aug 2019 12:14:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F96620840
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Aug 2019 12:14:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727777AbfHMMOV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Aug 2019 08:14:21 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52794 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726600AbfHMMOV (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Tue, 13 Aug 2019 08:14:21 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 23C183064FD2;
        Tue, 13 Aug 2019 12:14:21 +0000 (UTC)
Received: from krava (unknown [10.43.17.33])
        by smtp.corp.redhat.com (Postfix) with SMTP id 1F4316A75E;
        Tue, 13 Aug 2019 12:14:18 +0000 (UTC)
Date:   Tue, 13 Aug 2019 14:14:18 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     "Jin, Yao" <yao.jin@linux.intel.com>
Cc:     acme@kernel.org, jolsa@kernel.org, peterz@infradead.org,
        mingo@redhat.com, alexander.shishkin@linux.intel.com,
        Linux-kernel@vger.kernel.org, ak@linux.intel.com,
        kan.liang@intel.com, yao.jin@intel.com
Subject: Re: [PATCH v3] perf diff: Report noisy for cycles diff
Message-ID: <20190813121418.GA9349@krava>
References: <20190809233029.12265-1-yao.jin@linux.intel.com>
 <20190812083555.GC11752@krava>
 <0e1a0f70-5089-7524-c53b-2762fc174a20@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0e1a0f70-5089-7524-c53b-2762fc174a20@linux.intel.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.45]); Tue, 13 Aug 2019 12:14:21 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 13, 2019 at 12:13:26PM +0800, Jin, Yao wrote:
> 
> 
> On 8/12/2019 4:35 PM, Jiri Olsa wrote:
> > On Sat, Aug 10, 2019 at 07:30:29AM +0800, Jin Yao wrote:
> > 
> > SNIP
> > 
> > > +		if (vals[i] != 0)
> > > +			return 0;
> > > +	return 1;
> > > +}
> > > +
> > > +static int print_cycles_spark(char *bf, int size, unsigned long *svals, u64 n)
> > > +{
> > > +	int len = n, printed;
> > > +
> > > +	if (len <= 1)
> > > +		return 0;
> > > +
> > > +	if (len > NUM_SPARKS)
> > > +		len = NUM_SPARKS;
> > > +	if (all_zero(svals, len))
> > > +		return 0;
> > > +
> > > +	printed = print_spark(bf, size, svals, len);
> > > +	printed += scnprintf(bf + printed, size - printed, " ");
> > > +
> > > +	if (n > NUM_SPARKS)
> > > +		printed += scnprintf(bf + printed, size - printed, "..");
> > 
> > will this '..' ever be printed? I can't see that even if I enlarge
> > the column width..
> > 
> > jirka
> > 
> 
> @@ -83,6 +85,8 @@ struct hist_entry_diff {
>                 /* PERF_HPP_DIFF__CYCLES */
>                 s64     cycles;
>         };
> +       struct stats    stats;
> +       unsigned long   svals[NUM_SPARKS];
>  };
> 
> Now we only save 8 items in svals[] (NUM_PARKS = 8). So '..' will not be
> printed. The code of printing '..' is for future possible case.
> 
> If you think it's not necessary, I would remove this.

please remove it then

thanks,
jirka
