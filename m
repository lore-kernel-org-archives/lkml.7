Return-Path: <SRS0=EIds=SH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6031C282CE
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 21:59:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 70EAB20989
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 21:59:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726512AbfDEV75 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Apr 2019 17:59:57 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:50002 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726124AbfDEV75 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Apr 2019 17:59:57 -0400
Received: from p5492e2fc.dip0.t-ipconnect.de ([84.146.226.252] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1hCWsN-0005hH-82; Fri, 05 Apr 2019 23:59:55 +0200
Date:   Fri, 5 Apr 2019 23:59:54 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Borislav Petkov <bp@alien8.de>
cc:     LKML <linux-kernel@vger.kernel.org>, Jann Horn <jannh@google.com>,
        X86 ML <x86@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>,
        Ingo Molnar <mingo@redhat.com>
Subject: Re: [PATCH 1/3] x86/microcode/intel: Refactor Intel microcode blob
 loading
In-Reply-To: <20190405133010.24249-2-bp@alien8.de>
Message-ID: <alpine.DEB.2.21.1904052359390.1802@nanos.tec.linutronix.de>
References: <20190405133010.24249-1-bp@alien8.de> <20190405133010.24249-2-bp@alien8.de>
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

On Fri, 5 Apr 2019, Borislav Petkov wrote:

> From: Jann Horn <jannh@google.com>
> 
> Change generic_load_microcode() to use the iov_iter API instead of a
> clumsy open-coded version which has to pay attention to __user data
> or kernel data, depending on the loading method. This allows to avoid
> explicit casting between user and kernel pointers.
> 
> Because the iov_iter API makes it hard to read the same location twice,
> as a side effect, also fix a double-read of the microcode header (which
> could e.g. lead to out-of-bounds reads in microcode_sanity_check()).
> 
> Not that it matters much, only root is allowed to load microcode
> anyway...

Nice!

Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
