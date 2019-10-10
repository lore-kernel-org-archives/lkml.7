Return-Path: <SRS0=5y3R=YD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67587ECE58E
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Oct 2019 06:53:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 40CEB218AC
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Oct 2019 06:53:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vaa/hrOu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733009AbfJJGxG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Oct 2019 02:53:06 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:41615 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727207AbfJJGxF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Oct 2019 02:53:05 -0400
Received: by mail-pf1-f193.google.com with SMTP id q7so3248769pfh.8
        for <linux-kernel@vger.kernel.org>; Wed, 09 Oct 2019 23:53:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=1tog4qOu28aA6MBUMyxcFn0XIhdAFDQXw6a1PcMV9YQ=;
        b=vaa/hrOuOtWmZoqekcNT/l2sNwCQcdVYJi0jw8jleaHfe3O8hcZqvuziiDv8hxM8Yi
         YGec/XSJmMvcTHvTxqxz2pQ5RA2eKyTLO48Ozj+Alv/FzGWW+qg4oZekR1irnnnI5LBp
         7Gkf68L5z/Hjh2979LubA5/jsC4cjONNKa+sewFyYm0qkbq+Oliut0uZXkQCDQJFi6bu
         SynjqkTnRwxofYY8ZEXYCtJlMWcKN//VdmUfELu8593kDCXDtNGYI13FQ1kk6Gjb3EFT
         5MFlP0YhUvPoNENnFSJgH+PeN9n+qYxI9FdyGdyLIIe7ArPJON201fbBck6Yd3/x405X
         AM9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=1tog4qOu28aA6MBUMyxcFn0XIhdAFDQXw6a1PcMV9YQ=;
        b=k3pz9ZJKCIDW5t8unYuHvxnhkQ+B6o+BuEl5rRDuLOs8eILgcntGeO/tAR1EhNSSjM
         MONxHkyrhg6ZdEEcv0Z2UBaByfiY8upiq+F6loF/IexJQcRBv+C10KQW6hakuNzssGve
         dJXKzmpzKj6e2Gavcu6mxRIiom3onnQoH41f24bo8N1cji+Ul+iMch84giSiFpRnx4mK
         QugLspp5AcXFceKDrquO2DIoJLiXvGn9Xg6vRmFwAIU2trSLdo44p0rV5SuNd0bK6DGH
         e99S4NsWiKFhZj34gF05aIr98sXRqol9I6tzDutefYTHcPFcBnKsifRaEO4t1YSgkEGV
         W5PA==
X-Gm-Message-State: APjAAAWQ8LNLL6saOJw3I2VtlCSOTt++CfPwZLbSJQhsi8rDBNptMS5k
        gKklYg3vWeY/XDtqSUhNIC/KLg==
X-Google-Smtp-Source: APXvYqxU20oqFB5TOhSKMaCwUM9mTTrvoKhEEwkYaAntasBDVIqDyOcWBnmY3OgD603MRBU9wdOBAg==
X-Received: by 2002:a17:90b:914:: with SMTP id bo20mr9126322pjb.6.1570690384766;
        Wed, 09 Oct 2019 23:53:04 -0700 (PDT)
Received: from localhost ([122.172.151.112])
        by smtp.gmail.com with ESMTPSA id 16sm4121658pfi.55.2019.10.09.23.53.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 09 Oct 2019 23:53:04 -0700 (PDT)
Date:   Thu, 10 Oct 2019 12:23:02 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     Linux PM <linux-pm@vger.kernel.org>,
        Ville =?utf-8?B?U3lyasOkbMOk?= <ville.syrjala@linux.intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Stable <stable@vger.kernel.org>,
        "Paul E . McKenney" <paulmck@linux.vnet.ibm.com>,
        Andi Kleen <ak@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH] cpufreq: Avoid cpufreq_suspend() deadlock on system
 shutdown
Message-ID: <20191010065302.ltdngpfqzpj3gxjr@vireshk-i7>
References: <20191003140828.14801-1-ville.syrjala@linux.intel.com>
 <20191004123026.GU1208@intel.com>
 <CAJZ5v0hsiyKfVcDFbnJKqDkCKWhbSfNrmm7yVhudONuS0SWALw@mail.gmail.com>
 <10202295.pfq90QWH5T@kreacher>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <10202295.pfq90QWH5T@kreacher>
User-Agent: NeoMutt/20180716-391-311a52
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09-10-19, 01:29, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> It is incorrect to set the cpufreq syscore shutdown callback pointer
> to cpufreq_suspend(), because that function cannot be run in the
> syscore stage of system shutdown for two reasons: (a) it may attempt
> to carry out actions depending on devices that have already been shut
> down at that point and (b) the RCU synchronization carried out by it
> may not be able to make progress then.
> 
> The latter issue has been present since commit 45975c7d21a1 ("rcu:
> Define RCU-sched API in terms of RCU for Tree RCU PREEMPT builds"),
> but the former one has always been there regardless.
> 
> Fix that by dropping cpufreq_syscore_ops altogether and making
> device_shutdown() call cpufreq_suspend() directly before shutting
> down devices, which is along the lines of what system-wide power
> management does.
> 
> Fixes: 45975c7d21a1 ("rcu: Define RCU-sched API in terms of RCU for Tree RCU PREEMPT builds")
> Reported-by: Ville Syrjälä <ville.syrjala@linux.intel.com>
> Tested-by: Ville Syrjälä <ville.syrjala@linux.intel.com>
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
>  drivers/base/core.c       |    3 +++
>  drivers/cpufreq/cpufreq.c |   10 ----------
>  2 files changed, 3 insertions(+), 10 deletions(-)

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
