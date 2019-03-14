Return-Path: <SRS0=GgR0=RR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 410E5C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 15:10:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0D24E20811
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 15:10:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O97VXI/E"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727091AbfCNPKT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Mar 2019 11:10:19 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:43751 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726691AbfCNPKS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Mar 2019 11:10:18 -0400
Received: by mail-lf1-f67.google.com with SMTP id g7so4489404lfh.10;
        Thu, 14 Mar 2019 08:10:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=QFv7XgSuT6xBTdO3jmwBeBBZOivd4lt0c9Ic6gJvH9I=;
        b=O97VXI/EDTg68BPr4Zgh72YNRtAhr4mALMd/1ETaQFtbcILFB9E0IhSYeHLgSXrHXk
         pEJ21a2rLyWA0UG1JY1aEEPagcxKVev2pTz7PUmu6B6iOSYvFivKbmvZDwN1/2NrFW8T
         AOYf43SATgS9W+ZlHnPgOQ0uiAzPeTCDN1/3ngPIntaiB80+HjrxIu4so/AxxiAycG8L
         3ceTHj3BkfAtTuaglDzuNhZdLIzJ0o+Z/aRVoXrt7b7HvlFiF7nbccM1E1/qsu/YoNr3
         zHg6DDMZj3ee8LGW4aixDcssOp2EvgcQ8Rb9axLy98VIv5J79xCoFkMWP2XujHwXHTCP
         tmBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=QFv7XgSuT6xBTdO3jmwBeBBZOivd4lt0c9Ic6gJvH9I=;
        b=YBUDIXsxkXf1kE9zZQ4Xo18OYvpyTeiFtiRRHEcF3mPaGDHxaHudIpSEi8kq34gxMm
         ZKynuAXWE79XT4uNXdFK63s2Bs577Fld23Mm97HYTdZKk4sc30LbUZ1g1DmFJZu3KbfJ
         twdN7XOYxmxBjKlt9dDqmYskBChiD27/I29z/WzFnXe7Y7+pFjVrhfA33QhZZUtZ1NGS
         yWbAF7Mw4uZX7pYXOZDMub57nqrUsapGZRSd9z3UOrD8455ZergaND6n6Rj1zLOqGXH9
         dOqYpXqWJningIw+UTA1UOYqSM6rKmNOT92wswyhnraVGauxNxbMC9q03gnXh9ckQtiL
         j7ng==
X-Gm-Message-State: APjAAAXFEhRD9RN2aAwaoOf5dW9Z7iuZytDeGUI9WjGoR0sigiwLgWje
        6mBPNa2w169G3k5BaS2WE3k=
X-Google-Smtp-Source: APXvYqz7wFFEbo+hVRZO1gVc80Rjj3BbN8gA5bJyO2gIJ8DcbPG84f/LkEkTBnXtnVhUMwSXoviEJg==
X-Received: by 2002:a19:48d5:: with SMTP id v204mr16000029lfa.70.1552576216324;
        Thu, 14 Mar 2019 08:10:16 -0700 (PDT)
Received: from [10.17.182.20] (ll-74.141.223.85.sovam.net.ua. [85.223.141.74])
        by smtp.gmail.com with ESMTPSA id p3sm2506353ljj.14.2019.03.14.08.10.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 14 Mar 2019 08:10:15 -0700 (PDT)
Subject: Re: [Xen-devel][PATCH] xen/netfront: Remove unneeded .resume callback
To:     Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        netdev@vger.kernel.org, xen-devel@lists.xenproject.org,
        linux-kernel@vger.kernel.org, jgross@suse.com,
        sstabellini@kernel.org, davem@davemloft.net
Cc:     Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>,
        Volodymyr Babchuk <Volodymyr_Babchuk@epam.com>
References: <20190314131749.25706-1-andr2000@gmail.com>
 <c87d2bfb-b029-6c18-e3ad-cb798055f761@oracle.com>
 <6205819a-af39-8cd8-db87-f3fe047ff064@gmail.com>
 <ecc825e6-89d3-bbd5-5243-5cc66fa93045@oracle.com>
From:   Oleksandr Andrushchenko <andr2000@gmail.com>
Message-ID: <b55d4f90-100c-7a2a-9651-c99c06953465@gmail.com>
Date:   Thu, 14 Mar 2019 17:10:14 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <ecc825e6-89d3-bbd5-5243-5cc66fa93045@oracle.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/14/19 5:02 PM, Boris Ostrovsky wrote:
> On 3/14/19 10:52 AM, Oleksandr Andrushchenko wrote:
>> On 3/14/19 4:47 PM, Boris Ostrovsky wrote:
>>> On 3/14/19 9:17 AM, Oleksandr Andrushchenko wrote:
>>>> From: Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>
>>>>
>>>> Currently on driver resume we remove all the network queues and
>>>> destroy shared Tx/Rx rings leaving the driver in its current state
>>>> and never signaling the backend of this frontend's state change.
>>>> This leads to the number of consequences:
>>>> - when frontend withdraws granted references to the rings etc. it
>>>> cannot
>>>>     be cleanly done as the backend still holds those (it was not told to
>>>>     free the resources)
>>>> - it is not possible to resume driver operation as all the
>>>> communication
>>>>     means with the backned were destroyed by the frontend, thus
>>>>     making the frontend appear to the guest OS as functional, but
>>>>     not really.
>>> What do you mean? Are you saying that after resume you lose
>>> connectivity?
>> Exactly, if you take a look at the .resume callback as it is now
>> what it does it destroys the rings etc. and never notifies the backend
>> of that, e.g. it stays in, say, connected state with communication
>> channels destroyed. It never goes into any other Xen bus state, so
>> there is
>> no way its state machine can help recovering.
>
> My tree is about a month old so perhaps there is some sort of regression
> but this certainly works for me. After resume netfront gets
> XenbusStateInitWait from backend which causes xennet_connect().
Ah, the difference can be of the way we get the guest enter
the suspend state. I am making my guest to suspend with:
echo mem > /sys/power/state
And then I use an interrupt to the guest (this is a test code)
to wake it up.
Could you please share your exact use-case when the guest enters suspend
and what you do to resume it?
I can see no way backend may want enter XenbusStateInitWait in my use-case
as it simply doesn't know we want him to.
>
> -boris
>
>
Thank you,
Oleksandr
