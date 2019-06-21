Return-Path: <SRS0=s1fu=UU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13945C43613
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Jun 2019 17:19:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E249E2070B
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Jun 2019 17:19:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726080AbfFURTY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Jun 2019 13:19:24 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:55496 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725985AbfFURTY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jun 2019 13:19:24 -0400
Received: from p5b06daab.dip0.t-ipconnect.de ([91.6.218.171] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1heNC4-0002RK-SJ; Fri, 21 Jun 2019 19:19:21 +0200
Date:   Fri, 21 Jun 2019 19:19:20 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Zhenzhong Duan <zhenzhong.duan@oracle.com>
cc:     linux-kernel@vger.kernel.org, mingo@kernel.org, bp@alien8.de,
        x86@kernel.org, hpa@zytor.com, jgross@suse.com,
        ndesaulniers@google.com, gregkh@linuxfoundation.org,
        srinivas.eeda@oracle.com
Subject: Re: [PATCH] x86/speculation/mds: Flush store buffer after wake up
 from sleep
In-Reply-To: <1561011237-12312-1-git-send-email-zhenzhong.duan@oracle.com>
Message-ID: <alpine.DEB.2.21.1906211916000.5503@nanos.tec.linutronix.de>
References: <1561011237-12312-1-git-send-email-zhenzhong.duan@oracle.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 19 Jun 2019, Zhenzhong Duan wrote:

> Intel document says: "When a thread wakes from a sleep state, the store
> buffer is repartitioned again. This causes the store buffer to transfer
> store buffer entries from the thread that was already active to the one
> which just woke up."
> 
> To avoid data leak from sibling thread to the woken thread, flush store
> buffer right after wake up.

That's a pointless exercise. The buffers are flushed again when returning
to user space. Inside the kernel the potential leak is completely
uninteresting unless you consider the kernel as a malicious entity.
 
> Move mds_idle_clear_cpu_buffers() after trace_hardirqs_on() to ensure
> all store buffer entries are flushed before sleep.

I'm fine with that change, albeit trace_hardirqs_on() is hardly leaking
somethimg interesting.

Thanks,

	tglx
