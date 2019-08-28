Return-Path: <SRS0=kjqD=WY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E95FC3A5A1
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 14:09:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 215AE23407
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 14:09:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1567001382;
	bh=NbxD37/YZywxtJEqp4Mp+jtxWAYcea3eBo2cQaaKeG8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=qANatjNz3HwNsOkaFvCZyAeVBworM9vMHPZxXTuYmyMdlmM+CJqAkvx+c1UQEVvNM
	 x2OYjjw7hzQ8OvZzj+/HSQf8y5jDArWBuCO1cJO/VmDfdrp4DbC3dfUqA6BVemLqTU
	 CiFZc92SJcTDeiHuxJXTt/gPMe4hMylKUBFAKBug=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726719AbfH1OJl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Aug 2019 10:09:41 -0400
Received: from mx2.suse.de ([195.135.220.15]:42882 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726515AbfH1OJk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Aug 2019 10:09:40 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 50EFEAE92;
        Wed, 28 Aug 2019 14:09:39 +0000 (UTC)
Date:   Wed, 28 Aug 2019 16:09:38 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Waiman Long <longman@redhat.com>
Cc:     Dan Williams <dan.j.williams@gmail.com>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, Stephen Rothwell <sfr@canb.auug.org.au>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Toshiki Fukasawa <t-fukasawa@vx.jp.nec.com>
Subject: Re: [PATCH v2] fs/proc/page: Skip uninitialized page when iterating
 page structures
Message-ID: <20190828140938.GL28313@dhcp22.suse.cz>
References: <20190826124336.8742-1-longman@redhat.com>
 <20190827142238.GB10223@dhcp22.suse.cz>
 <20190828080006.GG7386@dhcp22.suse.cz>
 <8363a4ba-e26f-f88c-21fc-5dd1fe64f646@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8363a4ba-e26f-f88c-21fc-5dd1fe64f646@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 28-08-19 09:46:21, Waiman Long wrote:
> On 8/28/19 4:00 AM, Michal Hocko wrote:
> > On Tue 27-08-19 16:22:38, Michal Hocko wrote:
> >> Dan, isn't this something we have discussed recently?
> > This was http://lkml.kernel.org/r/20190725023100.31141-3-t-fukasawa@vx.jp.nec.com
> > and talked about /proc/kpageflags but this is essentially the same thing
> > AFAIU. I hope we get a consistent solution for both issues.
> >
> Yes, it is the same problem. The uninitialized page structure problem
> affects all the 3 /proc/kpage{cgroup,count,flags) files.
> 
> Toshiki's patch seems to fix it just for /proc/kpageflags, though.

Yup. I was arguing that whacking a mole kinda fix is far from good. Dan
had some arguments on why initializing those struct pages is a problem.
The discussion had a half open end though. I hoped that Dan would try
out the initialization side but I migh have misunderstood.
-- 
Michal Hocko
SUSE Labs
