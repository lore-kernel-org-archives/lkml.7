Return-Path: <SRS0=Ybdz=SI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BE8BC10F06
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Apr 2019 19:13:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E9B2921019
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Apr 2019 19:13:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="HhKE9HBg";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="HhKE9HBg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726656AbfDFTNH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 6 Apr 2019 15:13:07 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:39206 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726427AbfDFTNH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Apr 2019 15:13:07 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 9EEE360ADE; Sat,  6 Apr 2019 19:13:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1554577986;
        bh=HpCdy244h/aIhd5jVZu04Iy8ZH8g0VAh+n7/UMhtaVQ=;
        h=Subject:To:References:From:Date:In-Reply-To:From;
        b=HhKE9HBg3PmrNO2WKoOV8yB1yW3OAnUjwLG9qBDep8AyDcVi+2FpleSS2daU5gE1o
         VYk+tP+dUNetaJ2NQTZwLk6Ze1+gx5XVGwMcgvZXT9FfPJC2ri1yqECXK8lfwNyueN
         7N3PQOmkiZwSR5JD7LBiajrO0tL9Ru9+QdrNQ04s=
Received: from [10.79.171.6] (blr-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.18.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: mojha@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id EA29560A42;
        Sat,  6 Apr 2019 19:12:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1554577986;
        bh=HpCdy244h/aIhd5jVZu04Iy8ZH8g0VAh+n7/UMhtaVQ=;
        h=Subject:To:References:From:Date:In-Reply-To:From;
        b=HhKE9HBg3PmrNO2WKoOV8yB1yW3OAnUjwLG9qBDep8AyDcVi+2FpleSS2daU5gE1o
         VYk+tP+dUNetaJ2NQTZwLk6Ze1+gx5XVGwMcgvZXT9FfPJC2ri1yqECXK8lfwNyueN
         7N3PQOmkiZwSR5JD7LBiajrO0tL9Ru9+QdrNQ04s=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org EA29560A42
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=mojha@codeaurora.org
Subject: Re: [PATCH] kernel: pid_namespace : fix warning Using plain integer
 as NULL pointer
To:     Hariprasad Kelam <hariprasad.kelam@gmail.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org
References: <20190406104828.GA26135@hari-Inspiron-1545>
From:   Mukesh Ojha <mojha@codeaurora.org>
Message-ID: <9af19729-cd8a-c3ec-6e89-1696f338c5c1@codeaurora.org>
Date:   Sun, 7 Apr 2019 00:42:56 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190406104828.GA26135@hari-Inspiron-1545>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 4/6/2019 4:18 PM, Hariprasad Kelam wrote:
> changed passing function argument "0 to NULL" to fix below sparse
> warning
>
> kernel/pid_namespace.c:55:76: warning: Using plain integer as NULL
> pointer
>
> did changes to avoid checkpatch error "prefer a maximum 75 chars per
> line"
>
> Signed-off-by: Hariprasad Kelam <hariprasad.kelam@gmail.com>
Reviewed-by: Mukesh Ojha <mojha@codeaurora.org>

Cheers,
-Mukesh

> ---
>   kernel/pid_namespace.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/kernel/pid_namespace.c b/kernel/pid_namespace.c
> index aa6e72f..6e4afdc 100644
> --- a/kernel/pid_namespace.c
> +++ b/kernel/pid_namespace.c
> @@ -52,7 +52,8 @@ static struct kmem_cache *create_pid_cachep(unsigned int level)
>   	mutex_lock(&pid_caches_mutex);
>   	/* Name collision forces to do allocation under mutex. */
>   	if (!*pkc)
> -		*pkc = kmem_cache_create(name, len, 0, SLAB_HWCACHE_ALIGN, 0);
> +		*pkc =
> +		    kmem_cache_create(name, len, 0, SLAB_HWCACHE_ALIGN, NULL);
>   	mutex_unlock(&pid_caches_mutex);
>   	/* current can fail, but someone else can succeed. */
>   	return READ_ONCE(*pkc);
