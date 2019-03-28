Return-Path: <SRS0=Qu8K=R7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1AA8C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 19:34:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6A2BB20685
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 19:34:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="LwC6HNS+";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="SnRWy6bE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726227AbfC1TeR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Mar 2019 15:34:17 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:49736 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725994AbfC1TeR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Mar 2019 15:34:17 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 103E860790; Thu, 28 Mar 2019 19:34:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1553801656;
        bh=aa5y1wanFPJFPrSX/rtLYSSyhLC+I69Lm2O8WNFDsSI=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=LwC6HNS+tbVuIZ352HsMXdvY9y6CACJwy0pB/mSD4xN7PrwyRKux0pY3mCpDJHk40
         vcTZMwWTodpAbklfb/HQvQDPzeqPXrrP2InAR86zrsvnAaUYpVBIwnWHtigytqoAMc
         rIkTNTf/Wj7B6Mv8C153QGO6bUhKKhpAZNOrfR70=
Received: from [10.79.174.182] (blr-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.18.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: mojha@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 86CC760159;
        Thu, 28 Mar 2019 19:34:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1553801653;
        bh=aa5y1wanFPJFPrSX/rtLYSSyhLC+I69Lm2O8WNFDsSI=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=SnRWy6bEPhWI6sqaLlpweSRXM4xr9khQ3J36ou8d19jNgjSKeVRqYuVJDEhjBsrgd
         ik0KGUeuvEOG3gOiwiN+4kIWJOWTLi+9/c7hfmZkTQznM9EKNHhUngYO7ZxJxDnMZB
         BoA4tw6BmNA54KOwccEoxt+w1oSE3feId+ld4AVw=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 86CC760159
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=mojha@codeaurora.org
Subject: Re: [PATCH] n_tty: check for negative and zero space return from
 tty_write_room
To:     Colin King <colin.king@canonical.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20190328171005.5822-1-colin.king@canonical.com>
From:   Mukesh Ojha <mojha@codeaurora.org>
Message-ID: <e5f8282c-60e0-cefe-8ee6-2690a24e3b60@codeaurora.org>
Date:   Fri, 29 Mar 2019 01:04:02 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190328171005.5822-1-colin.king@canonical.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 3/28/2019 10:40 PM, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
>
> The return from tty_write_room could potentially be negative if
> a tty write_room driver returns an error number (not that any seem
> to do). Rather than just check for a zero return, also check for
> a -ve return. This avoids the unsigned nr being set to a large unsigned
> value on the assignment from variable space and can lead to overflowing
> the buffer buf.  Better to be safe than assume all write_room
> implementations in tty drivers are going to do the right thing.
>
> Signed-off-by: Colin Ian King <colin.king@canonical.com>


Looks reasonable to me.


Reviewed-by: Mukesh Ojha <mojha@codeaurora.org>

-Mukesh.


> ---
>   drivers/tty/n_tty.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/tty/n_tty.c b/drivers/tty/n_tty.c
> index 9cdb0fa3c4bf..66630787fbf9 100644
> --- a/drivers/tty/n_tty.c
> +++ b/drivers/tty/n_tty.c
> @@ -550,7 +550,7 @@ static ssize_t process_output_block(struct tty_struct *tty,
>   	mutex_lock(&ldata->output_lock);
>   
>   	space = tty_write_room(tty);
> -	if (!space) {
> +	if (space <= 0) {
>   		mutex_unlock(&ldata->output_lock);
>   		return 0;
>   	}
