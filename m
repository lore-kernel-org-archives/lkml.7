Return-Path: <SRS0=yZjE=R4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4690C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 12:04:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7805720850
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 12:04:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553515494;
	bh=IR+cbQ8mnrWFq8xpCaCR8PXo9cK5AuCR3YrwCH+2Wt4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=FaCe2Z3ptZPwdwEiHKsa/8a4007peBh39n56eOV4PBiwWX81bg5zihJeOMsiCpWmC
	 50tGLdxqCTaK3M5kzkfvTei6bthstEHTm1zUhhlWh4nBmpVmohSGMKlhjZ9Ny/HsYr
	 06fpspugE1UEUY0kiTspTdJ4g8/jFvoL/wMURWmw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731100AbfCYMEx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Mar 2019 08:04:53 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:35089 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730982AbfCYMEx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Mar 2019 08:04:53 -0400
Received: by mail-ot1-f68.google.com with SMTP id m10so145581otp.2;
        Mon, 25 Mar 2019 05:04:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7nY9vNYAgSpHMFFX6XJ2cHnkwlh6W9iRY1aPPy39XCk=;
        b=V6TyTMrASZe2EHX2zik4/vGVNEzr9kwNO7FTrRvpPZkqHDOCL2935Cxq9VgUdseG27
         ikdPKFMQaIcbcDdZbfCTNk0SwyZu9iin/l7XopM7HIb7fdGvGzpkLr504TBGhK589VPU
         r5gJ1n21ePyp449bCMDzGiIGyfZFFjVUTvmI2Oabdl0InGlSz+SrwED3KxuG50E68/9n
         5r7fn7ZiFxmMW//q058Vlc9W86eLb6TCqMmyh4b5QoEsdxmnBh3TrJ7FsMtJBGh4/KCZ
         GnY7WaHgNBNDHo0u+0woQ45u9pfeerYwUqb7V1+RWjciWox3EsfntCg501P6IsGfg+Ze
         7yLg==
X-Gm-Message-State: APjAAAWKPxJzO0RMjvTd9Hrvl/5dGxRwKYQQNYIN2uP/gxtihcXCSesH
        8ooeotiB4Bg74ja5+Lf8faiHoNztXpW2gS1e4HM=
X-Google-Smtp-Source: APXvYqzyOk5zOTR09x7smwi+rtco3aXsuoq5e2jUgvcbb5gsmAi47O6AL9qsVWy+Uf/ynZBmWxOWYgKkOwZAh5iOqkg=
X-Received: by 2002:a9d:36a:: with SMTP id 97mr16616242otv.124.1553515492247;
 Mon, 25 Mar 2019 05:04:52 -0700 (PDT)
MIME-Version: 1.0
References: <20190322224520.6740-1-srinivas.pandruvada@linux.intel.com> <20190322224520.6740-3-srinivas.pandruvada@linux.intel.com>
In-Reply-To: <20190322224520.6740-3-srinivas.pandruvada@linux.intel.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 25 Mar 2019 13:04:41 +0100
Message-ID: <CAJZ5v0ii-Q_w-6gPaz75+=7hKoZSv50gdCDk78DyA1BCwQ+jyA@mail.gmail.com>
Subject: Re: [PATCH 2/2] cpufreq: intel_pstate: Also use cppc nominal_perf for base_frequency
To:     Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Prashanth Prakash <pprakash@codeaurora.org>,
        Xiongfeng Wang <wangxiongfeng2@huawei.com>,
        "4 . 20+" <stable@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 22, 2019 at 11:45 PM Srinivas Pandruvada
<srinivas.pandruvada@linux.intel.com> wrote:
>
> ACPI specifications stat that if the "Guaranteed Performance Register" is
> not implemented, OSPM assumes guaranteed performance is always equal to
> nominal performance. So for invalid and unimplemented guaranteed
> performance register, use nominal performance as guaranteed performance.
>
> This change will fallback to nominal_perf when guranteed_perf is invalid.
> If nominal_perf is also invalid, then fallback to existing implementation,
> which is to read from HWP Capabilities MSR.
>
> Fixes: 86d333a8cc7f ("cpufreq: intel_pstate: Add base_frequency attribute")
> Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
> Cc: 4.20+ <stable@vger.kernel.org> # 4.20+
> ---
>  drivers/cpufreq/intel_pstate.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/drivers/cpufreq/intel_pstate.c b/drivers/cpufreq/intel_pstate.c
> index 7b4b0a7ac68b..e16dea241c55 100644
> --- a/drivers/cpufreq/intel_pstate.c
> +++ b/drivers/cpufreq/intel_pstate.c
> @@ -385,6 +385,9 @@ static int intel_pstate_get_cppc_guranteed(int cpu)
>         if (ret)
>                 return ret;
>
> +       if (!cppc_perf.guaranteed_perf)
> +               return cppc_perf.nominal_perf;
> +
>         return cppc_perf.guaranteed_perf;
>  }

I would do this the other way around, that is

if (cppc_perf.guaranteed_perf)
        return cppc_perf.guaranteed_perf;

return cppc_perf.nominal_perf;

That is slightly easier to follow IMO.
