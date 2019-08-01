Return-Path: <SRS0=wo+8=V5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8BACC19759
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 13:17:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C4D7E206B8
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 13:17:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729602AbfHANRL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Aug 2019 09:17:11 -0400
Received: from foss.arm.com ([217.140.110.172]:36014 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728592AbfHANRL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Aug 2019 09:17:11 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B6475337;
        Thu,  1 Aug 2019 06:17:10 -0700 (PDT)
Received: from e107158-lin.cambridge.arm.com (unknown [10.1.194.52])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2B6F93F575;
        Thu,  1 Aug 2019 06:17:10 -0700 (PDT)
Date:   Thu, 1 Aug 2019 14:17:07 +0100
From:   Qais Yousef <qais.yousef@arm.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     mingo@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/5] Fix FIFO-99 abuse
Message-ID: <20190801131707.5rpyydznnhz474la@e107158-lin.cambridge.arm.com>
References: <20190801111348.530242235@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190801111348.530242235@infradead.org>
User-Agent: NeoMutt/20171215
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/01/19 13:13, Peter Zijlstra wrote:
> I noticed a bunch of kthreads defaulted to FIFO-99, fix them.
> 
> The generic default is FIFO-50, the admin will have to configure the system
> anyway.
> 
> For some the purpose is to be above OTHER and then FIFO-1 really is sufficient.

I was looking in this area too and was thinking of a way to consolidate the
creation of RT/DL tasks in the kernel and the way we set the priority.

Does it make sense to create a new header for RT priorities for kthreads
created in the kernel so that we can easily track and rationale about the
relative priorities of in-kernel RT tasks?

When working in the FW world such a header helped a lot in understanding what
runs at each priority level and how to reason about what priority level makes
sense for a new item. It could be a nice single point of reference; even for
admins.

Cheers

--
Qais Yousef
