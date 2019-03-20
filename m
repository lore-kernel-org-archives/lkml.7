Return-Path: <SRS0=4Jrr=RX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86671C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 03:50:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3C2B920857
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 03:50:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="CjWs6wNE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727579AbfCTDuT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Mar 2019 23:50:19 -0400
Received: from smtp-fw-9102.amazon.com ([207.171.184.29]:34825 "EHLO
        smtp-fw-9102.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727106AbfCTDuS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Mar 2019 23:50:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1553053816; x=1584589816;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=B7Z9k8q1xGnoUmWrs1oyq1DlUAqkHTxgYEU9CfpPdOQ=;
  b=CjWs6wNEpvfPCrT9oFyiUH6NBxLyK6J08JJI8mzYUim+5RYPyknsTOWj
   /USNCPLGvNvKcH+YsjoXvRe/xmEnptUVt0DlUVYnPkLxYNCl4oqOXtSJp
   8SGfkVlXORidFDI7MGm1WxH6aLrTvO5xunney6YVr0mxGfg09uGB0OZm5
   8=;
X-IronPort-AV: E=Sophos;i="5.60,246,1549929600"; 
   d="scan'208";a="666091845"
Received: from sea3-co-svc-lb6-vlan3.sea.amazon.com (HELO email-inbound-relay-1a-e34f1ddc.us-east-1.amazon.com) ([10.47.22.38])
  by smtp-border-fw-out-9102.sea19.amazon.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 20 Mar 2019 03:50:11 +0000
Received: from EX13MTAUWB001.ant.amazon.com (iad55-ws-svc-p15-lb9-vlan3.iad.amazon.com [10.40.159.166])
        by email-inbound-relay-1a-e34f1ddc.us-east-1.amazon.com (8.14.7/8.14.7) with ESMTP id x2K3o5VS003555
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=FAIL);
        Wed, 20 Mar 2019 03:50:07 GMT
Received: from EX13D10UWB004.ant.amazon.com (10.43.161.121) by
 EX13MTAUWB001.ant.amazon.com (10.43.161.207) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Wed, 20 Mar 2019 03:50:07 +0000
Received: from [10.94.35.169] (10.43.161.197) by EX13D10UWB004.ant.amazon.com
 (10.43.161.121) with Microsoft SMTP Server (TLS) id 15.0.1367.3; Wed, 20 Mar
 2019 03:50:06 +0000
Subject: Re: [Xen-devel] [PATCH] xen/netfront: Remove unneeded .resume
 callback
To:     Oleksandr Andrushchenko <andr2000@gmail.com>,
        Julien Grall <julien.grall@arm.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        <netdev@vger.kernel.org>, <xen-devel@lists.xenproject.org>,
        <linux-kernel@vger.kernel.org>, <jgross@suse.com>,
        <sstabellini@kernel.org>, <davem@davemloft.net>
CC:     Volodymyr Babchuk <Volodymyr_Babchuk@epam.com>,
        Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>,
        <anchalag@amazon.com>, <eduval@amazon.com>
References: <20190314131749.25706-1-andr2000@gmail.com>
 <c87d2bfb-b029-6c18-e3ad-cb798055f761@oracle.com>
 <6205819a-af39-8cd8-db87-f3fe047ff064@gmail.com>
 <ecc825e6-89d3-bbd5-5243-5cc66fa93045@oracle.com>
 <b55d4f90-100c-7a2a-9651-c99c06953465@gmail.com>
 <09afcdca-258f-e5ca-5c31-b7fd079eb213@oracle.com>
 <3e868e7a-4872-e8ab-fd2c-90917ad6d593@arm.com>
 <d709d185-5345-c463-3fd1-e711f954e58a@gmail.com>
From:   Munehisa Kamata <kamatam@amazon.com>
Message-ID: <435369ba-ad3b-1d3a-c2f4-babe8bb6189c@amazon.com>
Date:   Tue, 19 Mar 2019 20:50:05 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.3
MIME-Version: 1.0
In-Reply-To: <d709d185-5345-c463-3fd1-e711f954e58a@gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.43.161.197]
X-ClientProxiedBy: EX13D17UWC002.ant.amazon.com (10.43.162.61) To
 EX13D10UWB004.ant.amazon.com (10.43.161.121)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/18/2019 3:02 AM, Oleksandr Andrushchenko wrote:
