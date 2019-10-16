Return-Path: <SRS0=S2At=YJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 554A2FA372B
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 10:27:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 34ED020650
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 10:27:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392429AbfJPK1q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Oct 2019 06:27:46 -0400
Received: from mx1.redhat.com ([209.132.183.28]:38564 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727451AbfJPK1p (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Wed, 16 Oct 2019 06:27:45 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 595AD3001571;
        Wed, 16 Oct 2019 10:27:45 +0000 (UTC)
Received: from krava (unknown [10.43.17.61])
        by smtp.corp.redhat.com (Postfix) with SMTP id 626E560127;
        Wed, 16 Oct 2019 10:27:43 +0000 (UTC)
Date:   Wed, 16 Oct 2019 12:27:42 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     "Jin, Yao" <yao.jin@linux.intel.com>
Cc:     acme@kernel.org, jolsa@kernel.org, peterz@infradead.org,
        mingo@redhat.com, alexander.shishkin@linux.intel.com,
        Linux-kernel@vger.kernel.org, ak@linux.intel.com,
        kan.liang@intel.com, yao.jin@intel.com
Subject: Re: [PATCH] perf list: Hide deprecated events by default
Message-ID: <20191016102742.GA30251@krava>
References: <20191015025357.8708-1-yao.jin@linux.intel.com>
 <20191015091401.GE10951@krava>
 <627305a7-3aec-037a-1c36-6ca884f35d1d@linux.intel.com>
 <20191016072741.GA15031@krava>
 <2a1d1883-ca28-2dae-4ae3-fbae81174d55@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2a1d1883-ca28-2dae-4ae3-fbae81174d55@linux.intel.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.46]); Wed, 16 Oct 2019 10:27:45 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 16, 2019 at 06:22:06PM +0800, Jin, Yao wrote:
> 
> 
> On 10/16/2019 3:27 PM, Jiri Olsa wrote:
> > On Wed, Oct 16, 2019 at 08:59:13AM +0800, Jin, Yao wrote:
> > > 
> > > 
> > > On 10/15/2019 5:14 PM, Jiri Olsa wrote:
> > > > On Tue, Oct 15, 2019 at 10:53:57AM +0800, Jin Yao wrote:
> > > > > There are some deprecated events listed by perf list. But we can't remove
> > > > > them from perf list with ease because some old scripts may use them.
> > > > > 
> > > > > Deprecated events are old names of renamed events.  When an event gets
> > > > > renamed the old name is kept around for some time and marked with
> > > > > Deprecated. The newer Intel event lists in the tree already have these
> > > > > headers.
> > > > > 
> > > > > So we need to keep them in the event list, but provide a new option to
> > > > > show them. The new option is "--deprecated".
> > > > > 
> > > > > With this patch, the deprecated events are hidden by default but they can
> > > > > be displayed when option "--deprecated" is enabled.
> > > > 
> > > > not sure it's wise to hide them, because people will not read man page
> > > > to find --deprecated option, they will rather complain right away ;-)
> > > > 
> > > > how about to display them as another topic, like:
> > > > 
> > > > pipeline:
> > > > 	...
> > > > uncore:
> > > > 	...
> > > > deprecated:
> > > > 	...
> > > > 
> > > > jirka
> > > > 
> > > 
> > > Hi Jiri,
> > > 
> > > I don't know if we add a new topic "deprecated" in perf list output, does
> > > the old script need to be modified as well?
> > > 
> > > Say the events are moved to the "deprecated" section, I just guess the
> > > script needs the modification.
> > > 
> > > That's just my personal guess. :)
> > 
> > i did not mean adding new topic all the way down,
> > just to display the deprecated events like that
> > 
> > jirka
> > 
> 
> Sorry, maybe I misunderstood what you suggested. Correct me if my
> understanding is wrong.
> 
> Now the perf list output is like:
> 
> pipeline:
>   event1
>   event2
> uncore:
>   event3
>   event4
> 
> My understanding for your suggestion is, we need to add "deprecated", for
> example:
> 
> pipeline:
>   event1
>   event2
> uncore:
>   event4
> deprecated:
>   event3
> 
> In above example, I assume the event3 is deprecated.
> 
> So my worry is, the user's old script may not find the event3 if we move it
> from "uncore" to "deprecated". Maybe I'm worried a lot. :(

well, your patch removes it unless you specify --deprecated
option of course

perhaps we could do

deprecated:
uncore:
  event3

jirka
