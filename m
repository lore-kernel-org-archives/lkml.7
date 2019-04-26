Return-Path: <SRS0=fl2C=S4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_MUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA494C43218
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 07:42:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A22E420684
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 07:42:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="HzSM0zqj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726302AbfDZHmi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Apr 2019 03:42:38 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:43812 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725923AbfDZHmi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Apr 2019 03:42:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=VSMhN+nfzaw1tZG3jJEpjZvzXxWyKbRMlymqbYuBFjg=; b=HzSM0zqj3Ao+/TzgNdgd1swkv
        JUIT5sLDscQK7QUjPui60Fvql3zrVQm8NFusS8MfvwLnn55u3O48d96ky/W/rckJ6suzG75KqhZvp
        goK9pKaYevwe0u0lWHZ/+tgW9cfR9Rhl3MSHvwuZ7mpfbVrxMvYP44caQxNOw681WR2JB4Hn9raAF
        SoVI0o6PWu/nkXUh6kwm/JtEvs9Tw/s3BJSK1mR7t1FTOJki6PrvzB1LUl2J022GsIZyhT+n+oqh/
        WFMNNLbCiyBzUksflqli8vZGvY7c1Ng1ZDfA4aDL35wGDW56lsq8MBGvtNgQMfbfcuCMquiyDm4dL
        GfZMyX+tA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hJvV3-0005gQ-VC; Fri, 26 Apr 2019 07:42:26 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id CB82029D1A321; Fri, 26 Apr 2019 09:42:23 +0200 (CEST)
Date:   Fri, 26 Apr 2019 09:42:23 +0200
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
Subject: Re: [RFC PATCH 5/7] x86/mm/fault: hook up SCI verification
Message-ID: <20190426074223.GY4038@hirez.programming.kicks-ass.net>
References: <1556228754-12996-1-git-send-email-rppt@linux.ibm.com>
 <1556228754-12996-6-git-send-email-rppt@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1556228754-12996-6-git-send-email-rppt@linux.ibm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 26, 2019 at 12:45:52AM +0300, Mike Rapoport wrote:
> If a system call runs in isolated context, it's accesses to kernel code and
> data will be verified by SCI susbsytem.
> 
> Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>
> ---
>  arch/x86/mm/fault.c | 28 ++++++++++++++++++++++++++++
>  1 file changed, 28 insertions(+)

There's a distinct lack of touching do_double_fault(). It appears to me
that you'll instantly trigger #DF when you #PF, because the #PF handler
itself will not be able to run.

And then obviously you have to be very careful to make sure #DF can,
_at_all_times_ run, otherwise you'll tripple-fault and we all know what
that does.