> +Amazon
> pls see inline
Hi Oleksandr,

Let me add some comments as the original author of the series.

> 
> On 3/14/19 9:00 PM, Julien Grall wrote:
>> Hi,
>>
>> On 3/14/19 3:40 PM, Boris Ostrovsky wrote:
>>> On 3/14/19 11:10 AM, Oleksandr Andrushchenko wrote:
>>>> On 3/14/19 5:02 PM, Boris Ostrovsky wrote:
>>>>> On 3/14/19 10:52 AM, Oleksandr Andrushchenko wrote:
>>>>>> On 3/14/19 4:47 PM, Boris Ostrovsky wrote:
>>>>>>> On 3/14/19 9:17 AM, Oleksandr Andrushchenko wrote:
>>>>>>>> From: Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>
>>>>>>>>
>>>>>>>> Currently on driver resume we remove all the network queues and
>>>>>>>> destroy shared Tx/Rx rings leaving the driver in its current state
>>>>>>>> and never signaling the backend of this frontend's state change.
>>>>>>>> This leads to the number of consequences:
>>>>>>>> - when frontend withdraws granted references to the rings etc. it
>>>>>>>> cannot
>>>>>>>>      be cleanly done as the backend still holds those (it was not
>>>>>>>> told to
>>>>>>>>      free the resources)
>>>>>>>> - it is not possible to resume driver operation as all the
>>>>>>>> communication
>>>>>>>>      means with the backned were destroyed by the frontend, thus
>>>>>>>>      making the frontend appear to the guest OS as functional, but
>>>>>>>>      not really.
>>>>>>> What do you mean? Are you saying that after resume you lose
>>>>>>> connectivity?
>>>>>> Exactly, if you take a look at the .resume callback as it is now
>>>>>> what it does it destroys the rings etc. and never notifies the backend
>>>>>> of that, e.g. it stays in, say, connected state with communication
>>>>>> channels destroyed. It never goes into any other Xen bus state, so
>>>>>> there is
>>>>>> no way its state machine can help recovering.
>>>>>
>>>>> My tree is about a month old so perhaps there is some sort of regression
>>>>> but this certainly works for me. After resume netfront gets
>>>>> XenbusStateInitWait from backend which causes xennet_connect().
>>>> Ah, the difference can be of the way we get the guest enter
>>>> the suspend state. I am making my guest to suspend with:
>>>> echo mem > /sys/power/state
>>>> And then I use an interrupt to the guest (this is a test code)
>>>> to wake it up.
>>>> Could you please share your exact use-case when the guest enters suspend
>>>> and what you do to resume it?
>>>
>>>
>>> xl save / xl restore
>>>
>>>> I can see no way backend may want enter XenbusStateInitWait in my
>>>> use-case
>>>> as it simply doesn't know we want him to.
>>>
>>>
>>> Yours looks like ACPI path, I don't know how well it was tested TBH.
>>
>> I remember a series from amazon [1] that plays around suspend and hibernation. The patch [2] leads me to think that guest triggered suspend/resume does not work properly. It looks like the series has never been fully reviewed. Not sure why...
> Julien, thanks a lot for bringing these patches to our attention which we obviously missed.
>>
>> Anyway, from my understanding this series may solve Oleksandr issue. However, this would only address the common code side. AFAIK Oleksandr is targeting Arm platform. If so, I think this would require more work than this series. Arm code still miss few bits properly suspend/resume arch specific code (see [2]).
>>
>> I have a branch on my git to track the series. However, they never have been resent after Ian Campbell left Citrix. I would be happy to review them if someone wants to pick them up and repost them.
>>
> First of all, let me make it clear that we are interested in hibernation long term, so it would be
> desirable to re-use as much work form resume/suspend as we can. But, we see it as a step by
> step work, e.g. first S2RAM and later on hibernation.
> Let me clarify the immediate use-case that we have, so it is easier to understand what we want
> and what we don't at the moment. We are about to continue work started by Mirela/Xilinx on
> Suspend-to-RAM for ARM [3] and we made number of assumptions:
> 1. We are talking about *system* suspend, e.g. the goal is to suspend all the components
> of the system and Xen itself at once. Think about this as fast-boot and/or energy saving
> feature if you will.
> 2. With suspend/resume there is no intention to migrate VMs to any other host.
> 3. Most probably configuration of the back/front won't change between suspend/resume.
> But long term we are also thinking for supporting suspend/resume in its broader meaning,
> e.g. what is probably what you mean by suspend/resume.
AFAIK .suspend and .resume callbacks in frontend drivers are
specifically for xl save/restore case rather than the normal "system"
suspend. i.e. The former is Boris' case and something I called "Xen
suspend" in the patch series, the latter should be your interest and
called "ACPI path" here, and I referred to as "PM suspend". They are
very different code paths, see drivers/xen/manage.c for details of
Xen suspend.

