Return-Path: <SRS0=2kAr=R3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7A80C43381
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Mar 2019 20:13:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7B8E72082F
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Mar 2019 20:13:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728878AbfCXUNW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 24 Mar 2019 16:13:22 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:44234 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726743AbfCXUNW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Mar 2019 16:13:22 -0400
Received: from p5492e2fc.dip0.t-ipconnect.de ([84.146.226.252] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1h89Uc-00060r-IC; Sun, 24 Mar 2019 21:13:19 +0100
Date:   Sun, 24 Mar 2019 21:13:18 +0100 (CET)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Josh Poimboeuf <jpoimboe@redhat.com>
cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        Andrea Arcangeli <aarcange@redhat.com>,
        Waiman Long <longman@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Jiri Kosina <jikos@kernel.org>
Subject: Re: [PATCH] cpu/hotplug: Create SMT sysfs interface for all arches
In-Reply-To: <426cde0f727f0cbadc501bb9bca8c99c4e11ac02.1551462051.git.jpoimboe@redhat.com>
Message-ID: <alpine.DEB.2.21.1903242104280.1798@nanos.tec.linutronix.de>
References: <426cde0f727f0cbadc501bb9bca8c99c4e11ac02.1551462051.git.jpoimboe@redhat.com>
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

On Fri, 1 Mar 2019, Josh Poimboeuf wrote:
> Make the /sys/devices/system/cpu/smt/* files available on all arches, so
> user space has a consistent way to detect whether SMT is enabled.
> 
> The 'control' file now shows 'notsupported' for architectures which
> don't yet have CONFIG_HOTPLUG_SMT.

I'm slowly crawling through my backlog ...

> --- a/Documentation/ABI/testing/sysfs-devices-system-cpu
> +++ b/Documentation/ABI/testing/sysfs-devices-system-cpu
> @@ -514,7 +514,8 @@ Description:	Control Symetric Multi Threading (SMT)
>  			 "on"		SMT is enabled
>  			 "off"		SMT is disabled
>  			 "forceoff"	SMT is force disabled. Cannot be changed.
> -			 "notsupported" SMT is not supported by the CPU
> +			 "notsupported" Runtime SMT toggling is not currently
> +					supported for the architecture

Second thoughts. I'm not really convinced that changing the meaning of
notsupported and in fact overloading it, is the right thing to do.
notsupported means now:

  CPU does not support it - OR - architecture does not support it

That's not pretty and we are surely not short of state space. There are
several options for handling this:

 1) Do not expose the state file, just expose the active file

 2) Expose the state file, but return -ENOTSUPP or some other sensible error
    code

 3) Expose the state file and let show return 'notimplemented' which is
    more accurate. That wouldn't even require to expand the state space
    enum. It just can be returned unconditionally.

Thanks,

	tglx
