Return-Path: <SRS0=Qu8K=R7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB254C4360F
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 06:27:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 79D352075E
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 06:27:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="mTQ7HAwJ";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="mTQ7HAwJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726242AbfC1G1X (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Mar 2019 02:27:23 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:46986 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725779AbfC1G1W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Mar 2019 02:27:22 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id ED9236072E; Thu, 28 Mar 2019 06:27:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1553754441;
        bh=CpHBBwnHGRk33r6Ll3obWwhbWYNOm2kCdIO3VBGKsOU=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=mTQ7HAwJqBjK+/RkC0FM267RGcz1xJbQoL5xQDpQvW4P0rnpwJ/N1PoPFMVjtddYL
         Ri2jcm9M1RKz8S+Xp6SelfPdrCq9stmZhfWFik4wViyMtqU4IJBbckgqvp8+Z0kmgR
         my/6wGmLaGGEQwAfx2ONox0rDvZ+cGjwFaloyUGY=
Received: from [10.204.79.83] (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: mojha@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 7BABB6072E;
        Thu, 28 Mar 2019 06:27:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1553754441;
        bh=CpHBBwnHGRk33r6Ll3obWwhbWYNOm2kCdIO3VBGKsOU=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=mTQ7HAwJqBjK+/RkC0FM267RGcz1xJbQoL5xQDpQvW4P0rnpwJ/N1PoPFMVjtddYL
         Ri2jcm9M1RKz8S+Xp6SelfPdrCq9stmZhfWFik4wViyMtqU4IJBbckgqvp8+Z0kmgR
         my/6wGmLaGGEQwAfx2ONox0rDvZ+cGjwFaloyUGY=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 7BABB6072E
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=mojha@codeaurora.org
Subject: Re: [PATCH] tools/perf/util: Remove duplicate headers
To:     jagdsh.linux@gmail.com, peterz@infradead.org, mingo@redhat.com,
        acme@kernel.org, alexander.shishkin@linux.intel.com,
        jolsa@redhat.com, namhyung@kernel.org, ast@kernel.org,
        kafai@fb.com, songliubraving@fb.com, yhs@fb.com,
        yao.jin@linux.intel.com, eranian@google.com
Cc:     linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        bpf@vger.kernel.org
References: <1553724446-40957-1-git-send-email-jagdsh.linux@gmail.com>
From:   Mukesh Ojha <mojha@codeaurora.org>
Message-ID: <599c35c3-88b8-f007-9eee-d7fddb1cb31b@codeaurora.org>
Date:   Thu, 28 Mar 2019 11:57:13 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <1553724446-40957-1-git-send-email-jagdsh.linux@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 3/28/2019 3:37 AM, jagdsh.linux@gmail.com wrote:
> From: Jagadeesh Pagadala <jagdsh.linux@gmail.com>
>
> Remove duplicate headers which are included twice.
> Signed-off-by: Jagadeesh Pagadala <jagdsh.linux@gmail.com>

Reviewed-by: Mukesh Ojha <mojha@codeaurora.org>

-Mukesh

> ---
>   tools/perf/util/annotate.c             | 1 -
>   tools/perf/util/data.c                 | 1 -
>   tools/perf/util/get_current_dir_name.c | 1 -
>   tools/perf/util/stat-display.c         | 1 -
>   4 files changed, 4 deletions(-)
>
> diff --git a/tools/perf/util/annotate.c b/tools/perf/util/annotate.c
> index c8b0117..b1dd021 100644
> --- a/tools/perf/util/annotate.c
> +++ b/tools/perf/util/annotate.c
> @@ -36,7 +36,6 @@
>   #include <pthread.h>
>   #include <linux/bitops.h>
>   #include <linux/kernel.h>
> -#include <bpf/libbpf.h>
>   
>   /* FIXME: For the HE_COLORSET */
>   #include "ui/browser.h"
> diff --git a/tools/perf/util/data.c b/tools/perf/util/data.c
> index 6a64f71..509a41e 100644
> --- a/tools/perf/util/data.c
> +++ b/tools/perf/util/data.c
> @@ -8,7 +8,6 @@
>   #include <unistd.h>
>   #include <string.h>
>   #include <asm/bug.h>
> -#include <sys/types.h>
>   #include <dirent.h>
>   
>   #include "data.h"
> diff --git a/tools/perf/util/get_current_dir_name.c b/tools/perf/util/get_current_dir_name.c
> index 267aa60..ebb80cd 100644
> --- a/tools/perf/util/get_current_dir_name.c
> +++ b/tools/perf/util/get_current_dir_name.c
> @@ -5,7 +5,6 @@
>   #include "util.h"
>   #include <unistd.h>
>   #include <stdlib.h>
> -#include <stdlib.h>
>   
>   /* Android's 'bionic' library, for one, doesn't have this */
>   
> diff --git a/tools/perf/util/stat-display.c b/tools/perf/util/stat-display.c
> index 6d043c7..7b3a16c 100644
> --- a/tools/perf/util/stat-display.c
> +++ b/tools/perf/util/stat-display.c
> @@ -12,7 +12,6 @@
>   #include "string2.h"
>   #include "sane_ctype.h"
>   #include "cgroup.h"
> -#include <math.h>
>   #include <api/fs/fs.h>
>   
>   #define CNTR_NOT_SUPPORTED	"<not supported>"
