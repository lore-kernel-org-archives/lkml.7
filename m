Return-Path: <SRS0=iR9I=YX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A277CA9EC7
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Oct 2019 15:03:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5404E208E3
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Oct 2019 15:03:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727009AbfJ3PDG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Oct 2019 11:03:06 -0400
Received: from mx2.suse.de ([195.135.220.15]:48256 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726175AbfJ3PDF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Oct 2019 11:03:05 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id D41D1B3B1;
        Wed, 30 Oct 2019 15:03:03 +0000 (UTC)
Date:   Wed, 30 Oct 2019 16:03:02 +0100
From:   Torsten Duwe <duwe@suse.de>
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, Jessica Yu <jeyu@kernel.org>,
        Helge Deller <deller@gmx.de>,
        "James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>,
        linux-kernel@vger.kernel.org, amit.kachhap@arm.com,
        catalin.marinas@arm.com, james.morse@arm.com, jpoimboe@redhat.com,
        jthierry@redhat.com, linux-parisc@vger.kernel.org,
        mingo@redhat.com, peterz@infradead.org, rostedt@goodmis.org,
        svens@stackframe.org, takahiro.akashi@linaro.org, will@kernel.org
Subject: Re: [PATCHv2 2/8] module/ftrace: handle patchable-function-entry
Message-ID: <20191030150302.GA965@suse.de>
References: <20191029165832.33606-1-mark.rutland@arm.com>
 <20191029165832.33606-3-mark.rutland@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191029165832.33606-3-mark.rutland@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 29, 2019 at 04:58:26PM +0000, Mark Rutland wrote:
> When using patchable-function-entry, the compiler will record the
> callsites into a section named "__patchable_function_entries" rather
> than "__mcount_loc". Let's abstract this difference behind a new
> FTRACE_CALLSITE_SECTION, so that architectures don't have to handle this
> explicitly (e.g. with custom module linker scripts).
> 
> As parisc currently handles this explicitly, it is fixed up accordingly,
> with its custom linker script removed. Since FTRACE_CALLSITE_SECTION is
> only defined when DYNAMIC_FTRACE is selected, the parisc module loading
> code is updated to only use the definition in that case. When
> DYNAMIC_FTRACE is not selected, modules shouldn't have this section, so
> this removes some redundant work in that case.
> 
> I built parisc generic-{32,64}bit_defconfig with DYNAMIC_FTRACE enabled,
> and verified that the section made it into the .ko files for modules.

This is because of remaining #ifdeffery in include/asm-generic/vmlinux.lds.h:

#ifdef CC_USING_PATCHABLE_FUNCTION_ENTRY
#define MCOUNT_REC()    . = ALIGN(8);                           \
                        __start_mcount_loc = .;                 \
                        KEEP(*(__patchable_function_entries))   \
                        __stop_mcount_loc = .;
#else
#define MCOUNT_REC()    . = ALIGN(8);                           \
                        __start_mcount_loc = .;                 \
                        KEEP(*(__mcount_loc))                   \
                        __stop_mcount_loc = .;
#endif

Maybe you want to tackle that as well? I suggest to have at least one
FTRACE_CALLSITE_SECTION definition without double quotes. Alternatively, my
earlier solution just kept both sections, in case either one or both are
present.

                        KEEP(*(__patchable_function_entries))   \
                        KEEP(*(__mcount_loc))                   \

	Torsten
