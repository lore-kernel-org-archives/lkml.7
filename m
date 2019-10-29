Return-Path: <SRS0=sYEh=YW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DAA4CA9EAE
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Oct 2019 11:15:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1D526208E3
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Oct 2019 11:15:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1572347725;
	bh=SRzW6FPQi8ILQcHxWmUOSb/ba5l1skxBzk0N9Zb67L4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=JZ94cQ6cYgou14u5MlEbNRXwQ7oMqIlv8Epg0bZsLh0r1zlNIPbGE39XxY+jj0Iqc
	 kCFk3wKY+DJxYXl/r85g097wNQbOE1tF+v/HmdIUXanC1ie5LyB0ABGUzeBESsFhmo
	 yMGIhPEPveEgfPz3CXLNCv6ReY5srx2eankVATus=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731958AbfJ2LPX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Oct 2019 07:15:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:54780 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727453AbfJ2LPX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Oct 2019 07:15:23 -0400
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 11E4020874;
        Tue, 29 Oct 2019 11:15:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572347722;
        bh=SRzW6FPQi8ILQcHxWmUOSb/ba5l1skxBzk0N9Zb67L4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=MJdt7Qkk8k8EZ3/tmQnFyxliB71kW0Fijqg99du9tXDTYkAjb/luEfkEjNGNcaZwg
         +HMHEyLiKIi9Eui/X2aR2rO4gQQR2I113KBb4OV19kIVsDSHx0qGFkdXJhnjZBu40T
         587urYEACjLw9EEzNQ6voqtMd9lA5yn3AW3eFhvQ=
Date:   Tue, 29 Oct 2019 11:15:17 +0000
From:   Will Deacon <will@kernel.org>
To:     Julien Grall <julien.grall@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        catalin.marinas@arm.com, suzuki.poulose@arm.com,
        Dave.Martin@arm.com
Subject: Re: [PATCH] arm64: cpufeature: Export Armv8.6 Matrix feature to
 userspace
Message-ID: <20191029111517.GE11590@willie-the-truck>
References: <20191025171056.30641-1-julien.grall@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191025171056.30641-1-julien.grall@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 25, 2019 at 06:10:56PM +0100, Julien Grall wrote:
> This patch provides support for reporting the presence of Armv8.6
> Matrix and its optional features to userspace.

Are you sure this is 8.6 and not earlier?

> This based on [1] + commit ec52c7134b1f "arm64: cpufeature: Treat
> ID_AA64ZFR0_EL1 as RAZ when SVE is not enabled" (taken from v5.4-rc4).
> 
> [1]  arm64/for-next/elf-hwcap-docs
> ---
>  Documentation/arm64/cpu-feature-registers.rst |  8 ++++++++
>  Documentation/arm64/elf_hwcaps.rst            | 15 +++++++++++++++
>  arch/arm64/include/asm/hwcap.h                |  4 ++++
>  arch/arm64/include/asm/sysreg.h               |  7 +++++++
>  arch/arm64/include/uapi/asm/hwcap.h           |  4 ++++
>  arch/arm64/kernel/cpufeature.c                | 11 +++++++++++
>  arch/arm64/kernel/cpuinfo.c                   |  4 ++++
>  7 files changed, 53 insertions(+)
> 
> diff --git a/Documentation/arm64/cpu-feature-registers.rst b/Documentation/arm64/cpu-feature-registers.rst
> index ffcf4e2c71ef..d1d6d56a7b08 100644
> --- a/Documentation/arm64/cpu-feature-registers.rst
> +++ b/Documentation/arm64/cpu-feature-registers.rst
> @@ -193,6 +193,8 @@ infrastructure:
>       +------------------------------+---------+---------+
>       | Name                         |  bits   | visible |
>       +------------------------------+---------+---------+
> +     | I8MM                         | [52-55] |    y    |
> +     +------------------------------+---------+---------+

Looking at:

https://developer.arm.com/docs/ddi0601/latest/aarch64-system-registers/id_aa64isar1_el1

Then I8MM is advertised as "Armv8.2", alongside other fields that we haven't
listed here such as BF16 and SPECRES.

So we probably want a patch bringing all of this up to speed, rather than
randomly advertising some features and not others.

>       | SB                           | [36-39] |    y    |
>       +------------------------------+---------+---------+
>       | FRINTTS                      | [32-35] |    y    |
> @@ -227,6 +229,12 @@ infrastructure:
>       +------------------------------+---------+---------+
>       | Name                         |  bits   | visible |
>       +------------------------------+---------+---------+
> +     | F64MM                        | [56-59] |    y    |
> +     +------------------------------+---------+---------+
> +     | F32MM                        | [52-55] |    y    |
> +     +------------------------------+---------+---------+
> +     | I8MM                         | [44-47] |    y    |
> +     +------------------------------+---------+---------+

Urgh, we're inconsistent in our bitfields. Some are [lo-hi] whilst others
are [hi-lo]. Please can you fix that in a preparatory patch? I prefer
[hi-lo] and it matches the arch docs.

Will
