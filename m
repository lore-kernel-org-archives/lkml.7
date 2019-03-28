Return-Path: <SRS0=Qu8K=R7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEBE3C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 10:04:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 999232173C
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 10:04:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553767467;
	bh=0xn+lQGeJ2qNbkLw38g9RcaOmJe5146cFXrDT5v5jaU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=dRE294FK5AC/OWziIg4U6VP8DiSKQ/5vjvCoVZh53ULU43tKujdkGx33qUZVnHcW7
	 PfOR8MTLVNaPpnMYzWOKxoH8Ldym9nsjgPdcezmD2AyYnMNTZlgQShh/N34//04CwC
	 IhoM6uY45ysfpVQtfiZnTXHx9md50PwLi4i9hkXw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727327AbfC1KE0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Mar 2019 06:04:26 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:38363 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725815AbfC1KE0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Mar 2019 06:04:26 -0400
Received: by mail-ot1-f68.google.com with SMTP id e80so17759206ote.5;
        Thu, 28 Mar 2019 03:04:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xtmdu5XLPrI43gJK8nagjJ6gJWySA3zZa00qKeEf1cg=;
        b=WHO6a5P2TEJ3xVqmmqo0emS0ZQKQWwWsyc9MN1z+8kd08LHyAUbawjPhp/6/QzIzIq
         aLi7S3i9MlEoXe7R7KGk55q98rbEeRmtxA5kAu0b1ddVBRQR2YA5vGtoahVJGtNfHVgN
         Ma40bhmCdKwMwZXfaGfGpJlgdeaOm4SDuNJ4d+TYJkl9hxrB+AfEWZVTuBM1ZLC7sjr6
         K5WRNxNF61iOwi0x0e3TEGaj3YW3OoqC3coQXNQmJnMW49vINErwPuvbOZ/3L/5KJmpa
         9+i8j12ylnSWmAMZAYg81SKi6tNk3pwPdsdFE7ksNXBwZyI7YpiuuSR3PDKAPynuObkd
         Ac/g==
X-Gm-Message-State: APjAAAWlj2jFELEnqMTDUoBewi3+89YCk7iLDovgzIIKpbtfpagYG+hi
        OqOYguLAtJ8r00i2m9Moh66hGlElJ6p7GBrJoxo=
X-Google-Smtp-Source: APXvYqzlJVh1s+XobKp09nau8PesjtF/07r/DzPbrxPVBfpYZV15X+lhIcrKNW+O4swMRYaigkdN8ASQm+O+Bm25WiI=
X-Received: by 2002:a9d:36a:: with SMTP id 97mr3722387otv.124.1553767465525;
 Thu, 28 Mar 2019 03:04:25 -0700 (PDT)
MIME-Version: 1.0
References: <20190326223938.5365-1-jeremy.linton@arm.com> <20190326223938.5365-2-jeremy.linton@arm.com>
In-Reply-To: <20190326223938.5365-2-jeremy.linton@arm.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 28 Mar 2019 11:04:14 +0100
Message-ID: <CAJZ5v0g7DOTiP=UiyqW6wf7AWyK8bi93CGsAsg_T=6HJDWrQww@mail.gmail.com>
Subject: Re: [PATCH 1/4] ACPI/PPTT: Add function to return ACPI 6.3 Identical tokens
To:     Jeremy Linton <jeremy.linton@arm.com>
Cc:     Linux ARM <linux-arm-kernel@lists.infradead.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        James Morse <james.morse@arm.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Linuxarm <linuxarm@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 26, 2019 at 11:40 PM Jeremy Linton <jeremy.linton@arm.com> wrote:
>
> ACPI 6.3 adds a flag to indicate that child nodes are all
> identical cores. This is useful to authoritatively determine
> if a set of (possibly offline) cores are identical or not.
>
> Since the flag doesn't give us a unique id we can generate
> one and use it to create bitmaps of sibling nodes, or simply
> in a loop to determine if a subset of cores are identical.
>
> Signed-off-by: Jeremy Linton <jeremy.linton@arm.com>
> ---
>  drivers/acpi/pptt.c  | 26 ++++++++++++++++++++++++++
>  include/linux/acpi.h |  5 +++++
>  2 files changed, 31 insertions(+)
>
> diff --git a/drivers/acpi/pptt.c b/drivers/acpi/pptt.c
> index 065c4fc245d1..472c95ec816b 100644
> --- a/drivers/acpi/pptt.c
> +++ b/drivers/acpi/pptt.c
> @@ -660,3 +660,29 @@ int find_acpi_cpu_topology_package(unsigned int cpu)
>         return find_acpi_cpu_topology_tag(cpu, PPTT_ABORT_PACKAGE,
>                                           ACPI_PPTT_PHYSICAL_PACKAGE);
>  }
> +
> +/**
> + * find_acpi_cpu_topology_hetero_id() - Determine a unique implementation

Maybe "Get a core architecture tag"?

> + * @cpu: Kernel logical cpu number

s/logical cpu/logical CPU/ please.

> + *
> + * Determine a unique heterogeneous ID for the given CPU. CPUs with the same
> + * implementation should have matching IDs. Since this is a tree we can only
> + * detect implementations where the heterogeneous flag is the parent to all
> + * matching cores. AKA if a two socket machine has two different core types
> + * in each socket this will end up being represented as four unique core types
> + * rather than two.

I find it quite difficult to parse that comment, honestly.

AFAICS, the function returns a tag that will be the same for all cores
with the same architecture in one package.  That is, if the package is
heterogeneous and there are two types of cores in it, there will be
two different tags.  Is this correct?

> + *
> + * The returned ID can be used to group peers with identical implementation.
> + *
> + * The search terminates when a level is found with the identical implementation
> + * flag set or we reach a root node.
> + *
> + * Return: -ENOENT if the PPTT doesn't exist, or the cpu cannot be found.
> + * Otherwise returns a value which represents a group of identical cores
> + * similar to this cpu.
> + */
> +int find_acpi_cpu_topology_hetero_id(unsigned int cpu)
> +{
> +       return find_acpi_cpu_topology_tag(cpu, PPTT_ABORT_PACKAGE,
> +                                         ACPI_PPTT_ACPI_IDENTICAL);
> +}
> diff --git a/include/linux/acpi.h b/include/linux/acpi.h
> index d5dcebd7aad3..1444fb042898 100644
> --- a/include/linux/acpi.h
> +++ b/include/linux/acpi.h
> @@ -1309,6 +1309,7 @@ static inline int lpit_read_residency_count_address(u64 *address)
>  #ifdef CONFIG_ACPI_PPTT
>  int find_acpi_cpu_topology(unsigned int cpu, int level);
>  int find_acpi_cpu_topology_package(unsigned int cpu);
> +int find_acpi_cpu_topology_hetero_id(unsigned int cpu);
>  int find_acpi_cpu_cache_topology(unsigned int cpu, int level);
>  #else
>  static inline int find_acpi_cpu_topology(unsigned int cpu, int level)
> @@ -1319,6 +1320,10 @@ static inline int find_acpi_cpu_topology_package(unsigned int cpu)
>  {
>         return -EINVAL;
>  }
> +static int find_acpi_cpu_topology_hetero_id(unsigned int cpu)
> +{
> +       return -EINVAL;
> +}
>  static inline int find_acpi_cpu_cache_topology(unsigned int cpu, int level)
>  {
>         return -EINVAL;
> --
> 2.20.1
>
