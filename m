Return-Path: <SRS0=BPXs=SN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A337DC282CE
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 00:44:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7C98A217D4
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 00:44:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726808AbfDKAoF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Apr 2019 20:44:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:56500 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725982AbfDKAoF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Apr 2019 20:44:05 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 99BEF2133D;
        Thu, 11 Apr 2019 00:44:03 +0000 (UTC)
Date:   Wed, 10 Apr 2019 20:44:01 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     linux-kernel@vger.kernel.org, paulmck@linux.vnet.ibm.com,
        keescook@chromium.org, mathieu.desnoyers@efficios.com,
        Jessica Yu <jeyu@kernel.org>,
        kernel-hardening@lists.openwall.com, kernel-team@android.com,
        rcu@vger.kernel.org
Subject: Re: [PATCH v3 3/3] module: Make __tracepoints_ptrs as read-only
Message-ID: <20190410204401.62f928ca@gandalf.local.home>
In-Reply-To: <20190410202902.GA167446@google.com>
References: <20190410195708.162185-1-joel@joelfernandes.org>
        <20190410195708.162185-3-joel@joelfernandes.org>
        <20190410161112.540017d9@gandalf.local.home>
        <20190410202902.GA167446@google.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 10 Apr 2019 16:29:02 -0400
Joel Fernandes <joel@joelfernandes.org> wrote:

> The srcu structure pointer array is modified at module load time because the
> array is fixed up by the module loader at load-time with the final locations
> of the tracepoints right?  Basically relocation fixups. At compile time, I
> believe it is not know what the values in the ptr array are. I believe same
> is true for the tracepoint ptrs array.
> 
> Also it needs to be in a separate __tracepoint_ptrs so that this code works:
> 
> 
> #ifdef CONFIG_TRACEPOINTS
> 	mod->tracepoints_ptrs = section_objs(info, "__tracepoints_ptrs",
> 					     sizeof(*mod->tracepoints_ptrs),
> 					     &mod->num_tracepoints);
> #endif
> 
> Did I  miss some point? Thanks,

But there's a lot of others too. Hmm, does this mean that the RO data
sections that are in modules are not set to RO?

There's a bunch of separate sections that are RO. Just look in
include/asm-generic/vmlinux.lds.h under the RO_DATA_SECTION() macro.

A lot of the sections saved in module.c:find_module_sections() are in
that RO_DATA when compiled as a builtin. Are they not RO when loaded via
a module?

If this is the case, there probably is going to be a lot more sections
added to your list.

-- Steve
