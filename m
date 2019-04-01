Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA458C10F05
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 11:53:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B83022082C
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 11:53:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="KRcu9EGe";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="ONEieNCd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726988AbfDALxx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 07:53:53 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:41888 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726473AbfDALxx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 07:53:53 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 978B960DAD; Mon,  1 Apr 2019 11:53:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1554119631;
        bh=0Oq294hODR2MRQ22TzquAFiZXTSTJLxPJFrUh3xAmJc=;
        h=Subject:To:References:From:Date:In-Reply-To:From;
        b=KRcu9EGeNA/qau31gt7TFLfzRHeLy3tYt8JvTgPxcizXHVoxgG0ZZ+Mvpq4NDkNe2
         4xYp887EDoKyF4av8e6tiOs4y1iXtCwDtljdbjOXXxjCFIwMk22gfBFPbnPEHw/cOT
         RBBHV2xEmZQwiLsHsegATvwHFSEPoapRlpKAmbG0=
Received: from [10.204.79.83] (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: mojha@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id A62BC60A42;
        Mon,  1 Apr 2019 11:53:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1554119630;
        bh=0Oq294hODR2MRQ22TzquAFiZXTSTJLxPJFrUh3xAmJc=;
        h=Subject:To:References:From:Date:In-Reply-To:From;
        b=ONEieNCdfP8eFuvRTTcGZOPA0TDjyaD+gevnOOJBD3ejsrhP1PM8i+RgX+4PhLrFu
         7bG//CWCkWIseXzlBqKfvlYEeRriMm4M0roDypyyor20QSJayp9lT/JGSHfyiSMTm9
         pFKzdg6xJUp33tFpxAT3aPYj5C/tOFm1CWRSU+bE=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org A62BC60A42
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=mojha@codeaurora.org
Subject: Re: [PATCH] fs/open: Fix most outstanding security bugs
To:     Johannes Thumshirn <jthumshirn@suse.de>,
        Linux Kernel Mailinglist <linux-kernel@vger.kernel.org>,
        Linux FSDEVEL Mailinglist <linux-fsdevel@vger.kernel.org>
References: <20190401090113.22946-1-jthumshirn@suse.de>
From:   Mukesh Ojha <mojha@codeaurora.org>
Message-ID: <6af4fb10-6ab0-7dd4-27ad-fac0118490d2@codeaurora.org>
Date:   Mon, 1 Apr 2019 17:23:45 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190401090113.22946-1-jthumshirn@suse.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 4/1/2019 2:31 PM, Johannes Thumshirn wrote:
> Over the last 20 years, the Linux kernel has accumulated hundreds if not
> thousands of security vulnerabilities.
>
> One common pattern in most of these security related reports is processes
> called "syzkaller", "trinity" or "syz-executor" opening files and then
> abuse kernel interfaces causing kernel crashes or even worse threats using
> memory overwrites or by exploiting race conditions.
>
> Hunting down these bugs has become time consuming and very expensive, so
> I've decided to put an end to it.
>
> If one of the above mentioned processes tries opening a file, return -EPERM
> indicating this process does not have the permission to open files on Linux
> anymore.
>
> Signed-off-by: Johannes Thumshirn <jthumshirn@suse.de>


Reviewed-by: Mukesh Ojha <mojha@codeaurora.org>

Cheers,
-Mukesh

> ---
>   fs/open.c | 14 ++++++++++++++
>   1 file changed, 14 insertions(+)
>
> diff --git a/fs/open.c b/fs/open.c
> index f1c2f855fd43..3a3b460beccd 100644
> --- a/fs/open.c
> +++ b/fs/open.c
> @@ -1056,6 +1056,20 @@ long do_sys_open(int dfd, const char __user *filename, int flags, umode_t mode)
>   	struct open_flags op;
>   	int fd = build_open_flags(flags, mode, &op);
>   	struct filename *tmp;
> +	char comm[TASK_COMM_LEN];
> +	int i;
> +	static const char * const list[] = {
> +		"syzkaller",
> +		"syz-executor,"
> +		"trinity",
> +		NULL
> +	};
> +
> +	get_task_comm(comm, current);
> +
> +	for (i = 0; i < ARRAY_SIZE(list); i++)
> +		if (!strncmp(comm, list[i], strlen(list[i])))
> +			return -EPERM;
>   
>   	if (fd)
>   		return fd;