> Given that, we think that we don't need Xen support to save grants, page tables and other
> VM's context on suspend at least at the first stage as we are implementing not a fully
> blown suspend/resume, but only S2RAM part of it which is much more simpler than a generic
> suspend implementation. We only need changes to Linux kernel frontend drivers from [1] - the
> piece that we miss is suspend/resume implementation in the netfront driver. What is more, as
> we are not changing back/front configuration, we can even live with empty .resume/.suspend
> frontend's callbacks because event channels, rings etc. are "statically" allocated in our
> use-case at the first system start (cold boot). And indeed, tests show that waking domains
> in the right order do allow that.
> So, frankly, from [3] we are immediately interested in implementing .resume/.suspend, not
If you just (re)implement .suspend and .resume so without taking care
of Xen suspend, you can easily break the existing functionality. The
patch series introduced .freeze and .restore callbacks for both PM
suspend and hibernation, and kept .suspend (not implemented in most
frontend though) and .resume with no changes for Xen suspend.

Note that xenbus has mapped freeze/thaw/restore events to suspend,
resume and cancel callbacks to handle "checkpoint" case[4]. This was a
bit tricky and led me to the design to have the separate set of
callbacks at each frontend driver level[5]. You might need to consider
a similar approach even if your immediate interest at the moment is PM
suspend.

> even freeze/thaw/restore callbacks: if Amazon has will and capacity to continue working on [3]
> then once that gets into the upstream it also solves our S2RAM use-case, but if not then we
> can probably re-work netfront patch and only provide .resume/.suspend callbacks which we need
> for now (remember our very specific use-case which can survive suspend without callbacks
> implemented).
> IMO, patches at [2] seem to be useful while implementing generic suspend/resume and can
> be postponed for S2RAM.
> 
> Julien/Juergen/Boris/Amazon - could you please express your view on the above?
> Is it acceptable that for now we only take re-worked netfront patch from [3] with full
> implementation in mind for later (we reuse code for .resume/.suspend)?
In fact, Anchal has taken over my initial work and she may want to chime
in here.

That said, I'd be very happy to review patches if you come up with your
own ones, so feel free to add me in that case.

>> Cheers,
>>
>> [1] https://lists.xenproject.org/archives/html/xen-devel/2018-06/msg00823.html
>>
>> [2] http://xenbits.xen.org/gitweb/?p=people/julieng/linux-arm.git;a=shortlog;h=refs/heads/xen-migration/v2
>>
> [3] https://lists.xenproject.org/archives/html/xen-devel/2018-11/msg01093.html

[4] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=b3e96c0c756211e805c6941d4a6e5f6e1995cb6b
[5] https://lists.xenproject.org/archives/html/xen-devel/2018-06/msg00825.html

>>>
>>>
>>> -boris
>>>
>>> _______________________________________________
>>> Xen-devel mailing list
>>> Xen-devel@lists.xenproject.org
>>> https://lists.xenproject.org/mailman/listinfo/xen-devel
>>>
>>
> Thank you,
> Oleksandr

Thanks,
Munehisa
