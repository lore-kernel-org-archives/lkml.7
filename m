Return-Path: <SRS0=7x1k=SF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79A36C4360F
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 12:30:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4D4AC20882
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 12:30:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726388AbfDCMaX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Apr 2019 08:30:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:41346 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726064AbfDCMaW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Apr 2019 08:30:22 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D9D1F2084C;
        Wed,  3 Apr 2019 12:30:20 +0000 (UTC)
Date:   Wed, 3 Apr 2019 08:30:19 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     Torsten Duwe <duwe@lst.de>, Will Deacon <will.deacon@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Julien Thierry <julien.thierry@arm.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Ingo Molnar <mingo@redhat.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>,
        AKASHI Takahiro <takahiro.akashi@linaro.org>,
        Amit Daniel Kachhap <amit.kachhap@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        live-patching@vger.kernel.org
Subject: Re: [PATCH v7 2/3] arm64: implement ftrace with regs
Message-ID: <20190403083019.29f5fd9b@gandalf.local.home>
In-Reply-To: <20190403024842.drobymuwvx6hmwv7@blommer>
References: <20190118163736.6A99268CEB@newverein.lst.de>
        <20190118163908.E338E68D93@newverein.lst.de>
        <20190403024842.drobymuwvx6hmwv7@blommer>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 3 Apr 2019 03:48:43 +0100
Mark Rutland <mark.rutland@arm.com> wrote:

> We currently have:
> 
> ftrace_make_nop(mod, rec, addr)
> ftrace_make_call(rec, addr)
> ftrace_modify_call(rec, old_addr, new_addr)
> 
> ... whereas we could have:
> 
> ftrace_call_init(mod, rec)
> ftrace_call_enable(rec, addr)
> ftrace_call_disable(rec, addr)
> ftrace_call_modify(rec, old_addr, new_addr)
> 
> ... so we wouldn't need to special-case anything for initialization (and
> don't need MCOUNT_ADDR at all), and it would be clearer as to what was
> happening at each stage.

Just a note. I would be OK if someone wants to work in changing the
ftrace interface to be this. I'll review the code, but I don't have the
cycles to implement such a change.

-- Steve
