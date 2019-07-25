Return-Path: <SRS0=6YJq=VW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5AE6C76191
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 16:28:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8F5CB217F4
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 16:28:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729260AbfGYQ2c (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jul 2019 12:28:32 -0400
Received: from foss.arm.com ([217.140.110.172]:60622 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726950AbfGYQ2c (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jul 2019 12:28:32 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4D9F9174E;
        Thu, 25 Jul 2019 09:28:31 -0700 (PDT)
Received: from arrakis.emea.arm.com (arrakis.cambridge.arm.com [10.1.196.78])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 158293F71A;
        Thu, 25 Jul 2019 09:28:29 -0700 (PDT)
Date:   Thu, 25 Jul 2019 17:28:28 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Julien Grall <julien.grall@arm.com>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        kvmarm@lists.cs.columbia.edu, james.morse@arm.com,
        marc.zyngier@arm.com, julien.thierry@arm.com,
        suzuki.poulose@arm.com, will.deacon@arm.com
Subject: Re: [PATCH v3 09/15] arm64/mm: Split the function
 check_and_switch_context in 3 parts
Message-ID: <20190725162827.GE4113@arrakis.emea.arm.com>
References: <20190724162534.7390-1-julien.grall@arm.com>
 <20190724162534.7390-10-julien.grall@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190724162534.7390-10-julien.grall@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 24, 2019 at 05:25:28PM +0100, Julien Grall wrote:
> The function check_and_switch_context is used to:
>     1) Check whether the ASID is still valid
>     2) Generate a new one if it is not valid
>     3) Switch the context
> 
> While the latter is specific to the MM subsystem, the rest could be part
> of the generic ASID allocator.
> 
> After this patch, the function is now split in 3 parts which corresponds
> to the use of the functions:
>     1) asid_check_context: Check if the ASID is still valid
>     2) asid_new_context: Generate a new ASID for the context
>     3) check_and_switch_context: Call 1) and 2) and switch the context
> 
> 1) and 2) have not been merged in a single function because we want to
> avoid to add a branch in when the ASID is still valid. This will matter
> when the code will be moved in separate file later on as 1) will reside
> in the header as a static inline function.
> 
> Signed-off-by: Julien Grall <julien.grall@arm.com>
> 
> ---
>     Will wants to avoid to add a branch when the ASID is still valid. So
>     1) and 2) are in separates function. The former will move to a new
>     header and make static inline.

Was this discussion logged somewhere, just to get the context?

I presume by "branch" you meant the function call to
asid_check_context(). Personally, I don't like the duplication of this
function in patch 13. This is part of the ASID allocation algorithm and
I prefer to keep them together (we even had a bug in here with the xchg
use).

Do you have any numbers to show how non-inlining this function affects
the performance (hackbench -P would do).

-- 
Catalin
