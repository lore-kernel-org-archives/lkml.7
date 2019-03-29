Return-Path: <SRS0=SA5R=SA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0883C10F06
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 02:22:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BABB52173C
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 02:22:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728631AbfC2CWW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Mar 2019 22:22:22 -0400
Received: from mx1.redhat.com ([209.132.183.28]:38706 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728022AbfC2CWV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Mar 2019 22:22:21 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 62D5F307D85E;
        Fri, 29 Mar 2019 02:22:21 +0000 (UTC)
Received: from redhat.com (ovpn-121-118.rdu2.redhat.com [10.10.121.118])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 599DD6E40B;
        Fri, 29 Mar 2019 02:22:20 +0000 (UTC)
Date:   Thu, 28 Mar 2019 22:22:18 -0400
From:   Jerome Glisse <jglisse@redhat.com>
To:     John Hubbard <jhubbard@nvidia.com>
Cc:     Ira Weiny <ira.weiny@intel.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Dan Williams <dan.j.williams@intel.com>
Subject: Re: [PATCH v2 02/11] mm/hmm: use reference counting for HMM struct v2
Message-ID: <20190329022217.GI16680@redhat.com>
References: <20190328110719.GA31324@iweiny-DESK2.sc.intel.com>
 <20190328191122.GA5740@redhat.com>
 <c8fd897f-b9d3-a77b-9898-78e20221ba44@nvidia.com>
 <20190328212145.GA13560@redhat.com>
 <fcb7be01-38c1-ed1f-70a0-d03dc9260473@nvidia.com>
 <20190328165708.GH31324@iweiny-DESK2.sc.intel.com>
 <20190329010059.GB16680@redhat.com>
 <55dd8607-c91b-12ab-e6d7-adfe6d9cb5e2@nvidia.com>
 <20190329015003.GE16680@redhat.com>
 <cc587c80-34ea-8d08-533d-0dc0c2fb079f@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cc587c80-34ea-8d08-533d-0dc0c2fb079f@nvidia.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.48]); Fri, 29 Mar 2019 02:22:21 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 28, 2019 at 07:11:17PM -0700, John Hubbard wrote:
> On 3/28/19 6:50 PM, Jerome Glisse wrote:
> [...]
> >>>
> >>> The hmm_put() is just releasing the reference on the hmm struct.
> >>>
> >>> Here i feel i am getting contradicting requirement from different people.
> >>> I don't think there is a way to please everyone here.
> >>>
> >>
> >> That's not a true conflict: you're comparing your actual implementation
> >> to Ira's request, rather than comparing my request to Ira's request.
> >>
> >> I think there's a way forward. Ira and I are actually both asking for the
> >> same thing:
> >>
> >> a) clear, concise get/put routines
> >>
> >> b) avoiding odd side effects in functions that have one name, but do
> >> additional surprising things.
> > 
> > Please show me code because i do not see any other way to do it then
> > how i did.
> > 
> 
> Sure, I'll take a run at it. I've driven you crazy enough with the naming 
> today, it's time to back it up with actual code. :)

Note that every single line in mm_get_hmm() do matter.

> I hope this is not one of those "we must also change Nouveau in N+M steps" 
> situations, though. I'm starting to despair about reviewing code that
> basically can't be changed...

It can be change but i rather not do too many in one go, each change is
like a tango with one partner and having tango with multiple partner at
once is painful much more likely to step on each other foot.

Cheers,
Jérôme
