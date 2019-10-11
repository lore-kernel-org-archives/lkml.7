Return-Path: <SRS0=Osat=YE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B28B6C47404
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Oct 2019 18:17:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 90A2A20673
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Oct 2019 18:17:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728792AbfJKSR1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Oct 2019 14:17:27 -0400
Received: from foss.arm.com ([217.140.110.172]:39288 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728701AbfJKSR1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Oct 2019 14:17:27 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9DF25142F;
        Fri, 11 Oct 2019 11:17:26 -0700 (PDT)
Received: from [10.1.196.105] (eglon.cambridge.arm.com [10.1.196.105])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3BE8B3F703;
        Fri, 11 Oct 2019 11:17:24 -0700 (PDT)
Subject: Re: [PATCH v6 02/17] arm64: hibernate: pass the allocated pgdp to
 ttbr0
To:     Pavel Tatashin <pasha.tatashin@soleen.com>
References: <20191004185234.31471-1-pasha.tatashin@soleen.com>
 <20191004185234.31471-3-pasha.tatashin@soleen.com>
From:   James Morse <james.morse@arm.com>
Cc:     jmorris@namei.org, sashal@kernel.org, ebiederm@xmission.com,
        kexec@lists.infradead.org, linux-kernel@vger.kernel.org,
        corbet@lwn.net, catalin.marinas@arm.com, will@kernel.org,
        linux-arm-kernel@lists.infradead.org, marc.zyngier@arm.com,
        vladimir.murzin@arm.com, matthias.bgg@gmail.com,
        bhsharma@redhat.com, linux-mm@kvack.org, mark.rutland@arm.com
Message-ID: <bb937db3-f23a-809b-4ad8-ca86f689554d@arm.com>
Date:   Fri, 11 Oct 2019 19:17:22 +0100
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191004185234.31471-3-pasha.tatashin@soleen.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Pavel,

On 04/10/2019 19:52, Pavel Tatashin wrote:
> ttbr0 should be set to the beginning of pgdp, however, currently
> in create_safe_exec_page it is set to pgdp after pgd_offset_raw(),
> which works by accident.
> 
> Fixes: 0194e760f7d2 ("arm64: hibernate: avoid potential TLB conflict")

(That was a 'break before make' fix, the affected code comes from:
 82869ac57b5d (""arm64: kernel: Add support for hibernate/suspend-to-disk))

But, it works in all one circumstances its used: we know all the top bits will be zero.
I agree its by accident and we should fix it.

I don't think we should send it to stable.
Please drop the fixes tag, with that:
Reviewed-by: James Morse <james.morse@arm.com>


Thanks,

James


[0] https://lore.kernel.org/linux-arm-kernel/ddd81093-89fc-5146-0b33-ad3bd9a1c10c@arm.com/
