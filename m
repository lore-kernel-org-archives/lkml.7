Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87B0AC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 06:40:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3E8CD20811
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 06:40:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dRAjvZ/B"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387471AbfC0Gk0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 02:40:26 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:38720 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726185AbfC0Gk0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 02:40:26 -0400
Received: by mail-lj1-f196.google.com with SMTP id p14so12349754ljg.5;
        Tue, 26 Mar 2019 23:40:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=1+41+A2BHD4ldNqlyuqV0uC0rr0jA3AQ/6ywkM4+QWI=;
        b=dRAjvZ/BEQf3I1scwyljAcaAjEz2CvzWiU/w2FbOkydknVpwtuO5vY7keGbfI+j7rQ
         Wto6twFDdaysVQctnG1yET9wHhd9jaYQf9ftD36FoFkScS+jQxmZmGmtBWzbc6X+MHWG
         d+XJYpp3B3SyGtVhiVPCy+Cuv/fk/Pg4pzzvNl7zWLp/tEOvxxhotm9+ZCSw4CrVbGVD
         zwJc7pNgaDZAVsSc58iHQEBmcXuQfjY+S0xzy0Pn6v0yj6SvF6W9KlWFXQ1o628bSCBT
         fplnHfxKAMcXIMJ0+8dB1JhIdO5bDfrPsik3GfFHoKhTrn7DSu+BWbff/EEnTwUb0Rdh
         YO9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=1+41+A2BHD4ldNqlyuqV0uC0rr0jA3AQ/6ywkM4+QWI=;
        b=NnuWRw980qMkKY0xsFdKSqn6ww4OXbGYpqy8K7WT8Az3mb03XNS/PuocGROf1c23+N
         KbfLMDaFr2EcOfTNtoUUfqGf/TXxxeqIeKLGXtldFolRzLH/x3lh/Lik3Z3CBv8IGlv5
         DN0LbeEKG/xLXG1tV6gDskIARYHoZojl54/5xfGWjXMYFZPEsD595iq7yrqxedORG8ZS
         hViCl1EduDR7K24lsXVbUSfGv7X9m7vI1Wi3Uixq+6Ue6lr48q1w6STJiLUZUi+FcSyc
         ZORfhleBvzc+TmCj9y4VWLcVFwSOF+pA2VxaZsp6pMzYKH1wj8V6vLnfRlABDwCmifD6
         v1Dw==
X-Gm-Message-State: APjAAAWpqOACrZssaOZUFODDzi6Os08/e1j8szOx9l57Pi5ItzaRiEhj
        PlPiTlVCe4aQxNAIp1noJdI=
X-Google-Smtp-Source: APXvYqwvK0RQfAk/7fXXZa/b/A6Fw1tjSvIOofpSGgLxmIIXltefqPJ92d9IfQCrJ0Of12SYAqnnAw==
X-Received: by 2002:a2e:8719:: with SMTP id m25mr19288893lji.50.1553668822988;
        Tue, 26 Mar 2019 23:40:22 -0700 (PDT)
Received: from [10.17.182.20] (ll-22.209.223.85.sovam.net.ua. [85.223.209.22])
        by smtp.gmail.com with ESMTPSA id u2sm4387060lje.74.2019.03.26.23.40.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 26 Mar 2019 23:40:22 -0700 (PDT)
Subject: Re: [Xen-devel] [PATCH] xen/netfront: Remove unneeded .resume
 callback
To:     Anchal Agarwal <anchalag@amazon.com>
Cc:     Munehisa Kamata <kamatam@amazon.com>,
        "Oleksandr_Andrushchenko@epam.com" <Oleksandr_Andrushchenko@epam.com>,
        Julien Grall <julien.grall@arm.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "jgross@suse.com" <jgross@suse.com>,
        "sstabellini@kernel.org" <sstabellini@kernel.org>,
        "davem@davemloft.net" <davem@davemloft.net>,
        Volodymyr Babchuk <Volodymyr_Babchuk@epam.com>,
        "eduval@amazon.com" <eduval@amazon.com>
