Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79DC0C10F00
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 12:43:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4A5A32087C
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 12:43:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="IOPxLOwd";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="Eh+4puF8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729495AbfC0MnC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 08:43:02 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:34774 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727488AbfC0MnB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 08:43:01 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 91E766115A; Wed, 27 Mar 2019 12:43:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1553690580;
        bh=kCVlYYT7Zq0cuvP/t13s9ICrRVAfL5NGYHm90y9jRAo=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=IOPxLOwdrfnmJbYNhBlI9k7j2q8GhkA9KuydOJlL5ai+PI2O9M36onQa04fbP23YK
         fA4RFtakQTAKEwCSEtfufRXQTP9uHCp48GhMRjlPqbAMyi7Gu/CI5UvTBy9URtXxDv
         RDucBGAt1Q1MwmRj7dd7JXKZHEe461ELTHSRmCBM=
Received: from [10.204.79.83] (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: mojha@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id D38336110F;
        Wed, 27 Mar 2019 12:42:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1553690578;
        bh=kCVlYYT7Zq0cuvP/t13s9ICrRVAfL5NGYHm90y9jRAo=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=Eh+4puF87NHDyW+W+cEvDyL8DcrUIkCyaTnKdmiOS+dFGep/RpDFwdhVPU+rtigG5
         699FZk3jU92cXx5hTixfr7eHOV0E8SIPudnbm2t9I/AQMS0+Vokhf3+N0IZq+7dqi2
         IKd5Bqj7wdEkBJICFTopjikpc2HzKG53PRHf8z+Y=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org D38336110F
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=mojha@codeaurora.org
Subject: Re: [PATCH] Yama: mark local symbols as static
To:     Jann Horn <jannh@google.com>, Kees Cook <keescook@chromium.org>
Cc:     linux-kernel@vger.kernel.org, James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        linux-security-module@vger.kernel.org
References: <20190326230841.87834-1-jannh@google.com>
From:   Mukesh Ojha <mojha@codeaurora.org>
Message-ID: <b63d2960-98f4-a2cd-41a5-3d9bd1ff0ec5@codeaurora.org>
Date:   Wed, 27 Mar 2019 18:12:52 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.0
MIME-Version: 1.0
In-Reply-To: <20190326230841.87834-1-jannh@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 3/27/2019 4:38 AM, Jann Horn wrote:
> sparse complains that Yama defines functions and a variable as non-static
> even though they don't exist in any header. Fix it by making them static.
>
> Signed-off-by: Jann Horn <jannh@google.com>

Reviewed-by: Mukesh Ojha <mojha@codeaurora.org>


> ---
>   security/yama/yama_lsm.c | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/security/yama/yama_lsm.c b/security/yama/yama_lsm.c
> index 57cc60722dd3..06b14a57b0a4 100644
> --- a/security/yama/yama_lsm.c
> +++ b/security/yama/yama_lsm.c
> @@ -206,7 +206,7 @@ static void yama_ptracer_del(struct task_struct *tracer,
>    * yama_task_free - check for task_pid to remove from exception list
>    * @task: task being removed
>    */
> -void yama_task_free(struct task_struct *task)
> +static void yama_task_free(struct task_struct *task)
>   {
>   	yama_ptracer_del(task, task);
>   }
> @@ -401,7 +401,7 @@ static int yama_ptrace_access_check(struct task_struct *child,
>    *
>    * Returns 0 if following the ptrace is allowed, -ve on error.
>    */
> -int yama_ptrace_traceme(struct task_struct *parent)
> +static int yama_ptrace_traceme(struct task_struct *parent)
>   {
>   	int rc = 0;
>   
> @@ -452,7 +452,7 @@ static int yama_dointvec_minmax(struct ctl_table *table, int write,
>   static int zero;
>   static int max_scope = YAMA_SCOPE_NO_ATTACH;
>   
> -struct ctl_path yama_sysctl_path[] = {
> +static struct ctl_path yama_sysctl_path[] = {
>   	{ .procname = "kernel", },
>   	{ .procname = "yama", },
>   	{ }
