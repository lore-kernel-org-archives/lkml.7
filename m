Return-Path: <SRS0=GGWy=XB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 937C4C43331
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Sep 2019 15:17:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7168A20650
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Sep 2019 15:17:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390638AbfIFPR6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Sep 2019 11:17:58 -0400
Received: from foss.arm.com ([217.140.110.172]:57982 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726168AbfIFPR6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Sep 2019 11:17:58 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9B9CE1596;
        Fri,  6 Sep 2019 08:17:57 -0700 (PDT)
Received: from [10.1.196.105] (unknown [10.1.196.105])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0D1163F59C;
        Fri,  6 Sep 2019 08:17:54 -0700 (PDT)
From:   James Morse <james.morse@arm.com>
Subject: Re: [PATCH v3 05/17] arm64, hibernate: check pgd table allocation
To:     Pavel Tatashin <pasha.tatashin@soleen.com>
Cc:     jmorris@namei.org, sashal@kernel.org, ebiederm@xmission.com,
        kexec@lists.infradead.org, linux-kernel@vger.kernel.org,
        corbet@lwn.net, catalin.marinas@arm.com, will@kernel.org,
        linux-arm-kernel@lists.infradead.org, marc.zyngier@arm.com,
        vladimir.murzin@arm.com, matthias.bgg@gmail.com,
        bhsharma@redhat.com, linux-mm@kvack.org, mark.rutland@arm.com
References: <20190821183204.23576-1-pasha.tatashin@soleen.com>
 <20190821183204.23576-6-pasha.tatashin@soleen.com>
Message-ID: <ddd81093-89fc-5146-0b33-ad3bd9a1c10c@arm.com>
Date:   Fri, 6 Sep 2019 16:17:53 +0100
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20190821183204.23576-6-pasha.tatashin@soleen.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Pavel,

On 21/08/2019 19:31, Pavel Tatashin wrote:
> There is a bug in create_safe_exec_page(), when page table is allocated
> it is not checked that table is allocated successfully:
> 
> But it is dereferenced in: pgd_none(READ_ONCE(*pgdp)).

If there is a bug, it shouldn't be fixed part way through a series. This makes it
difficult to backport the fix.

Please split this out as an independent patch with a 'Fixes:' tag for the commit that
introduced the bug.


> Another issue,

So this patch does two things? That is rarely a good idea. Again, this makes it difficult
to backport the fix.


> is that phys_to_ttbr() uses an offset in page table instead
> of pgd directly.

If you were going to reuse this, that would be a bug. But because the only page that is
being mapped, is mapped to PAGE_SIZE, all the top bits will be 0. The offset calls are
boiler-plate. It doesn't look intentional, but its harmless.


Please separate out the potential NULL-dereference bits so there is a clean stand-alone
fix that can be sent to the stable trees.


Thanks,

James
