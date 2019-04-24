Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AC02C282E3
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 12:57:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF2FE21773
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 12:57:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JmeGTZKC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730302AbfDXM5m (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 08:57:42 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:39909 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726322AbfDXM5m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 08:57:42 -0400
Received: by mail-pl1-f194.google.com with SMTP id e92so7479085plb.6;
        Wed, 24 Apr 2019 05:57:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=SLjRph+8jU4ZtxyMRBhIIBKEMjfFncgRikIohBy/zGs=;
        b=JmeGTZKCDidV/196lNg88lKAV3t3Tj7bxyw7LCqH9GKovPsLdUKfzrWQTC11szv0zf
         GkcGnaLhuZxdWVBj+CiWnjlEDo/98/RQnMoqaq2Fy1IPoaC4iEZXlaBWEvKbweiZjpCu
         kC2NTB/fC7athht9rl4l1ALjnOv20SQUBAaOhcBMdkrOsANcLa6PoBAruUJTspzZoP/W
         Wea6KT7OH6xlU98C8eZk+dFxvi8cOUfr/WtkrhW6Rq7IdcyReZwrlREq/UceiX4k2NZN
         3hxIHfVmqZDi2X5ASMfl8BFIwQZQAyc+gGbBocJZztJQdARBBGK/sIzpddpHZTZ2uyRx
         cx+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=SLjRph+8jU4ZtxyMRBhIIBKEMjfFncgRikIohBy/zGs=;
        b=RKpdoe4L/DeC3sRzFrzVkbrN/hnD6hEg960E3YiNWM0XHmFn727RfPJGkO5+yLJGiE
         16/N1N5BubxpKoAabVfmDScIEC7RS5iKSAfGxvAGgsNfYQnAUzzXcqxMNANCFo+Yy/sG
         QVhN7esJx6Zq3+RhUnPOeH2z3lgikEZTtMqVuEul746FEc8m9q8YhSuPY0IJoi9w4XBY
         hn11NFgSBnv1RNtHdHO/bOkQN2EXVpDrE8dHinRcrG2U17/EyBu7dOHpSQNnjkjJ62XN
         oHVfoOg6ShfiGXgEE21JlfmssjRoP5FPzDAyjc/XU+IyN69ydhEWmgW4Ei6N4egGIMxG
         sREg==
X-Gm-Message-State: APjAAAVtQgkoR0rHqs0b+vukXjcu300QTd5b8TySUzrwqxDmDWeBIYev
        RWs3FSISbKL32jRRhtn3BTmpH4ao
X-Google-Smtp-Source: APXvYqxWSio2BfHWAkUa3fFMjK02KxL7lsTKChypOqrdK5FAP5wxh+UroIbrkERmrzOzrT5CWDIqiw==
X-Received: by 2002:a17:902:201:: with SMTP id 1mr32635430plc.89.1556110661368;
        Wed, 24 Apr 2019 05:57:41 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id 6sm31057788pft.64.2019.04.24.05.57.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 24 Apr 2019 05:57:40 -0700 (PDT)
Subject: Re: [PATCH v2 06/16] watchdog: hpwdt: drop warning after calling
 watchdog_init_timeout
To:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Wolfram Sang <wsa@the-dreams.de>
Cc:     Jerry Hoemann <jerry.hoemann@hpe.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Linux Watchdog Mailing List <linux-watchdog@vger.kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20190416102515.12269-1-wsa+renesas@sang-engineering.com>
 <20190416102515.12269-7-wsa+renesas@sang-engineering.com>
 <20190416203431.GA20072@anatevka> <20190416204814.GA26442@roeck-us.net>
 <20190416205533.GB8268@kunai> <20190416212046.GC26442@roeck-us.net>
 <20190416221702.GC8268@kunai> <20190416223813.GA744@roeck-us.net>
 <20190417194528.xwivkyubhxyfrx4m@ninjato>
 <CAMuHMdVuZH86bOBsymuPj+68o+exAtao9509XUjoXkozyi1Hvg@mail.gmail.com>
From:   Guenter Roeck <linux@roeck-us.net>
Message-ID: <54286f3b-98f7-1b7c-8768-2c88ef73e9af@roeck-us.net>
Date:   Wed, 24 Apr 2019 05:57:38 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <CAMuHMdVuZH86bOBsymuPj+68o+exAtao9509XUjoXkozyi1Hvg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/24/19 1:38 AM, Geert Uytterhoeven wrote:
> Hi Wolfram,
> 
> On Wed, Apr 17, 2019 at 9:46 PM Wolfram Sang <wsa@the-dreams.de> wrote:
>>> Yes, that works as well. Note that it will actually print something like
>>> "watchdog: <device>: ..." due to the pr_fmt() at the top of watchdog_core.c.
>>> I guess that should be ok.
>>
>> I have the following diff applied on top of patch 2. Works with and
>> without a parent device. I am not super happy casting 'identity' but
>> since its u8-type is exported to userspace, I think we can't avoid it.
>> Guenter, is this cast safe? Here is the diff:
>>
>> diff --git a/drivers/watchdog/watchdog_core.c b/drivers/watchdog/watchdog_core.c
>> index cd3ca6b366ef..62be9e52a4de 100644
>> --- a/drivers/watchdog/watchdog_core.c
>> +++ b/drivers/watchdog/watchdog_core.c
>> @@ -115,6 +115,8 @@ static void watchdog_check_min_max_timeout(struct watchdog_device *wdd)
>>   int watchdog_init_timeout(struct watchdog_device *wdd,
>>                                  unsigned int timeout_parm, struct device *dev)
>>   {
>> +       const char *dev_str = wdd->parent ? dev_name(wdd->parent) :
>> +                             (const char *)wdd->info->identity;
> 
>      struct watchdog_info {
>              ...
>              __u8  identity[32];     /* Identity of the board */
>      };
> 
> Is identity[] guaranteed to be NUL-terminated?
> 

I would hope so, because we export its contents via sysfs to userspace
with
	return sprintf(buf, "%s\n", wdd->info->identity);

Also, there are already several pr_err() assuming that it is
a string,

Guenter