References: <20190314131749.25706-1-andr2000@gmail.com>
 <c87d2bfb-b029-6c18-e3ad-cb798055f761@oracle.com>
 <6205819a-af39-8cd8-db87-f3fe047ff064@gmail.com>
 <ecc825e6-89d3-bbd5-5243-5cc66fa93045@oracle.com>
 <b55d4f90-100c-7a2a-9651-c99c06953465@gmail.com>
 <09afcdca-258f-e5ca-5c31-b7fd079eb213@oracle.com>
 <3e868e7a-4872-e8ab-fd2c-90917ad6d593@arm.com>
 <d709d185-5345-c463-3fd1-e711f954e58a@gmail.com>
 <435369ba-ad3b-1d3a-c2f4-babe8bb6189c@amazon.com>
 <fde362d0-dd48-9c9a-e71a-8fb158909551@epam.com>
 <20190325173011.GA20277@kaos-source-ops-60001.pdx1.amazon.com>
From:   Oleksandr Andrushchenko <andr2000@gmail.com>
Message-ID: <f5e824de-da57-9574-3813-2668f2932a6e@gmail.com>
Date:   Wed, 27 Mar 2019 08:40:20 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <20190325173011.GA20277@kaos-source-ops-60001.pdx1.amazon.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/25/19 7:30 PM, Anchal Agarwal wrote:
> On Fri, Mar 22, 2019 at 10:44:33AM +0000, Oleksandr Andrushchenko wrote:
>> On 3/20/19 5:50 AM, Munehisa Kamata wrote:
>>> On 3/18/2019 3:02 AM, Oleksandr Andrushchenko wrote:
>>>> +Amazon
>>>> pls see inline
>>> Hi Oleksandr,
>>>
>>> Let me add some comments as the original author of the series.
>> Thank you for your work!
> Hi Oleksandr,
>>>> On 3/14/19 9:00 PM, Julien Grall wrote:
>>>>> Hi,
>>>>>
>>>>> On 3/14/19 3:40 PM, Boris Ostrovsky wrote:
>>>>>> On 3/14/19 11:10 AM, Oleksandr Andrushchenko wrote:
>>>>>>> On 3/14/19 5:02 PM, Boris Ostrovsky wrote:
>>>>>>>> On 3/14/19 10:52 AM, Oleksandr Andrushchenko wrote:
>>>>>>>>> On 3/14/19 4:47 PM, Boris Ostrovsky wrote:
>>>>>>>>>> On 3/14/19 9:17 AM, Oleksandr Andrushchenko wrote:
>>>>>>>>>>> From: Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>
>>>>>>>>>>>
>>>>>>>>>>> Currently on driver resume we remove all the network queues and
>>>>>>>>>>> destroy shared Tx/Rx rings leaving the driver in its current state
>>>>>>>>>>> and never signaling the backend of this frontend's state change.
>>>>>>>>>>> This leads to the number of consequences:
>>>>>>>>>>> - when frontend withdraws granted references to the rings etc. it
>>>>>>>>>>> cannot
>>>>>>>>>>>   ???????? be cleanly done as the backend still holds those (it was not
>>>>>>>>>>> told to
>>>>>>>>>>>   ???????? free the resources)
>>>>>>>>>>> - it is not possible to resume driver operation as all the
>>>>>>>>>>> communication
>>>>>>>>>>>   ???????? means with the backned were destroyed by the frontend, thus
>>>>>>>>>>>   ???????? making the frontend appear to the guest OS as functional, but
>>>>>>>>>>>   ???????? not really.
>>>>>>>>>> What do you mean? Are you saying that after resume you lose
>>>>>>>>>> connectivity?
>>>>>>>>> Exactly, if you take a look at the .resume callback as it is now
>>>>>>>>> what it does it destroys the rings etc. and never notifies the backend
>>>>>>>>> of that, e.g. it stays in, say, connected state with communication
>>>>>>>>> channels destroyed. It never goes into any other Xen bus state, so
>>>>>>>>> there is
>>>>>>>>> no way its state machine can help recovering.
>>>>>>>> My tree is about a month old so perhaps there is some sort of regression
>>>>>>>> but this certainly works for me. After resume netfront gets
>>>>>>>> XenbusStateInitWait from backend which causes xennet_connect().
>>>>>>> Ah, the difference can be of the way we get the guest enter
>>>>>>> the suspend state. I am making my guest to suspend with:
>>>>>>> echo mem > /sys/power/state
>>>>>>> And then I use an interrupt to the guest (this is a test code)
>>>>>>> to wake it up.
>>>>>>> Could you please share your exact use-case when the guest enters suspend
>>>>>>> and what you do to resume it?
>>>>>> xl save / xl restore
>>>>>>
>>>>>>> I can see no way backend may want enter XenbusStateInitWait in my
>>>>>>> use-case
>>>>>>> as it simply doesn't know we want him to.
>>>>>> Yours looks like ACPI path, I don't know how well it was tested TBH.
>>>>> I remember a series from amazon [1] that plays around suspend and hibernation. The patch [2] leads me to think that guest triggered suspend/resume does not work properly. It looks like the series has never been fully reviewed. Not sure why...
>>>> Julien, thanks a lot for bringing these patches to our attention which we obviously missed.
>>>>> Anyway, from my understanding this series may solve Oleksandr issue. However, this would only address the common code side. AFAIK Oleksandr is targeting Arm platform. If so, I think this would require more work than this series. Arm code still miss few bits properly suspend/resume arch specific code (see [2]).
>>>>>
>>>>> I have a branch on my git to track the series. However, they never have been resent after Ian Campbell left Citrix. I would be happy to review them if someone wants to pick them up and repost them.
>>>>>
>>>> First of all, let me make it clear that we are interested in hibernation long term, so it would be
>>>> desirable to re-use as much work form resume/suspend as we can. But, we see it as a step by
>>>> step work, e.g. first S2RAM and later on hibernation.
>>>> Let me clarify the immediate use-case that we have, so it is easier to understand what we want
>>>> and what we don't at the moment. We are about to continue work started by Mirela/Xilinx on
>>>> Suspend-to-RAM for ARM [3] and we made number of assumptions:
>>>> 1. We are talking about *system* suspend, e.g. the goal is to suspend all the components
>>>> of the system and Xen itself at once. Think about this as fast-boot and/or energy saving
>>>> feature if you will.
>>>> 2. With suspend/resume there is no intention to migrate VMs to any other host.
>>>> 3. Most probably configuration of the back/front won't change between suspend/resume.
>>>> But long term we are also thinking for supporting suspend/resume in its broader meaning,
>>>> e.g. what is probably what you mean by suspend/resume.
>>> AFAIK .suspend and .resume callbacks in frontend drivers are
>>> specifically for xl save/restore case rather than the normal "system"
>>> suspend. i.e. The former is Boris' case and something I called "Xen
>>> suspend" in the patch series, the latter should be your interest and
>>> called "ACPI path" here, and I referred to as "PM suspend". They are
>>> very different code paths, see drivers/xen/manage.c for details of
>>> Xen suspend.
>> Yes, I saw that code, thank you
>>>> Given that, we think that we don't need Xen support to save grants, page tables and other
>>>> VM's context on suspend at least at the first stage as we are implementing not a fully
>>>> blown suspend/resume, but only S2RAM part of it which is much more simpler than a generic
>>>> suspend implementation. We only need changes to Linux kernel frontend drivers from [1] - the
>>>> piece that we miss is suspend/resume implementation in the netfront driver. What is more, as
>>>> we are not changing back/front configuration, we can even live with empty .resume/.suspend
>>>> frontend's callbacks because event channels, rings etc. are "statically" allocated in our
>>>> use-case at the first system start (cold boot). And indeed, tests show that waking domains
>>>> in the right order do allow that.
>>>> So, frankly, from [3] we are immediately interested in implementing .resume/.suspend, not
>>> If you just (re)implement .suspend and .resume so without taking care
>>> of Xen suspend, you can easily break the existing functionality. The
>>> patch series introduced .freeze and .restore callbacks for both PM
>>> suspend and hibernation, and kept .suspend (not implemented in most
>>> frontend though) and .resume with no changes for Xen suspend.
>>>
>>> Note that xenbus has mapped freeze/thaw/restore events to suspend,
>>> resume and cancel callbacks to handle "checkpoint" case[4]. This was a
>>> bit tricky and led me to the design to have the separate set of
>>> callbacks at each frontend driver level[5]. You might need to consider
>>> a similar approach even if your immediate interest at the moment is PM
>>> suspend.
>> For the immediate task we have at the moment we think we can re-use
>> your work and implement .suspend/.resume based on it (we are targeting
>> S2RAM as the first stage).
>> But long term - we do support the idea of fully implemented
>> suspend and *hibernate* functionality as you describe it.
>> So, yes, we are also thinking about that.
>>>> even freeze/thaw/restore callbacks: if Amazon has will and capacity to continue working on [3]
>>>> then once that gets into the upstream it also solves our S2RAM use-case, but if not then we
>>>> can probably re-work netfront patch and only provide .resume/.suspend callbacks which we need
>>>> for now (remember our very specific use-case which can survive suspend without callbacks
>>>> implemented).
>>>> IMO, patches at [2] seem to be useful while implementing generic suspend/resume and can
>>>> be postponed for S2RAM.
>>>>
>>>> Julien/Juergen/Boris/Amazon - could you please express your view on the above?
>>>> Is it acceptable that for now we only take re-worked netfront patch from [3] with full
>>>> implementation in mind for later (we reuse code for .resume/.suspend)?
>>> In fact, Anchal has taken over my initial work and she may want to chime
>>> in here.
>> Great, could you please let us know what is the progress and further plans
>> on that, so we do not work on the same code and can coordinate our
>> efforts somehow? Anchal, could you please shed some light on this?
> Looks like my previous email did not make it to mailing list. May be some issues with my
> email server settings. Giving it another shot.
> Yes, I am working on those patches and plan to re-post them in an effort to upstream.
This is really great, looking forward to it: any date in your mind
when this can happen?
> I agree with Munehisa here on considering the patches that are already out there as
> I plan to keep the same model to distinguish PM SUSPEND and PM HIBERNATION from xen
> suspend and resume. There may be minor fixes here and there however, the overall
> idea will still remain the same.
Ok, so I'll plan my efforts accordingly
>   As the previous patches there will be support for
> only xen-blkfront and xen-netfront in the initial patchset.
>>> That said, I'd be very happy to review patches if you come up with your
>>> own ones, so feel free to add me in that case.
>> Sure, thank you!
>>>>> Cheers,
>>>>>
>>>>> [1] https://lists.xenproject.org/archives/html/xen-devel/2018-06/msg00823.html
>>>>>
>>>>> [2] http://xenbits.xen.org/gitweb/?p=people/julieng/linux-arm.git;a=shortlog;h=refs/heads/xen-migration/v2
>>>>>
>>>> [3] https://lists.xenproject.org/archives/html/xen-devel/2018-11/msg01093.html
>>> [4] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=b3e96c0c756211e805c6941d4a6e5f6e1995cb6b
>>> [5] https://lists.xenproject.org/archives/html/xen-devel/2018-06/msg00825.html
>>>
>>>>>> -boris
>>>>>>
>>>>>> _______________________________________________
>>>>>> Xen-devel mailing list
>>>>>> Xen-devel@lists.xenproject.org
>>>>>> https://lists.xenproject.org/mailman/listinfo/xen-devel
>>>>>>
>>>> Thank you,
>>>> Oleksandr
>>> Thanks,
>>> Munehisa
> Thanks,
> Anchal
Thank you,
Oleksandr
