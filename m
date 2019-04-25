Return-Path: <SRS0=Q+aa=S3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F090C43219
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 18:18:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E03D620717
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 18:18:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="a2ZfRHVi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730410AbfDYSR7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Apr 2019 14:17:59 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:53528 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727120AbfDYSR6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Apr 2019 14:17:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=tRoNJ8c4cbN57uzpVjJsLti1b65Ha0XS4q1OKT5SUhc=; b=a2ZfRHViaari4YLFzrqFZ4Xcv
        pPtn0t/Ikwnz+zDeTwk5ZwWrGRVlT58S1XUXFSR8UgdTWRWewHdmfi4Subbyk8BKZwyNIG9unYqRE
        ALVHeVhS1e7uwc9LiONexeLx6a1SPYdmNRcLVe9GKIvDolsrpFXatNsNNIdTw21e/BJU5Dzhgy5ka
        2lkgXtDWh8vQ0B1s4dKgSvZ/lZT23l0RSn0J3QDJjFMaHw2aIPTeZ+Ug3Pe6X1dqSAuPRxjAc55Yb
        zKoCB0V6hKaeSVzY626itIKuX52IEH2PzF9nn3cwyYwucKNtPk/jTGTHqzLOiQgxvd7UEy1pISpqQ
        iPcq7BOgw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hJiwK-0008P9-UW; Thu, 25 Apr 2019 18:17:45 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id E5895203C072C; Thu, 25 Apr 2019 20:17:42 +0200 (CEST)
Date:   Thu, 25 Apr 2019 20:17:42 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Rick Edgecombe <rick.p.edgecombe@intel.com>
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
        Nadav Amit <namit@vmware.com>
Subject: Re: [PATCH v4 04/23] x86/mm: Save DRs when loading a temporary mm
Message-ID: <20190425181742.GZ11158@hirez.programming.kicks-ass.net>
References: <20190422185805.1169-1-rick.p.edgecombe@intel.com>
 <20190422185805.1169-5-rick.p.edgecombe@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190422185805.1169-5-rick.p.edgecombe@intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 22, 2019 at 11:57:46AM -0700, Rick Edgecombe wrote:
> From: Nadav Amit <namit@vmware.com>
> 
> Prevent user watchpoints from mistakenly firing while the temporary mm
> is being used. As the addresses that of the temporary mm might overlap
> those of the user-process, this is necessary to prevent wrong signals
> or worse things from happening.

Ooh, goody, that would be fun indeed.

> Cc: Andy Lutomirski <luto@kernel.org>

Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>

> Signed-off-by: Nadav Amit <namit@vmware.com>
> Signed-off-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
