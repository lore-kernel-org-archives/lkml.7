Return-Path: <SRS0=6OEZ=YL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22C9ACA9ECF
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 05:07:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE94D222C5
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 05:07:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Or1S1NJB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2504366AbfJRFHS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Oct 2019 01:07:18 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:34371 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2504025AbfJRFHQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Oct 2019 01:07:16 -0400
Received: by mail-pl1-f193.google.com with SMTP id k7so2270445pll.1
        for <linux-kernel@vger.kernel.org>; Thu, 17 Oct 2019 22:07:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=BN38U1tWSQycIwUtKvgVS41nw2Y5xmAR6qADXcgIN/E=;
        b=Or1S1NJBS21mZ3T0kRuw3+pg9/9vA19tlOBKzPCu+VJOzUGorap9nhyIFOs7X2qgrg
         zvJDJQwIS1BW+6v7Hpb7lsxv4M+N1QE5YfJhC/1Fj5/SMhEmHI+miSmHuYfJPzUy6eFa
         GC0iDI+pBneF36jZra4sKjv7DLrI/2YleI/qLkqhHXu5iCL7IzKssn9od150fmLSzfsz
         LCOOYySKfikf3B2ZqQcd/I/6X7u97Zel3TIjOM8ZSAJdp2jpXC24fyV1GimkEn+jQcpD
         jBnPpOKMTIiYCrVbDyuUNr2v1+bDc60g12qFOhDG8ORiKRo/fqfAbqCIaTrPDAbvhTUO
         GGdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=BN38U1tWSQycIwUtKvgVS41nw2Y5xmAR6qADXcgIN/E=;
        b=as3mvW1Jlod6/UAwJdphflMMFR7ACMitXMFsutiQLXZ6K28wkX5Ebs7liDv8Fw5hKM
         /xzr5X7HLk+kwv49spYtKDYiTe+DAJGlFSUCbbg7qICGqPlKInADTOdK7zeNZhqdNJGm
         k0rh1FKvsi11baWDNqr+eCSW+nzeTCDV0RS6m71UDkFe9o5S8kOrHR6TftHK7UjB4YIB
         wzyHiklPgkDXJFqCX01AX0ycnCWO/4vHrN47Hdg4JD4w+qSm/6YjYdvE99yI2/8rtciJ
         Qn3nnn5J7Yt8XrUzvOb8q+plhnSH2+/yXwVm7zfoNDh7fXjYNgSjjB65jDNSvlQQJDWY
         fqCQ==
X-Gm-Message-State: APjAAAVGFj6d5RPss65HyYYcB/XecK9cUsCFUAzRPs1qtAvdv/gFEa0m
        I5mOSeBNOOR81O2aYy3sCxdzeGgf3cQ=
X-Google-Smtp-Source: APXvYqzkRC1EwPpxmXJHKXXdNdXNMqjA0MEl0CEAzz/4I6yX9UtNA1XEwdpB6tAX43Fk+9Ejz7Ry3Q==
X-Received: by 2002:a17:902:904b:: with SMTP id w11mr7882591plz.182.1571375235738;
        Thu, 17 Oct 2019 22:07:15 -0700 (PDT)
Received: from localhost ([122.172.151.112])
        by smtp.gmail.com with ESMTPSA id 74sm4821485pfy.78.2019.10.17.22.07.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 17 Oct 2019 22:07:14 -0700 (PDT)
Date:   Fri, 18 Oct 2019 10:37:12 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     John Hubbard <jhubbard@nvidia.com>
Cc:     Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Preeti U Murthy <preeti@linux.vnet.ibm.com>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>, linux-pm@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v2] cpufreq: powernv: fix stack bloat and NR_CPUS
 limitation
Message-ID: <20191018050712.qr2axffmbms5h4xb@vireshk-i7>
References: <20191018045539.3765565-1-jhubbard@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191018045539.3765565-1-jhubbard@nvidia.com>
User-Agent: NeoMutt/20180716-391-311a52
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17-10-19, 21:55, John Hubbard wrote:
> The following build warning occurred on powerpc 64-bit builds:
> 
> drivers/cpufreq/powernv-cpufreq.c: In function 'init_chip_info':
> drivers/cpufreq/powernv-cpufreq.c:1070:1: warning: the frame size of 1040 bytes is larger than 1024 bytes [-Wframe-larger-than=]
> 
> This is due to putting 1024 bytes on the stack:
> 
>     unsigned int chip[256];
> 
> ...and while looking at this, it also has a bug: it fails with a stack
> overrun, if CONFIG_NR_CPUS > 256.
> 
> Fix both problems by dynamically allocating based on CONFIG_NR_CPUS.
> 
> Fixes: 053819e0bf840 ("cpufreq: powernv: Handle throttling due to Pmax capping at chip level")
> Cc: Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>
> Cc: Preeti U Murthy <preeti@linux.vnet.ibm.com>
> Cc: Viresh Kumar <viresh.kumar@linaro.org>
> Cc: Rafael J. Wysocki <rjw@rjwysocki.net>
> Cc: linux-pm@vger.kernel.org
> Cc: linuxppc-dev@lists.ozlabs.org
> Signed-off-by: John Hubbard <jhubbard@nvidia.com>
> ---
> 
> Changes since v1: includes Viresh's review commit fixes.
> 
>  drivers/cpufreq/powernv-cpufreq.c | 17 +++++++++++++----
>  1 file changed, 13 insertions(+), 4 deletions(-)

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
