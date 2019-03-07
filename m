Return-Path: <SRS0=uyI7=RK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C4DCC43381
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 09:31:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5B03220840
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 09:31:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726309AbfCGJb1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Mar 2019 04:31:27 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:42846 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726102AbfCGJb0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Mar 2019 04:31:26 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2B33BEBD;
        Thu,  7 Mar 2019 01:31:26 -0800 (PST)
Received: from queper01-lin (queper01-lin.cambridge.arm.com [10.1.195.48])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 394E93F706;
        Thu,  7 Mar 2019 01:31:24 -0800 (PST)
Date:   Thu, 7 Mar 2019 09:31:19 +0000
From:   Quentin Perret <quentin.perret@arm.com>
To:     Juri Lelli <juri.lelli@gmail.com>
Cc:     Lingutla Chandrasekhar <clingutla@codeaurora.org>,
        sudeep.holla@arm.com, dietmar.eggemann@arm.com,
        gregkh@linuxfoundation.org, will.deacon@arm.com,
        catalin.marinas@arm.com, morten.rasmussen@arm.com,
        linux-arm-kernel@lists.infradead.org, jeremy.linton@arm.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] arch_topology: Make cpu_capacity sysfs node as
 ready-only
Message-ID: <20190307093116.slvugyeos46kl3et@queper01-lin>
References: <20190306152254.GB19434@e105550-lin.cambridge.arm.com>
 <1551886073-16217-1-git-send-email-clingutla@codeaurora.org>
 <20190307072856.GC29753@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190307072856.GC29753@localhost.localdomain>
User-Agent: NeoMutt/20171215
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Juri,

On Thursday 07 Mar 2019 at 08:28:56 (+0100), Juri Lelli wrote:
> There are cases in which this needs to be RW, as recently discussed
> https://lore.kernel.org/lkml/20181123135807.GA14964@e107155-lin/

Yeah there's that problem when you can't fix your DT ... But I guess
this is a problem for _all_ values in the DT, not just capacities right ?
But these other values, I'd expected they just can't be fixed from
userspace most of the time, you just have to live with sub-optimal
values. So I don't find it unreasonable to do that for capacities too.

> IMHO, if the core_sibling assumption doesn't work in all cases, one
> should be looking into fixing it, rather than making this RO.

It's just that this thing keeps causing more harm than it helps IMO.
It's quite severely broken ATM, and it prevents us from assuming
'stable' capacity values in places were we'd like to do so (e.g. EAS).

And I'm not aware of a single platform where this is used. So, I'm
personally all for removing the write capability if we can.

Thanks,
Quentin
