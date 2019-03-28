Return-Path: <SRS0=Qu8K=R7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8A64C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 02:14:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 756672075C
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 02:14:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lQ+X+HeE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728162AbfC1COu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 22:14:50 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:37043 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725948AbfC1COt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 22:14:49 -0400
Received: by mail-pl1-f196.google.com with SMTP id q6so4208219pll.4;
        Wed, 27 Mar 2019 19:14:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=WcIfSuDzcVqJnqzpsrMSqQpY9TJgfHhhgtnvEmSCiNQ=;
        b=lQ+X+HeEN4NUPNA+AH698sHgAzSRAqM5EegpFBbYOZhPIf1c13Py0HIGMPokGoOGVy
         I/+B+MqD0l5sUnna9kmcTCAJLKC+qkAItFs7kbKoVsaxX6M5fQL/uECTTNbMO9lhLVlA
         /lzeneWnKqONxjRiQ+3l+MJHye0gWpwpVeXy0Z01nQhjhiLHT1jtGPfzfj4MX5JbHyW1
         LtHOtDxxuOfP7gL3KCQxcop4BEX4AreJo/FprqizPke7+amMian8MkSWQGyZ0ZKWhErt
         g0WCdBA8tvZsGzrlRUeTTsf4DyVXLnGtiVUz5jh52F18+i70M4Wu4YN4YrfGACz20tk3
         He3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=WcIfSuDzcVqJnqzpsrMSqQpY9TJgfHhhgtnvEmSCiNQ=;
        b=iHYkBc7/ukYImLgTK6xuurZBBLPLff5JMA5Gl+ikiF2IJ2Xi0v0YCYcGbnywS5XtBt
         2SGDXNK+si5+XCzHbv/yLsphFvJuYCosIoUqbfJyqy+k618amDvVohY1oE6QPp6WAhAs
         7BxrDqDFDOO/w7nKxHNEKsnQ9K7pJWAYjnSUfG+P3ZmR1wS923wFnAUaskU8R/FV3RrF
         55VFeJYqJ1qPhXVGZ4gdOu29lIFWAg0X5uRpb95RHpmxa7uZOE6hVYIge43LpLeRvpaF
         L+lH9A9htXccVgw2D9znNY90UQXQA/sPifNegOANoHnyMWItBm4qnYsVD2wCCNJfpjcK
         Z7rg==
X-Gm-Message-State: APjAAAVAYTHW5sE+OeF/ARAqEH0YFx2IWseVMMzrlF+VQSc+J8CbcDdl
        JhcOA5af3yLlahU2NrGE9lC667MF
X-Google-Smtp-Source: APXvYqy5JeHM9msmkwi5MPt//pUIeUxpFKRx8f1ZqKJxmGATPCg4CCFSwjqT+XAwEQ/L7l1hBeBakQ==
X-Received: by 2002:a17:902:9881:: with SMTP id s1mr10923229plp.99.1553739288543;
        Wed, 27 Mar 2019 19:14:48 -0700 (PDT)
Received: from [192.168.1.3] (ip68-101-123-102.oc.oc.cox.net. [68.101.123.102])
        by smtp.gmail.com with ESMTPSA id r11sm2561069pga.87.2019.03.27.19.14.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 27 Mar 2019 19:14:47 -0700 (PDT)
Subject: Re: [PATCH net-next v5 09/22] ethtool: implement EVENT notifications
To:     Michal Kubecek <mkubecek@suse.cz>, Jiri Pirko <jiri@resnulli.us>
Cc:     David Miller <davem@davemloft.net>, netdev@vger.kernel.org,
        Jakub Kicinski <jakub.kicinski@netronome.com>,
        Andrew Lunn <andrew@lunn.ch>,
        John Linville <linville@tuxdriver.com>,
        Stephen Hemminger <stephen@networkplumber.org>,
        linux-kernel@vger.kernel.org
References: <cover.1553532199.git.mkubecek@suse.cz>
 <971a93b567c81103716902cd1ad00946201f9710.1553532199.git.mkubecek@suse.cz>
 <20190327130428.GB14297@nanopsycho> <20190327141443.GS26076@unicorn.suse.cz>
From:   Florian Fainelli <f.fainelli@gmail.com>
Openpgp: preference=signencrypt
Message-ID: <a3d94fdf-964a-5a2c-3d96-74a0323af37e@gmail.com>
Date:   Wed, 27 Mar 2019 19:14:43 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190327141443.GS26076@unicorn.suse.cz>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 3/27/2019 7:14 AM, Michal Kubecek wrote:
> On Wed, Mar 27, 2019 at 02:04:28PM +0100, Jiri Pirko wrote:
>> Mon, Mar 25, 2019 at 06:08:21PM CET, mkubecek@suse.cz wrote:
>>> Three types of netlink notifications are introduced:
>>>
>>>  - ETHA_EVENT_NEWDEV to notify about newly registered network devices
>>>  - ETHA_EVENT_DELDEV to notify about unregistered network devices
>>>  - ETHA_EVENT_RENAMEDEV to notify about renamed network device
>>>
>>> The notifications are triggered by NETDEV_REGISTER, NETDEV_UNREGISTER and
>>> NETDEV_CHANGENAME notifiers.
>>>
>>> These notifications are intended for applications and daemons monitoring
>>> ethtool events to allow updating the list of existing devices without
>>> having to open another socket for rtnetlink.
>>
>> Wait. You duplicate events that are already going out through RTNETLINK.
>> App should open RTNETLINK in order to get those. Other apps are doing
>> that too. I don't think that duplications like this are desirable :/
> 
> Is there a way to filter or at least recognize these events when using
> rtnetlink? I couldn't find any. The only way seems to be getting every
> RTM_NEWLINK message (there can be quite a lot of those), always perform
> the lookup in my device list and recognize what happened - only to
> almost always find that nothing interesting. It is possible, sure, but
> I would really like to avoid it.

I am afraid you are right about this, would adding a filtering
capability specifically for this in rtnetlink be a better route?
-- 
Florian
