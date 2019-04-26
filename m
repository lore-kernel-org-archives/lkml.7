Return-Path: <SRS0=fl2C=S4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2DA3C43219
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 07:50:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A00AE206E0
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 07:50:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Op/BtNTT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726144AbfDZHuF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Apr 2019 03:50:05 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:54664 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725899AbfDZHuF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Apr 2019 03:50:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=slE4aT5ZNj8dJtxH+FhGBwyu8kafNxlAmX6nDldrcS4=; b=Op/BtNTTdoi+lOukFcWX4choG
        882I7O1OKUeSfugw5FDEE8frhdfBaCMcWl7hiSMX4nAWztIGM/B8ibBqKFJCnPoXp3/kDy8rx4YhC
        uvUqRvrvrWFh2fq+KduiKrBv0H3yBWK9oBjFXVmqQdGZjrNASCAJ2og1IxUQGRcYMRhDFVfDSZfT+
        4VC6UmQw9hJk/NJjOjl6W/Xu0rWytUIlcVnGCFV7+DZT3hSVyFwowHpwdkK1vdxZB0t5myzQODMOg
        8HwgOCiydPFYEFjDX9PDp1qRkAhAtoU1oxTNk4Jif8MITPXfuFbirlP9K0Wd7JE+ALAjgNBoFEtto
        wg1bodvqA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hJvcM-0000zs-Bl; Fri, 26 Apr 2019 07:49:58 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id B4A6F29D1A323; Fri, 26 Apr 2019 09:49:56 +0200 (CEST)
Date:   Fri, 26 Apr 2019 09:49:56 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Mike Rapoport <rppt@linux.ibm.com>
Cc:     linux-kernel@vger.kernel.org,
        Alexandre Chartre <alexandre.chartre@oracle.com>,
        Andy Lutomirski <luto@kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        Jonathan Adams <jwadams@google.com>,
        Kees Cook <keescook@chromium.org>,
        Paul Turner <pjt@google.com>,
        Thomas Gleixner <tglx@linutronix.de>, linux-mm@kvack.org,
        linux-security-module@vger.kernel.org, x86@kernel.org
Subject: Re: [RFC PATCH 2/7] x86/sci: add core implementation for system call
 isolation
Message-ID: <20190426074956.GZ4038@hirez.programming.kicks-ass.net>
References: <1556228754-12996-1-git-send-email-rppt@linux.ibm.com>
 <1556228754-12996-3-git-send-email-rppt@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1556228754-12996-3-git-send-email-rppt@linux.ibm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 26, 2019 at 12:45:49AM +0300, Mike Rapoport wrote:
> The initial SCI implementation allows access to any kernel data, but it
> limits access to the code in the following way:
> * calls and jumps to known code symbols without offset are allowed
> * calls and jumps into a known symbol with offset are allowed only if that
> symbol was already accessed and the offset is in the next page
> * all other code access are blocked

So if you have a large function and an in-function jump skips a page
you're toast.

Why not employ the instruction decoder we have and unconditionally allow
all direct JMP/CALL but verify indirect JMP/CALL and RET ?

Anyway, I'm fearing the overhead of this one, this cannot be fast.
