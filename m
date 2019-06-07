Return-Path: <SRS0=2dYc=UG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C4E1C2BCA1
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Jun 2019 13:34:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 00B81212F5
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Jun 2019 13:34:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728941AbfFGNeO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Jun 2019 09:34:14 -0400
Received: from foss.arm.com ([217.140.110.172]:40198 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728071AbfFGNeN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jun 2019 09:34:13 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 37614337;
        Fri,  7 Jun 2019 06:34:13 -0700 (PDT)
Received: from arrakis.emea.arm.com (arrakis.cambridge.arm.com [10.1.196.78])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 33D0D3F96A;
        Fri,  7 Jun 2019 06:34:12 -0700 (PDT)
Date:   Fri, 7 Jun 2019 14:34:10 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     Anshuman Khandual <anshuman.khandual@arm.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Will Deacon <will.deacon@arm.com>,
        James Morse <james.morse@arm.com>,
        Andrey Konovalov <andreyknvl@google.com>
Subject: Re: [PATCH V3 1/2] arm64/mm: Consolidate page fault information
 capture
Message-ID: <20190607133409.GJ16801@arrakis.emea.arm.com>
References: <1559898786-28530-1-git-send-email-anshuman.khandual@arm.com>
 <1559898786-28530-2-git-send-email-anshuman.khandual@arm.com>
 <20190607103045.GB15753@lakrids.cambridge.arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190607103045.GB15753@lakrids.cambridge.arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 07, 2019 at 11:30:46AM +0100, Mark Rutland wrote:
> On Fri, Jun 07, 2019 at 02:43:05PM +0530, Anshuman Khandual wrote:
> > This consolidates page fault information capture and move them bit earlier.
> > While here it also adds an wrapper is_write_abort(). It also saves some
> > cycles by replacing multiple user_mode() calls into a single one earlier
> > during the fault.
> > 
> > Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
> > Cc: Catalin Marinas <catalin.marinas@arm.com>
> > Cc: Will Deacon <will.deacon@arm.com>
> > Cc: Mark Rutland <mark.rutland@arm.com>
> > Cc: James Morse <james.morse@arm.com>
> > Cc: Andrey Konovalov <andreyknvl@google.com>
> > ---
> >  arch/arm64/mm/fault.c | 26 +++++++++++++++++++-------
> >  1 file changed, 19 insertions(+), 7 deletions(-)
> 
> As I mentioned previously, I doubt that this has any measureable impact
> on performance, and other than commenting the caveats w.r.t. cache
> maintenance, I'm not sure this makes things any clearer.
> 
> However, AFAICT it is correct, so I'll leave that to Catalin:

I only merged the is_write_abort() wrapper from this patch (changed the
commit log as well).

-- 
Catalin
