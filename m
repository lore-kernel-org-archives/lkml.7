Return-Path: <SRS0=EIds=SH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51B83C282CE
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 17:01:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2AB28206C0
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 17:01:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731500AbfDERBU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Apr 2019 13:01:20 -0400
Received: from ivanoab6.miniserver.com ([5.153.251.140]:56746 "EHLO
        www.kot-begemot.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730492AbfDERBU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Apr 2019 13:01:20 -0400
X-Greylist: delayed 2626 seconds by postgrey-1.27 at vger.kernel.org; Fri, 05 Apr 2019 13:01:19 EDT
Received: from [192.168.17.6] (helo=jain.kot-begemot.co.uk)
        by www.kot-begemot.co.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <anton.ivanov@kot-begemot.co.uk>)
        id 1hCRX0-0000Ds-Gd; Fri, 05 Apr 2019 16:17:30 +0000
Received: from jain.kot-begemot.co.uk ([192.168.3.3])
        by jain.kot-begemot.co.uk with esmtp (Exim 4.89)
        (envelope-from <anton.ivanov@kot-begemot.co.uk>)
        id 1hCRWx-0001Gf-Pu; Fri, 05 Apr 2019 17:17:30 +0100
Subject: Re: [PATCH] um: Do not unlock mutex that is not hold.
To:     Daniel Walter <dwalter@google.com>, richard@nod.at,
        linux-um@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org
References: <20190402084332.88965-1-dwalter@google.com>
From:   Anton Ivanov <anton.ivanov@kot-begemot.co.uk>
Message-ID: <cb5e35f0-9f95-fec1-9325-be8fa580bf00@kot-begemot.co.uk>
Date:   Fri, 5 Apr 2019 17:17:27 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190402084332.88965-1-dwalter@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Clacks-Overhead: GNU Terry Pratchett
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 02/04/2019 09:43, Daniel Walter wrote:
>   Return error instead of trying to unlock a mutex that is not hold.
> 
> Signed-off-by: Daniel Walter <dwalter@google.com>
> ---
>   arch/um/drivers/ubd_kern.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/um/drivers/ubd_kern.c b/arch/um/drivers/ubd_kern.c
> index aca09be2373e..33c1cd6a12ac 100644
> --- a/arch/um/drivers/ubd_kern.c
> +++ b/arch/um/drivers/ubd_kern.c
> @@ -276,14 +276,14 @@ static int ubd_setup_common(char *str, int *index_out, char **error_out)
>   		str++;
>   		if(!strcmp(str, "sync")){
>   			global_openflags = of_sync(global_openflags);
> -			goto out1;
> +			return err;
>   		}
>   
>   		err = -EINVAL;
>   		major = simple_strtoul(str, &end, 0);
>   		if((*end != '\0') || (end == str)){
>   			*error_out = "Didn't parse major number";
> -			goto out1;
> +			return err;
>   		}
>   
>   		mutex_lock(&ubd_lock);
> 

Reviewed-by: Anton Ivanov <anton.ivanov@cambridgegreys.com>
Acked-by: Anton Ivanov <anton.ivanov@cambridgegreys.com>

-- 
Anton R. Ivanov
https://www.kot-begemot.co.uk/
