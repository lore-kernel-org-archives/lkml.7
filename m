Return-Path: <SRS0=TvG7=UK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2EF0C43218
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 14:09:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C5AE320652
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 14:09:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389809AbfFKOJM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Jun 2019 10:09:12 -0400
Received: from foss.arm.com ([217.140.110.172]:33758 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725811AbfFKOJL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jun 2019 10:09:11 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E7336344;
        Tue, 11 Jun 2019 07:09:10 -0700 (PDT)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C6E193F557;
        Tue, 11 Jun 2019 07:09:09 -0700 (PDT)
Date:   Tue, 11 Jun 2019 15:09:07 +0100
From:   Mark Rutland <mark.rutland@arm.com>
To:     Raphael Gault <raphael.gault@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        mingo@redhat.com, peterz@infradead.org, catalin.marinas@arm.com,
        will.deacon@arm.com, acme@kernel.org
Subject: Re: [PATCH 1/7] perf: arm64: Compile tests unconditionally
Message-ID: <20190611140907.GF29008@lakrids.cambridge.arm.com>
References: <20190611125315.18736-1-raphael.gault@arm.com>
 <20190611125315.18736-2-raphael.gault@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190611125315.18736-2-raphael.gault@arm.com>
User-Agent: Mutt/1.11.1+11 (2f07cb52) (2018-12-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 11, 2019 at 01:53:09PM +0100, Raphael Gault wrote:
> In order to subsequently add more tests for the arm64 architecture
> we compile the tests target for arm64 systematically.

Given prior questions regarding this commit, it's probably worth
spelling things out more explicitly, e.g.

  Currently we only build the arm64/tests directory if
  CONFIG_DWARF_UNWIND is selected, which is fine as the only test we
  have is arm64/tests/dwarf-unwind.o.

  So that we can add more tests to the test directory, let's
  unconditionally build the directory, but conditionally build
  dwarf-unwind.o depending on CONFIG_DWARF_UNWIND.

  There should be no functional change as a result of this patch.

> 
> Signed-off-by: Raphael Gault <raphael.gault@arm.com>

Either way, the patch looks good to me:

Acked-by: Mark Rutland <mark.rutland@arm.com>

Mark.

> ---
>  tools/perf/arch/arm64/Build       | 2 +-
>  tools/perf/arch/arm64/tests/Build | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/perf/arch/arm64/Build b/tools/perf/arch/arm64/Build
> index 36222e64bbf7..a7dd46a5b678 100644
> --- a/tools/perf/arch/arm64/Build
> +++ b/tools/perf/arch/arm64/Build
> @@ -1,2 +1,2 @@
>  perf-y += util/
> -perf-$(CONFIG_DWARF_UNWIND) += tests/
> +perf-y += tests/
> diff --git a/tools/perf/arch/arm64/tests/Build b/tools/perf/arch/arm64/tests/Build
> index 41707fea74b3..a61c06bdb757 100644
> --- a/tools/perf/arch/arm64/tests/Build
> +++ b/tools/perf/arch/arm64/tests/Build
> @@ -1,4 +1,4 @@
>  perf-y += regs_load.o
> -perf-y += dwarf-unwind.o
> +perf-$(CONFIG_DWARF_UNWIND) += dwarf-unwind.o
>  
>  perf-y += arch-tests.o
> -- 
> 2.17.1
> 
