Return-Path: <SRS0=/s9R=UY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CCC5C48BD5
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 08:50:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 093B3215EA
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 08:50:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730832AbfFYIu4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Jun 2019 04:50:56 -0400
Received: from mx1.redhat.com ([209.132.183.28]:56572 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727770AbfFYIu4 (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Tue, 25 Jun 2019 04:50:56 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 3E8327FDFD;
        Tue, 25 Jun 2019 08:50:56 +0000 (UTC)
Received: from krava (unknown [10.43.17.81])
        by smtp.corp.redhat.com (Postfix) with SMTP id 45ED419723;
        Tue, 25 Jun 2019 08:50:52 +0000 (UTC)
Date:   Tue, 25 Jun 2019 10:50:52 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     "Jin, Yao" <yao.jin@linux.intel.com>
Cc:     acme@kernel.org, jolsa@kernel.org, peterz@infradead.org,
        mingo@redhat.com, alexander.shishkin@linux.intel.com,
        Linux-kernel@vger.kernel.org, ak@linux.intel.com,
        kan.liang@intel.com, yao.jin@intel.com
Subject: Re: [PATCH v4 4/7] perf diff: Use hists to manage basic blocks per
 symbol
Message-ID: <20190625085052.GC9574@krava>
References: <1561041402-29444-1-git-send-email-yao.jin@linux.intel.com>
 <1561041402-29444-5-git-send-email-yao.jin@linux.intel.com>
 <20190624075718.GE5471@krava>
 <cdc87d42-8a5c-5b12-c746-896e3324cb35@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cdc87d42-8a5c-5b12-c746-896e3324cb35@linux.intel.com>
User-Agent: Mutt/1.12.0 (2019-05-25)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.27]); Tue, 25 Jun 2019 08:50:56 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 24, 2019 at 10:49:25PM +0800, Jin, Yao wrote:
> 
> 
> On 6/24/2019 3:57 PM, Jiri Olsa wrote:
> > On Thu, Jun 20, 2019 at 10:36:39PM +0800, Jin Yao wrote:
> > 
> > SNIP
> > 
> > > +
> > > +static void *block_entry_zalloc(size_t size)
> > > +{
> > > +	return zalloc(size + sizeof(struct hist_entry));
> > > +}
> > > +
> > > +static void block_entry_free(void *he)
> > > +{
> > > +	struct block_info *bi = ((struct hist_entry *)he)->block_info;
> > > +
> > > +	block_info__put(bi);
> > > +	free(he);
> > > +}
> > > +
> > > +struct hist_entry_ops block_entry_ops = {
> > > +	.new    = block_entry_zalloc,
> > > +	.free   = block_entry_free,
> > > +};
> > 
> > hum, so there's already block_hist_ops moving that stuff into 'struct block_hist',
> > which is great, but why don't we have 'struct block_entry' in here? that would
> > keep the 'struct block_info'
> > 
> > thanks,
> > jirka
> > 
> 
> Hi Jiri,
> 
> If I define 'struct block_entry' as following and cast 'he' to 'struct
> block_entry' in some places, such as in block_cmp(), we can get the 'struct
> block_entry'.
> 
> struct block_entry {
> 	struct block_info bi;
> 	struct hist_entry he;
> };
> 
> But I don't know when I can set the 'bi' of 'struct block_entry'. Before or
> after calling hists__add_entry_xxx()? Before calling hists__add_entry_xxx(),
> we don't know the hist_entry. After calling hists__add_entry_xxx(), actually
> the hist_entry__cmp doesn't work (no bi ).
> 
> That's why I create block_info in hist_entry. Maybe I misunderstand what
> your suggested, correct me if I'm wrong.

ah you need the data already in place when calling hists__add_entry_block,
because of the block_cmp sorting function.. ok, it's the same tyhing we
do in c2c with mem_info.. I guess we can survive one pointer

I'll check the rest

thanks,
jirka
