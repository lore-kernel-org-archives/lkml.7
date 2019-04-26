Return-Path: <SRS0=fl2C=S4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EE69C4321A
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 12:36:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DBE3C2084F
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 12:36:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="op8cY6PD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726172AbfDZMgh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Apr 2019 08:36:37 -0400
Received: from merlin.infradead.org ([205.233.59.134]:33188 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726039AbfDZMgg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Apr 2019 08:36:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=oL8TTwWf1lScK+P2aI8yHUzecgCr0tD4qW+nChTl00s=; b=op8cY6PDBfokaJTi0IoRoXdKK
        wAZ+Ad6aX6IxVamFRPcS1dcY7bMX4xn6KYbwmRYjeSZx1kzjsbYVtjeEKMn5g+I9jRqpc7NsKcl6d
        ipfvVSItPtEe0044dQwTYDEc6vLU7ATUKEjAawkv8oXsUc4nkHkux0vwu44fc0rbg6exJwzeMUIuI
        +T60zYaYG8yV90PEW69dsOOyNJTIGvdf1/HpT1FSTkOa89UzHU5BYAtjh3K0ciOahUKydkJ6uNSmR
        FqBuByl34lt3kovjo4NkyejsIlQJVyp0YBHCDnRz5chrwTtPogDXKqFUmgN1aa99n2k9uVbrXQfF5
        p6HK9g99Q==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hK05F-0000L5-Q4; Fri, 26 Apr 2019 12:36:05 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 060DA29D23253; Fri, 26 Apr 2019 14:36:04 +0200 (CEST)
Date:   Fri, 26 Apr 2019 14:36:03 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Nadav Amit <namit@vmware.com>
Cc:     Borislav Petkov <bp@alien8.de>, Andy Lutomirski <luto@kernel.org>,
        Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org,
        x86@kernel.org, hpa@zytor.com,
        Thomas Gleixner <tglx@linutronix.de>,
        Nadav Amit <nadav.amit@gmail.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        linux_dti@icloud.com, linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, akpm@linux-foundation.org,
        kernel-hardening@lists.openwall.com, linux-mm@kvack.org,
        will.deacon@arm.com, ard.biesheuvel@linaro.org,
        kristen@linux.intel.com, deneen.t.dock@intel.com,
        Rick Edgecombe <rick.p.edgecombe@intel.com>
Subject: Re: [PATCH v5 00/23] x86: text_poke() fixes and executable lockdowns
Message-ID: <20190426123603.GD12232@hirez.programming.kicks-ass.net>
References: <20190426001143.4983-1-namit@vmware.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190426001143.4983-1-namit@vmware.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 25, 2019 at 05:11:20PM -0700, Nadav Amit wrote:
> Yet another version, per PeterZ request, addressing the latest feedback.
> 

Well, I would've been OK with just an updated to the one patch, but
thanks. Let me see if I can get all that to apply :-)
