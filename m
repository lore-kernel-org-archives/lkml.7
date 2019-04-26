Return-Path: <SRS0=fl2C=S4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5FE2C43218
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 17:40:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5A42B206C1
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 17:40:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726400AbfDZRkX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Apr 2019 13:40:23 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47990 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726315AbfDZRkW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Apr 2019 13:40:22 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 41B59CA1F5;
        Fri, 26 Apr 2019 17:40:22 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.43.17.159])
        by smtp.corp.redhat.com (Postfix) with SMTP id EB69B60BF3;
        Fri, 26 Apr 2019 17:40:20 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Fri, 26 Apr 2019 19:40:21 +0200 (CEST)
Date:   Fri, 26 Apr 2019 19:40:19 +0200
From:   Oleg Nesterov <oleg@redhat.com>
To:     Roman Gushchin <guro@fb.com>
Cc:     Roman Gushchin <guroan@gmail.com>, Tejun Heo <tj@kernel.org>,
        Kernel Team <Kernel-team@fb.com>,
        "cgroups@vger.kernel.org" <cgroups@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v10 4/9] cgroup: cgroup v2 freezer
Message-ID: <20190426174019.GB24755@redhat.com>
References: <20190405174708.1010-1-guro@fb.com>
 <20190405174708.1010-5-guro@fb.com>
 <20190419151912.GA12152@redhat.com>
 <20190419161118.GA23357@tower.DHCP.thefacebook.com>
 <20190419162600.GC12228@redhat.com>
 <20190419165600.GC23357@tower.DHCP.thefacebook.com>
 <20190420105838.GA17468@redhat.com>
 <20190422221116.GA10341@tower.DHCP.thefacebook.com>
 <20190424154619.GG16167@redhat.com>
 <20190424220634.GA22896@tower.DHCP.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190424220634.GA22896@tower.DHCP.thefacebook.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.38]); Fri, 26 Apr 2019 17:40:22 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/24, Roman Gushchin wrote:
>
> On Wed, Apr 24, 2019 at 05:46:19PM +0200, Oleg Nesterov wrote:
> >
> > OK, how about the ABSOLUTELY UNTESTED patch below? For the start.
>
> It looks good to me (and all freezer selftests pass).
>
> Just to be sure, is it a solution to avoid the busy loop in the signal handling
> loop, right?

Yes,

> Because it doesn't allow to drop the ->frozen check from recalc().

Yes. Because we can race with unfreeze after leave_frozen().

> The JOBCTL_TRAP_FREEZE check without siglock initially looked dangerous to me,
> but after some thoughts I didn't find any case when it's wrong.

I think this is fine... Yes, JOBCTL_TRAP_FREEZE can be already set when we take
siglock, but I don't think we need to recheck this flag.

The only important thing (afaics) is that CGRP_FREEZE is stable under css_set_lock,
so we can't wrongly set TRAP_FREEZE.

> Do you prefer me to master a patch

Yes please ;)

Oleg.

