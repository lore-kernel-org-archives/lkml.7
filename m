Return-Path: <SRS0=LLNM=ZF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44AD2C43331
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Nov 2019 09:04:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1D21921A49
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Nov 2019 09:04:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727032AbfKMJEV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Nov 2019 04:04:21 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:36972 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726086AbfKMJEV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Nov 2019 04:04:21 -0500
Received: from p5b06da22.dip0.t-ipconnect.de ([91.6.218.34] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1iUoZT-0006K4-Gd; Wed, 13 Nov 2019 10:04:15 +0100
Date:   Wed, 13 Nov 2019 10:04:14 +0100 (CET)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     "Harris, Robert" <robert.harris@alertlogic.com>
cc:     Ingo Molnar <mingo@kernel.org>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "dvhart@infradead.org" <dvhart@infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: Help requested: futex(..., FUTEX_WAIT_PRIVATE, ...) returns
 EPERM
In-Reply-To: <E0332978-739B-4546-9C3F-975216C349D2@alertlogic.com>
Message-ID: <alpine.DEB.2.21.1911130956150.1833@nanos.tec.linutronix.de>
References: <E0332978-739B-4546-9C3F-975216C349D2@alertlogic.com>
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

On Tue, 12 Nov 2019, Harris, Robert wrote:

> I am investigating an issue on 4.9.184 in which futex() returns EPERM
> intermittently for
> 
> futex(uaddr, FUTEX_WAIT_PRIVATE, val, &timeout, NULL, 0)
> 
> The failure affects an application in an AWS lambda;  traditional
> debugging approaches vary from difficult to impossible.  I cannot
> reproduce the problem at will, instrument the kernel, install a new
> kernel or get an application core dump.
> 
> Understanding the circumstances under which EPERM can be returned for
> FUTEX_WAIT_PRIVATE would be useful but it is not a documented failure
> mode.  I have spent some time looking through futex.c but have not
> found anything yet.  I would be grateful for a hint from someone more
> knowledgeable.

sys_futex(FUTEX_WAIT_PRIVATE) does not return -EPERM. Only the PI variants
do that.

Thanks,

	tglx
