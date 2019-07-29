Return-Path: <SRS0=K9bG=V2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCEADC76186
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 21:33:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E7C1206DD
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 21:33:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730162AbfG2Vdp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jul 2019 17:33:45 -0400
Received: from foss.arm.com ([217.140.110.172]:52652 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729545AbfG2Vdp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jul 2019 17:33:45 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CD299337;
        Mon, 29 Jul 2019 14:33:44 -0700 (PDT)
Received: from e107158-lin.cambridge.arm.com (e107158-lin.cambridge.arm.com [10.1.194.55])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C95423F71F;
        Mon, 29 Jul 2019 14:33:43 -0700 (PDT)
Date:   Mon, 29 Jul 2019 22:33:41 +0100
From:   Qais Yousef <qais.yousef@arm.com>
To:     Waiman Long <longman@redhat.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        Phil Auld <pauld@redhat.com>
Subject: Re: [PATCH v2] sched/core: Don't use dying mm as active_mm of
 kthreads
Message-ID: <20190729213341.pacbqtcsdfmkdbsr@e107158-lin.cambridge.arm.com>
References: <20190727171047.31610-1-longman@redhat.com>
 <20190729081800.qbamrvsf4rjna656@e107158-lin.cambridge.arm.com>
 <be28b3d2-3f94-806b-874d-db2248a2c3a9@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <be28b3d2-3f94-806b-874d-db2248a2c3a9@redhat.com>
User-Agent: NeoMutt/20171215
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/29/19 17:06, Waiman Long wrote:
> On 7/29/19 4:18 AM, Qais Yousef wrote:
> > On 07/27/19 13:10, Waiman Long wrote:
> >> It was found that a dying mm_struct where the owning task has exited
> >> can stay on as active_mm of kernel threads as long as no other user
> >> tasks run on those CPUs that use it as active_mm. This prolongs the
> >> life time of dying mm holding up memory and other resources like swap
> >> space that cannot be freed.
> >>
> >> Fix that by forcing the kernel threads to use init_mm as the active_mm
> >> if the previous active_mm is dying.
> >>
> >> The determination of a dying mm is based on the absence of an owning
> >> task. The selection of the owning task only happens with the CONFIG_MEMCG
> >> option. Without that, there is no simple way to determine the life span
> >> of a given mm. So it falls back to the old behavior.
> > I don't really know a lot about this code, but does the owner field has to
> > depend on CONFIG_MEMCG? ie: can't the owner be always set?
> >
> Yes, the owner field is only used and defined when CONFIG_MEMCG is on.

I guess this is the simpler answer of it's too much work to take it out of
CONFIG_MEMCG.

Anyway, given the direction of the thread this is moot now :-)

Thanks!

--
Qais Yousef
