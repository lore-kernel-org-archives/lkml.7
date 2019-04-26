Return-Path: <SRS0=fl2C=S4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45F3CC43219
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 16:24:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0728B206C1
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 16:24:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="MP8yg4sf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726377AbfDZQY2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Apr 2019 12:24:28 -0400
Received: from mail.skyhub.de ([5.9.137.197]:54062 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726243AbfDZQY1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Apr 2019 12:24:27 -0400
Received: from zn.tnic (p200300EC2F0E4E009523F59E52E4EA88.dip0.t-ipconnect.de [IPv6:2003:ec:2f0e:4e00:9523:f59e:52e4:ea88])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 6E77A1EC078A;
        Fri, 26 Apr 2019 18:24:26 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1556295866;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=2kiYXGYQX2SxOeynwl2dMGLr/4+J9UNbsvmt9zhXxcw=;
        b=MP8yg4sfmw/0aLJX6+H2QSXOfIqxrnrABKDyCgJuCZsGKOl2flA+YlHq+cwQwphTIHC97B
        cRbzKCVI+s2zOqUfNt2/LaJoWOd5HdA3LcLeuEgHBqScH5msH+VvopY8fybDznGIi5NTs9
        WAM0JrQWVAyoxNdsJMDhAG0aqTJ7dOY=
Date:   Fri, 26 Apr 2019 18:24:25 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Gary R Hook <ghook@amd.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        "Hook, Gary" <Gary.Hook@amd.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "luto@kernel.org" <luto@kernel.org>,
        Alexander Potapenko <glider@google.com>
Subject: Re: [PATCH] x86/mm/mem_encrypt: Disable all instrumentation for SME
 early boot code
Message-ID: <20190426162425.GI4608@zn.tnic>
References: <155440965936.6194.3202659723198724589.stgit@sosrh7.amd.com>
 <alpine.DEB.2.21.1904042237020.1802@nanos.tec.linutronix.de>
 <5dfcb133-0a0e-9e07-3774-313e30814e79@amd.com>
 <20190408165835.GJ15689@zn.tnic>
 <8a14050e-2516-5c0f-195d-611c6959b94b@amd.com>
 <20190408190800.GL15689@zn.tnic>
 <b0ee2570-c9ba-2a7c-2a8b-0dfa46685e62@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <b0ee2570-c9ba-2a7c-2a8b-0dfa46685e62@amd.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 26, 2019 at 03:11:17PM +0000, Gary R Hook wrote:
> 2) Turn off instrumentation for lib/cmdline.c. The risk is that any
>     changes to its code would not enjoy the benefits of KASAN/etc testing
>     (if enabled).

What happened to Thomas' suggestion to turn off instrumentation for
those files only when CONFIG_AMD_MEM_ENCRYPT=y?

Which is a variant of 2) above with ifdeffery.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
