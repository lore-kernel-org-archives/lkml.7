Return-Path: <SRS0=GgR0=RR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93775C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 09:25:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5F76A20693
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 09:25:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726885AbfCNJZi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Mar 2019 05:25:38 -0400
Received: from relay.sw.ru ([185.231.240.75]:47630 "EHLO relay.sw.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726689AbfCNJZi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Mar 2019 05:25:38 -0400
Received: from [172.16.25.169]
        by relay.sw.ru with esmtp (Exim 4.91)
        (envelope-from <ktkhai@virtuozzo.com>)
        id 1h4McI-00021J-PM; Thu, 14 Mar 2019 12:25:34 +0300
Subject: Re: Re: [External] Re: vmscan: Reclaim unevictable pages
To:     Pankaj Suryawanshi <pankaj.suryawanshi@einfochips.com>,
        Michal Hocko <mhocko@kernel.org>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "minchan@kernel.org" <minchan@kernel.org>
References: <SG2PR02MB3098A05E09B0D3F3CB1C3B9BE84B0@SG2PR02MB3098.apcprd02.prod.outlook.com>
 <SG2PR02MB309806967AE91179CAFEC34BE84B0@SG2PR02MB3098.apcprd02.prod.outlook.com>
 <SG2PR02MB3098B751EC6B8E32806A42FBE84B0@SG2PR02MB3098.apcprd02.prod.outlook.com>
 <20190314084120.GF7473@dhcp22.suse.cz>
 <SG2PR02MB309894F6D7DF9148846088F3E84B0@SG2PR02MB3098.apcprd02.prod.outlook.com>
From:   Kirill Tkhai <ktkhai@virtuozzo.com>
Message-ID: <226a92b9-94c5-b859-c54b-3aacad3089cc@virtuozzo.com>
Date:   Thu, 14 Mar 2019 12:25:34 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <SG2PR02MB309894F6D7DF9148846088F3E84B0@SG2PR02MB3098.apcprd02.prod.outlook.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14.03.2019 11:52, Pankaj Suryawanshi wrote:
> 
> I am using kernel version 4.14.65 (on Android pie [ARM]).
> 
> No additional patches applied on top of vanilla.(Core MM).
> 
> If  I change in the vmscan.c as below patch, it will work. 

Sorry, but 4.14.65 does not have braces around trylock_page(),
like in your patch below.

See https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/tree/mm/vmscan.c?h=v4.14.65

[...]

>> diff --git a/mm/vmscan.c b/mm/vmscan.c
>> index be56e2e..2e51edc 100644
>> --- a/mm/vmscan.c
>> +++ b/mm/vmscan.c
>> @@ -990,15 +990,17 @@ static unsigned long shrink_page_list(struct list_head *page_list,
>>                  page = lru_to_page(page_list);
>>                  list_del(&page->lru);
>>
>>                 if (!trylock_page(page)) {
>>                          goto keep;
>>                 }
