Return-Path: <SRS0=qxzQ=YP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1C95CA9EA0
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Oct 2019 12:56:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7B0832075A
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Oct 2019 12:56:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="jcguvE70"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389201AbfJVM4X (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Oct 2019 08:56:23 -0400
Received: from mail.skyhub.de ([5.9.137.197]:34370 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388090AbfJVM4X (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Oct 2019 08:56:23 -0400
Received: from zn.tnic (p200300EC2F0D770050FB97201665E20F.dip0.t-ipconnect.de [IPv6:2003:ec:2f0d:7700:50fb:9720:1665:e20f])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id A65671EC0C93;
        Tue, 22 Oct 2019 14:56:21 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1571748981;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=ks1D9cpBLbkfWTmP9/zselE/e5+jDjbNzQqZmgKx9es=;
        b=jcguvE70r76Nwj7LatlqAWnUUBSXLYHwSALouOKz1MzbmbLTOMF7c7RYagsBjyHQAEbdyQ
        6rTgqhezg/UzWC9hxm21LZBVleeTfGxkeWl7gekr+Nk2Kodh98Qx+SHQ6SfX/WcZU34jUH
        AZ27Q5fIwPgzzKd/DJ5TMkz0mCfqA9s=
Date:   Tue, 22 Oct 2019 14:56:15 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Jiri Slaby <jslaby@suse.cz>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        tip-bot2 for Jiri Slaby <tip-bot2@linutronix.de>,
        linux-kernel@vger.kernel.org, linux-tip-commits@vger.kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        linux-arch@vger.kernel.org, Masami Hiramatsu <mhiramat@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>, x86-ml <x86@kernel.org>,
        Ingo Molnar <mingo@kernel.org>
Subject: Re: [PATCH] x86/ftrace: Get rid of function_hook
Message-ID: <20191022125615.GE31700@zn.tnic>
References: <157141622788.29376.4016565749507481510.tip-bot2@tip-bot2>
 <20191018124800.0a7006bb@gandalf.local.home>
 <20191018124956.764ac42e@gandalf.local.home>
 <20191018171354.GB20368@zn.tnic>
 <20191018133735.77e90e36@gandalf.local.home>
 <20191018194856.GC20368@zn.tnic>
 <20191018163125.346e078d@gandalf.local.home>
 <20191019073424.GA27353@zn.tnic>
 <20191021141038.GC7014@zn.tnic>
 <f8dcb3dd-a8a6-5326-ea4a-bea2eb1c4651@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <f8dcb3dd-a8a6-5326-ea4a-bea2eb1c4651@suse.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 22, 2019 at 01:38:42PM +0200, Jiri Slaby wrote:
> On the top of Steven's comment:
> Acked-by: Jiri Slaby <jslaby@suse.cz>
> 
> Thanks for taking care of this while my tooth was causing me pain.

Sure, np. Toothache is yuck.

Ok, so after some back'n'forth yesterday on IRC, I think we agree on
only renaming function_hook but keeping its SYM_FUNC* annotation so
that ORC can unwind into it because we're fancy and we do all kinds of
unwinding from interrupts in ftrace handlers and all that other fun. So
it needs to know that that thing is a function.

So here it is as a proper patch as a reply to this message.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
