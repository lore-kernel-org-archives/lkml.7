Return-Path: <SRS0=yZjE=R4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA222C10F03
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 11:50:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A9ADC20850
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 11:50:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553514612;
	bh=ojQ8xu1tZPYXOVLHMjBXyTM+lDx9aJKRyfDT9QlVzR4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=tbtK4MbdodI33R2KzJXQGpAdwkEe1MxKYTPEbte3S/1PQMNPe9Ii28UURCmVDlFBC
	 gy6J3BKB4s1IBSTYQJEsIA1abyZerpCQO9zXvwnYtC4f54GEJicxo1BFplBA9jGM7d
	 VqFZlt/OyXRwksbKD4GBns4db4IAD47sunimbqb8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731000AbfCYLuL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Mar 2019 07:50:11 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:38605 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730730AbfCYLuL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Mar 2019 07:50:11 -0400
Received: by mail-ot1-f67.google.com with SMTP id e80so7716967ote.5;
        Mon, 25 Mar 2019 04:50:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=B01+fr2+NTMioALtiwXKnfmVVhNymoUrrB6iL0c6XLo=;
        b=pxPryPjmCK2h3rZNMOWgvpNz5lSbIsn00yEBy3er4f8WNMQXvzBJnyMLJu9BBsC11B
         JMFo8QYLBZmMaUIeYXpCqANncRURwlHOjKbqIok4Ch3xipk3Fg+0frlTR2hzyCrpVuae
         mjzmj/H8BwZE9cZ5WCh24tA91jnJjhyAh+oNfXLuMn30kLF4DlW7sivw6pLm1+NQ96/c
         jVYF47GJgt2UzUuBTzuz+DW/EGEfPJVMPRtGv3X4EyIfH55ylnREqV2CeMQiqv2vFWoI
         cc8Az0Fqbm7uMBI0tXJKUYqgLFxQeiatddjAVnHOF8U8p99NQBjMgZp7ZfyTeFi8ozvH
         hGtg==
X-Gm-Message-State: APjAAAWQa1IAgEUTF4+I1u3uiY4I6HpvMbH6wOD4rE7OcQtW08gumFnJ
        WPMuOWurxy/1TbN4TXA+p3zfT1ZIg08STYFpvbY=
X-Google-Smtp-Source: APXvYqzaiHXfo5EDh97fUmKTxqQePTR+qWZyYH565Zl3ylwlW/YsxnPr6T/O6Zr1gY4kpGiRobaggbQm4ruVVnKba/s=
X-Received: by 2002:a9d:738c:: with SMTP id j12mr16641308otk.119.1553514610189;
 Mon, 25 Mar 2019 04:50:10 -0700 (PDT)
MIME-Version: 1.0
References: <20190322224520.6740-1-srinivas.pandruvada@linux.intel.com> <20190322224520.6740-2-srinivas.pandruvada@linux.intel.com>
In-Reply-To: <20190322224520.6740-2-srinivas.pandruvada@linux.intel.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 25 Mar 2019 12:49:59 +0100
Message-ID: <CAJZ5v0g6=QZ7m8phjsYfZOxKNbc0Ny1ySPTScg=yzxOUsGk6HQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] ACPI / CPPC: Fix processing for guaranteed performance
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
> As per ACPI specification "Guaranteed Performance Register" is a "Buffer"
> field. It can't be "Integer" field. So treat "Integer" type as invalid and
> ignore "Guaranteed Performance Register".
> Also save one cpc_read() call, when "Guaranteed Performance Register" is
> not present, which means register defined as:
> "Register(SystemMemory, 0, 0, 0, 0)".
>
> Fixes: 29523f095397 ("ACPI / CPPC: Add support for guaranteed performance")
> Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
> Cc: 4.20+ <stable@vger.kernel.org> # 4.20+
> ---
>  drivers/acpi/cppc_acpi.c | 10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/acpi/cppc_acpi.c b/drivers/acpi/cppc_acpi.c
> index 1b207fca1420..3f6c290e06af 100644
> --- a/drivers/acpi/cppc_acpi.c
> +++ b/drivers/acpi/cppc_acpi.c
> @@ -1150,8 +1150,14 @@ int cppc_get_perf_caps(int cpunum, struct cppc_perf_caps *perf_caps)
>         cpc_read(cpunum, nominal_reg, &nom);
>         perf_caps->nominal_perf = nom;
>
> -       cpc_read(cpunum, guaranteed_reg, &guaranteed);
> -       perf_caps->guaranteed_perf = guaranteed;
> +       if (guaranteed_reg->type == ACPI_TYPE_INTEGER  ||
> +           (guaranteed_reg->type == ACPI_TYPE_BUFFER &&
> +            IS_NULL_REG(&guaranteed_reg->cpc_entry.reg))) {

AFAICS anything different from a buffer should be rejected here, so
why don't you do

if (guaranteed_reg->type != ACPI_TYPE_BUFFER  ||
IS_NULL_REG(&guaranteed_reg->cpc_entry.reg))

> +               perf_caps->guaranteed_perf = 0;
> +       } else {
> +               cpc_read(cpunum, guaranteed_reg, &guaranteed);
> +               perf_caps->guaranteed_perf = guaranteed;
> +       }
>
>         cpc_read(cpunum, lowest_non_linear_reg, &min_nonlinear);
>         perf_caps->lowest_nonlinear_perf = min_nonlinear;
> --
> 2.17.2
>
