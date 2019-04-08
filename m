Return-Path: <SRS0=N68d=SK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1A7DC10F13
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 15:25:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8C5B921841
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 15:25:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729087AbfDHPZP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Apr 2019 11:25:15 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:50192 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727664AbfDHPZP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Apr 2019 11:25:15 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B8B7E15AB;
        Mon,  8 Apr 2019 08:25:14 -0700 (PDT)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C25183F557;
        Mon,  8 Apr 2019 08:25:11 -0700 (PDT)
Date:   Mon, 8 Apr 2019 16:25:09 +0100
From:   Mark Rutland <mark.rutland@arm.com>
To:     Torsten Duwe <duwe@lst.de>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>
Cc:     Will Deacon <will.deacon@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Julien Thierry <julien.thierry@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Ingo Molnar <mingo@redhat.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>,
        AKASHI Takahiro <takahiro.akashi@linaro.org>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Amit Daniel Kachhap <amit.kachhap@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        live-patching@vger.kernel.org, kasan-dev@googlegroups.com
Subject: Re: [PATCH v8 3/5] arm64: replace -pg with CC_FLAGS_FTRACE in
 mm/kasan Makefile
Message-ID: <20190408152509.GK6139@lakrids.cambridge.arm.com>
References: <20190208150826.44EBC68DD2@newverein.lst.de>
 <20190208151014.CD48668DDC@newverein.lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190208151014.CD48668DDC@newverein.lst.de>
User-Agent: Mutt/1.11.1+11 (2f07cb52) (2018-12-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 08, 2019 at 04:10:14PM +0100, Torsten Duwe wrote:
>   In preparation for arm64 supporting ftrace built on other compiler
>   options, let's have makefiles remove the $(CC_FLAGS_FTRACE)
>   flags, whatever these may be, rather than assuming '-pg'.
> 
>   There should be no functional change as a result of this patch.
> 
> Signed-off-by: Torsten Duwe <duwe@suse.de>

Andrey, would you be happy if we were to take this via the arm64 tree?

Assuming so, could we please have your ack?

Thanks,
Mark.

> 
> ---
>  mm/kasan/Makefile |    4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> --- a/mm/kasan/Makefile
> +++ b/mm/kasan/Makefile
> @@ -5,8 +5,8 @@ UBSAN_SANITIZE_generic.o := n
>  UBSAN_SANITIZE_tags.o := n
>  KCOV_INSTRUMENT := n
>  
> -CFLAGS_REMOVE_common.o = -pg
> -CFLAGS_REMOVE_generic.o = -pg
> +CFLAGS_REMOVE_common.o = $(CC_FLAGS_FTRACE)
> +CFLAGS_REMOVE_generic.o = $(CC_FLAGS_FTRACE)
>  # Function splitter causes unnecessary splits in __asan_load1/__asan_store1
>  # see: https://gcc.gnu.org/bugzilla/show_bug.cgi?id=63533
>  
