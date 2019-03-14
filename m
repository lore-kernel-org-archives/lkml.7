Return-Path: <SRS0=GgR0=RR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E672DC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 14:52:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B317D2075C
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 14:52:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aSOguwzw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726938AbfCNOwc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Mar 2019 10:52:32 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:33297 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726539AbfCNOwb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Mar 2019 10:52:31 -0400
Received: by mail-lj1-f193.google.com with SMTP id z7so5107562lji.0;
        Thu, 14 Mar 2019 07:52:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=30l/yLVqcv3PdQ2omNlC84KOCY1EsOA8XbXrjw+dVbM=;
        b=aSOguwzwteBhNslSigmWnIdkblpckeD2VoozvmSFNDEth5eemT0RzSAGgBVey+uzql
         sTzAHujX3+rirXxUzPurbc7YbjRnnw+pFGIcUmu9gh37nXrwOpzUcsbYtowHDsOK5Cih
         3gQ1QNWCBDM8ffz1iYbO6k8kltIPWOtUDVeyWoU8doMAyp5X1ULNAimrd1LaOU9ugVIX
         BslRLZIyhfPsqOWckFaDZ78hNnD9e9iE/+r1fKwrkfWp73PFjIRh9CCc+Rhepr52f+rZ
         Q+gllIN681fBgAudrHa3KYixvpSfvCZ4uTj+eLa0hNv6rnCdUZst6JVCecJ1iNX2JIT3
         ayAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=30l/yLVqcv3PdQ2omNlC84KOCY1EsOA8XbXrjw+dVbM=;
        b=e36v7ZHcp2IH4GF2Rz2AKcljPXR2A2iPoT4diIb95vA+Iw/XG9Xv0D7LPgtiH1UElO
         n3fzNlD3swkzQvr55X54AWZex1JuxB5ukaBZSy2a9cY7esp6ug7Ll+iO8iEt1O95ntNt
         6nyzd2QVOTghgdVzsjSn+i887ztlJsvYZPYsXRydmiY3B6P2I2UY+mMM3TTUJUP7o6HQ
         EkoBp2RFajHkVor9tW963ZCrZvJ1iXTJX9r2FFrUnjCmV1KvVVL64co3oLEtLlJdKAXL
         tpnFyWLHdWNOZM5BASUku7RHT/VbKvDH5jMSp+SipBs7N3+RpmEZ9ZBucghWG/dlC9CA
         ueGA==
X-Gm-Message-State: APjAAAUzdrygwZqlLDieW2O4YMjoKLrvRWzOWCNbuRU/xykGSj9pfn2T
        Q7UqKPG+Nv/If2tJa7WAwJM=
X-Google-Smtp-Source: APXvYqyAorVubrLp2btNF/rn02J8pA0YpBNfmT8ZAl5D7768tZ2AMAKcejZNEAqNEmRWPYvLphxJdw==
X-Received: by 2002:a2e:9f0b:: with SMTP id u11mr28451717ljk.64.1552575147858;
        Thu, 14 Mar 2019 07:52:27 -0700 (PDT)
Received: from [10.17.182.20] (ll-74.141.223.85.sovam.net.ua. [85.223.141.74])
        by smtp.gmail.com with ESMTPSA id s73sm776388lfs.62.2019.03.14.07.52.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 14 Mar 2019 07:52:27 -0700 (PDT)
Subject: Re: [Xen-devel][PATCH] xen/netfront: Remove unneeded .resume callback
To:     Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        netdev@vger.kernel.org, xen-devel@lists.xenproject.org,
        linux-kernel@vger.kernel.org, jgross@suse.com,
        sstabellini@kernel.org, davem@davemloft.net
Cc:     Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>,
        Volodymyr Babchuk <Volodymyr_Babchuk@epam.com>
References: <20190314131749.25706-1-andr2000@gmail.com>
 <c87d2bfb-b029-6c18-e3ad-cb798055f761@oracle.com>
From:   Oleksandr Andrushchenko <andr2000@gmail.com>
Message-ID: <6205819a-af39-8cd8-db87-f3fe047ff064@gmail.com>
Date:   Thu, 14 Mar 2019 16:52:20 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <c87d2bfb-b029-6c18-e3ad-cb798055f761@oracle.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/14/19 4:47 PM, Boris Ostrovsky wrote:
> On 3/14/19 9:17 AM, Oleksandr Andrushchenko wrote:
>> From: Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>
>>
>> Currently on driver resume we remove all the network queues and
>> destroy shared Tx/Rx rings leaving the driver in its current state
>> and never signaling the backend of this frontend's state change.
>> This leads to the number of consequences:
>> - when frontend withdraws granted references to the rings etc. it cannot
>>    be cleanly done as the backend still holds those (it was not told to
>>    free the resources)
>> - it is not possible to resume driver operation as all the communication
>>    means with the backned were destroyed by the frontend, thus
>>    making the frontend appear to the guest OS as functional, but
>>    not really.
>
> What do you mean? Are you saying that after resume you lose connectivity?
Exactly, if you take a look at the .resume callback as it is now
what it does it destroys the rings etc. and never notifies the backend
of that, e.g. it stays in, say, connected state with communication
channels destroyed. It never goes into any other Xen bus state, so there is
no way its state machine can help recovering.
>
> -boris
>
>
>> Fix this by not destroying communication channels/rings on driver
>> resume.
>>
>> Signed-off-by: Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>
>> ---
>>   drivers/net/xen-netfront.c | 17 -----------------
>>   1 file changed, 17 deletions(-)
>>
>> diff --git a/drivers/net/xen-netfront.c b/drivers/net/xen-netfront.c
>> index c914c24f880b..2ca162048da4 100644
>> --- a/drivers/net/xen-netfront.c
>> +++ b/drivers/net/xen-netfront.c
>> @@ -1422,22 +1422,6 @@ static void xennet_disconnect_backend(struct netfront_info *info)
>>   	}
>>   }
>>   
>> -/**
>> - * We are reconnecting to the backend, due to a suspend/resume, or a backend
>> - * driver restart.  We tear down our netif structure and recreate it, but
>> - * leave the device-layer structures intact so that this is transparent to the
>> - * rest of the kernel.
>> - */
>> -static int netfront_resume(struct xenbus_device *dev)
>> -{
>> -	struct netfront_info *info = dev_get_drvdata(&dev->dev);
>> -
>> -	dev_dbg(&dev->dev, "%s\n", dev->nodename);
>> -
>> -	xennet_disconnect_backend(info);
>> -	return 0;
>> -}
>> -
>>   static int xen_net_read_mac(struct xenbus_device *dev, u8 mac[])
>>   {
>>   	char *s, *e, *macstr;
>> @@ -2185,7 +2169,6 @@ static struct xenbus_driver netfront_driver = {
>>   	.ids = netfront_ids,
>>   	.probe = netfront_probe,
>>   	.remove = xennet_remove,
>> -	.resume = netfront_resume,
>>   	.otherend_changed = netback_changed,
>>   };
>>   

