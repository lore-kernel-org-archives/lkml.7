Return-Path: <SRS0=sd1o=XD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D57DEC4332F
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Sep 2019 06:27:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A55E3214DB
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Sep 2019 06:27:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (4096-bit key) header.d=kolabnow.com header.i=@kolabnow.com header.b="k7HMG2uG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727793AbfIHG1F (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 8 Sep 2019 02:27:05 -0400
Received: from mx.kolabnow.com ([95.128.36.42]:7426 "EHLO mx.kolabnow.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725787AbfIHG1F (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Sep 2019 02:27:05 -0400
Received: from localhost (unknown [127.0.0.1])
        by ext-mx-out001.mykolab.com (Postfix) with ESMTP id 4CEDC55C;
        Sun,  8 Sep 2019 08:27:03 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kolabnow.com; h=
        content-type:content-type:content-transfer-encoding:mime-version
        :references:in-reply-to:message-id:date:date:subject:subject
        :from:from:received:received:received; s=dkim20160331; t=
        1567924022; x=1569738423; bh=loMIHDDy1oxTCVSwj4XybWzWNEfOxw9dOex
        0dta1oSM=; b=k7HMG2uGGvIhtmuqKZsnUsM2+oDrz9NwVq1iuUC+OacaBKgtDpP
        axLA6S7Tc9sofqvTTxU97FG4bevwoJdrZxhc/d3K8y8gffTEoSLRJ1S+tv4UTluy
        lm8Lt90ajCaeCAIMhDp3md/KhhcoZ7DqWXlm9LoTaB3JIf9ui8+QbAKRUzFg5z9k
        tXpX0m8Qx7MPsNPm2AfVB/rO2w5nbeQpp/mXVsAJnq8L8AK8d6/307BrkEsmbD9l
        3ibajXbZ7aeMWG7u6f87f+JTjZ6E17WWNpd37kXRnDeVldAZd/BCpY8SfF6TL1Gd
        21GvwmevjWmkNCGiwfp1jO7PBKyYP2ULt91E91zjF+bZw6xgKrK04Mwxsmv/qhHn
        YbiJLJ2lBW23nsdbxMdxMVtHUtFPzXUf86GkL+uTxWhw5uDar4fDZWfWtTt+Lmgs
        utXGUdHWqLGVS9K8tfC9TJImVVugvhkoFu5bRxdZEPL3lQBMPUK+7x0CAipuvBj+
        /78BQ5O+iacEnSQSwkfB0x8HY0mcpy1mL3qwynk2wUHyGkVkU13Z7sd52XP/XxLB
        VvfVQXoqY84MoKQIIYisK/rXpe6yNMYhyB+myeku2hVB670Mx0pyTkhg/eDvspY1
        2QbDa6taMjhMqGWWjdLi0x9GahDCY2N/GsxlKEu0Z9gGk9pU7RMgNYwY=
X-Virus-Scanned: amavisd-new at mykolab.com
Received: from mx.kolabnow.com ([127.0.0.1])
        by localhost (ext-mx-out001.mykolab.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id m9IlTzeRscVp; Sun,  8 Sep 2019 08:27:02 +0200 (CEST)
Received: from int-mx001.mykolab.com (unknown [10.9.13.1])
        by ext-mx-out001.mykolab.com (Postfix) with ESMTPS id BFB663FE;
        Sun,  8 Sep 2019 08:27:02 +0200 (CEST)
Received: from ext-subm002.mykolab.com (unknown [10.9.6.2])
        by int-mx001.mykolab.com (Postfix) with ESMTPS id 60CED174B;
        Sun,  8 Sep 2019 08:27:02 +0200 (CEST)
From:   Federico Vaga <federico.vaga@vaga.pv.it>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH v2] doc:lock: remove reference to clever use of read-write lock
Date:   Sun, 08 Sep 2019 08:27:00 +0200
Message-ID: <9118016.19PSEFGOkz@harkonnen>
In-Reply-To: <20190907104841.18928-1-federico.vaga@vaga.pv.it>
References: <20190907104841.18928-1-federico.vaga@vaga.pv.it>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ignore this, the commit message is incorrect. I am sending a V3

On Saturday, September 7, 2019 12:48:41 PM CEST Federico Vaga wrote:
> Remove the clever example about read-write lock because these type of
> lock is not reccomended anymore (according to the very same document).
> So there is no reason to teach cleaver things that people should not do.
> 
> (and by the way there was a little typo)
> 
> Signed-off-by: Federico Vaga <federico.vaga@vaga.pv.it>
> ---
>  Documentation/locking/spinlocks.rst | 12 ------------
>  1 file changed, 12 deletions(-)
> 
> diff --git a/Documentation/locking/spinlocks.rst
> b/Documentation/locking/spinlocks.rst index e93ec6645238..66e3792f8a36
> 100644
> --- a/Documentation/locking/spinlocks.rst
> +++ b/Documentation/locking/spinlocks.rst
> @@ -139,18 +139,6 @@ on other CPU's, because an interrupt on another CPU
> doesn't interrupt the CPU that holds the lock, so the lock-holder can
> continue and eventually releases the lock).
> 
> -Note that you can be clever with read-write locks and interrupts. For
> -example, if you know that the interrupt only ever gets a read-lock, then
> -you can use a non-irq version of read locks everywhere - because they
> -don't block on each other (and thus there is no dead-lock wrt interrupts.
> -But when you do the write-lock, you have to use the irq-safe version.
> -
> -For an example of being clever with rw-locks, see the "waitqueue_lock"
> -handling in kernel/sched/core.c - nothing ever _changes_ a wait-queue from
> -within an interrupt, they only read the queue in order to know whom to
> -wake up. So read-locks are safe (which is good: they are very common
> -indeed), while write-locks need to protect themselves against interrupts.
> -
>  		Linus
> 
>  ----




