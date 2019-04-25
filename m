Return-Path: <SRS0=Q+aa=S3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C3A9C43219
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 14:35:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0C65D2067D
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 14:35:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726861AbfDYOfL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Apr 2019 10:35:11 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58102 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726020AbfDYOfL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Apr 2019 10:35:11 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 051D8307EA92;
        Thu, 25 Apr 2019 14:35:11 +0000 (UTC)
Received: from pauld.bos.csb (dhcp-17-51.bos.redhat.com [10.18.17.51])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id E150F600C0;
        Thu, 25 Apr 2019 14:35:08 +0000 (UTC)
Date:   Thu, 25 Apr 2019 10:35:07 -0400
From:   Phil Auld <pauld@redhat.com>
To:     Vineeth Remanan Pillai <vpillai@digitalocean.com>
Cc:     Tim Chen <tim.c.chen@linux.intel.com>,
        Nishanth Aravamudan <naravamudan@digitalocean.com>,
        Julien Desfossez <jdesfossez@digitalocean.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Aubrey Li <aubrey.intel@gmail.com>, mingo@kernel.org,
        tglx@linutronix.de, pjt@google.com, torvalds@linux-foundation.org,
        linux-kernel@vger.kernel.org, subhra.mazumdar@oracle.com,
        fweisbec@gmail.com, keescook@chromium.org, kerrnel@google.com,
        Aaron Lu <aaron.lwe@gmail.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [RFC PATCH v2 11/17] sched: Basic tracking of matching tasks
Message-ID: <20190425143506.GB979@pauld.bos.csb>
References: <54772e18-2f70-34cc-29ef-b9291f4846e2@linux.intel.com>
 <20190424204337.22283-1-vpillai@digitalocean.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190424204337.22283-1-vpillai@digitalocean.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.44]); Thu, 25 Apr 2019 14:35:11 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 24, 2019 at 08:43:36PM +0000 Vineeth Remanan Pillai wrote:
> > A minor nitpick.  I find keeping the vruntime base readjustment in
> > core_prio_less probably is more straight forward rather than pass a
> > core_cmp bool around.
> 
> The reason I moved the vruntime base adjustment to __prio_less is
> because, the vruntime seemed alien to __prio_less when looked as
> a standalone function.
> 
> I do not have a strong opinion on both. Probably a better approach
> would be to replace both cpu_prio_less/core_prio_less with prio_less
> which takes the third arguement 'bool on_same_rq'?
> 

Fwiw, I find the two names easier to read than a boolean flag. Could still
be wrapped to a single implementation I suppose. 

An enum to control cpu or core would be more readable, but probably overkill... 


Cheers,
Phil


> Thanks

-- 
