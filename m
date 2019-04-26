Return-Path: <SRS0=fl2C=S4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0C0EC43219
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 09:05:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 792FE2077B
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 09:05:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556269502;
	bh=uaBeEqmTZeit711eU/27JEsAvccaA7mOXg0Nh5Ekomo=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:List-ID:From;
	b=bkR5lSkNA5nS8OtunYF1dS58qpSAT+podjIWU+A1efDce46oq5QjN1zo6Uu41xZJk
	 EoX/ajOPyw/nCI9gXB6l/l4C/3i8bBjLtYNXKUGkyJ1+QH4yKCS9GSJalnMegh46cN
	 tIrL1yMhS34jfd1NCmW6MNjyR+PzzTDFgyr7wEw0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726272AbfDZJFB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Apr 2019 05:05:01 -0400
Received: from twin.jikos.cz ([91.219.245.39]:34186 "EHLO twin.jikos.cz"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725800AbfDZJFB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Apr 2019 05:05:01 -0400
X-Greylist: delayed 3377 seconds by postgrey-1.27 at vger.kernel.org; Fri, 26 Apr 2019 05:05:00 EDT
Received: from twin.jikos.cz (jikos@[127.0.0.1])
        by twin.jikos.cz (8.13.6/8.13.6) with ESMTP id x3Q87p6T000940
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
        Fri, 26 Apr 2019 10:07:52 +0200
Received: from localhost (jikos@localhost)
        by twin.jikos.cz (8.13.6/8.13.6/Submit) with ESMTP id x3Q87oY9000925;
        Fri, 26 Apr 2019 10:07:50 +0200
X-Authentication-Warning: twin.jikos.cz: jikos owned process doing -bs
Date:   Fri, 26 Apr 2019 10:07:50 +0200 (CEST)
From:   Jiri Kosina <jikos@kernel.org>
To:     Andy Lutomirski <luto@kernel.org>
cc:     Mike Rapoport <rppt@linux.ibm.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Alexandre Chartre <alexandre.chartre@oracle.com>,
        Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        Jonathan Adams <jwadams@google.com>,
        Kees Cook <keescook@chromium.org>,
        Paul Turner <pjt@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Linux-MM <linux-mm@kvack.org>,
        LSM List <linux-security-module@vger.kernel.org>,
        X86 ML <x86@kernel.org>
Subject: Re: [RFC PATCH 0/7] x86: introduce system calls addess space
 isolation
In-Reply-To: <CALCETrWkYYh=L1nSO7GYt0FvMhjCcEaQiM2JEi3FfkJbYJFh2g@mail.gmail.com>
Message-ID: <alpine.LRH.2.00.1904261006290.10464@gjva.wvxbf.pm>
References: <1556228754-12996-1-git-send-email-rppt@linux.ibm.com> <CALCETrWkYYh=L1nSO7GYt0FvMhjCcEaQiM2JEi3FfkJbYJFh2g@mail.gmail.com>
User-Agent: Alpine 2.00 (LRH 1167 2008-08-23)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 25 Apr 2019, Andy Lutomirski wrote:

> The benefit seems to come from making sure that the RET instruction 
> actually goes somewhere that's already been faulted in.

Which doesn't seem to be really compatible with things like retpolines or 
anyone using FTRACE_WITH_REGS to modify stored instruction pointer.

-- 
Jiri Kosina
SUSE Labs
