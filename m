Return-Path: <SRS0=7x1k=SF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 704BBC10F06
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 11:00:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3BF2A20882
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 11:00:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726890AbfDCLA5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Apr 2019 07:00:57 -0400
Received: from foss.arm.com ([217.140.101.70]:37916 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725935AbfDCLA4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Apr 2019 07:00:56 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2055780D;
        Wed,  3 Apr 2019 04:00:56 -0700 (PDT)
Received: from arrakis.emea.arm.com (arrakis.cambridge.arm.com [10.1.196.78])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 76EA73F59C;
        Wed,  3 Apr 2019 04:00:54 -0700 (PDT)
Date:   Wed, 3 Apr 2019 12:00:51 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Pavel Machek <pavel@ucw.cz>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        James Morse <james.morse@arm.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Will Deacon <will.deacon@arm.com>,
        Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 4.4 078/131] PM / Hibernate: Call flush_icache_range() on
 pages restored in-place
Message-ID: <20190403110051.GB34351@arrakis.emea.arm.com>
References: <20190401170051.645954551@linuxfoundation.org>
 <20190401170058.681712612@linuxfoundation.org>
 <20190401203918.GA26671@amd>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190401203918.GA26671@amd>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 01, 2019 at 10:39:18PM +0200, Pavel Machek wrote:
> On Mon 2019-04-01 19:02:28, Greg Kroah-Hartman wrote:
> > 4.4-stable review patch.  If anyone has any objections, please let me know.
> > 
> > ------------------
> > 
> > [ Upstream commit f6cf0545ec697ddc278b7457b7d0c0d86a2ea88e ]
> > 
> > Some architectures require code written to memory as if it were data to be
> > 'cleaned' from any data caches before the processor can fetch them as new
> > instructions.
> > 
> > During resume from hibernate, the snapshot code copies some pages directly,
> > meaning these architectures do not get a chance to perform their cache
> > maintenance. Modify the read and decompress code to call
> > flush_icache_range() on all pages that are restored, so that the restored
> > in-place pages are guaranteed to be executable on these architectures.
> > 
> > Signed-off-by: James Morse <james.morse@arm.com>
> > Acked-by: Pavel Machek <pavel@ucw.cz>
> > Acked-by: Rafael J. Wysocki <rjw@rjwysocki.net>
> > Acked-by: Catalin Marinas <catalin.marinas@arm.com>
> > [will: make clean_pages_on_* static and remove initialisers]
> > Signed-off-by: Will Deacon <will.deacon@arm.com>
> > Signed-off-by: Sasha Levin <sashal@kernel.org>
> 
> I don't think this is suitable for stable.
> 
> Catalin: Are there platforms that a) need this and b) support
> hibernation in 4.4.X?

Good point. This commit was required for the arm64 hibernate support
that went in the 4.7 kernel.

Greg, why was this patch selected for stable? It's harmless anyway.

Thanks.

-- 
Catalin

