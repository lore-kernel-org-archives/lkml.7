Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 287D1C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 11:09:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E0A362082C
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 11:09:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qocdnVak"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728113AbfCVLJ0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 07:09:26 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:34968 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726667AbfCVLJ0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 07:09:26 -0400
Received: by mail-lj1-f194.google.com with SMTP id t13so1689907lji.2;
        Fri, 22 Mar 2019 04:09:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=Eg78DCTu8GLZTzLmHUotjjOZKd0IHC9v3Rv5FsiM3kk=;
        b=qocdnVakNIvremL+J8pHBn2k21UU0LKbQjnaZJQwLqagyoADtoENpVW+CUOhNyQY6f
         cZpyDESrxHPsVh5sWGUO1F4/4b/aYDJ3/N4S4/5bwGIKlatmq4tsluklH1ezatuwXYm9
         8P3pFTbK4kl109xW6PT5XVPIWj1Vkmnxmrvrn0U+r4FaB6tcsEd0QoXa1n9KW8lUJ/Rz
         lni1bm/0ApNY+1rkmh1lvtaFWeGz1HIdeeYgVsHmaHxvMcXO8HO2VBu75/1sA7Xp2X3f
         1Q92SwqALY09qZuogBOxG+atPFzZxjfslhw8k0E+l3o+Ib8K9Sf6TJzARjRoixLDXKn1
         wnPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=Eg78DCTu8GLZTzLmHUotjjOZKd0IHC9v3Rv5FsiM3kk=;
        b=nXp+EmJbhw7vk7LS4+gQI0jieLBcXv8MbD5prJwMl4Em3bW7t1ZuyIg3cWKpC82xh0
         v/fZ3kKf3U0JCAi1UNg/F4W5/zlKyft8qZvNZaHlEwxHaA15c99zqvOZm62yqGxGsV//
         JeHc5NpbtndUle5G+9N4hm6joLgZ8esHfXxjkKs6Ilx1BhJ8LxYi5u5u+WxaKYNHhUW2
         PSrnqXhGnHuzm8Po0tQmlOvtvN7Jextsm+DUT1jethYv44x/YopGZcQy5//oZvcAxvY0
         LcLSLoSZtslfz2e0nkuOiV5+Iz6SrH7ZN4xLVaJGpszpfx7vsBDPZ9rjgQOVXYwLPO28
         Ka7A==
X-Gm-Message-State: APjAAAWuNPqRaL24G6iCgFORyNzN92BIE/ZqQTJ46d0nas0kr/H2Gldr
        y54SeqxBOIzWYxRo61Eh4Og=
X-Google-Smtp-Source: APXvYqx0MNFYbNTLbUorGAr6kzIXtKrGJozJJURIbWrOl87OXgl4Hmjl2cN2NxVRLlJqky796ysUug==
X-Received: by 2002:a2e:97cc:: with SMTP id m12mr4943781ljj.181.1553252964189;
        Fri, 22 Mar 2019 04:09:24 -0700 (PDT)
Received: from [10.17.182.20] (ll-74.141.223.85.sovam.net.ua. [85.223.141.74])
        by smtp.gmail.com with ESMTPSA id j2sm1581215lfm.56.2019.03.22.04.09.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 22 Mar 2019 04:09:23 -0700 (PDT)
Subject: Re: [Xen-devel][PATCH] Input: xen-kbdfront - signal the backend that
 we disconnect
To:     Juergen Gross <jgross@suse.com>, xen-devel@lists.xenproject.org,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        dmitry.torokhov@gmail.com, boris.ostrovsky@oracle.com
Cc:     Volodymyr_Babchuk@epam.com,
        Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>
References: <20190315092348.32613-1-andr2000@gmail.com>
 <32add426-ae36-ecc9-aa3e-6169fe04f231@suse.com>
From:   Oleksandr Andrushchenko <andr2000@gmail.com>
Message-ID: <9b814fc6-d130-ec63-65a1-fbfd957de52b@gmail.com>
Date:   Fri, 22 Mar 2019 13:09:22 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <32add426-ae36-ecc9-aa3e-6169fe04f231@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/22/19 1:03 PM, Juergen Gross wrote:
> On 15/03/2019 10:23, Oleksandr Andrushchenko wrote:
>> From: Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>
>>
>> While disconnecting from the backend we clean up shared resources
>> (event channel, ring buffer), but never let the backend know about
>> that. This may lead to inconsistent backend state and/or shared
>> resources use.
>> Fix this by explicitly letting the backend know that frontend has
>> destroyed shared resources by changing its Xen bus state accordingly.
>>
>> Signed-off-by: Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>
>> ---
>>   drivers/input/misc/xen-kbdfront.c | 2 ++
>>   1 file changed, 2 insertions(+)
>>
>> diff --git a/drivers/input/misc/xen-kbdfront.c b/drivers/input/misc/xen-kbdfront.c
>> index 24bc5c5d876f..ecb6e719e0e2 100644
>> --- a/drivers/input/misc/xen-kbdfront.c
>> +++ b/drivers/input/misc/xen-kbdfront.c
>> @@ -488,6 +488,8 @@ static int xenkbd_connect_backend(struct xenbus_device *dev,
>>   
>>   static void xenkbd_disconnect_backend(struct xenkbd_info *info)
>>   {
>> +	xenbus_switch_state(info->xbdev, XenbusStateClosing);
>> +
>>   	if (info->irq >= 0)
>>   		unbind_from_irqhandler(info->irq, info);
>>   	info->irq = -1;
>>
> As already stated for the related netfront patch: I'm not sure this
> is really what we want. Have you tested xl save/restore or migration
> of the guest with your patch applied?
Well, it comes out that this is not enough and needs much more work,
so please let's abandon this patch
>
> Juergen
Thank you,
Oleksandr
