Return-Path: <SRS0=fl2C=S4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B99CC43218
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 14:57:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CB7D9206E0
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 14:57:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="qaIDOuC8";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="IIFGf7Gv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726531AbfDZO5n (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Apr 2019 10:57:43 -0400
Received: from bedivere.hansenpartnership.com ([66.63.167.143]:49228 "EHLO
        bedivere.hansenpartnership.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726120AbfDZO5l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Apr 2019 10:57:41 -0400
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id 1D8068EE121;
        Fri, 26 Apr 2019 07:57:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1556290660;
        bh=MZ013Ph+lwQOoeohYQwwAPYLitvi2p0CBYiqPPjHpqI=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=qaIDOuC8aei1p/7IP9m9Fe7r3xqglUB9MVs7PdBCgZ558WNyEKGsDorTWf6PNNGxB
         BTCy/bnugUhZTtol9nQJKxUOW5moxnmy6Gtwb+BQs14FYokmStzrgIUIm+keNdtkd3
         r5f9oNC6yUkycIj3GOuPJLi7exfOyTK4AX48QUlM=
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
        by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id hitVsonP8-dL; Fri, 26 Apr 2019 07:57:39 -0700 (PDT)
Received: from [153.66.254.194] (unknown [50.35.68.20])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id 2A3368EE079;
        Fri, 26 Apr 2019 07:57:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1556290659;
        bh=MZ013Ph+lwQOoeohYQwwAPYLitvi2p0CBYiqPPjHpqI=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=IIFGf7GvQu8MCRHZXr1XtGW4XmqGJGBhgBm0P/VIYkiYQnktRNLrbXtK7lNWiswf4
         CKM8fUqVlquzGGDbVl94Z804nFWX6K13cOYwj/7elY9L73iANUBV0998IYN5LsYoUi
         OS2d0wMqqxyLuYMsxisTCzOk+GuvidU3cUz4dVWY=
Message-ID: <1556290658.2833.28.camel@HansenPartnership.com>
Subject: Re: [RFC PATCH 2/7] x86/sci: add core implementation for system
 call isolation
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     Dave Hansen <dave.hansen@intel.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        linux-kernel@vger.kernel.org
Cc:     Alexandre Chartre <alexandre.chartre@oracle.com>,
        Andy Lutomirski <luto@kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        Jonathan Adams <jwadams@google.com>,
        Kees Cook <keescook@chromium.org>,
        Paul Turner <pjt@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>, linux-mm@kvack.org,
        linux-security-module@vger.kernel.org, x86@kernel.org
Date:   Fri, 26 Apr 2019 07:57:38 -0700
In-Reply-To: <627d9321-466f-c4ed-c658-6b8567648dc6@intel.com>
References: <1556228754-12996-1-git-send-email-rppt@linux.ibm.com>
         <1556228754-12996-3-git-send-email-rppt@linux.ibm.com>
         <627d9321-466f-c4ed-c658-6b8567648dc6@intel.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2019-04-26 at 07:46 -0700, Dave Hansen wrote:
> On 4/25/19 2:45 PM, Mike Rapoport wrote:
> > After the isolated system call finishes, the mappings created
> > during its execution are cleared.
> 
> Yikes.  I guess that stops someone from calling write() a bunch of
> times on every filesystem using every block device driver and all the
> DM code to get a lot of code/data faulted in.  But, it also means not
> even long-running processes will ever have a chance of behaving
> anything close to normally.
> 
> Is this something you think can be rectified or is there something
> fundamental that would keep SCI page tables from being cached across
> different invocations of the same syscall?

There is some work being done to look at pre-populating the isolated
address space with the expected execution footprint of the system call,
yes.  It lessens the ROP gadget protection slightly because you might
find a gadget in the pre-populated code, but it solves a lot of the
overhead problem.

James

