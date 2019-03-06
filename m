Return-Path: <SRS0=vY9Y=RJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33D5EC43381
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 20:11:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0ED08205F4
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 20:11:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730493AbfCFULJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Mar 2019 15:11:09 -0500
Received: from Galois.linutronix.de ([146.0.238.70]:52222 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726540AbfCFULJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Mar 2019 15:11:09 -0500
Received: from p5492e2fc.dip0.t-ipconnect.de ([84.146.226.252] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1h1csc-00043m-I7; Wed, 06 Mar 2019 21:11:06 +0100
Date:   Wed, 6 Mar 2019 21:11:06 +0100 (CET)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Matthew Whitehead <tedheadster@gmail.com>
cc:     linux-kernel@vger.kernel.org, mingo@kernel.org, luto@kernel.org
Subject: Re: [PATCH] x86/CPU: Use correct macros for Cyrix calls on Geode
 processors
In-Reply-To: <1551902228-21319-1-git-send-email-tedheadster@gmail.com>
Message-ID: <alpine.DEB.2.21.1903062109200.1646@nanos.tec.linutronix.de>
References: <1551902228-21319-1-git-send-email-tedheadster@gmail.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Matthew,

On Wed, 6 Mar 2019, Matthew Whitehead wrote:

> There are comments in processor-cyrix.h advising you to _not_ make calls
> using the deprecated macros in this style:
> 
>   setCx86_old(CX86_CCR4, getCx86_old(CX86_CCR4) | 0x80);
> 
> This is because it expands the macro into a non-functioning calling
> sequence. The calling order must be:
> 
>   outb(CX86_CCR2, 0x22);
>   inb(0x23);
> 
> >From the comments:
> 
>  * When using the old macros a line like
>  *   setCx86(CX86_CCR2, getCx86(CX86_CCR2) | 0x88);
>  * gets expanded to:
>  *  do {
>  *    outb((CX86_CCR2), 0x22);
>  *    outb((({
>  *        outb((CX86_CCR2), 0x22);
>  *        inb(0x23);
>  *    }) | 0x88), 0x23);
>  *  } while (0);
> 
> The new macros fix this problem, so use them instead. Tested on an
> actual Geode processor.

Thanks for cleaning that up, but now the old macros are unused, so please
remove them entirely including the comment.

Thanks,

	tglx
