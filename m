Return-Path: <SRS0=uTOJ=ST=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5437FC282DA
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 15:16:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 269DC21773
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 15:16:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555514186;
	bh=JH2HUpdWLGb4SijG4uMgSFaNehYepgtc1BtSkXiffjo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=EgsLxM6OdgFAOvnau81OTHgw2vt/w/nBigO2gamuiLbgBhvgtxE3aHnJc0Z6OEZD3
	 LBbqcqO4T5VoUMQVPGb+Id840qLLQONhP7ITU1p/5AZ8ZMumprrNfYygp/0QnXlX/8
	 LenSD+lv0uUA8YwO0KIw6XheqRvP7TnyBkBbqMdA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732550AbfDQPQY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Apr 2019 11:16:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:43456 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729940AbfDQPQY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Apr 2019 11:16:24 -0400
Received: from linux-8ccs (nat.nue.novell.com [195.135.221.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9414E20645;
        Wed, 17 Apr 2019 15:16:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1555514183;
        bh=JH2HUpdWLGb4SijG4uMgSFaNehYepgtc1BtSkXiffjo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=fcC9YlYIw23SgDLWb2KU5r2Ygg7zxasDA+c/d0JSMMCi7SZP9fu7/x+3Me0OUgYJq
         tpBCwF9K4W3E+OidkKYDJH3AsOOq9jwOmW5xXhgaycQciwHJRA9gst0Jf+GMWxp86z
         lb6wEOpJ5WiSW+Q+vWKZc+6Fbv9johAfdC/ppPR0=
Date:   Wed, 17 Apr 2019 17:16:18 +0200
From:   Jessica Yu <jeyu@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Joel Fernandes <joel@joelfernandes.org>,
        linux-kernel@vger.kernel.org, paulmck@linux.vnet.ibm.com,
        keescook@chromium.org, mathieu.desnoyers@efficios.com,
        kernel-hardening@lists.openwall.com, kernel-team@android.com,
        rcu@vger.kernel.org
Subject: Re: [PATCH v3 3/3] module: Make __tracepoints_ptrs as read-only
Message-ID: <20190417151618.GD17099@linux-8ccs>
References: <20190410195708.162185-1-joel@joelfernandes.org>
 <20190410195708.162185-3-joel@joelfernandes.org>
 <20190410161112.540017d9@gandalf.local.home>
 <20190410202902.GA167446@google.com>
 <20190410204401.62f928ca@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20190410204401.62f928ca@gandalf.local.home>
X-OS:   Linux linux-8ccs 5.1.0-rc1-lp150.12.28-default+ x86_64
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+++ Steven Rostedt [10/04/19 20:44 -0400]:
>On Wed, 10 Apr 2019 16:29:02 -0400
>Joel Fernandes <joel@joelfernandes.org> wrote:
>
>> The srcu structure pointer array is modified at module load time because the
>> array is fixed up by the module loader at load-time with the final locations
>> of the tracepoints right?  Basically relocation fixups. At compile time, I
>> believe it is not know what the values in the ptr array are. I believe same
>> is true for the tracepoint ptrs array.
>>
>> Also it needs to be in a separate __tracepoint_ptrs so that this code works:
>>
>>
>> #ifdef CONFIG_TRACEPOINTS
>> 	mod->tracepoints_ptrs = section_objs(info, "__tracepoints_ptrs",
>> 					     sizeof(*mod->tracepoints_ptrs),
>> 					     &mod->num_tracepoints);
>> #endif
>>
>> Did I  miss some point? Thanks,
>
>But there's a lot of others too. Hmm, does this mean that the RO data
>sections that are in modules are not set to RO?
>
>There's a bunch of separate sections that are RO. Just look in
>include/asm-generic/vmlinux.lds.h under the RO_DATA_SECTION() macro.
>
>A lot of the sections saved in module.c:find_module_sections() are in
>that RO_DATA when compiled as a builtin. Are they not RO when loaded via
>a module?

Unlike the kernel, the module loader does not rely on a linker script
to determine which sections get what protections. On module load, all
sections in a module are looped through and those sections without the
SHF_WRITE flag will be set to RO. For example, when there is a section
filled with structs declared as const or if the section was explicitly
given only the SHF_ALLOC attribute, those will be read-only. As long
as the sections were given the correct section attributes for
read-only, it'll have read-only protection. I see this is already the
case for __param and  __ksymtab*/__kcrctab* sections, but I agree that
a full audit would be useful to be consistent with builtin RO
protections.

Hope that helps,

Jessica
