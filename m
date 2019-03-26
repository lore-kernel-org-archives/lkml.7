Return-Path: <SRS0=4nbc=R5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A1DBC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 18:35:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3A48520700
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 18:35:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732486AbfCZSfB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Mar 2019 14:35:01 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:49088 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731467AbfCZSfB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Mar 2019 14:35:01 -0400
Received: from p5492e2fc.dip0.t-ipconnect.de ([84.146.226.252] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1h8quY-0003ok-79; Tue, 26 Mar 2019 19:34:58 +0100
Date:   Tue, 26 Mar 2019 19:34:57 +0100 (CET)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Josh Poimboeuf <jpoimboe@redhat.com>
cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        Andrea Arcangeli <aarcange@redhat.com>,
        Waiman Long <longman@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Jiri Kosina <jikos@kernel.org>
Subject: Re: [PATCH] cpu/hotplug: Create SMT sysfs interface for all arches
In-Reply-To: <20190326180348.fzerpltlf62dnurd@treble>
Message-ID: <alpine.DEB.2.21.1903261934280.1789@nanos.tec.linutronix.de>
References: <426cde0f727f0cbadc501bb9bca8c99c4e11ac02.1551462051.git.jpoimboe@redhat.com> <alpine.DEB.2.21.1903242104280.1798@nanos.tec.linutronix.de> <20190326133236.lylrrbacznezybjm@treble> <alpine.DEB.2.21.1903261452290.1789@nanos.tec.linutronix.de>
 <20190326180348.fzerpltlf62dnurd@treble>
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

On Tue, 26 Mar 2019, Josh Poimboeuf wrote:
> On Tue, Mar 26, 2019 at 02:53:04PM +0100, Thomas Gleixner wrote:
> > > Makes sense.  I like #3.  I can post another version.
> > 
> > Yes, please.
> 
> Something like so (on top of the original patch)?
> 
> diff --git a/Documentation/ABI/testing/sysfs-devices-system-cpu b/Documentation/ABI/testing/sysfs-devices-system-cpu
> index 4a11cba73085..5eea46fefcb2 100644
> --- a/Documentation/ABI/testing/sysfs-devices-system-cpu
> +++ b/Documentation/ABI/testing/sysfs-devices-system-cpu
> @@ -511,11 +511,12 @@ Description:	Control Symetric Multi Threading (SMT)
>  		control: Read/write interface to control SMT. Possible
>  			 values:
>  
> -			 "on"		SMT is enabled
> -			 "off"		SMT is disabled
> -			 "forceoff"	SMT is force disabled. Cannot be changed.
> -			 "notsupported" Runtime SMT toggling is not currently
> -					supported for the architecture
> +			 "on"		  SMT is enabled
> +			 "off"		  SMT is disabled
> +			 "forceoff"	  SMT is force disabled. Cannot be changed.
> +			 "notsupported"   SMT is not supported by the CPU
> +			 "notimplemented" SMT runtime toggling is not
> +					  implemented for the architecture
>  
>  			 If control status is "forceoff" or "notsupported" writes
>  			 are rejected.
> diff --git a/kernel/cpu.c b/kernel/cpu.c
> index 517ab1803a22..05a71ee98440 100644
> --- a/kernel/cpu.c
> +++ b/kernel/cpu.c
> @@ -2145,7 +2145,11 @@ static const char *smt_states[] = {
>  static ssize_t
>  show_smt_control(struct device *dev, struct device_attribute *attr, char *buf)
>  {
> -	return snprintf(buf, PAGE_SIZE - 2, "%s\n", smt_states[cpu_smt_control]);
> +	const char *state = IS_ENABLED(CONFIG_HOTPLUG_SMT) ?
> +				smt_states[cpu_smt_control] :
> +				"notimplemented";
> +
> +	return snprintf(buf, PAGE_SIZE - 2, "%s\n", state);
>  }

Looks good!

Thanks,

	tglx
