Return-Path: <SRS0=fWiu=Y6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1F1EC5DF62
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Nov 2019 11:23:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 75BDA206A3
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Nov 2019 11:23:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731376AbfKFLXP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Nov 2019 06:23:15 -0500
Received: from foss.arm.com ([217.140.110.172]:38158 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726101AbfKFLXP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Nov 2019 06:23:15 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 78A097A7;
        Wed,  6 Nov 2019 03:23:14 -0800 (PST)
Received: from arrakis.emea.arm.com (unknown [10.1.197.42])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2525F3F6C4;
        Wed,  6 Nov 2019 03:23:13 -0800 (PST)
Date:   Wed, 6 Nov 2019 11:23:11 +0000
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Bhupesh Sharma <bhsharma@redhat.com>
Cc:     linux-arm-kernel@lists.infradead.org, bhupesh.linux@gmail.com,
        James Morse <james.morse@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Will Deacon <will@kernel.org>,
        Steve Capper <steve.capper@arm.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        linux-kernel@vger.kernel.org, kexec@lists.infradead.org
Subject: Re: [PATCH] arm64: mm: Remove MAX_USER_VA_BITS definition
Message-ID: <20191106112310.GG21133@arrakis.emea.arm.com>
References: <1572904606-27961-1-git-send-email-bhsharma@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1572904606-27961-1-git-send-email-bhsharma@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 05, 2019 at 03:26:46AM +0530, Bhupesh Sharma wrote:
> commit 9b31cf493ffa ("arm64: mm: Introduce MAX_USER_VA_BITS definition")
> introduced the MAX_USER_VA_BITS definition, which was used to support
> the arm64 mm use-cases where the user-space could use 52-bit virtual
> addresses whereas the kernel-space would still could a maximum of 48-bit
> virtual addressing.
> 
> But, now with commit b6d00d47e81a ("arm64: mm: Introduce 52-bit Kernel
> VAs"), we removed the 52-bit user/48-bit kernel kconfig option and hence
> there is no longer any scenario where user VA != kernel VA size
> (even with CONFIG_ARM64_FORCE_52BIT enabled, the same is true).
> 
> Hence we can do away with the MAX_USER_VA_BITS macro as it is equal to
> VA_BITS (maximum VA space size) in all possible use-cases. Note that
> even though the 'vabits_actual' value would be 48 for arm64 hardware
> which don't support LVA-8.2 extension (even when CONFIG_ARM64_VA_BITS_52
> is enabled), VA_BITS would still be set to a value 52. Hence this change
> would be safe in all possible VA address space combinations.
> 
> Cc: James Morse <james.morse@arm.com>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: Will Deacon <will@kernel.org>
> Cc: Steve Capper <steve.capper@arm.com>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> Cc: linux-kernel@vger.kernel.org
> Cc: kexec@lists.infradead.org
> Signed-off-by: Bhupesh Sharma <bhsharma@redhat.com>

Queued for 5.5. Thanks.

-- 
Catalin
