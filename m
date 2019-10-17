Return-Path: <SRS0=WVJ0=YK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28BA3FA3728
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Oct 2019 02:39:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F36382053B
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Oct 2019 02:39:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="o3f848n8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407302AbfJQCjl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Oct 2019 22:39:41 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:38001 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388036AbfJQCjl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Oct 2019 22:39:41 -0400
Received: by mail-pf1-f196.google.com with SMTP id h195so615902pfe.5
        for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2019 19:39:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=zEFefyCYvjEsaVVPS2qn/8n4VOwk3cwSj8+ZMD6emik=;
        b=o3f848n8kbDlHt5KBM6BXMuHOO1zMriF51e1YO2oquFVRSWl+42FqCRhHdlFOXs7E0
         htfMHEtwXke3pWQMe0kQgl6GMwdSrOkuxPtkfvRV89PfS3/EY4I75fKsxwaf3y9gYAlE
         HmN0NiMJRG4aiPIY0LIKOsrh1jjJBu+OMahIjB2n9NpdGqPoYZhAFyWwfkQGJYL49Y44
         rNHpgMSIHpFvnG5A/nma2/D+350Oja329tWqeeKTUtm9yBmO6qJ0mELVvJvMOjE3XMzX
         VEJ4yem+QkGzr0CxIRcyXz70mSKzXXqVD/ny5ci01XHOqTAcuBH6elHvn9lcjLcY+3vK
         6zEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=zEFefyCYvjEsaVVPS2qn/8n4VOwk3cwSj8+ZMD6emik=;
        b=mkjXP1uFMw7IAlSdQETM4NGT2cKyNybYI0rcRew6x39m5O5q01ityw0CQt0IsXB3ap
         XqJXXXfWvK8+KNcrjXzVZtnzJoTLbpH/8uLcVAA5Y2SM9jM+PTXfwUYGRCzkqy8Lhq1/
         OV8WyHxjpNXYbOeyzKm/cinqPDVMdpOLsG1uENEAjQfPaWKPo3ZNHRxXj0p5eOgM0WUu
         1pNOPl3tvP7IH3gxF6xD1RjLiXxYgvSNV5XdTw2f3MHE2tqrlZm26OkzaeuBs2kzhzrZ
         g6bnz+cb1Ms8nQYAugp12XwrWIpc0TvLu1lD/p//EgRnkm6Vtw4yiKU6N51z19SNIxEi
         jjvw==
X-Gm-Message-State: APjAAAWyIAHvrjlnfYD8YtMAx9wTdP7CBVQOKipcXlAJ7PTJ9TLZO1XG
        L0cjg0GArSm6gZfsOEMSogVnYw==
X-Google-Smtp-Source: APXvYqzdrRZBIUMnzPMVc2UOR1CHHTWtq4YXpulhQnyUqCEvFi6i5kz49j3bwFbo8NvjTfpRESnM7Q==
X-Received: by 2002:aa7:970b:: with SMTP id a11mr972230pfg.37.1571279979302;
        Wed, 16 Oct 2019 19:39:39 -0700 (PDT)
Received: from localhost ([122.172.151.112])
        by smtp.gmail.com with ESMTPSA id z12sm494571pfj.41.2019.10.16.19.39.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 16 Oct 2019 19:39:38 -0700 (PDT)
Date:   Thu, 17 Oct 2019 08:09:36 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Sudeep Holla <sudeep.holla@arm.com>
Cc:     "Rafael J . Wysocki" <rjw@rjwysocki.net>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] cpufreq: merge arm_big_little and vexpress-spc
Message-ID: <20191017023936.vgkdfnyaz3r4k74z@vireshk-i7>
References: <20191016110344.15259-1-sudeep.holla@arm.com>
 <20191016110344.15259-3-sudeep.holla@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191016110344.15259-3-sudeep.holla@arm.com>
User-Agent: NeoMutt/20180716-391-311a52
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16-10-19, 12:03, Sudeep Holla wrote:
> arm_big_little cpufreq driver was designed as a generic big little
> driver that could be used by any platform and make use of bL switcher.
> Over years alternate solutions have be designed and merged to deal with
> bL/HMP systems like EAS.
> 
> Also since no other driver made use of generic arm_big_little cpufreq
> driver except Vexpress SPC, we can merge them together as vexpress-spc
> driver used only on Vexpress TC2(CA15_CA7) platform.
> 
> Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
> ---
>  MAINTAINERS                            |   5 +-
>  drivers/cpufreq/Kconfig.arm            |  12 +-
>  drivers/cpufreq/Makefile               |   2 -
>  drivers/cpufreq/arm_big_little.c       | 658 ------------------------
>  drivers/cpufreq/arm_big_little.h       |  43 --
>  drivers/cpufreq/vexpress-spc-cpufreq.c | 661 ++++++++++++++++++++++++-
>  6 files changed, 652 insertions(+), 729 deletions(-)
>  delete mode 100644 drivers/cpufreq/arm_big_little.c
>  delete mode 100644 drivers/cpufreq/arm_big_little.h

The delta produced here is enormous probably because you copy/pasted things. I
am wondering if using git mv to rename arm_big_little.c and then move spc bits
into it will make this delta smaller to review ?

-- 
viresh
