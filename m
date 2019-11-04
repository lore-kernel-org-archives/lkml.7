Return-Path: <SRS0=xa+R=Y4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_2 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3A08CA9ED3
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Nov 2019 13:25:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 850CB222C1
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Nov 2019 13:25:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729099AbfKDNZr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Nov 2019 08:25:47 -0500
Received: from smtprelay0064.hostedemail.com ([216.40.44.64]:48142 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727332AbfKDNZr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Nov 2019 08:25:47 -0500
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay01.hostedemail.com (Postfix) with ESMTP id 8F764100E7B4D;
        Mon,  4 Nov 2019 13:25:45 +0000 (UTC)
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-HE-Tag: crush17_8910377eab214
X-Filterd-Recvd-Size: 2742
Received: from grimm.local.home (unknown [146.247.46.6])
        (Authenticated sender: rostedt@goodmis.org)
        by omf10.hostedemail.com (Postfix) with ESMTPA;
        Mon,  4 Nov 2019 13:25:41 +0000 (UTC)
Date:   Mon, 4 Nov 2019 08:25:38 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, Jessica Yu <jeyu@kernel.org>,
        Helge Deller <deller@gmx.de>,
        "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
        linux-kernel@vger.kernel.org, amit.kachhap@arm.com,
        catalin.marinas@arm.com, duwe@suse.de, james.morse@arm.com,
        jpoimboe@redhat.com, jthierry@redhat.com,
        linux-parisc@vger.kernel.org, mingo@redhat.com,
        peterz@infradead.org, svens@stackframe.org,
        takahiro.akashi@linaro.org, will@kernel.org
Subject: Re: [PATCHv2 2/8] module/ftrace: handle patchable-function-entry
Message-ID: <20191104082538.292b501a@grimm.local.home>
In-Reply-To: <20191029165832.33606-3-mark.rutland@arm.com>
References: <20191029165832.33606-1-mark.rutland@arm.com>
        <20191029165832.33606-3-mark.rutland@arm.com>
X-Mailer: Claws Mail 3.17.4git49 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 29 Oct 2019 16:58:26 +0000
Mark Rutland <mark.rutland@arm.com> wrote:

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
> 
> Signed-off-by: Mark Rutland <mark.rutland@arm.com>
> Reviewed-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> Cc: Helge Deller <deller@gmx.de>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: James E.J. Bottomley <James.Bottomley@HansenPartnership.com>
> Cc: Jessica Yu <jeyu@kernel.org>
> Cc: Steven Rostedt <rostedt@goodmis.org>
> Cc: Sven Schnelle <svens@stackframe.org>
> Cc: linux-parisc@vger.kernel.org
> 

Acked-by: Steven Rostedt (VMware) <rostedt@goodmis.org>

-- Steve
