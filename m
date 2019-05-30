Return-Path: <SRS0=Dgga=T6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,T_DKIMWL_WL_HIGH autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 633A1C28CC0
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 21:12:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 369A0261BF
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 21:12:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1559250726;
	bh=lP/AL2XHGTjZcNzcRUYh2X8FQXSOs48hPUamSqXxOP4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=h0pJMnXikDbqzj4p+ab0rOk2HcyW4M9jarUvMqUmFUa+bVscjALGBaKk/4rKAhu45
	 Wml8Z8LKPq1LRMVvYvrgMsBHmlNbE0BwdR7fK1cqYB4FSSq4SvJ7+IrWLjUc7z4VtD
	 xgqoopfaZ3FmnSW6ArxPYIV2hg7L+eBMrdDakG4c=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726713AbfE3VMF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 May 2019 17:12:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:45760 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726308AbfE3VME (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 May 2019 17:12:04 -0400
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 38387261BF
        for <linux-kernel@vger.kernel.org>; Thu, 30 May 2019 21:12:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559250723;
        bh=lP/AL2XHGTjZcNzcRUYh2X8FQXSOs48hPUamSqXxOP4=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=KhPa1+Aobxxbc4xzN281oVWwID+PkLhtoIblGY8fPeOvnXJ8bZXovYmnkE8c2/ea8
         u6dIA0eUES39j0EHijAT++kLlJOrdo+WdwngPbIMSFj7JdbTo3NJTtz6W1zz+Gltg3
         DRmCmX4pO7Kb0GxOW3ar7Z8MoYA3kbelyxEou1JE=
Received: by mail-wr1-f45.google.com with SMTP id l2so5085449wrb.9
        for <linux-kernel@vger.kernel.org>; Thu, 30 May 2019 14:12:03 -0700 (PDT)
X-Gm-Message-State: APjAAAUQfuFpAGdsLZwfqXH+af/8fB2X7X2xax8zEEzEs0MHLqfqsu2T
        8wkYVeWXgeMATEUET7UtmNRyGcRU0V+2X2tfwWy5Cw==
X-Google-Smtp-Source: APXvYqxgjy1du6CD7sZnM42SLw6e1eNqsHX851g+KfYJVCBin9CX8WxCbXSjhE2NtLKWy3zwtRa3graFyAhOVvBQgGk=
X-Received: by 2002:a5d:610e:: with SMTP id v14mr3924626wrt.343.1559250721829;
 Thu, 30 May 2019 14:12:01 -0700 (PDT)
MIME-Version: 1.0
References: <1558742162-73402-1-git-send-email-fenghua.yu@intel.com> <1558742162-73402-5-git-send-email-fenghua.yu@intel.com>
In-Reply-To: <1558742162-73402-5-git-send-email-fenghua.yu@intel.com>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Thu, 30 May 2019 14:11:48 -0700
X-Gmail-Original-Message-ID: <CALCETrXTZq5bbVv8vGoV0H5tgXpxSnC2pdZgi-Ob_0WwWhWdHA@mail.gmail.com>
Message-ID: <CALCETrXTZq5bbVv8vGoV0H5tgXpxSnC2pdZgi-Ob_0WwWhWdHA@mail.gmail.com>
Subject: Re: [PATCH v3 4/5] x86/umwait: Add sysfs interface to control umwait
 maximum time
To:     Fenghua Yu <fenghua.yu@intel.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        H Peter Anvin <hpa@zytor.com>,
        Andrew Cooper <andrew.cooper3@citrix.com>,
        Ashok Raj <ashok.raj@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Ravi V Shankar <ravi.v.shankar@intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>, x86 <x86@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 24, 2019 at 5:05 PM Fenghua Yu <fenghua.yu@intel.com> wrote:
>
> IA32_UMWAIT_CONTROL[31:2] determines the maximum time in TSC-quanta
> that processor can stay in C0.1 or C0.2. A zero value means no maximum
> time.
>
> Each instruction sets its own deadline in the instruction's implicit
> input EDX:EAX value. The instruction wakes up if the time-stamp counter
> reaches or exceeds the specified deadline, or the umwait maximum time
> expires, or a store happens in the monitored address range in umwait.
>
> Users can write an unsigned 32-bit number to
> /sys/devices/system/cpu/umwait_control/max_time to change the default
> value. Note that a value of zero means there is no limit. Low order
> two bits are ignored.
>
> Signed-off-by: Fenghua Yu <fenghua.yu@intel.com>
> Reviewed-by: Ashok Raj <ashok.raj@intel.com>
> Reviewed-by: Tony Luck <tony.luck@intel.com>
> ---
>  arch/x86/power/umwait.c | 37 +++++++++++++++++++++++++++++++++++++
>  1 file changed, 37 insertions(+)
>
> diff --git a/arch/x86/power/umwait.c b/arch/x86/power/umwait.c
> index cf5de7e1cc24..61076aad7138 100644
> --- a/arch/x86/power/umwait.c
> +++ b/arch/x86/power/umwait.c
> @@ -103,8 +103,45 @@ static ssize_t enable_c0_2_store(struct device *dev,
>  }
>  static DEVICE_ATTR_RW(enable_c0_2);
>
> +static ssize_t
> +max_time_show(struct device *kobj, struct device_attribute *attr, char *buf)
> +{
> +       return sprintf(buf, "%u\n", umwait_max_time);
> +}
> +
> +static ssize_t max_time_store(struct device *kobj,
> +                             struct device_attribute *attr,
> +                             const char *buf, size_t count)
> +{
> +       u32 max_time;
> +       int ret;
> +
> +       ret = kstrtou32(buf, 0, &max_time);
> +       if (ret)
> +               return ret;
> +
> +       mutex_lock(&umwait_lock);
> +
> +       /* Only get max time value from bits[31:2] */
> +       max_time &= MSR_IA32_UMWAIT_CONTROL_MAX_TIME;

I think you should error out if high bits are set.  I'm okay with
masking off low bits, except that an input of 1 should not turn into
0, since 0 is special IIRC.
