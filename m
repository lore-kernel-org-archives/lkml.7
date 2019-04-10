Return-Path: <SRS0=SZ1Q=SM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08933C10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 06:54:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C63D32083E
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 06:54:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="kV0N3dlj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728667AbfDJGyb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Apr 2019 02:54:31 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:54228 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726894AbfDJGyb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Apr 2019 02:54:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=CfDh/xNSvQ6EpIdUx9RPQ4MIQT/XHWChd9LJLZS9JsE=; b=kV0N3dlj2s/HL8wFzcoLue67i
        CZOFlZ/q5xB4uwQjY97aF9FGscWcMAneQnU8II+ElbJBIyL+ztLj/AnAen8Z+Wj/u58PHN7Cys/SF
        yqQ+dsKbESdMtI2v01C67Q9QHjSnJ0MeH4Kv41py/jsAhLsgVgIyCF8eZ1g0OZKpzKRjlsXDfoTAi
        GQfp11BXTLRrojPUImTKIhVDzC5Y7wWrgyNHX0ZR+TGMrpqkiAbBOLh+Z8ulVcqg2J5GD6suFaLSi
        hkruuFIq9usoLLmoj35UL0SdkNSsYisCXwUoYHZGf5FBsrAUKmKnLWNkwuZB6713/7Mih/wpbYMKI
        8FsnA06fw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hE77k-0000sW-6c; Wed, 10 Apr 2019 06:54:20 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 02E45201F29A7; Wed, 10 Apr 2019 08:54:17 +0200 (CEST)
Date:   Wed, 10 Apr 2019 08:54:17 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Andy Lutomirski <luto@amacapital.net>,
        "H. Peter Anvin" <hpa@zytor.com>, Andi Kleen <andi@firstfloor.org>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        libc-alpha <libc-alpha@sourceware.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Carlos O'Donell <carlos@redhat.com>, x86 <x86@kernel.org>
Subject: Re: rseq/x86: choosing rseq code signature
Message-ID: <20190410065417.GU11158@hirez.programming.kicks-ass.net>
References: <11513896.2624.1554838336494.JavaMail.zimbra@efficios.com>
 <913288111.2663.1554842622822.JavaMail.zimbra@efficios.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <913288111.2663.1554842622822.JavaMail.zimbra@efficios.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 09, 2019 at 04:43:42PM -0400, Mathieu Desnoyers wrote:
> +/*
> + * RSEQ_SIG is used with the following privileged instructions, which trap in user-space:
> + * x86-32:    0f 01 3d 53 30 05 53      invlpg 0x53053053
> + * x86-64:    0f 01 3d 53 30 05 53      invlpg 0x53053053(%rip)
> + */

Right, and the alternative is: 0f b9 3d $SIG, which decodes to:

  UD1 $SIG(%rip),%edi

which will trap unconditionally. The only problem is that gas will not
actually assemble it, but since we're .byte coding it, it doesn't
matter.

UD1 is specified by both AMD and Intel to take a ModR/M, unlike UD0
where they disagree on the ModR/M.
