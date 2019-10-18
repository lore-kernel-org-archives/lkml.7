Return-Path: <SRS0=6OEZ=YL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26AA5CA9EA1
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 08:38:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0AB5321897
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 08:38:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407597AbfJRIi1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Oct 2019 04:38:27 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:4730 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727903AbfJRIiZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Oct 2019 04:38:25 -0400
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 8334FBB43E802C608D56;
        Fri, 18 Oct 2019 16:38:22 +0800 (CST)
Received: from [127.0.0.1] (10.202.227.179) by DGGEMS410-HUB.china.huawei.com
 (10.3.19.210) with Microsoft SMTP Server id 14.3.439.0; Fri, 18 Oct 2019
 16:38:13 +0800
Subject: Re: [PATCH v6 2/2] drivers/perf: Add CCPI2 PMU support in ThunderX2
 UNCORE driver.
To:     Ganapatrao Kulkarni <gklkml16@gmail.com>,
        Will Deacon <will@kernel.org>
References: <1571218608-15933-1-git-send-email-gkulkarni@marvell.com>
 <1571218608-15933-3-git-send-email-gkulkarni@marvell.com>
 <b8e1a637-faf4-4567-7d3e-a4f13dfa1cf0@huawei.com>
 <CAKTKpr4QoTDjbSxO4CvSH2sNvmrTJKjxi+RZH4mYfyDaaN96Sw@mail.gmail.com>
 <20191017154750.jgn6e3465qrsu53e@willie-the-truck>
 <CAKTKpr5ntp5X6Lvp=rKT_F1E1ftdqtjSWTgpEOqEwaDMH2kc1w@mail.gmail.com>
CC:     Ganapatrao Prabhakerrao Kulkarni <gkulkarni@marvell.com>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "corbet@lwn.net" <corbet@lwn.net>,
        Jan Glauber <jglauber@marvell.com>,
        Jayachandran Chandrasekharan Nair <jnair@marvell.com>,
        Robert Richter <rrichter@marvell.com>,
        Zhangshaokun <zhangshaokun@hisilicon.com>
From:   John Garry <john.garry@huawei.com>
Message-ID: <f7c91a7d-1f0e-24be-1491-fd0dae7f1daf@huawei.com>
Date:   Fri, 18 Oct 2019 09:38:06 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.3.0
MIME-Version: 1.0
In-Reply-To: <CAKTKpr5ntp5X6Lvp=rKT_F1E1ftdqtjSWTgpEOqEwaDMH2kc1w@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.227.179]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18/10/2019 05:21, Ganapatrao Kulkarni wrote:
> Hi Will,
>
> On Thu, Oct 17, 2019 at 9:17 PM Will Deacon <will@kernel.org> wrote:
>>
>> On Thu, Oct 17, 2019 at 12:38:51PM +0530, Ganapatrao Kulkarni wrote:
>>> On Wed, Oct 16, 2019 at 7:01 PM John Garry <john.garry@huawei.com> wrote:
>>>>> +TX2_EVENT_ATTR(req_pktsent, CCPI2_EVENT_REQ_PKT_SENT);
>>>>> +TX2_EVENT_ATTR(snoop_pktsent, CCPI2_EVENT_SNOOP_PKT_SENT);
>>>>> +TX2_EVENT_ATTR(data_pktsent, CCPI2_EVENT_DATA_PKT_SENT);
>>>>> +TX2_EVENT_ATTR(gic_pktsent, CCPI2_EVENT_GIC_PKT_SENT);
>>>>> +
>>>>> +static struct attribute *ccpi2_pmu_events_attrs[] = {
>>>>> +     &tx2_pmu_event_attr_req_pktsent.attr.attr,
>>>>> +     &tx2_pmu_event_attr_snoop_pktsent.attr.attr,
>>>>> +     &tx2_pmu_event_attr_data_pktsent.attr.attr,
>>>>> +     &tx2_pmu_event_attr_gic_pktsent.attr.attr,
>>>>> +     NULL,
>>>>> +};
>>>>
>>>> Hi Ganapatrao,
>>>>
>>>> Have you considered adding these as uncore pmu-events in the perf tool?
>>>>
>>> At the moment no, since the number of events exposed/listed are very few.
>>
>> Then sounds like a perfect time to nip it in the bud before the list grows
>> ;)
>
> I had internal discussion with architecture team, they have confirmed
> that, these are the only published events and no plan to add new.
> However, If any such request comes from HW team in future, i will add
> them to JSON files.

Don't you find perf list is swamped with all the uncore events?

For Huawei platform, I find this:
./perf list pmu | grep "Kernel PMU event" | grep hisi | wc -l
648

That's because we have so many instances of the same PMUs, not because 
there are many events per PMU.

TBH, I would like to delete all the events from the hisi uncore kernel 
drivers, now that they're supported in the perf tool, but I think that 
would constitute an ABI breakage.

Maybe there is a way to hide them, but I couldn't find it.

John

>
> I have incorporate all your previous comments, Can you please Ack and
> queue it to 5.5?
>
>>
>> If you can manage with these things in userspace, then I agree with John
>> that it would be preferential to do it that way. It also offers more
>> flexibility if we get the metricgroup stuff working properly (I think it's
>> buggered for big/little atm).
>>
>> Will
>
> Thanks,
> Ganapat
>
> .
>


