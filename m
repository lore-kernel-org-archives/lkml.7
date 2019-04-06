Return-Path: <SRS0=Ybdz=SI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44C6CC282DC
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Apr 2019 18:48:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 132A6213F2
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Apr 2019 18:48:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="FVadyNEv";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="JkcO8t3n"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726623AbfDFSsG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 6 Apr 2019 14:48:06 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:54398 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726427AbfDFSsF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Apr 2019 14:48:05 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id F0C7F60A42; Sat,  6 Apr 2019 18:48:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1554576484;
        bh=bsfESOPAMIt6kwXs1L5nh9XkRg1/EBCHLoLNOWy+Tvw=;
        h=Subject:To:References:From:Date:In-Reply-To:From;
        b=FVadyNEvL61FKcMpqBw/2H/Qi0GkcYZSU8Ox/ZbBJC1kb3WlfZZ5Tab/d8mfUeBIM
         sWkKM6xkL51QOsG6F08VlIYMk7ga5dBUxGrKgx51sFS7141B3T1Q8R7Y5osjIAwAkf
         vr7npl2ImxRmBxF5ZoxNvIhgH4MuWgNxxos0uZX8=
Received: from [10.79.171.6] (blr-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.18.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: mojha@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 339536044E;
        Sat,  6 Apr 2019 18:47:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1554576483;
        bh=bsfESOPAMIt6kwXs1L5nh9XkRg1/EBCHLoLNOWy+Tvw=;
        h=Subject:To:References:From:Date:In-Reply-To:From;
        b=JkcO8t3nJEo+vI4PaMB/NTMws8XKpEMQpjFIC8Gml4TRjb73R3WJ0s0QFBnzAo+/z
         BKeyY0K7bWTIJvetgHxKJdM/0qftQGYCNNW5uRHaPeFW8MEIY0Ajm1tziFN+YMB0pr
         w0HJswCWuUU/B1mAdwsN5HFEGMEr1OtndOLh3EH0=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 339536044E
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=mojha@codeaurora.org
Subject: Re: [PATCH] watchdog: machzwd : fix warning Using plain integer as
 NULL pointer
To:     Hariprasad Kelam <hariprasad.kelam@gmail.com>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20190406131415.GA3844@hari-Inspiron-1545>
From:   Mukesh Ojha <mojha@codeaurora.org>
Message-ID: <38e42bc9-f0b1-5839-c5f3-b88d0fd2dd41@codeaurora.org>
Date:   Sun, 7 Apr 2019 00:17:50 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190406131415.GA3844@hari-Inspiron-1545>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 4/6/2019 6:44 PM, Hariprasad Kelam wrote:
> Changes passing function argument 0 to NULL to avoid below sparse
> warning
>
>   CHECK   drivers/watchdog//machzwd.c
> drivers/watchdog//machzwd.c:321:25: warning: Using plain integer as NULL
> pointer
> Signed-off-by: Hariprasad Kelam <hariprasad.kelam@gmail.com>
Reviewed-by: Mukesh Ojha <mojha@codeaurora.org>

Cheers,
-Mukesh

> ---
>   drivers/watchdog/machzwd.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/watchdog/machzwd.c b/drivers/watchdog/machzwd.c
> index 88d823d..c3926d0 100644
> --- a/drivers/watchdog/machzwd.c
> +++ b/drivers/watchdog/machzwd.c
> @@ -318,7 +318,7 @@ static long zf_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
>   	case WDIOC_GETBOOTSTATUS:
>   		return put_user(0, p);
>   	case WDIOC_KEEPALIVE:
> -		zf_ping(0);
> +		zf_ping(NULL);
>   		break;
>   	default:
>   		return -ENOTTY;
