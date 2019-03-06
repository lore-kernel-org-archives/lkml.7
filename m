Return-Path: <SRS0=vY9Y=RJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6999C43381
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 11:01:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 767F8206DD
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 11:01:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="wby4Qrr/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730268AbfCFLBq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Mar 2019 06:01:46 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:36257 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730257AbfCFLBp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Mar 2019 06:01:45 -0500
Received: by mail-pg1-f193.google.com with SMTP id r124so8134712pgr.3
        for <linux-kernel@vger.kernel.org>; Wed, 06 Mar 2019 03:01:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=n1tgyXH5l4YP6OyUorpmVFltlSvMdZOpP8r+ig6hKuk=;
        b=wby4Qrr/UskjPLezyTYM4agRNmDZR0Yl9IYjgLLS9zaoQ4IBSL5Q8c+ycocZ1ef/79
         EYd/J5gQWZnMbYEhgOko+zPfEd/mpmlcRGhlOgfO5IRkx5qjYRd8GnZb0Hd07z5VJwUl
         v3H9I/QHR+ejmjtnHlOxX+VB+U6yENjFqXTQWJV1tiv1AxvM7i7my2Rcfkwb3SiN+YNR
         4NtPIAyDV+2J1uaI5qeptQdMrOC3QVHJRgayIJ1/JHgo1LFyJR1SWNyuE+683mZCIHEG
         +gzTRWxiuMuvCTQ/djBFgATNucAGyTwjWSYekNmkqVktHaI4sTbFsEGuovofPsksXGKQ
         xNMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=n1tgyXH5l4YP6OyUorpmVFltlSvMdZOpP8r+ig6hKuk=;
        b=a17gs3DlSy552QpskX0+6NBwgW9Jh6/j8QusFeLJwI27WzGdoYe8t+jnefoQDOQ/6W
         oWVsOP8Dm1HYfFfHckkky3ORtpv5soGSN7+4sR54BV7ZAox2QvUg71mLdSRztM78CZX5
         Mm9OtFRh3e1eiB2zwwauKyvlg+hpLVUxt2b27qcJCGEW8HncRmbLPF0lviVFVHr1rXKL
         lOvh1obK/erFCLS4JBmCVhElRtzDVX+Ck4T5XkWryrEScmSGYjiqvLf5Mm3u8hVKdG9w
         ObY3NA65Uzi8yKmMWY5ECaS7dKDv17GUQNSakpccYIX6ekLO6d+uvg3ZAJ6zypoUPOwh
         EV9w==
X-Gm-Message-State: APjAAAWl6Cf8zwh3TIbsPepGgHPWhmYasJ1c9KV7U+sWkFjbj5RACN8d
        X4WODj6gICu1q5RZ0l4D/QnpLs2BpZ4=
X-Google-Smtp-Source: APXvYqz3PVC6VEv9ly1w8V9QkV1chCcVChyXsO3Mep6L1XA6HAXhCCPx4WbnH9NKboJtGRCOep19Sw==
X-Received: by 2002:a63:d357:: with SMTP id u23mr5632600pgi.153.1551870104201;
        Wed, 06 Mar 2019 03:01:44 -0800 (PST)
Received: from localhost ([122.171.71.18])
        by smtp.gmail.com with ESMTPSA id s37sm3132788pgk.36.2019.03.06.03.01.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 06 Mar 2019 03:01:42 -0800 (PST)
Date:   Wed, 6 Mar 2019 16:31:40 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     Linux PM <linux-pm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Chen Yu <yu.c.chen@intel.com>,
        Gabriele Mazzotta <gabriele.mzt@gmail.com>
Subject: Re: [PATCH v2 0/3] cpufreq: intel_pstate: Handle _PPC updates on
 global turbo disable/enable
Message-ID: <20190306110140.weyktajj7ty7vuxn@vireshk-i7>
References: <1755407.S0oJirvq9V@aspire.rjw.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1755407.S0oJirvq9V@aspire.rjw.lan>
User-Agent: NeoMutt/20180323-120-3dd1ac
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05-03-19, 11:23, Rafael J. Wysocki wrote:
> Hi All,
> 
> This is a follow-up to the RFT patch set posted previously:
> https://lore.kernel.org/lkml/9956076.F4luUDm1Dq@aspire.rjw.lan/
> 
> Patch [1/3] causes intel_pstate to update all policies if it gets a _PPC change
> notification and sees a global turbo disable/enable change.
> 
> Patch [2/3] adds cpufreq_cpu_acquire() and cpufreq_cpu_release() to reduce
> code duplication after the next patch a bit (and Srinivas wanted the rwsem
> manipulation to not be done directly by the driver).
> 
> Patch [3/3] makes intel_pstate update cpuinfo.max_freq for all policies in
> those cases.
> 
> I've atted Tested-by tags to patches [1/3] and [3/3], because there are only
> cosmetic differences between them and what has been tested.

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
