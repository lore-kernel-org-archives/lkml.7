Return-Path: <SRS0=iR9I=YX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5613CA9EC6
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Oct 2019 15:25:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BBAEE21882
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Oct 2019 15:25:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727084AbfJ3PZV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Oct 2019 11:25:21 -0400
Received: from mx2.suse.de ([195.135.220.15]:56988 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726246AbfJ3PZU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Oct 2019 11:25:20 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 2F6B7B1AE;
        Wed, 30 Oct 2019 15:25:19 +0000 (UTC)
Date:   Wed, 30 Oct 2019 16:25:17 +0100 (CET)
From:   Miroslav Benes <mbenes@suse.cz>
To:     Mark Rutland <mark.rutland@arm.com>
cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        amit.kachhap@arm.com, catalin.marinas@arm.com, deller@gmx.de,
        duwe@suse.de, James.Bottomley@HansenPartnership.com,
        james.morse@arm.com, jeyu@kernel.org, jpoimboe@redhat.com,
        jthierry@redhat.com, linux-parisc@vger.kernel.org,
        mingo@redhat.com, peterz@infradead.org, rostedt@goodmis.org,
        svens@stackframe.org, takahiro.akashi@linaro.org, will@kernel.org
Subject: Re: [PATCHv2 3/8] arm64: module: rework special section handling
In-Reply-To: <20191029165832.33606-4-mark.rutland@arm.com>
Message-ID: <alpine.LSU.2.21.1910301614330.18400@pobox.suse.cz>
References: <20191029165832.33606-1-mark.rutland@arm.com> <20191029165832.33606-4-mark.rutland@arm.com>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 29 Oct 2019, Mark Rutland wrote:

> When we load a module, we have to perform some special work for a couple
> of named sections. To do this, we iterate over all of the module's
> sections, and perform work for each section we recognize.
> 
> To make it easier to handle the unexpected absence of a section, and to
> make the section-specific logic easer to read, let's factor the section

s/easer/easier/

> search into a helper. Similar is already done in the core module loader,
> and other architectures (and ideally we'd unify these in future).
> 
> If we expect a module to have an ftrace trampoline section, but it
> doesn't have one, we'll now reject loading the module. When
> ARM64_MODULE_PLTS is selected, any correctly built module should have
> one (and this is assumed by arm64's ftrace PLT code) and the absence of
> such a section implies something has gone wrong at build time.
> 
> Subsequent patches will make use of the new helper.
> 
> Signed-off-by: Mark Rutland <mark.rutland@arm.com>
> Reviewed-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: James Morse <james.morse@arm.com>
> Cc: Will Deacon <will@kernel.org>

Reviewed-by: Miroslav Benes <mbenes@suse.cz>

M
