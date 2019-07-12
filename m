Return-Path: <SRS0=V+Ds=VJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27FF0C742B9
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jul 2019 12:06:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E6E3521019
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jul 2019 12:06:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="2QOMxlXA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727150AbfGLMGq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Jul 2019 08:06:46 -0400
Received: from merlin.infradead.org ([205.233.59.134]:33508 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726155AbfGLMGl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Jul 2019 08:06:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=ntU8oMPY07ayUBkHvLSDuYCv3bfOAchf1eGcoqpdijs=; b=2QOMxlXA+8126DIzk43azdjz/
        HTxF5vVgRNoK7eXeV7hS7V1jAf9WCS4q5WVvukltI89jL/68fcRWkkChom0D0Qs+ySTAPkDKhAcMW
        KIkwVCJddWmGDBwJEK/alumUxLK56Wp69kd2oqoMRl6rDT5yLxTGmVWGBe3tzhytayu293pbe063L
        XvB/wtMNFB/+jRyFzmVKAw4Evgb2W+hew33DVW73HwjR5X4oDsI19z5ZJYTqT51PkP3owlZFnQG7m
        Df0O4cQXW6b1je3YygrtUIK9fFrflY8grdrrsB/d5uUX2BncLqs+0dqdGgY/UJB0FZP4ZUUQnTGWh
        ZwFO7rzKQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hluJn-0004ys-JF; Fri, 12 Jul 2019 12:06:27 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 2C84620A4087D; Fri, 12 Jul 2019 14:06:26 +0200 (CEST)
Date:   Fri, 12 Jul 2019 14:06:26 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Zhenzhong Duan <zhenzhong.duan@oracle.com>
Cc:     linux-kernel@vger.kernel.org, xen-devel@lists.xenproject.org,
        x86@kernel.org, srinivas.eeda@oracle.com,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Juergen Gross <jgross@suse.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>
Subject: Re: [PATCH v2] xen/pv: Fix a boot up hang revealed by int3 self test
Message-ID: <20190712120626.GW3402@hirez.programming.kicks-ass.net>
References: <1562832921-20831-1-git-send-email-zhenzhong.duan@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1562832921-20831-1-git-send-email-zhenzhong.duan@oracle.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 11, 2019 at 04:15:21PM +0800, Zhenzhong Duan wrote:
> diff --git a/arch/x86/xen/enlighten_pv.c b/arch/x86/xen/enlighten_pv.c
> index 4722ba2..2138d69 100644
> --- a/arch/x86/xen/enlighten_pv.c
> +++ b/arch/x86/xen/enlighten_pv.c
> @@ -596,7 +596,7 @@ struct trap_array_entry {
>  
>  static struct trap_array_entry trap_array[] = {
>  	{ debug,                       xen_xendebug,                    true },
> -	{ int3,                        xen_xenint3,                     true },
> +	{ int3,                        xen_int3,                        true },
>  	{ double_fault,                xen_double_fault,                true },
>  #ifdef CONFIG_X86_MCE
>  	{ machine_check,               xen_machine_check,               true },

I'm confused on the purpose of trap_array[], could you elucidate me?

The sole user seems to be get_trap_addr() and that talks about ISTs, but
#BP isn't an IST anymore, so why does it have ist_okay=true?
