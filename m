Return-Path: <SRS0=TKbG=UN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0BADC31E44
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 09:21:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C59D921473
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 09:21:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1560504082;
	bh=fYkt2SgnqUqmhdlU83CXPiUZZtXPJoQ4xtjQSYaPHiI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=JfuEvbw0KsHvRyMnzAj4DImLKZDcrZYg5YyZDdT0SO7pSWkPqs0GSp52tZPf7cCQC
	 LFMP127wBxdnDeZPZKLD1aD74YZLLhCPHFKjxR96R+dz3tiGKJ+uJeeAjCOz0MMPFL
	 HiSVCM/EOCX1cBEHRXS0J4wq/aKscqPX4zkyMJNE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727042AbfFNJVV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Jun 2019 05:21:21 -0400
Received: from mail-oi1-f194.google.com ([209.85.167.194]:46251 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727006AbfFNJVU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jun 2019 05:21:20 -0400
Received: by mail-oi1-f194.google.com with SMTP id 65so1426570oid.13
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jun 2019 02:21:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+9UoFcQA8E/RGYw8JkP4QI6UkiiLAdxzMXwv4vRvymk=;
        b=Kn77zdk6ZCN+AFoMgzFv65v4XitTeW2Viv0VVOgC0V1iUaYuRMzOrdNfz05g6SnorL
         riQNzYye88R2znNs5ja6tzrV+bO/EjyJ4ilEM8M3gn8JIHXj5eA4jvpzQDJkeFCY7wM6
         hkFJOM3OPeanzt8LsFsp93xkPpjOqS4y1JJTh41sRrNgAgXe2fXN1OfeR1x3dl8i02Tc
         FSpAuCyL1TpIQRUSxAHnCCnJmy5EBQQIZBFyUcnFoOkW+aMBQheYhJscWlJZ4gjokEbT
         cWU5covvCAx90ADaAd4oLHRH2zucgmNKr5FKOKFAO0SUF6KFn4nttLW3xR5LusMNf71S
         nSKA==
X-Gm-Message-State: APjAAAWC9n/no1kyPPKXyzDNh9G7bur0THNvsfQuQehiJo6uBBWhtREo
        eQUEg9iJ11t3Dacmcr6rU29W7sWNLA5b30rKzpA=
X-Google-Smtp-Source: APXvYqzcyjdECkJPA/hT/f6HvOUiY0oQaxWpnSMiegfzC2M2Ix7pGc5P/o7V4kwJBNdgVN97awk++tdJHsk4+Bu4xbQ=
X-Received: by 2002:aca:4e89:: with SMTP id c131mr1257880oib.57.1560504079718;
 Fri, 14 Jun 2019 02:21:19 -0700 (PDT)
MIME-Version: 1.0
References: <20190530161024.85637-1-james.morse@arm.com>
In-Reply-To: <20190530161024.85637-1-james.morse@arm.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 14 Jun 2019 11:21:08 +0200
Message-ID: <CAJZ5v0i1BMJRKdVfYsrH9AZwG-JdmqDPtcXH3H0=Kf=ZAwQfpQ@mail.gmail.com>
Subject: Re: [PATCH] drivers: base: cacheinfo: Ensure cpu hotplug work is done
 before Intel RDT
To:     James Morse <james.morse@arm.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Reinette Chatre <reinette.chatre@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 30, 2019 at 6:10 PM James Morse <james.morse@arm.com> wrote:
>
> The cacheinfo structures are alloced/freed by cpu online/offline
> callbacks. Originally these were only used by sysfs to expose the
> cache topology to user space. Without any in-kernel dependencies
> CPUHP_AP_ONLINE_DYN was an appropriate choice.
>
> resctrl has started using these structures to identify CPUs that
> share a cache. It updates its 'domain' structures from cpu
> online/offline callbacks. These depend on the cacheinfo structures
> (resctrl_online_cpu()->domain_add_cpu()->get_cache_id()->
>  get_cpu_cacheinfo()).
> These also run as CPUHP_AP_ONLINE_DYN.
>
> Now that there is an in-kernel dependency, move the cacheinfo
> work earlier so we know its done before resctrl's CPUHP_AP_ONLINE_DYN
> work runs.
>
> Cc: Fenghua Yu <fenghua.yu@intel.com>
> Cc: Reinette Chatre <reinette.chatre@intel.com>
> Signed-off-by: James Morse <james.morse@arm.com>

This looks reasonable to me, but I would send the patch to Thomas
Gleixner (with CCs to Tony Luck and Boris Petkov in addition to your
original CC list).

> ---
> I haven't seen any problems because of this. If someone thinks it should
> go to stable:
> Cc: <stable@vger.kernel.org> #4.10.x
>
> The particular patch that added RDT is:
> Fixes: 2264d9c74dda1 ("x86/intel_rdt: Build structures for each resource based on cache topology")

IMO it is OK to add a Fixes: tag if your patch is needed on top of the
other on for everything to work as expected, regardless of what pieces
of code are touched by each of them.  That information is useful to
people who need to make backporting decisions, for example (if they
decide to backport the original patch, they would probably want to
backport your patch on top of it).

> But as this touches a different set of files, I'm not sure how appropriate
> a fixes tag is.
>
>  drivers/base/cacheinfo.c   | 3 ++-
>  include/linux/cpuhotplug.h | 1 +
>  2 files changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/base/cacheinfo.c b/drivers/base/cacheinfo.c
> index a7359535caf5..b444f89a2041 100644
> --- a/drivers/base/cacheinfo.c
> +++ b/drivers/base/cacheinfo.c
> @@ -655,7 +655,8 @@ static int cacheinfo_cpu_pre_down(unsigned int cpu)
>
>  static int __init cacheinfo_sysfs_init(void)
>  {
> -       return cpuhp_setup_state(CPUHP_AP_ONLINE_DYN, "base/cacheinfo:online",
> +       return cpuhp_setup_state(CPUHP_AP_BASE_CACHEINFO_ONLINE,
> +                                "base/cacheinfo:online",
>                                  cacheinfo_cpu_online, cacheinfo_cpu_pre_down);
>  }
>  device_initcall(cacheinfo_sysfs_init);
> diff --git a/include/linux/cpuhotplug.h b/include/linux/cpuhotplug.h
> index 6a381594608c..50c893f03c21 100644
> --- a/include/linux/cpuhotplug.h
> +++ b/include/linux/cpuhotplug.h
> @@ -175,6 +175,7 @@ enum cpuhp_state {
>         CPUHP_AP_WATCHDOG_ONLINE,
>         CPUHP_AP_WORKQUEUE_ONLINE,
>         CPUHP_AP_RCUTREE_ONLINE,
> +       CPUHP_AP_BASE_CACHEINFO_ONLINE,
>         CPUHP_AP_ONLINE_DYN,
>         CPUHP_AP_ONLINE_DYN_END         = CPUHP_AP_ONLINE_DYN + 30,
>         CPUHP_AP_X86_HPET_ONLINE,
> --
> 2.20.1
>
