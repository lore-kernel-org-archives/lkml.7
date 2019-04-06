Return-Path: <SRS0=Ybdz=SI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,UNWANTED_LANGUAGE_BODY autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45D5FC10F06
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Apr 2019 18:50:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0E6D8213F2
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Apr 2019 18:50:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="evPKa72D";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="AY3aA6+n"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726646AbfDFSuI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 6 Apr 2019 14:50:08 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:56074 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726427AbfDFSuI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Apr 2019 14:50:08 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 81128601B4; Sat,  6 Apr 2019 18:50:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1554576607;
        bh=jNbGrw2UvfkonM+Cx/hPo3ApEycPLVvJNA/YMtJTv+4=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=evPKa72D3ZJX+6sG227eyPrbORKr3ekugwyXmwrJz+4OT1Q3SlVaVpEReN/AUH/ZZ
         5oaWqjXHbVxR5EgjdUhpjay2OS6BOJRxDDafgx+t+mBUmZCa9wv2SVD67A7gr3cMcc
         HU8apVzPPR4dcum3I1MDMzVC7/7kzbXIiaD5/TCQ=
Received: from [10.79.171.6] (blr-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.18.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: mojha@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id B72956044E;
        Sat,  6 Apr 2019 18:49:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1554576606;
        bh=jNbGrw2UvfkonM+Cx/hPo3ApEycPLVvJNA/YMtJTv+4=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=AY3aA6+ngmhXxeOPliGtXs0S1qmOeUt+r6lH43G1+YZfWRHAB8KO1dP8W1FePMeTk
         rYYO6AgHoywFRyV3ykv5OvIXOcjbfu5/XR+OT8OzxYiDUx8iA9mceDvoisN69xR9I4
         yI36o1KLavEVxD6UKfsmxqGBkH6+Hpi1TAhJBIU0=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org B72956044E
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=mojha@codeaurora.org
Subject: Re: [PATCH] perf: Remove duplicate headers
To:     Souptick Joarder <jrdr.linux@gmail.com>, peterz@infradead.org,
        mingo@redhat.com, acme@kernel.org,
        alexander.shishkin@linux.intel.com, namhyung@kernel.org,
        ak@linux.intel.com, eranian@google.com
Cc:     linux-kernel@vger.kernel.org, sabyasachi.linux@gmail.com,
        brajeswar.linux@gmail.com
References: <1554557789-9474-1-git-send-email-jrdr.linux@gmail.com>
From:   Mukesh Ojha <mojha@codeaurora.org>
Message-ID: <e7de2c3d-01cf-52fb-f00a-2c4321009d08@codeaurora.org>
Date:   Sun, 7 Apr 2019 00:19:54 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <1554557789-9474-1-git-send-email-jrdr.linux@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 4/6/2019 7:06 PM, Souptick Joarder wrote:
> Removed duplicate headers which are included twice.
> Signed-off-by: Souptick Joarder <jrdr.linux@gmail.com>
Reviewed-by: Mukesh Ojha <mojha@codeaurora.org>

Cheers,
-Mukesh

> ---
>   tools/perf/util/data.c                 | 1 -
>   tools/perf/util/get_current_dir_name.c | 1 -
>   tools/perf/util/stat-display.c         | 1 -
>   3 files changed, 3 deletions(-)
>
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
