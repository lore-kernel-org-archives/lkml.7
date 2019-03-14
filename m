Return-Path: <SRS0=GgR0=RR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 036C1C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 13:50:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C9CBF2184C
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 13:50:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VtmT4GCl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727627AbfCNNuP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Mar 2019 09:50:15 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:36162 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727394AbfCNNuP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Mar 2019 09:50:15 -0400
Received: by mail-lj1-f193.google.com with SMTP id v10so4888892lji.3;
        Thu, 14 Mar 2019 06:50:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=4ddxflZglpAI5MJot1Q2YWINVe1fcfeCgG+OR0bKChI=;
        b=VtmT4GClFn3/Smbv3EEZ13PJDaMMv2Am6r9u/b4ENSsdFFNS0As3uSAExqXDzvFOwh
         ot4CwySDMPtRf1myo9GDFY9w7DC1ZS+kV3EwnJnmTSLAl4HXnfmK/id3GNQ7euvDqp7+
         3Yk360b08ekddYbaqSPUDli6O62zfvswgZXgRKyr27x6pe0a+FPcmKKRG8eatRfhCMna
         c+dQZ8WFUOJ3aoCGqahPojJeHSlvoc6h1CrcCdN+CfUR4NzF08ueg/purBsECr/o6jbb
         3hu97OSOTb1stjerrNdePinI0hdF2ec2y01kMaJ2IBLZemhVguVUD7EQPWWSsihywbDt
         jK+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=4ddxflZglpAI5MJot1Q2YWINVe1fcfeCgG+OR0bKChI=;
        b=VYi48awlPcsqAxDipbGv3kRWUw5ZvELknEyYfaQCjN9v8II+EZwKuKMZRnmoIpV3ww
         DPxgGU82C3eLrWTdpKc6F5MIX2GLbwi1eQLu25aY9dSVokbj+NrbZFVOx2IOSJmOom4T
         KeGztaVkrSQ1JW9egK0jCGKGJVp6oOv1LteSn1SjHQzjJFHS34UBLnMHeK/QuW+7DWK0
         RMGbs5yY4ITb0pb/56jafbeV3zDND5hFJaRijDr4XLFEi04zjsMQFIahvtZmXn3WIccU
         8dNCPuqDua0spskBpxJzewW2DHVlgFaUDRgloazynV3IlqQrt73rCSjhdctyvCO7n7wu
         Nb7g==
X-Gm-Message-State: APjAAAVhwgOnJyyoJKn3yfQqgmUIiMhI9/3lCAoFbdDGEbeKkMss9kbl
        aSfLSmc5ChxS+Sg5SaSt9tM=
X-Google-Smtp-Source: APXvYqwr8rUwihxlALmupZ0d+9phhoXK4fkLpld3mSIOF6er5NKvdJ3BV7UJX1vx9YYxtjYj/3g8Gw==
X-Received: by 2002:a2e:8eda:: with SMTP id e26mr557835ljl.157.1552571412733;
        Thu, 14 Mar 2019 06:50:12 -0700 (PDT)
Received: from [10.17.182.20] (ll-74.141.223.85.sovam.net.ua. [85.223.141.74])
        by smtp.gmail.com with ESMTPSA id m16sm2431905ljb.50.2019.03.14.06.50.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 14 Mar 2019 06:50:12 -0700 (PDT)
Subject: Re: [Xen-devel][PATCH] xen/netfront: Remove unneeded .resume callback
To:     netdev@vger.kernel.org, xen-devel@lists.xenproject.org,
        linux-kernel@vger.kernel.org, jgross@suse.com,
        boris.ostrovsky@oracle.com, sstabellini@kernel.org,
        davem@davemloft.net
Cc:     Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>
References: <20190314131749.25706-1-andr2000@gmail.com>
From:   Oleksandr Andrushchenko <andr2000@gmail.com>
Message-ID: <5c8dd6fa-7173-6618-ef4e-018c0be20028@gmail.com>
Date:   Thu, 14 Mar 2019 15:50:10 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <20190314131749.25706-1-andr2000@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I am still confused about suspend/resume for the front drivers,
for instance, block front [1] does implement full/proper reconnect
on .resume, but net front only does this partially.

Could anyone please shed some light on suspend/resume design?

Thank you,
Oleksandr

On 3/14/19 3:17 PM, Oleksandr Andrushchenko wrote:
> From: Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>
>
> Currently on driver resume we remove all the network queues and
> destroy shared Tx/Rx rings leaving the driver in its current state
> and never signaling the backend of this frontend's state change.
> This leads to the number of consequences:
> - when frontend withdraws granted references to the rings etc. it cannot
>    be cleanly done as the backend still holds those (it was not told to
>    free the resources)
> - it is not possible to resume driver operation as all the communication
>    means with the backned were destroyed by the frontend, thus
>    making the frontend appear to the guest OS as functional, but
>    not really.
>
> Fix this by not destroying communication channels/rings on driver
> resume.
>
> Signed-off-by: Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>
> ---
>   drivers/net/xen-netfront.c | 17 -----------------
>   1 file changed, 17 deletions(-)
>
> diff --git a/drivers/net/xen-netfront.c b/drivers/net/xen-netfront.c
> index c914c24f880b..2ca162048da4 100644
> --- a/drivers/net/xen-netfront.c
> +++ b/drivers/net/xen-netfront.c
> @@ -1422,22 +1422,6 @@ static void xennet_disconnect_backend(struct netfront_info *info)
>   	}
>   }
>   
> -/**
> - * We are reconnecting to the backend, due to a suspend/resume, or a backend
> - * driver restart.  We tear down our netif structure and recreate it, but
> - * leave the device-layer structures intact so that this is transparent to the
> - * rest of the kernel.
> - */
> -static int netfront_resume(struct xenbus_device *dev)
> -{
> -	struct netfront_info *info = dev_get_drvdata(&dev->dev);
> -
> -	dev_dbg(&dev->dev, "%s\n", dev->nodename);
> -
> -	xennet_disconnect_backend(info);
> -	return 0;
> -}
> -
>   static int xen_net_read_mac(struct xenbus_device *dev, u8 mac[])
>   {
>   	char *s, *e, *macstr;
> @@ -2185,7 +2169,6 @@ static struct xenbus_driver netfront_driver = {
>   	.ids = netfront_ids,
>   	.probe = netfront_probe,
>   	.remove = xennet_remove,
> -	.resume = netfront_resume,
>   	.otherend_changed = netback_changed,
>   };
>   

[1] 
https://elixir.bootlin.com/linux/v5.0.2/source/drivers/block/xen-blkfront.c#L2072
