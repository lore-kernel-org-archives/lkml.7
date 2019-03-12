Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35A53C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 12:15:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 03CCC206DF
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 12:15:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726670AbfCLMPm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Mar 2019 08:15:42 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:59316 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726284AbfCLMPm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Mar 2019 08:15:42 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: eballetbo)
        with ESMTPSA id BB3B0280CCC
Subject: Re: [PATCH] platform/chrome: Fix locking pattern in
 wilco_ec_mailbox()
To:     Nick Crews <ncrews@chromium.org>, bleung@chromium.org
Cc:     linux-kernel@vger.kernel.org, dlaurie@chromium.org,
        groeck@google.com, dtor@google.com
References: <20190311155838.255314-1-ncrews@chromium.org>
From:   Enric Balletbo i Serra <enric.balletbo@collabora.com>
Message-ID: <b593cc1e-4e88-9b56-b533-4d4481dde6db@collabora.com>
Date:   Tue, 12 Mar 2019 13:15:37 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <20190311155838.255314-1-ncrews@chromium.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Nick,

On 11/3/19 16:58, Nick Crews wrote:
> Before, ec->data_buffer could be written to from multiple
> contexts at the same time. Since the ec is shared data,
> it needs to be inside the mutex as well.
> 

Probably you're missing a fixes tag here.

> Signed-off-by: Nick Crews <ncrews@chromium.org>
> ---
>  drivers/platform/chrome/wilco_ec/mailbox.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/platform/chrome/wilco_ec/mailbox.c b/drivers/platform/chrome/wilco_ec/mailbox.c
> index f6ff29a11f1a..d6cb96168285 100644
> --- a/drivers/platform/chrome/wilco_ec/mailbox.c
> +++ b/drivers/platform/chrome/wilco_ec/mailbox.c
> @@ -223,12 +223,12 @@ int wilco_ec_mailbox(struct wilco_ec_device *ec, struct wilco_ec_message *msg)
>  		msg->command, msg->type, msg->flags, msg->response_size,
>  		msg->request_size);
>  
> -	/* Prepare request packet */

There is a reason to remove this comment?

> +	mutex_lock(&ec->mailbox_lock);
> +
>  	rq = ec->data_buffer;
>  	wilco_ec_prepare(msg, rq);
> -
> -	mutex_lock(&ec->mailbox_lock);
>  	ret = wilco_ec_transfer(ec, msg, rq);
> +	

Trailing whitespaces here

>  	mutex_unlock(&ec->mailbox_lock);
>  
>  	return ret;
> 

You don't need to resend, I'll add the fixes tag, fix the trailing whitespaces
and queue as a fix for 5.1 once the merge window closes.

Thanks,
 Enric
