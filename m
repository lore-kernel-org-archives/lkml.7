Return-Path: <SRS0=NWWL=SU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63229C10F0E
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 12:13:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2A2EB217D7
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 12:13:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YX6hIvRl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388897AbfDRMNl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Apr 2019 08:13:41 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:37661 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387519AbfDRMNk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Apr 2019 08:13:40 -0400
Received: by mail-pf1-f193.google.com with SMTP id 8so1038953pfr.4
        for <linux-kernel@vger.kernel.org>; Thu, 18 Apr 2019 05:13:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=VVWbBy4grUnMdIPtpRFfpRTHvYGJcNOcN44fXPxQV6Q=;
        b=YX6hIvRlUGn2fx9qlCF8+4JlhEmDssqvUvbjYxjVlHsfBTWkrcnaSaIRgOYi3XPo/7
         jMYyiA/aJS42mjmec2L6jJzwVIL06HdQOljYvxOIXujI27xSFCzsy9gzVWteWic6M6eQ
         NFZI/6/3FJgQeQtnb1CjOTZ7iuj8qNORmdvhBqnrLvAATr35ktvQSieJJ0pXsUVQCGUp
         VUz5yXZgqNNKBGXSK8ZQfDxl1pFyJTosmoi6CY7aHjw688/T+39Ub8U3OyFL0ASi/tc+
         b2vltukpFlTx/z3Fx1GTZNQCgRSyUGtcZgoXYWuEyHevClqBDEjyyQhfdRHYzMf21EL5
         Esxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=VVWbBy4grUnMdIPtpRFfpRTHvYGJcNOcN44fXPxQV6Q=;
        b=n/+ZV/veoPo0lz5LvJP35g4BsmTuFzCmskeE4qwOI4eYramU+Kx1wGGbujM8V3LtJh
         BTO3OhK1r0sZL5WUgqeN3B2e8+ou0ARrGrDS0dNY9Tw5hqOCjV4n1/lM4b9lJQsN2Tyw
         GvaBs707NrVIK4V+uguluQKelC8GVGf/5HF9ZwI5oBDZh2ytfKJ6OW58fcNEVTbtQePg
         5CHjYHkZ2/+9vr7Vq8wTqHIlwJewOj6d+LD2CggM4tQRwGDr+54MBo7v4CCK5myLBuH8
         wSPTIaYJepxRzUdMlBPl32aI+QsShB1FHKIpRt/Bfm2HUxfjkeuWJq8S4VlJ2MeB9gGw
         4dZA==
X-Gm-Message-State: APjAAAUfU4MWkx452yrVPE/VpmBofvNlAcvYqFvitbJAXLXxCaZ5DKJO
        Nnqo12dOvUjIrfU3SAkyINk=
X-Google-Smtp-Source: APXvYqxGLcrJMSPQu3w/mCbcanWL4DS+CLcgvM7UcQymchNomht1jCAeG6rqZwrHUU290Cpl1Q3ifw==
X-Received: by 2002:aa7:9465:: with SMTP id t5mr5961827pfq.247.1555589619616;
        Thu, 18 Apr 2019 05:13:39 -0700 (PDT)
Received: from [192.168.0.6] ([123.213.206.190])
        by smtp.gmail.com with ESMTPSA id s79sm4073986pfa.31.2019.04.18.05.13.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 18 Apr 2019 05:13:38 -0700 (PDT)
Subject: Re: [PATCH] nvme: determine the number of IO queues
To:     Aaron Ma <aaron.ma@canonical.com>,
        Maxim Levitsky <mlevitsk@redhat.com>,
        linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
        keith.busch@intel.com, axboe@fb.com
References: <1555510379-20199-1-git-send-email-aaron.ma@canonical.com>
 <a2f0a97e14b884dc1183db9cbdd6f4b520000ce3.camel@redhat.com>
 <096935354b16662eb481aeda1f48001ba489463c.camel@redhat.com>
 <e79703d5-3502-6519-a497-71b2b2a8768f@canonical.com>
From:   Minwoo Im <minwoo.im.dev@gmail.com>
Message-ID: <99ab1942-9c38-695d-03dc-ea6eecb31217@gmail.com>
Date:   Thu, 18 Apr 2019 21:13:35 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <e79703d5-3502-6519-a497-71b2b2a8768f@canonical.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/18/19 3:21 PM, Aaron Ma wrote:
> On 4/18/19 1:33 AM, Maxim Levitsky wrote:
>> On Wed, 2019-04-17 at 20:32 +0300, Maxim Levitsky wrote:
>>> On Wed, 2019-04-17 at 22:12 +0800, Aaron Ma wrote:
>>>> Some controllers support limited IO queues, when over set
>>>> the number, it will return invalid field error.
>>>> Then NVME will be removed by driver.
>>>>
>>>> Find the max number of IO queues that controller supports.
>>>> When it still got invalid result, set 1 IO queue at least to
>>>> bring NVME online.
>>> To be honest a spec compliant device should not need this.
>>> The spec states:
>>>
>>> "Number of I/O Completion Queues Requested (NCQR): Indicates the number of I/O
>>> Completion
>>> Queues requested by software. This number does not include the Admin
>>> Completion
>>> Queue. A
>>> minimum of one queue shall be requested, reflecting that the minimum support
>>> is
>>> for one I/O
>>> Completion Queue. This is a 0’s based value. The maximum value that may be
>>> specified is 65,534
>>> (i.e., 65,535 I/O Completion Queues). If the value specified is 65,535, the
>>> controller should return
>>> an error of Invalid Field in Command."
>>>
>>>
>>> This implies that you can ask for any value and the controller must not
>>> respond
>>> with an error, but rather indicate how many queues it supports.
>>>
>>> Maybe its better to add a quirk for the broken device, which needs this?
> 
> Adding quirk only makes the code more complicated.
> This patch doesn't change the default behavior.
> Only handle the NVME error code.
> 
> Yes the IO queues number is 0's based, but driver would return error and
> remove the nvme device as dead.

IMHO, if a controller indicates an error with this set_feature command, then
we need to figure out why the controller was returning the error to host.

If you really want to use at least a single queue to see an alive I/O queue,
controller should not return the error because as you mentioned above,
NCQA, NSQA will be returned as 0-based.  If an error is there, that could
mean that controller may not able to provide even a single queue for I/O.

Thanks,
Minwoo Im

> 
> So set it as 1 at least the NVME can be probed properly.
> 
> Regards,
> Aaron
> 
>> I forgot to add the relevant paragraph:
>>
>> "Note: The value allocated may be smaller or larger than the number of queues
>> requested, often in virtualized
>> implementations. The controller may not have as many queues to allocate as are
>> requested. Alternatively,
>> the controller may have an allocation unit of queues (e.g. power of two) and may
>> supply more queues to
>> host software to satisfy its allocation unit."
>>
>>
>> Best regards,
>> 	Maxim Levitsky
>>
> 
> _______________________________________________
> Linux-nvme mailing list
> Linux-nvme@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-nvme
> 

