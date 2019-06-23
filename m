Return-Path: <SRS0=hO5d=UX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F2BBC43613
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 03:02:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4DFE92073F
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 03:02:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727287AbfFXDBn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 23 Jun 2019 23:01:43 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:34569 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726323AbfFXDBl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Jun 2019 23:01:41 -0400
Received: from p5b06daab.dip0.t-ipconnect.de ([91.6.218.171] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1hfBA2-0007QU-DG; Mon, 24 Jun 2019 00:40:35 +0200
Date:   Mon, 24 Jun 2019 00:40:33 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Fenghua Yu <fenghua.yu@intel.com>
cc:     Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        H Peter Anvin <hpa@zytor.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ashok Raj <ashok.raj@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Ravi V Shankar <ravi.v.shankar@intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>, x86 <x86@kernel.org>
Subject: Re: [PATCH v5 4/5] x86/umwait: Add sysfs interface to control umwait
 maximum time
In-Reply-To: <1560994438-235698-5-git-send-email-fenghua.yu@intel.com>
Message-ID: <alpine.DEB.2.21.1906232246380.32342@nanos.tec.linutronix.de>
References: <1560994438-235698-1-git-send-email-fenghua.yu@intel.com> <1560994438-235698-5-git-send-email-fenghua.yu@intel.com>
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

On Wed, 19 Jun 2019, Fenghua Yu wrote:

> Users can write an unsigned 32-bit number to
> /sys/devices/system/cpu/umwait_control/max_time to change the default

Users? Administrators can. Users NOT.

> value. Note that a value of zero means there is no limit. Low order
> two bits must be zero.

...

> +static ssize_t max_time_store(struct device *kobj,
> +			      struct device_attribute *attr,
> +			      const char *buf, size_t count)
> +{
> +	u32 max_time;
> +	int ret;
> +
> +	ret = kstrtou32(buf, 0, &max_time);
> +	if (ret)
> +		return ret;
> +
> +	/* bits[1:0] must be zero */
> +	if (max_time & ~MSR_IA32_UMWAIT_CONTROL_MAX_TIME)
> +		return -EINVAL;
> +
> +	mutex_lock(&umwait_lock);
> +
> +	if (max_time == get_umwait_ctrl_max_time())
> +		goto out_unlock;
> +
> +	WRITE_ONCE(umwait_control_cached,
> +		   UMWAIT_CTRL_VAL(max_time, get_umwait_ctrl_c02()));

Same convoluted logic with reading the cached value twice to confuse the
reader.

	ctrl = READ_ONCE(umwait_control_cached);
	if (max_time == umwait_ctrl_max_time(ctrl))
		goto out_unlock;

	ctrl = (ctrl & ~MSR_IA32_UMWAIT_CONTROL_TIME_MASK) | max_time;
	WRITE_ONCE(umwait_control_cached, ctrl);

Simple, right?

But this can be done even simpler with a shared update function:

static void umwait_update_control(u32 maxtime, bool c02_enable)
{
        u32 ctrl = maxtime & MSR_IA32_UMWAIT_CONTROL_TIME_MASK;

        if (!c02_enable)
                ctrl |= MSR_IA32_UMWAIT_CONTROL_C02_DISABLE;

        WRITE_ONCE(umwait_control_cached, ctrl);
        /* Propagate to all CPUs */
        on_each_cpu(umwait_update_control_msr, NULL, 1);
}

With that both functions become trivial and do not have duplicated code.

Thanks,

	tglx
