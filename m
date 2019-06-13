Return-Path: <SRS0=5wok=UM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD915C31E45
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 19:04:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8162F20B7C
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 19:04:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="f6vV0vy3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729552AbfFMTEN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Jun 2019 15:04:13 -0400
Received: from mail.skyhub.de ([5.9.137.197]:46406 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727334AbfFMTEK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jun 2019 15:04:10 -0400
Received: from zn.tnic (p200300EC2F06D500AC63EB441B910094.dip0.t-ipconnect.de [IPv6:2003:ec:2f06:d500:ac63:eb44:1b91:94])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id DD98D1EC0985;
        Thu, 13 Jun 2019 21:04:08 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1560452649;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=wNHnZ7FPLa+FExRIAsKFiqLYQi1EPxj5wKrhY0Ji1Cc=;
        b=f6vV0vy3VRSHop9unvz5GH7QSx31EAy5Vg0Lq+SpFCOCbU72ESacRb4SzP4Qqs9sPCihm7
        UWEfK9teXjBRD3q269ye9vQEhjKi9jGqMzkktXgz9uKJwInlUYvJrOrf1c7eeMM8nAPqUX
        UazvO/5oR1bsQFchZmJ5w/zZ9FAywz0=
Date:   Thu, 13 Jun 2019 21:03:59 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Christoph Hellwig <hch@lst.de>
Cc:     x86@kernel.org, Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/3] x86/fpu: don't use current->mm to check for a kthread
Message-ID: <20190613190359.GF11598@zn.tnic>
References: <20190604071524.12835-1-hch@lst.de>
 <20190604175411.GA27477@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190604175411.GA27477@lst.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 04, 2019 at 07:54:12PM +0200, Christoph Hellwig wrote:
> current->mm can be non-NULL if a kthread calls use_mm.  Check for
> PF_KTHREAD instead to decide when to store user mode FP state.
> 
> Fixes: 2722146eb784 ("x86/fpu: Remove fpu->initialized")
> Reported-by: Peter Zijlstra <peterz@infradead.org>
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  arch/x86/include/asm/fpu/internal.h | 6 +++---
>  arch/x86/kernel/fpu/core.c          | 3 ++-
>  2 files changed, 5 insertions(+), 4 deletions(-)

I had to take this one first because of the Fixes: tag and expedite it
through tip:x86/urgent. Check the tip-bot notification mail whether it
is still ok.

I'll redo the other ones ontop, or you can if you feel bored. :)

Thx.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
